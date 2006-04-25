Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWDYI1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWDYI1j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWDYI1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:27:39 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:8891 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750949AbWDYI1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:27:38 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Tue, 25 Apr 2006 10:26:53 +0200
User-Agent: KMail/1.9.1
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <nigel@suspend2.net>
References: <200604242355.08111.rjw@sisk.pl> <20060424221632.GQ3386@elf.ucw.cz>
In-Reply-To: <20060424221632.GQ3386@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604251026.53613.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 25 April 2006 00:16, Pavel Machek wrote:
> > The appended patch allows swsusp to break the "50% of the normal zone" limit.
> > This is achieved by using the observation that pages mapped by frozen
> > userland tasks need not be copied before saving.
> 
> I've not followed the patch too carefully, but it is not as bad as I
> expected...
> 
> > With this patch applied I was able to save (and restore ;-)) ~800 MB suspend
> > images on a box with 1 GB of RAM.
> 
> And did it also work second time? ;-).

Yes, somethinkg like 10 times in a row. :-)

> Okay, so it can be done, and patch does not look too bad. It still
> scares me. Is 800MB image more responsive than 500MB after resume?

Yes, it is, slightly, but I think 800 meg images are impractical for
performance reasons (like IMO everything above 500 meg with the current
hardware).  However this means we can save 80% of RAM with the patch
and that should be 400 meg instead of 250 on a 500 meg machine, or
200 meg instead of 125 on a 250 meg machine.

Apart from this we save some memory allocations and copyings during
suspend.

> I guess we can revert to old behaviour by simply returning 1 from
> need_to_copy, right?

Yes.

> I assume that need_to_copy returns 1 in case page is shared by current
> and some other process?

Yes.  [If the page is shared with the current task it has to mapped by it, in
which case it will be copied.]

> > [Please don't beat me very hard, just couldn't resist. ;-)]
> 
> Well, you are about to force me to learn about mm internals. Plus you
> force everyone who tries to modify swsusp. ... it may be okay if
> benefit is great enough and if it gets proper testing. Not 2.6.17
> material.

Obviously not, and yes it requires a _lot_ of testing especially on boxes
with 512 meg of RAM or less.

> Is benefit worth it?

Well, that depends.  I think for boxes with 1 GB of RAM or more it's just
unnecessary (as of today, but this may change if faster disks are available).
On boxes with 512 MB of RAM or less it may change a lot as far as the
responsiveness after resume is concerned.

Anyway do you think it may go into -mm (unless Andrew shoots it down,
that is ;-))?
 
> > --- linux-2.6.17-rc1-mm3.orig/include/linux/rmap.h	2006-04-22 10:34:33.000000000 +0200
> > +++ linux-2.6.17-rc1-mm3/include/linux/rmap.h	2006-04-22 10:34:45.000000000 +0200
> > @@ -104,6 +104,12 @@ pte_t *page_check_address(struct page *,
> >   */
> >  unsigned long page_address_in_vma(struct page *, struct vm_area_struct *);
> >  
> > +#ifdef CONFIG_SOFTWARE_SUSPEND
> > +int page_mapped_by_current(struct page *);
> > +#else
> > +static inline int page_mapped_by_current(struct page *page) { return 0; }
> > +#endif /* CONFIG_SOFTWARE_SUSPEND */
> 
> I'd leave it undefined. That will prevent nasty surprise when someone
> tries to use it w/o CONFIG_SOFTWARE_SUSPEND set.

OK

> > @@ -251,6 +253,14 @@ int restore_special_mem(void)
> >  	return ret;
> >  }
> >  
> > +/* Represents a stacked allocated page to be used in the future */
> > +struct res_page {
> > +	struct res_page *next;
> > +	char padding[PAGE_SIZE - sizeof(void *)];
> > +};
> > +
> > +static struct res_page *page_list;
> > +
> >  static int pfn_is_nosave(unsigned long pfn)
> >  {
> >  	unsigned long nosave_begin_pfn = __pa(&__nosave_begin) >>
> > PAGE_SHIFT;
> 
> Is this part of some other patch?

No.  That's because I use a linked list of allocated pages that has been
defined in a slightly different way in
swsusp-use-less-memory-during-resume.patch,
so I just redefine and reuse it.

> > @@ -490,6 +613,11 @@ void swsusp_free(void)
> >  	buffer = NULL;
> >  }
> >  
> > +void swsusp_free(void)
> > +{
> > +	free_image();
> > +	restore_active_inactive_lists();
> > +}
> 
> This still scares me. Nice test would be to
> save/restore_active_inactive_lists repeatedly in a loop ... on running
> system ... aha, but it probably can't work outside of refrigerator?

restore_active_inactive_lists() only does something if suspend fails
(otherwise the lists active_pages and inactive_pages are empty).

The suspend failure may be simulated by running swapoff and suspendig
with "echo disk > /sys/power/state".  However it wouldn't be interesting to
do this in a loop because it will make the same set of pages go out of the
LRU lists and back in a round robin fashion.

I did the the following test:
- ran swapoff
- tried to suspend with "echo disk > /sys/power/state" (which failed,
obviously)
- checked the numbers of active/inactive pages in /proc/meminfo
- ran swapon
- set image_size to 0
- suspended with "echo disk > /sys/power/state" to verify if the right number
of pages would be reclaimed
- resumed

at it worked, apparently.

> >  	case SNAPSHOT_UNFREEZE:
> >  		if (!data->frozen)
> >  			break;
> > +		if (data->ready) {
> > +			error = -EPERM;
> > +			break;
> > +		}
> >  		down(&pm_sem);
> >  		thaw_processes();
> >  		enable_nonboot_cpus();
> 
> Error from UNFREEZE is not nice:
> 
> Unfreeze:
>         unfreeze(snapshot_fd);
>         return error;
> }
> ... we don't handle it.

It will only occur if we don't call free_snapshot() before unfreeze() which is
a bug anyway.  We prevent it from occuring by always calling free_snapshot()
before unfreeze(). :-)

> OTOH I guess it will be all fixed on exit()?

Well, sort of, but I think the LRU lists always have to be restored before
thawing processes (eg. kswapd).

Greetings,
Rafael
