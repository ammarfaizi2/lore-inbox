Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262550AbVA0KMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbVA0KMs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 05:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbVA0KMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 05:12:33 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:40708 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262544AbVA0KMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 05:12:05 -0500
Date: Thu, 27 Jan 2005 10:12:01 +0000
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: Patch 1/6  introduce sysctl
Message-ID: <20050127101201.GB9760@infradead.org>
References: <20050127101117.GA9760@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127101117.GA9760@infradead.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This first patch of the series introduces a sysctl (default off) that
enables/disables the randomisation feature globally. Since randomisation may
make it harder to debug really tricky situations (reproducability goes
down), the sysadmin needs a way to disable it globally.

Signed-off-by: Arjan van de Ven <arjan@infradead.org>


diff -purN linux-2.6.11-rc2-bk4/include/linux/kernel.h linux-step-1/include/linux/kernel.h
--- linux-2.6.11-rc2-bk4/include/linux/kernel.h	2005-01-26 18:24:39.000000000 +0100
+++ linux-step-1/include/linux/kernel.h	2005-01-26 19:04:58.016540168 +0100
@@ -278,6 +278,9 @@ struct sysinfo {
 extern void BUILD_BUG(void);
 #define BUILD_BUG_ON(condition) do { if (condition) BUILD_BUG(); } while(0)
 
+
+extern int randomize_va_space; 
+
 /* Trap pasters of __FUNCTION__ at compile-time */
 #if __GNUC__ > 2 || __GNUC_MINOR__ >= 95
 #define __FUNCTION__ (__func__)
diff -purN linux-2.6.11-rc2-bk4/include/linux/sysctl.h linux-step-1/include/linux/sysctl.h
--- linux-2.6.11-rc2-bk4/include/linux/sysctl.h	2005-01-26 18:24:39.000000000 +0100
+++ linux-step-1/include/linux/sysctl.h	2005-01-26 19:01:13.640650488 +0100
@@ -135,6 +135,7 @@ enum
 	KERN_HZ_TIMER=65,	/* int: hz timer on or off */
 	KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
 	KERN_BOOTLOADER_TYPE=67, /* int: boot loader type */
+	KERN_RANDOMIZE=68, /* int: randomize virtual address space */
 };
 
 
diff -purN linux-2.6.11-rc2-bk4/kernel/sysctl.c linux-step-1/kernel/sysctl.c
--- linux-2.6.11-rc2-bk4/kernel/sysctl.c	2005-01-26 18:24:39.000000000 +0100
+++ linux-step-1/kernel/sysctl.c	2005-01-26 19:03:44.000000000 +0100
@@ -122,6 +122,8 @@ extern int sysctl_hz_timer;
 extern int acct_parm[];
 #endif
 
+int randomize_va_space = 0;
+
 static int parse_table(int __user *, int, void __user *, size_t __user *, void __user *, size_t,
 		       ctl_table *, void **);
 static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
@@ -633,6 +635,15 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+	{
+		.ctl_name	= KERN_RANDOMIZE,
+		.procname	= "randomize_va_space",
+		.data		= &randomize_va_space,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+
 	{ .ctl_name = 0 }
 };
 

