Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbVAJNzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbVAJNzC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 08:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbVAJNzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 08:55:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19112 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262257AbVAJNyz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 08:54:55 -0500
Date: Mon, 10 Jan 2005 08:58:55 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Andrea Arcangeli <andrea@novell.com>
Subject: Re: 2.4.x oops with X
Message-ID: <20050110105855.GD14098@logos.cnet>
References: <fa.kuv2u3i.hhma1k@ifi.uio.no> <fa.f87d0no.fk6a9u@ifi.uio.no> <41DF195F.4010406@pD9F86D75.dip0.t-ipconnect.de> <20050108014844.GB3210@redhat.com> <41DF98F4.5050805@pD9F8750A.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DF98F4.5050805@pD9F8750A.dip0.t-ipconnect.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 09:25:24AM +0100, Andreas Hartmann wrote:
> Hello Dave,
> 
> Dave Jones schrieb:
> > On Sat, Jan 08, 2005 at 12:21:03AM +0100, Andreas Hartmann wrote:
> > 
> >  > I put the actual oops here:
> >  > 
> >  > Jan  7 22:45:14 athlon kernel: get_user_pages PG_reserved page
> >  > onvma:de206840 flags:800ff page:0
> >  > Jan  7 22:45:14 athlon kernel: kernel BUG at memory.c:535!
> >  > Jan  7 22:45:14 athlon kernel: invalid operand: 0000
> >  > Jan  7 22:45:14 athlon kernel: serial usb-storage scsi_mod uhci usbcore
> >  > parport_pc lp parport loop lvm-modunix
> >  > Jan  7 22:45:14 athlon kernel: CPU:    0
> >  > Jan  7 22:45:14 athlon kernel: EIP:    0010:[<c013b002>]    Not tainted
> >  > Jan  7 22:45:14 athlon kernel: EFLAGS: 00010286
> >  > Jan  7 22:45:14 athlon kernel: eax: 00000045   ebx: 00000000   ecx:
> >  > de16c000   edx: 00000001
> >  > Jan  7 22:45:14 athlon kernel: esi: de206840   edi: ffffffff   ebp:
> >  > 00000001   esp: de16dc00
> >  > Jan  7 22:45:14 athlon kernel: ds: 0018   es: 0018   ss: 0018
> >  > Jan  7 22:45:14 athlon kernel: Process X (pid: 171, stackpage=de16d000)
> >  > Jan  7 22:45:14 athlon kernel: Stack: c0258ae0 de206840 000800ff 00000000
> >  > 00002cb0 de16c000 de16c000 00000010
> >  > Jan  7 22:45:14 athlon kernel:        de206840 000a0000 000a0454 de16c000
> >  > c016f5dc de16c000 dfa8a980 000a0000
> >  > Jan  7 22:45:14 athlon kernel:        00000001 00000000 00000001 de16dc6c
> >  > de16dc70 00002cb0 00000003 01388000
> >  > Jan  7 22:45:14 athlon kernel: Call Trace: [<c016f5dc>]  [<c0199a9d>]
> >  > [<c0198de7>]  [<c014d5b2>]  [<c0159255>]  [<c012437b>]  [<c0124415>]
> >  > [<c0107037>]  [<c0124821>]  [<c0108110>]  [<c0124d3f>]  [<c0108110>]
> >  > [<c0107214>]
> >  > Jan  7 22:45:14 athlon kernel: Code: 0f 0b 17 02 1e 88 25 c0 bf f2 ff ff
> >  > ff eb 97 e8 9a c3 fd ff
> >  > Jan  7 22:45:14 athlon kernel:  <6>note: X[171] exited with preempt_count 1
> > 
> > preempt_count ? Where did that come from?
> 
> It's an additional patch, belonging to swsusp2 (2.0.0.0.107)
> 
> >  >      -m /usr/src/linux-2.4.29-pre3-swsusp/System.map (specified)
> > 
> > swsusp too ?
> > 
> > Is this problem even reproducable on an unpatched 2.4 kernel ?
> 
> I can't reproduce the oops with 2.4.28 after the X-crash running glibc
> 2.3.4, no matter if swsusp is applied or not.


Hi Andreas,

I'm wondering who could create a VMA with Reserved pages, we know its not 
the agp code. 

The safer "solution" will be to remove the BUG() at get_user_pages().

Can you please apply the following patch and reproduce the 2.4.29-pre3 
X crash.

This will tell us the beginning and end of the VMA, which can give us a clue
which vma is this (my previous printk() debugging attempt is very unsuccessful).

If a VMA contains PG_reserved pages its probably a mapped-to-device area, and 
if it indeed is it must be marked as "VM_IO" - the kernel should not write 
this memory to disk.


--- a/mm/memory.c	2004-11-25 17:45:59.000000000 -0200
+++ b/mm/memory.c	2005-01-10 08:33:21.375622424 -0200
@@ -530,8 +530,9 @@
 		page_cache_release(pages[i]);
 	/* catch bad uses of PG_reserved on !VM_IO vma's */
 	printk(KERN_ERR "get_user_pages PG_reserved page on"
-			"vma:%p flags:%lx page:%d\n", savevma,
-			savevma->vm_flags, s);
+			"vma:%p vm_start:%lx vm_end:%lx vm_file:%p flags:%lx page:%d\n", 
+			savevma, savevma->vm_start, savevma->vm_end, 
+			savevma->vm_file, savevma->vm_flags, s);
 	BUG();
 	i = -EFAULT; 
 	goto out;


> The oops after X-crash with glibc 2.3.4 is reproducable with a clean
> 2.4.29pre3 kernel:
