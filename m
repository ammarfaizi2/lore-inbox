Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315590AbSECIH3>; Fri, 3 May 2002 04:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315593AbSECIH2>; Fri, 3 May 2002 04:07:28 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:63798 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315590AbSECIH0>; Fri, 3 May 2002 04:07:26 -0400
Date: Fri, 3 May 2002 10:08:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hong-Gunn Chew <hgchewML@optusnet.com.au>
Cc: "'Petr Vandrovec'" <VANDROVE@vc.cvut.cz>,
        "'Linux kernel mailing list'" <linux-kernel@vger.kernel.org>,
        riel@conectiva.com.br
Subject: Re: Memory corruption when running VMware. (was File curruption when running VMware)
Message-ID: <20020503100803.J11414@dualathlon.random>
In-Reply-To: <37A7BD60863@vcnet.vc.cvut.cz> <001701c1f24d$b7e50e10$241d7f81@hgclaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 12:23:35PM +0930, Hong-Gunn Chew wrote:
> Hi Petr, Andrea,
> 
> Petr wrote:
> >   So if you have >890MB of RAM and your kernel is compiled 
> > with support for pte in high memory, please stop using 
> > VMware, or reconfigure your 
> > kernel to not use pte in high memory (4GB config without 
> > pte-in-highmem is OK). Using pte-in-highmem with vmmon will 
> > cause kernel oopses and/or 
> > memory corruption :-(
> 
> I have been trying different kernel configurations to overcome this
> problem.  I found that turning on APIC seem to work properly.  However
> turning on IO-APIC causes it to hang just after X is started, which
> seems to be during the startup of gdm.
> I do have a silly question to ask though.  How do I compile the kernel
> NOT to use pte in high memory?

the simplest patch to avoid pte in highmem is this. It's against 19pre7aa3
but it will apply cleanly to the kernel you're using.

--- 2.4.19pre7aa3/mm/memory.c.~1~	Tue Apr 30 19:53:08 2002
+++ 2.4.19pre7aa3/mm/memory.c	Fri May  3 09:58:23 2002
@@ -1493,7 +1493,7 @@
 {
 	struct page * page;
 
-	page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM);
+	page = alloc_page(GFP_KERNEL);
 	if (page)
 		clear_pagetable(page);
 	return page;

However if I would be in you I'd simply add mem=850M to the append line
in /etc/lilo.conf until the vmmon/vmnet update is released, that should
be the most confortable approch from your part.

> Andrea wrote:
> > passing to the kernel mem=850M in lilo at boot will be enough.
> 
> This did not work as it causes vmware to seg fault with a kernel oops:

Hmm looking at the bounce_end_io_read it looks like the kernel didn't
recognized you specified mem=850M via lilo, not idea why. You should
check with `free` that your kernel is using only 850M of ram before
starting vmware. Can you show the contents of /proc/meminfo right after
boot?

> [generic_file_readahead+288/304] [bounce_end_io_read+164/288]
> [isapnp_set_mem+23/272] [vfs_link+23/256] [system_call+51/56]
> 	   [<f61fd5d1>] [<c01272b0>] [<c0131e94>] [<c01e0527>]
> [<c013e487>]  [<c0106f0b>]
> 	
> 	Code: 8b 11 89 d0 25 00 07 01 00 3d 00 04 00 00 75 12 81 ca 00
> 00
> 
> Cheers,
> Hong-Gunn


Andrea
