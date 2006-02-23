Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751762AbWBWR1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbWBWR1o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWBWR1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:27:44 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:50903 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751762AbWBWR1n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:27:43 -0500
Subject: Re: [PATCH] change b_size to size_t
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, Nathan Scott <nathans@sgi.com>,
       christoph <hch@lst.de>, mcao@us.ibm.com,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20060223163204.GA27682@kvack.org>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com>
	 <20060222151216.GA22946@lst.de>
	 <1140627510.22756.81.camel@dyn9047017100.beaverton.ibm.com>
	 <20060222165942.GA25167@lst.de> <20060223014004.GA900@frodo>
	 <20060222175923.784ce5de.akpm@osdl.org>
	 <1140712093.22756.106.camel@dyn9047017100.beaverton.ibm.com>
	 <20060223163204.GA27682@kvack.org>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 09:28:58 -0800
Message-Id: <1140715738.22756.125.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 11:32 -0500, Benjamin LaHaise wrote:
> On Thu, Feb 23, 2006 at 08:28:12AM -0800, Badari Pulavarty wrote:
> > Here is the updated version of the patch, which changes
> > buffer_head.b_size to size_t to support mapping large
> > amount of disk blocks (for large IOs).
> 
> Your patch doesn't seem to be inline, so I can't quote it.  Several 
> problems: on 64 bit platforms you introduced 4 bytes of padding into 
> buffer_head.  atomic_t only takes up 4 byte, while size_t is 8 byte 
> aligned. 


Ignore my previous mail.

How about doing this ? Change b_state to u32 and change b_size
to "size_t". This way, we don't increase the overall size of
the structure on 64-bit machines. Isn't it ?

Thanks,
Badari


struct buffer_head {
        u32 b_state;                    /* buffer state bitmap (see
above) */
        atomic_t b_count;               /* users using this buffer_head
*/
        struct buffer_head *b_this_page;/* circular list of page's
buffers */
        struct page *b_page;            /* the page this bh is mapped to
*/
        size_t b_size;                  /* size of mapping */

        sector_t b_blocknr;             /* start block number */
        char *b_data;                   /* pointer to data within the
page */

        struct block_device *b_bdev;
        bh_end_io_t *b_end_io;          /* I/O completion */
        void *b_private;                /* reserved for b_end_io */
        struct list_head b_assoc_buffers; /* associated with another
mapping */
};


Thanks,
Badari

