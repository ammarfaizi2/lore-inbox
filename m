Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVAMHGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVAMHGX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 02:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVAMHGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 02:06:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:15284 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261180AbVAMHGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 02:06:13 -0500
Date: Wed, 12 Jan 2005 23:05:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steve <s.egbert@sbcglobal.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-r1 MTRR bug
Message-Id: <20050112230553.683a813b.akpm@osdl.org>
In-Reply-To: <41E595E9.8040805@sbcglobal.net>
References: <41E595E9.8040805@sbcglobal.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve <s.egbert@sbcglobal.net> wrote:
>
>  For the Athlon 2100, I get the following outputs and then the VGA 
>  console is frozen from further output (but it doesn't prevent the full 
>  bootup into X windows session of which I am able to resume normal 
>  Linux/X session, but not able to regain any virtual console session.)

hm.  Not sure what could have caused that.

>  The virtual console (locked) shows the following outputs:
> 
>  vesafb: scrolling: redraw:

Have you tried disabling vesafb in config?

>  mtrr: size and base must be multiples of 4kiB  (<<-- this line is 
>  repeated 20 times).

Could you add this so we can track down the culprit?

--- 25/arch/i386/kernel/cpu/mtrr/main.c~mtrr-size-and-base-debug	2005-01-12 23:01:03.732426224 -0800
+++ 25-akpm/arch/i386/kernel/cpu/mtrr/main.c	2005-01-12 23:03:14.081610136 -0800
@@ -375,6 +375,19 @@ int mtrr_add_page(unsigned long base, un
 	return error;
 }
 
+static int mtrr_check(unsigned long base, unsigned long size)
+{
+	if ((base & (PAGE_SIZE - 1)) || (size & (PAGE_SIZE - 1))) {
+		printk(KERN_WARNING
+			"mtrr: size and base must be multiples of 4 kiB\n");
+		printk(KERN_DEBUG
+			"mtrr: size: 0x%lx  base: 0x%lx\n", size, base);
+		dump_stack();
+		return -1;
+	}
+	return 0;
+}
+
 /**
  *	mtrr_add - Add a memory type region
  *	@base: Physical base address of region
@@ -415,11 +428,8 @@ int
 mtrr_add(unsigned long base, unsigned long size, unsigned int type,
 	 char increment)
 {
-	if ((base & (PAGE_SIZE - 1)) || (size & (PAGE_SIZE - 1))) {
-		printk(KERN_WARNING "mtrr: size and base must be multiples of 4 kiB\n");
-		printk(KERN_DEBUG "mtrr: size: 0x%lx  base: 0x%lx\n", size, base);
+	if (mtrr_check(base, size))
 		return -EINVAL;
-	}
 	return mtrr_add_page(base >> PAGE_SHIFT, size >> PAGE_SHIFT, type,
 			     increment);
 }
@@ -511,11 +521,8 @@ int mtrr_del_page(int reg, unsigned long
 int
 mtrr_del(int reg, unsigned long base, unsigned long size)
 {
-	if ((base & (PAGE_SIZE - 1)) || (size & (PAGE_SIZE - 1))) {
-		printk(KERN_INFO "mtrr: size and base must be multiples of 4 kiB\n");
-		printk(KERN_DEBUG "mtrr: size: 0x%lx  base: 0x%lx\n", size, base);
+	if (mtrr_check(base, size))
 		return -EINVAL;
-	}
 	return mtrr_del_page(reg, base >> PAGE_SHIFT, size >> PAGE_SHIFT);
 }
 
_

