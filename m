Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317406AbSFRNcL>; Tue, 18 Jun 2002 09:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317407AbSFRNcK>; Tue, 18 Jun 2002 09:32:10 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:17596 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317406AbSFRNcI>; Tue, 18 Jun 2002 09:32:08 -0400
Message-Id: <200206181332.g5IDW5r54694@westrelay01.boulder.ibm.com>
User-Agent: Pan/0.11.2 (Unix)
From: "Vamsi Krishna S." <vamsi_krishna@in.ibm.com>
To: mgross@unix-os.sc.intel.com, linux-kernel@vger.kernel.org,
       vamsi_krishna@in.ibm.com
Subject: Re: [PATCH] Multi-threaded core dumps for 2.5.21.
Date: Tue, 18 Jun 2002 19:11:08 +0530
References: <200206142310.g5ENADP23772@unix-os.sc.intel.com>
Reply-To: vamsi_krishna@in.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

You are capturing the registers of the thread dumping core
twice in this patch. Please apply on top of your patch:

--- tcore/fs/binfmt_elf.c.ori	Mon Jun 17 15:02:27 2002
+++ tcore/fs/binfmt_elf.c	Mon Jun 17 15:02:49 2002
@@ -1203,22 +1203,6 @@
 
 	}
 
-	memset(&prstatus, 0, sizeof(prstatus));
-	/*
-	 * This transfers the registers from regs into the standard
-	 * coredump arrangement, whatever that is.
-	 */
-#ifdef ELF_CORE_COPY_REGS
-	ELF_CORE_COPY_REGS(prstatus.pr_reg, regs)
-#else
-	if (sizeof(elf_gregset_t) != sizeof(struct pt_regs))
-	{
-		printk("sizeof(elf_gregset_t) (%ld) != sizeof(struct pt_regs) (%ld)\n",
-			(long)sizeof(elf_gregset_t), (long)sizeof(struct pt_regs));
-	}
-	else
-		*(struct pt_regs *)&prstatus.pr_reg = *regs;
-#endif
 
 	 /* capture the status of all other threads */
 	if (signr) {


Same problem is there on the patch you posted for 2.4.18 too, the above will
apply with a slight offset.

Vamsi Krishna S.
Linux Technology Center, 
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi_krishna@in.ibm.com

On Sat, 15 Jun 2002 04:45:56 +0530, mgross wrote:

> Attached is a re-base of the 2.5.18 patch posted last week.
> 
> This patch has been tested on my SMP system and seems very stable, so far. I
> would like very much to see this feature added to the 2.5.x kernels and more
> milage given to it.
> 
> For ISV's not having the ability to create core dumps for pthread applications
> is a strong justification for not using Linux. Now is a good time for Linux
> support the ISV's WRT core files for multi-threaded applications.
> 
> To use the core files from multi-threaded applications, created with this patch
> you may need to strip the objects from /lib/libpthread. For my system 'strip
> /lib/libpthread-0.9.so makes things good, YMMV.
> 
> Please apply this patch.
> 
> --mgross
