Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265086AbUEUXq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbUEUXq1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264657AbUEUXpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:45:17 -0400
Received: from zeus.kernel.org ([204.152.189.113]:55731 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265086AbUEUXUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:20:05 -0400
Date: Thu, 20 May 2004 01:51:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: castet.matthieu@free.fr, linux-kernel@vger.kernel.org
Subject: Re: [patch] bug in cpuid & msr on nosmp machine
Message-Id: <20040520015142.0ca69add.akpm@osdl.org>
In-Reply-To: <1085042076.7541.27.camel@bach>
References: <40AB8CDF.8060408@free.fr>
	<20040520003240.75fd355d.akpm@osdl.org>
	<1085042076.7541.27.camel@bach>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> On Thu, 2004-05-20 at 17:32, Andrew Morton wrote:
> > I think what you want here is
> > 
> > 	if (!cpu_possible(cpu) || !cpu_online(cpu))
> > 		return -ENXIO;
> 
> It works, but it's not really correct.  cpu_possible() is correct, but
> cpu_online() might no longer be true by the time do_cpu_read() calls
> do_cpu_id().

mutter.  Are we likely to see any ia32 or x86_64 hotplug-cpu machines?

> One way would be to do lock_cpu_hotplug() in cpuid_open() and introduce
> a cpuid_close() which would do unlock_cpu_hotplug().  Another would be
> to drop the check here, and fail the actual read.  A final way is to do
> no checks, in which case it becomes a noop if the cpu is offline.

Too many options for me!

Doing lock_cpu_hotplug() in open() would allow an app to take that lock
permanently.

How about this?

 25-akpm/arch/i386/kernel/cpuid.c |   38 +++++++++++++++-----
 25-akpm/arch/i386/kernel/msr.c   |   74 ++++++++++++++++++++++++++++-----------
 2 files changed, 85 insertions(+), 27 deletions(-)

diff -puN arch/i386/kernel/cpuid.c~cpuid-msr-range-checking-fix arch/i386/kernel/cpuid.c
--- 25/arch/i386/kernel/cpuid.c~cpuid-msr-range-checking-fix	2004-05-20 01:51:19.395701600 -0700
+++ 25-akpm/arch/i386/kernel/cpuid.c	2004-05-20 01:51:19.400700840 -0700
@@ -115,9 +115,19 @@ static ssize_t cpuid_read(struct file *f
 	size_t rv;
 	u32 reg = *ppos;
 	int cpu = iminor(file->f_dentry->d_inode);
+	ssize_t ret = 0;
 
-	if (count % 16)
-		return -EINVAL;	/* Invalid chunk size */
+	lock_cpu_hotplug();
+
+	if (!cpu_possible(cpu) || !cpu_online(cpu)) {
+		ret = -ENXIO;	/* No such CPU */
+		goto out;
+	}
+
+	if (count % 16) {
+		ret = -EINVAL;	/* Invalid chunk size */
+		goto out;
+	}
 
 	for (rv = 0; count; count -= 16) {
 		do_cpuid(cpu, reg, data);
@@ -127,20 +137,32 @@ static ssize_t cpuid_read(struct file *f
 		*ppos = reg++;
 	}
 
-	return ((char *)tmp) - buf;
+	ret = ((char *)tmp) - buf;
+out:
+	lock_cpu_hotplug();
+	return ret;
 }
 
 static int cpuid_open(struct inode *inode, struct file *file)
 {
 	int cpu = iminor(file->f_dentry->d_inode);
-	struct cpuinfo_x86 *c = &(cpu_data)[cpu];
+	struct cpuinfo_x86 *c;
+	int ret = 0;
 
-	if (!cpu_online(cpu))
-		return -ENXIO;	/* No such CPU */
+	lock_cpu_hotplug();
+
+	if (!cpu_possible(cpu) || !cpu_online(cpu)) {
+		ret = -ENXIO;	/* No such CPU */
+		goot out;
+	}
+
+	c = &(cpu_data)[cpu];
 	if (c->cpuid_level < 0)
-		return -EIO;	/* CPUID not supported */
+		ret = -EIO;	/* CPUID not supported */
 
-	return 0;
+out:
+	unlock_cpu_hotplug();
+	return ret;
 }
 
 /*
diff -puN arch/i386/kernel/msr.c~cpuid-msr-range-checking-fix arch/i386/kernel/msr.c
--- 25/arch/i386/kernel/msr.c~cpuid-msr-range-checking-fix	2004-05-20 01:51:19.396701448 -0700
+++ 25-akpm/arch/i386/kernel/msr.c	2004-05-20 01:51:19.401700688 -0700
@@ -195,20 +195,37 @@ static ssize_t msr_read(struct file * fi
   u32 reg = *ppos;
   int cpu = iminor(file->f_dentry->d_inode);
   int err;
+  ssize_t ret = 0;
 
-  if ( count % 8 )
-    return -EINVAL; /* Invalid chunk size */
+  lock_cpu_hotplug();
+
+  if (!cpu_possible(cpu) || !cpu_online(cpu)) {
+    ret = -ENXIO;	/* No such CPU */
+    goto out;
+  }
+
+  if ( count % 8 ) {
+    ret = -EINVAL; /* Invalid chunk size */
+    goto out;
+  }
   
   for ( rv = 0 ; count ; count -= 8 ) {
     err = do_rdmsr(cpu, reg, &data[0], &data[1]);
-    if ( err )
-      return err;
-    if ( copy_to_user(tmp,&data,8) )
-      return -EFAULT;
+    if ( err ) {
+      ret = err;
+      goto out;
+    }
+    if ( copy_to_user(tmp,&data,8) ) {
+      ret = -EFAULT;
+      goto out;
+    }
     tmp += 2;
   }
 
-  return ((char *)tmp) - buf;
+  ret = ((char *)tmp) - buf;
+out:
+  unlock_cpu_hotplug();
+  return ret;
 }
 
 static ssize_t msr_write(struct file * file, const char __user * buf,
@@ -220,29 +237,48 @@ static ssize_t msr_write(struct file * f
   u32 reg = *ppos;
   int cpu = iminor(file->f_dentry->d_inode);
   int err;
+  int ret = 0;
+
+  lock_cpu_hotplug();
+
+  if (!cpu_possible(cpu) || !cpu_online(cpu)) {
+    ret = -ENXIO;	/* No such CPU */
+    goto out;
+  }
+
+  if ( count % 8 ) {
+    ret = -EINVAL; /* Invalid chunk size */
+    goto out;
+  }
 
-  if ( count % 8 )
-    return -EINVAL; /* Invalid chunk size */
-  
   for ( rv = 0 ; count ; count -= 8 ) {
-    if ( copy_from_user(&data,tmp,8) )
-      return -EFAULT;
+    if ( copy_from_user(&data,tmp,8) ) {
+      ret = -EFAULT;
+      goto out;
+    }
     err = do_wrmsr(cpu, reg, data[0], data[1]);
-    if ( err )
-      return err;
+    if ( err ) {
+      ret = err;
+      goto out;
+    }
     tmp += 2;
   }
 
-  return ((char *)tmp) - buf;
+  ret = ((char *)tmp) - buf;
+out:
+  unlock_cpu_hotplug();
+  return ret;
 }
 
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

