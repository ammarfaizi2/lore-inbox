Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWIZULT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWIZULT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWIZULT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:11:19 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:38623 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932270AbWIZULS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:11:18 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm 3/6] swsusp: Use block device offsets to identify swap locations
Date: Tue, 26 Sep 2006 22:04:02 +0200
User-Agent: KMail/1.9.1
Cc: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       LKML <linux-kernel@vger.kernel.org>
References: <200609231158.00147.rjw@sisk.pl> <200609231204.25911.rjw@sisk.pl> <20060926123853.14682513.akpm@osdl.org>
In-Reply-To: <20060926123853.14682513.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609262204.03512.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 26 September 2006 21:38, Andrew Morton wrote:
> On Sat, 23 Sep 2006 12:04:25 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > Make swsusp use block device offsets instead of swap offsets to identify swap
> > locations and make it use the same code paths for writing as well as for
> > reading data.
> > 
> > This allows us to use the same code for handling swap files and swap
> > partitions and to simplify the code, eg. by dropping rw_swap_page_sync().
> > 
> > ..
> >
> > +sector_t swapdev_block(int swap_type, pgoff_t offset)
> 
> swapdev_block() returns sector_t.
> 
> > -unsigned long alloc_swap_page(int swap, struct bitmap_page *bitmap)
> > +loff_t alloc_swapdev_block(int swap, struct bitmap_page *bitmap)
> >  {
> >  	unsigned long offset;
> >  
> >  	offset = swp_offset(get_swap_page_of_type(swap));
> >  	if (offset) {
> > -		if (bitmap_set(bitmap, offset)) {
> > +		if (bitmap_set(bitmap, offset))
> >  			swap_free(swp_entry(swap, offset));
> > -			offset = 0;
> > -		}
> > +		else
> > +			return swapdev_block(swap, offset);
> >  	}
> > -	return offset;
> > +	return 0;
> >  }
> 
> But alloc_swapdev_block() returns loff_t.

I'll change all that to sector_t.
 
> >  void free_all_swap_pages(int swap, struct bitmap_page *bitmap)
> > Index: linux-2.6.18-rc7-mm1/kernel/power/user.c
> > ===================================================================
> > --- linux-2.6.18-rc7-mm1.orig/kernel/power/user.c
> > +++ linux-2.6.18-rc7-mm1/kernel/power/user.c
> > @@ -239,7 +239,7 @@ static int snapshot_ioctl(struct inode *
> >  				break;
> >  			}
> >  		}
> > -		offset = alloc_swap_page(data->swap, data->bitmap);
> > +		offset = alloc_swapdev_block(data->swap, data->bitmap);
> 
> `offset' is declared loff_t, yet it is holding a sector_t.
> 
> > ===================================================================
> > --- linux-2.6.18-rc7-mm1.orig/kernel/power/swap.c
> > +++ linux-2.6.18-rc7-mm1/kernel/power/swap.c
> > @@ -34,8 +34,8 @@ extern char resume_file[];
> >  #define SWSUSP_SIG	"S1SUSPEND"
> >  
> >  static struct swsusp_header {
> > -	char reserved[PAGE_SIZE - 20 - sizeof(swp_entry_t)];
> > -	swp_entry_t image;
> > +	char	reserved[PAGE_SIZE - 20 - sizeof(loff_t)];
> > +	loff_t	image;
> 
> More possible sector_t/loff_t confusion.
> 
> >  static int swsusp_swap_check(void) /* This is called before saving image */
> >  {
> > -	int res = swap_type_of(swsusp_resume_device, 0);
> > +	int res;
> >  
> > -	if (res >= 0) {
> > -		root_swap = res;
> > -		return 0;
> > -	}
> > -	return res;
> > +	res = swap_type_of(swsusp_resume_device, 0);
> > +	if (res < 0)
> > +		return res;
> > +
> > +	root_swap = res;
> > +	resume_bdev = open_by_devnum(swsusp_resume_device, FMODE_WRITE);
> > +	if (IS_ERR(resume_bdev))
> > +		return PTR_ERR(resume_bdev);
> > +
> > +	set_blocksize(resume_bdev, PAGE_SIZE);
> > +	return 0;
> >  }
> 
> set_blocksize() can fail.

Will check for that.

> 
> > -#define MAP_PAGE_ENTRIES	(PAGE_SIZE / sizeof(long) - 1)
> > +#define MAP_PAGE_ENTRIES	(PAGE_SIZE / sizeof(loff_t) - 1)
> 
> I think this is dealing with sector_t's?

