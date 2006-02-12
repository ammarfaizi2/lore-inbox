Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWBLRI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWBLRI0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 12:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWBLRI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 12:08:26 -0500
Received: from drugphish.ch ([69.55.226.176]:6873 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S1750781AbWBLRIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 12:08:25 -0500
Message-ID: <43EF6B7D.5080607@drugphish.ch>
Date: Sun, 12 Feb 2006 18:08:13 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, discuss@x86-64.org
Subject: trap int3 problem while porting a user space application and small
 cleanup patch
Content-Type: multipart/mixed;
 boundary="------------040303030708080800010805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040303030708080800010805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

For a while I've been working on a little tool called mpt-status to be 
able to monitor LSI based controllers. The source can be found here:

     http://www.drugphish.ch/~ratz/mpt-status/

The issue I'm trying to track down now is why I cannot get it to work on 
a x86_64 kernel (Sun Fire V20z with AMD Opteron(tm) Processor 252 on 
SLES 9 PL3). I suspect 32/64 bit issues between in my ioctl message 
passing between user space and kernel space. Unfortunately when I strace 
the kernel spits out tons of following entries:

mpt-status[16045] trap int3 rip:400acf rsp:7fbfff70b0 error:0
mpt-status[16045] trap int3 rip:4008f1 rsp:7fbfff70a8 error:0
mpt-status[16045] trap int3 rip:400b86 rsp:7fbfff70b0 error:0

I can only remotely guess what happened because I'm not sound on x64 
trap handling, so my question is: How can I best debug and address this 
issue in my tool?

I'm pretty sure it has something to do with me including kernel headers 
in a user space tool, but noone has done the sanitizing for the LSI 
related headers residing in drivers/message/fusion. It works on all 
32-bit machines I've tested so far.

Attached is a small code style cleanup patch that resulted from my 
skimming through the arch/x86_64/kernel/traps.c code to figure out what 
went haywire. If Andi is ok with it, please consider applying.

Signed-off-by: Roberto Nibali <ratz@drugphish.ch>

Best regards,
Roberto Nibali, ratz
-- 
echo 
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc

--------------040303030708080800010805
Content-Type: text/x-patch;
 name="x86_64_kernel_traps_cleanup-1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x86_64_kernel_traps_cleanup-1.diff"

diff --git a/arch/x86_64/kernel/traps.c b/arch/x86_64/kernel/traps.c
index ee1b2da..3442a56 100644
--- a/arch/x86_64/kernel/traps.c
+++ b/arch/x86_64/kernel/traps.c
@@ -108,7 +108,7 @@ int printk_address(unsigned long address
 	if (!modname) 
 		modname = delim = ""; 		
         return printk("<%016lx>{%s%s%s%s%+ld}",
-		      address,delim,modname,delim,symname,offset); 
+		      address, delim, modname, delim, symname, offset); 
 } 
 #else
 int printk_address(unsigned long address)
@@ -320,13 +320,12 @@ void show_registers(struct pt_regs *regs
 		show_stack(NULL, (unsigned long*)rsp);
 
 		printk("\nCode: ");
-		if(regs->rip < PAGE_OFFSET)
+		if (regs->rip < PAGE_OFFSET)
 			goto bad;
 
-		for(i=0;i<20;i++)
-		{
+		for (i=0; i<20; i++) {
 			unsigned char c;
-			if(__get_user(c, &((unsigned char*)regs->rip)[i])) {
+			if (__get_user(c, &((unsigned char*)regs->rip)[i])) {
 bad:
 				printk(" Bad RIP value.");
 				break;
@@ -465,7 +464,7 @@ static void __kprobes do_trap(int trapnr
 			printk(KERN_INFO
 			       "%s[%d] trap %s rip:%lx rsp:%lx error:%lx\n",
 			       tsk->comm, tsk->pid, str,
-			       regs->rip,regs->rsp,error_code); 
+			       regs->rip, regs->rsp, error_code); 
 
 		if (info)
 			force_sig_info(signr, info, tsk);
@@ -479,9 +478,9 @@ static void __kprobes do_trap(int trapnr
 	{	     
 		const struct exception_table_entry *fixup;
 		fixup = search_exception_tables(regs->rip);
-		if (fixup) {
+		if (fixup)
 			regs->rip = fixup->fixup;
-		} else	
+		else	
 			die(str, regs, error_code);
 		return;
 	}
@@ -554,7 +553,7 @@ asmlinkage void __kprobes do_general_pro
 			printk(KERN_INFO
 		       "%s[%d] general protection rip:%lx rsp:%lx error:%lx\n",
 			       tsk->comm, tsk->pid,
-			       regs->rip,regs->rsp,error_code); 
+			       regs->rip, regs->rsp, error_code); 
 
 		force_sig(SIGSEGV, tsk);
 		return;

--------------040303030708080800010805--
