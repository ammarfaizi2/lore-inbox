Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264586AbUEUXq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264586AbUEUXq0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265208AbUEUXpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:45:46 -0400
Received: from zeus.kernel.org ([204.152.189.113]:55731 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264586AbUEUXTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:19:49 -0400
Date: Thu, 20 May 2004 00:32:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: matthieu castet <castet.matthieu@free.fr>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] bug in cpuid & msr on nosmp machine
Message-Id: <20040520003240.75fd355d.akpm@osdl.org>
In-Reply-To: <40AB8CDF.8060408@free.fr>
References: <40AB8CDF.8060408@free.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matthieu castet <castet.matthieu@free.fr> wrote:
>
> on monocpu machine (and maybe even on smp machine), when you try to 
>  acces to a cpu that don't exist (/dev/cpu/1/cpuid), cpuid (msr) call 
>  cpu_online, but on nosmp machine if the cpu!=0 this procude a BUG();
>  So I add a check that verify if the cpu can exist before calling cpu_online.
> 
>  Matthieu CASTET
> 
> 
> [cpuid.patch  text/x-patch (589 bytes)]
>  --- linux/arch/i386/kernel/cpuid.c	2004-05-18 20:47:05.000000000 +0200
>  +++ linux-2.6.5/arch/i386/kernel/cpuid.c	2004-04-04 05:36:12.000000000 +0200
>  @@ -135,7 +135,7 @@
>     int cpu = iminor(file->f_dentry->d_inode);
>     struct cpuinfo_x86 *c = &(cpu_data)[cpu];
>   
>  -  if (cpu >= num_possible_cpus() || !cpu_online(cpu))
>  +  if (!cpu_online(cpu))
>       return -ENXIO;		/* No such CPU */
>     if ( c->cpuid_level < 0 )
>       return -EIO;		/* CPUID not supported */
> 

I think what you want here is

	if (!cpu_possible(cpu) || !cpu_online(cpu))
		return -ENXIO;

Like the below.  Rusty agree?


--- 25/arch/i386/kernel/cpuid.c~cpuid-msr-range-checking-fix	2004-05-20 00:30:21.812166544 -0700
+++ 25-akpm/arch/i386/kernel/cpuid.c	2004-05-20 00:31:16.607836336 -0700
@@ -133,10 +133,12 @@ static ssize_t cpuid_read(struct file *f
 static int cpuid_open(struct inode *inode, struct file *file)
 {
 	int cpu = iminor(file->f_dentry->d_inode);
-	struct cpuinfo_x86 *c = &(cpu_data)[cpu];
+	struct cpuinfo_x86 *c;
 
-	if (!cpu_online(cpu))
+	if (!cpu_possible(cpu) || !cpu_online(cpu))
 		return -ENXIO;	/* No such CPU */
+
+	c = &(cpu_data)[cpu];
 	if (c->cpuid_level < 0)
 		return -EIO;	/* CPUID not supported */
 
diff -puN arch/i386/kernel/msr.c~cpuid-msr-range-checking-fix arch/i386/kernel/msr.c
--- 25/arch/i386/kernel/msr.c~cpuid-msr-range-checking-fix	2004-05-20 00:30:21.836162896 -0700
+++ 25-akpm/arch/i386/kernel/msr.c	2004-05-20 00:31:56.952702984 -0700
@@ -239,10 +239,12 @@ static ssize_t msr_write(struct file * f
 static int msr_open(struct inode *inode, struct file *file)
 {
   int cpu = iminor(file->f_dentry->d_inode);
-  struct cpuinfo_x86 *c = &(cpu_data)[cpu];
-  
-  if (!cpu_online(cpu))
-    return -ENXIO;		/* No such CPU */
+  struct cpuinfo_x86 *c;
+
+  if (!cpu_possible(cpu) || !cpu_online(cpu))
+    return -ENXIO;	/* No such CPU */
+
+  c = &(cpu_data)[cpu];
   if ( !cpu_has(c, X86_FEATURE_MSR) )
     return -EIO;		/* MSR not supported */
   

_

