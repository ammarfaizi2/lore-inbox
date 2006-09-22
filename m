Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWIVG7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWIVG7t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 02:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWIVG7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 02:59:49 -0400
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:55987 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750801AbWIVG7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 02:59:48 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: Fw: 2.6.17 oops, possibly ntfs/mmap related
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060921105236.76e344a2.akpm@osdl.org>
References: <20060912205602.57568b2a.akpm@osdl.org>
	 <1158832483.5958.7.camel@imp.csi.cam.ac.uk>
	 <1158849696.5958.39.camel@imp.csi.cam.ac.uk>
	 <20060921105236.76e344a2.akpm@osdl.org>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Fri, 22 Sep 2006 07:59:41 +0100
Message-Id: <1158908381.10415.1.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-21 at 10:52 -0700, Andrew Morton wrote:
> On Thu, 21 Sep 2006 15:41:36 +0100
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> > On Thu, 2006-09-21 at 10:54 +0100, Anton Altaparmakov wrote:
> > > On Tue, 2006-09-12 at 20:56 -0700, Andrew Morton wrote:
> > > Andrew, thanks for forwarding me the message...
> > > > Begin forwarded message:
> > > > 
> > > > We have a machine which is currently making heavy use of a usb hard disc
> > > > formatted with ntfs.  There have been two occasions where the kernel has
> > > > oopsed while this disc was being accessed heavily.  Before adding this HDD
> > > > the machine in question was rock solid which leads me to think that it
> > > > might be related to ntfs.  USB drives formatted with other filesystems do
> > > > not appear to suffer from this problem.
> > 
> > I have now seen such an oops too with 2.6.18 kernel.
> 
> I assume it is a once-off?

So far yes.  I now have seen a recursive locking thing reported by the
new lock analyzer but that looks like it has to do with NFS (my home
directory is on NFS) so I don't think it is in any way related.

> >  Note no NTFS file
> > systems were mounted at the time (but I had an NTFS file system mounted
> > earlier in the day).
> > 
> > The oops is caused by kswapd0 kernel thread, the stack trace is:
> > 
> > Call Trace:
> >  [<c10470a3>] shrink_inactive_list+0x46b/0x790
> >  [<c104747c>] shrink_zone+0xb4/0xd3
> >  [<c104797d>] kswapd+0x2de/0x3cf
> >  [<c102c18e>] kthread+0xc2/0xf0
> >  [<c1000bf1>] kernel_thread_helper+0x5/0xb
> > DWARF2 unwinder stuck at kernel_thread_helper+0x5/0xb
> > Leftover inexact backtrace:
> >  [<c1003e6c>] show_stack_log_lvl+0x8c/0x97
> >  [<c1003fc8>] show_registers+0x151/0x1c6
> >  [<c10041af>] die+0x172/0x27b
> >  [<c145f22c>] do_page_fault+0x42c/0x4f9
> >  [<c10037dd>] error_code+0x39/0x40
> >  [<c10470a3>] shrink_inactive_list+0x46b/0x790
> >  [<c104747c>] shrink_zone+0xb4/0xd3
> >  [<c104797d>] kswapd+0x2de/0x3cf
> >  [<c102c18e>] kthread+0xc2/0xf0
> >  [<c1000bf1>] kernel_thread_helper+0x5/0xb
> > 
> > And the EIP is at fs/buffer.c::try_to_release_page() the code of which
> > is here:
> > 
> > int try_to_release_page(struct page *page, gfp_t gfp_mask)
> > {
> >         struct address_space * const mapping = page->mapping;
> > 
> >         BUG_ON(!PageLocked(page));
> >         if (PageWriteback(page))
> >                 return 0;
> > 
> >         if (mapping && mapping->a_ops->releasepage)
> > 
> > ^^^ bug happens here when the value of mapping->a_ops is used to obtain
> > mapping->a_ops->releasepage
> > 
> >                 return mapping->a_ops->releasepage(page, gfp_mask);
> >         return try_to_free_buffers(page);
> > }
> > 
> > This bug seems to suggest that there is a page which the kernel is
> > trying to release private data which has page->mapping set to a valid
> > value and page->mapping->a_ops apparently set to an invalid value and
> > when page->mapping->a_ops->releasepage is dereferenced it causes an oops
> > with the kernel saying:
> > 
> > BUG: unable to handle kernel paging request at virtual address 020030d2
> > 
> > The values of the relevant variables from the oops are:
> > 
> > page = 0xc2248fa0
> > page->mapping = 0xe3a79eac
> > page->mapping->a_ops = 0x020030aa
> 
> I wonder if page->mapping really wanted to be 0xc3a79eac, only something
> set bit 29.

I don't know, it could be but the machine is totally stable so I would
be surprised if it is bad ram...

> > Note that 0x020030aa+0x28 = 020030d2 which is the oops causing address
> > and 0x28 is the offset of the releasepage function pointer in the
> > address space operations structure...
> > 
> > This oops is not identical to the oopses pointed out by Jonathan at:
> > 
> > http://www.atrad.com.au/~jwoithe/kernel/oopses-20060913.txt
> > 
> > But those oopses have to do with pages also so could be related...
> 
> Looks a bit different - Jonathan appears to have pulled a bad page* out
> of the radix tree whereas you got your page off the LRU.
> 
> > Anyone have any ideas how a page can end up in such a weird state?
> 
> Nope.

)-:

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://www.linux-ntfs.org/ & http://www-stu.christs.cam.ac.uk/~aia21/

