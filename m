Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVHMQuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVHMQuU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 12:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbVHMQuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 12:50:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17129 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932202AbVHMQuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 12:50:18 -0400
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference
	between /dev/kmem and /dev/mem)
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>
References: <1123796188.17269.127.camel@localhost.localdomain>
	 <1123809302.17269.139.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>
Content-Type: multipart/mixed; boundary="=-fUGVhWDwmb6nAcjrmvf+"
Date: Sat, 13 Aug 2005 18:50:10 +0200
Message-Id: <1123951810.3187.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fUGVhWDwmb6nAcjrmvf+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-08-12 at 09:35 -0700, Linus Torvalds wrote:
> 
> On Thu, 11 Aug 2005, Steven Rostedt wrote:
> > 
> > Found the problem.  It is a bug with mmap_kmem.  The order of checks is
> > wrong, so here's the patch.  Attached is a little program that reads the
> > System map looking for the variable modprobe_path.  If it finds it, then
> > it opens /dev/kmem for read only and mmaping it to read the contents of
> > modprobe_path.
> 
> I'm actually more inclined to try to deprecate /dev/kmem.. I don't think 
> anybody has ever really used it except for some rootkits. It only exists 
> in the first place because it's historical.
> 
> We do need to support /dev/mem for X, but even that might go away some 
> day. 
> 
> So I'd be perfectly happy to fix this, but I'd be even happier if we made 
> the whole kmem thing a config variable (maybe even default it to "off").

attached is a simple patch that does exactly this...


--=-fUGVhWDwmb6nAcjrmvf+
Content-Disposition: attachment; filename=mem.patch
Content-Type: text/x-patch; name=mem.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -purN linux-before/drivers/char/Kconfig linux-2.6.12/drivers/char/Kconfig
--- linux-before/drivers/char/Kconfig	2005-08-13 18:38:11.210821000 +0200
+++ linux-2.6.12/drivers/char/Kconfig	2005-08-13 18:44:31.182935339 +0200
@@ -1000,6 +1000,12 @@ config MMTIMER
 	  The mmtimer device allows direct userspace access to the
 	  Altix system timer.
 
+config DEVKMEM
+	tristate "Userspace access to virtual kernel memory (/dev/kmem)"
+	help
+	  The /dev/kmem device allows userspace access to kernel virtual
+	  memory, which can be useful for kernel debugging.
+
 source "drivers/char/tpm/Kconfig"
 
 endmenu
diff -purN linux-before/drivers/char/mem.c linux-2.6.12/drivers/char/mem.c
--- linux-before/drivers/char/mem.c	2005-08-13 18:38:11.261815000 +0200
+++ linux-2.6.12/drivers/char/mem.c	2005-08-13 18:41:09.002351297 +0200
@@ -259,22 +259,6 @@ static int mmap_mem(struct file * file, 
 	return 0;
 }
 
-static int mmap_kmem(struct file * file, struct vm_area_struct * vma)
-{
-        unsigned long long val;
-	/*
-	 * RED-PEN: on some architectures there is more mapped memory
-	 * than available in mem_map which pfn_valid checks
-	 * for. Perhaps should add a new macro here.
-	 *
-	 * RED-PEN: vmalloc is not supported right now.
-	 */
-	if (!pfn_valid(vma->vm_pgoff))
-		return -EIO;
-	val = (u64)vma->vm_pgoff << PAGE_SHIFT;
-	vma->vm_pgoff = __pa(val) >> PAGE_SHIFT;
-	return mmap_mem(file, vma);
-}
 
 #ifdef CONFIG_CRASH_DUMP
 /*
@@ -313,6 +297,25 @@ static ssize_t read_oldmem(struct file *
 extern long vread(char *buf, char *addr, unsigned long count);
 extern long vwrite(char *buf, char *addr, unsigned long count);
 
+#ifdef CONFIG_DEVKMEM
+
+static int mmap_kmem(struct file * file, struct vm_area_struct * vma)
+{
+        unsigned long long val;
+	/*
+	 * RED-PEN: on some architectures there is more mapped memory
+	 * than available in mem_map which pfn_valid checks
+	 * for. Perhaps should add a new macro here.
+	 *
+	 * RED-PEN: vmalloc is not supported right now.
+	 */
+	if (!pfn_valid(vma->vm_pgoff))
+		return -EIO;
+	val = (u64)vma->vm_pgoff << PAGE_SHIFT;
+	vma->vm_pgoff = __pa(val) >> PAGE_SHIFT;
+	return mmap_mem(file, vma);
+}
+
 /*
  * This function reads the *virtual* memory as seen by the kernel.
  */
@@ -521,6 +524,8 @@ static ssize_t write_kmem(struct file * 
  	return virtr + wrote;
 }
 
+#endif
+
 #if (defined(CONFIG_ISA) || !defined(__mc68000__)) && (!defined(CONFIG_PPC_ISERIES) || defined(CONFIG_PCI))
 static ssize_t read_port(struct file * file, char __user * buf,
 			 size_t count, loff_t *ppos)
@@ -768,6 +773,7 @@ static struct file_operations mem_fops =
 	.open		= open_mem,
 };
 
+#ifdef CONFIG_DEVKMEM
 static struct file_operations kmem_fops = {
 	.llseek		= memory_lseek,
 	.read		= read_kmem,
@@ -775,6 +781,7 @@ static struct file_operations kmem_fops 
 	.mmap		= mmap_kmem,
 	.open		= open_kmem,
 };
+#endif
 
 static struct file_operations null_fops = {
 	.llseek		= null_lseek,
@@ -843,9 +850,11 @@ static int memory_open(struct inode * in
 		case 1:
 			filp->f_op = &mem_fops;
 			break;
+#ifdef CONFIG_DEVKMEM
 		case 2:
 			filp->f_op = &kmem_fops;
 			break;
+#endif
 		case 3:
 			filp->f_op = &null_fops;
 			break;
@@ -894,7 +903,9 @@ static const struct {
 	struct file_operations	*fops;
 } devlist[] = { /* list of minor devices */
 	{1, "mem",     S_IRUSR | S_IWUSR | S_IRGRP, &mem_fops},
+#ifdef CONFIG_DEVKMEM
 	{2, "kmem",    S_IRUSR | S_IWUSR | S_IRGRP, &kmem_fops},
+#endif
 	{3, "null",    S_IRUGO | S_IWUGO,           &null_fops},
 #if (defined(CONFIG_ISA) || !defined(__mc68000__)) && (!defined(CONFIG_PPC_ISERIES) || defined(CONFIG_PCI))
 	{4, "port",    S_IRUSR | S_IWUSR | S_IRGRP, &port_fops},

--=-fUGVhWDwmb6nAcjrmvf+--

