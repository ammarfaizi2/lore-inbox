Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265064AbUETJao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265064AbUETJao (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 05:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265020AbUETJao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 05:30:44 -0400
Received: from ozlabs.org ([203.10.76.45]:45200 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265064AbUETJal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 05:30:41 -0400
Subject: Re: [patch] bug in cpuid & msr on nosmp machine
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: castet.matthieu@free.fr,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040520015142.0ca69add.akpm@osdl.org>
References: <40AB8CDF.8060408@free.fr>
	 <20040520003240.75fd355d.akpm@osdl.org> <1085042076.7541.27.camel@bach>
	 <20040520015142.0ca69add.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1085045400.7541.32.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 20 May 2004 19:30:01 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-20 at 18:51, Andrew Morton wrote:
> How about this?

Complicated *and* doesn't solve the original problem.

How about this?

Name: Fix i386/x86_64 cpuid/msr BUG() on Impossible CPUs
Status: Trivial

Matthieu Castet <castet.matthieu@free.fr> pointed out that testing
cpu_online(cpu) on a UP system goes BUG().

That's because you're never supposed to ask cpu_online() about a CPU
which is >= NR_CPUS.  msr and cpuid devices use the minor to indicate
the CPU number.  Oops.

Fix is to explicitly test cpu < NR_CPUS.  Using cpu_online() is OK;
although the CPU might go down before you actually read the file, that
will simply cause junk to be returned.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7878-linux-2.6.6-bk6/arch/i386/kernel/cpuid.c .7878-linux-2.6.6-bk6.updated/arch/i386/kernel/cpuid.c
--- .7878-linux-2.6.6-bk6/arch/i386/kernel/cpuid.c	2004-05-20 10:35:22.000000000 +1000
+++ .7878-linux-2.6.6-bk6.updated/arch/i386/kernel/cpuid.c	2004-05-20 19:26:47.000000000 +1000
@@ -132,10 +132,10 @@ static ssize_t cpuid_read(struct file *f
 
 static int cpuid_open(struct inode *inode, struct file *file)
 {
-	int cpu = iminor(file->f_dentry->d_inode);
+	unsigned int cpu = iminor(file->f_dentry->d_inode);
 	struct cpuinfo_x86 *c = &(cpu_data)[cpu];
 
-	if (!cpu_online(cpu))
+	if (cpu >= NR_CPUS || !cpu_online(cpu))
 		return -ENXIO;	/* No such CPU */
 	if (c->cpuid_level < 0)
 		return -EIO;	/* CPUID not supported */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7878-linux-2.6.6-bk6/arch/i386/kernel/msr.c .7878-linux-2.6.6-bk6.updated/arch/i386/kernel/msr.c
--- .7878-linux-2.6.6-bk6/arch/i386/kernel/msr.c	2004-02-18 23:54:12.000000000 +1100
+++ .7878-linux-2.6.6-bk6.updated/arch/i386/kernel/msr.c	2004-05-20 19:27:01.000000000 +1000
@@ -238,10 +238,10 @@ static ssize_t msr_write(struct file * f
 
 static int msr_open(struct inode *inode, struct file *file)
 {
-  int cpu = iminor(file->f_dentry->d_inode);
+  unsigned int cpu = iminor(file->f_dentry->d_inode);
   struct cpuinfo_x86 *c = &(cpu_data)[cpu];
   
-  if (!cpu_online(cpu))
+  if (cpu >= NR_CPUS || !cpu_online(cpu))
     return -ENXIO;		/* No such CPU */
   if ( !cpu_has(c, X86_FEATURE_MSR) )
     return -EIO;		/* MSR not supported */

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

