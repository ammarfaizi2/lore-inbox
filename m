Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWHITdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWHITdH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 15:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWHITdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 15:33:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51148 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751314AbWHITdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 15:33:05 -0400
Date: Wed, 9 Aug 2006 12:32:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>, linux-kernel@vger.kernel.org,
       mingo@redhat.com, arjan@infradead.org
Subject: Re: [BUG?] possible recursive locking detected (blkdev_open)
Message-Id: <20060809123241.fb2cca9c.akpm@osdl.org>
In-Reply-To: <20060809175642.GC10930@redhat.com>
References: <200608090757.32006.eike-kernel@sf-tec.de>
	<20060809013034.ac15526a.akpm@osdl.org>
	<20060809175642.GC10930@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2006 13:56:42 -0400
Dave Jones <davej@redhat.com> wrote:

> On Wed, Aug 09, 2006 at 01:30:34AM -0700, Andrew Morton wrote:
>  > On Wed, 9 Aug 2006 07:57:31 +0200
>  > Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
>  > 
>  > > =============================================
>  > > [ INFO: possible recursive locking detected ]
>  > > ---------------------------------------------
>  > 
>  > kernel version?
>  
> This question comes up time after time when we get lockdep reports.
> Lets do the same thing we do for oopses - print out the version in the report.
> It's an extra line of output though.  We could tack it on the end of the
> INFO: lines, but that screws up Ingo's pretty output.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> 
> --- linux-2.6/kernel/lockdep.c~	2006-08-09 13:53:49.000000000 -0400
> +++ linux-2.6/kernel/lockdep.c	2006-08-09 13:53:59.000000000 -0400
> @@ -36,6 +36,7 @@
>  #include <linux/stacktrace.h>
>  #include <linux/debug_locks.h>
>  #include <linux/irqflags.h>
> +#include <linux/utsname.h>
>  
>  #include <asm/sections.h>
> @@ -524,6 +524,9 @@ print_circular_bug_header(struct lock_li

hm, corrupted patch.  Needed a blank line before the @@ line,

>  	printk("\n=======================================================\n");
>  	printk(  "[ INFO: possible circular locking dependency detected ]\n");
> +	printk(  "%s %.*s\n", system_utsname.release,
> +		(int)strcspn(system_utsname.version, " "),
> +		system_utsname.version);

argh.  Every time someone adds one of these I get to go and fix up
namespaces-utsname-*.patch again.

So I did it as below:

--- a/kernel/lockdep.c~lockdep-print-kernel-version
+++ a/kernel/lockdep.c
@@ -36,6 +36,7 @@
 #include <linux/stacktrace.h>
 #include <linux/debug_locks.h>
 #include <linux/irqflags.h>
+#include <linux/utsname.h>
 
 #include <asm/sections.h>
 
@@ -508,6 +509,13 @@ print_circular_bug_entry(struct lock_lis
 	return 0;
 }
 
+static void print_kernel_version(void)
+{
+	printk("%s %.*s\n", system_utsname.release,
+		(int)strcspn(system_utsname.version, " "),
+		system_utsname.version);
+}
+
 /*
  * When a circular dependency is detected, print the
  * header first:
@@ -524,6 +532,7 @@ print_circular_bug_header(struct lock_li
 
 	printk("\n=======================================================\n");
 	printk(  "[ INFO: possible circular locking dependency detected ]\n");
+	print_kernel_version();
 	printk(  "-------------------------------------------------------\n");
 	printk("%s/%d is trying to acquire lock:\n",
 		curr->comm, curr->pid);
@@ -705,6 +714,7 @@ print_bad_irq_dependency(struct task_str
 	printk("\n======================================================\n");
 	printk(  "[ INFO: %s-safe -> %s-unsafe lock order detected ]\n",
 		irqclass, irqclass);
+	print_kernel_version();
 	printk(  "------------------------------------------------------\n");
 	printk("%s/%d [HC%u[%lu]:SC%u[%lu]:HE%u:SE%u] is trying to acquire:\n",
 		curr->comm, curr->pid,
@@ -786,6 +796,7 @@ print_deadlock_bug(struct task_struct *c
 
 	printk("\n=============================================\n");
 	printk(  "[ INFO: possible recursive locking detected ]\n");
+	print_kernel_version();
 	printk(  "---------------------------------------------\n");
 	printk("%s/%d is trying to acquire lock:\n",
 		curr->comm, curr->pid);
@@ -1368,6 +1379,7 @@ print_irq_inversion_bug(struct task_stru
 
 	printk("\n=========================================================\n");
 	printk(  "[ INFO: possible irq lock inversion dependency detected ]\n");
+	print_kernel_version();
 	printk(  "---------------------------------------------------------\n");
 	printk("%s/%d just changed the state of lock:\n",
 		curr->comm, curr->pid);
@@ -1462,6 +1474,7 @@ print_usage_bug(struct task_struct *curr
 
 	printk("\n=================================\n");
 	printk(  "[ INFO: inconsistent lock state ]\n");
+	print_kernel_version();
 	printk(  "---------------------------------\n");
 
 	printk("inconsistent {%s} -> {%s} usage.\n",
_

