Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276708AbRJBVlO>; Tue, 2 Oct 2001 17:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276710AbRJBVlE>; Tue, 2 Oct 2001 17:41:04 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:16654 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S276708AbRJBVkv>;
	Tue, 2 Oct 2001 17:40:51 -0400
Date: Tue, 2 Oct 2001 23:41:15 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: System reset on Kernel 2.4.10
Message-ID: <20011002234115.A1891@vana.vc.cvut.cz>
In-Reply-To: <527872464EC@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <527872464EC@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2001 at 11:02:28PM +0000, Petr Vandrovec wrote:
> On  2 Oct 01 at 23:52, VDA wrote:
> > V> Straced vmlinux does not reboot.
> > V> Kernel: 2.4.10+ext3+preempt
> > 
> > Well... sometimes it reboots too.
> > Once it rebooted ~10 mins after strace (system was at zero load).
> > Also it rebooted after two strace's in succession.
> 
> Look at fs/binfmt_elf.c, at line 642 (in -ac2). There is
> 
> error = elf_map(....)
> 
> but nobody bothers with checking error value, it even tries it
> to use as an offset if stars are in wrong constellation.
> If you could add these lines below the call:
> 
> if ((unsigned long)error >= (unsigned long)(-256)) {
>   set_fs(old_fs);
>   printk(KERN_DEBUG "Something went wrong with elf_map()\n");
>   kfree(elf_phdata);
>   send_sig(SIGSEGV, current, 0);
>   return 0;
> }
> 
> and then report results...

Well, I was not able to trigger reboot with unpatched kernel. With
patched one behavior looks same to me, except that elf_map went wrong
is printed by kernel.

I was not able to find where problem could be with unpatched
kernel, but arguments passed to do_brk(), set into mm->start_brk, 
{start,end}_code and so on looks very suspicious... But as on my 
system it does not crash neither with nor without patch below, I 
leave answer on someone else.

Btw, my system is 2.4.10-ac2, SMP PIII, compiled with Debian 2.95.4.
						Petr Vandrovec
						vandrove@vc.cvut.cz


--- linux/fs/binfmt_elf.c.xx	Mon Oct  1 18:34:46 2001
+++ linux/fs/binfmt_elf.c	Tue Oct  2 23:04:18 2001
@@ -640,7 +640,13 @@
 		}
 
 		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt, elf_prot, elf_flags);
-
+		if ((unsigned long)error >= (unsigned long)(-256)) {
+			set_fs(old_fs);
+			printk(KERN_DEBUG "elf_map went wrong\n");
+			kfree(elf_phdata);
+			send_sig(SIGSEGV, current, 0);
+			return 0;
+		}
 		if (!load_addr_set) {
 			load_addr_set = 1;
 			load_addr = (elf_ppnt->p_vaddr - elf_ppnt->p_offset);
