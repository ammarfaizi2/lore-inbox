Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315525AbSEVKJT>; Wed, 22 May 2002 06:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315526AbSEVKJS>; Wed, 22 May 2002 06:09:18 -0400
Received: from [195.63.194.11] ([195.63.194.11]:17167 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315525AbSEVKJQ>; Wed, 22 May 2002 06:09:16 -0400
Message-ID: <3CEB5F75.4000009@evision-ventures.com>
Date: Wed, 22 May 2002 11:05:57 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <Pine.LNX.4.44.0205202211040.949-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------090001080003000307020103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090001080003000307020103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Remove support for /dev/port altogether.

1. It is not usable with ports which require 4 byte access.

2. The same can be achieved by using capabilities and su bits and so on.

3. __m68000__ doesn't even implement it and most other non i386 archs
"implement" it but apparently don't even care about endianess issues.

4. It's not standard.

5. seek() + port access is "racy" with respect to multiple usage.

6. Nothing is using it.

... and so on and so on ...

And finally, kernel size with it:

    text    data     bss     dec     hex filename
1480587  243280  259628 1983495  1e4407 vmlinux

kernel size without it:

[root@kozaczek linux]# size vmlinux
    text    data     bss     dec     hex filename
1480229  243184  259628 1983041  1e4241 vmlinux

Which means a saving of 454 bytes :-).

--------------090001080003000307020103
Content-Type: text/plain;
 name="kill-ports-2.5.17.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kill-ports-2.5.17.patch"

diff -urN linux-old/Documentation/devices.txt linux/Documentation/devices.txt
--- linux-old/Documentation/devices.txt	2002-05-21 07:07:37.000000000 +0200
+++ linux/Documentation/devices.txt	2002-05-22 11:38:47.000000000 +0200
@@ -90,7 +90,7 @@
 		  1 = /dev/mem		Physical memory access
 		  2 = /dev/kmem		Kernel virtual memory access
 		  3 = /dev/null		Null device
-		  4 = /dev/port		I/O port access
+		  4 = /dev/port		OBSOLETE - since 2.5.18
 		  5 = /dev/zero		Null byte source
 		  6 = /dev/core		OBSOLETE - replaced by /proc/kcore
 		  7 = /dev/full		Returns ENOSPC on write
diff -urN linux-old/drivers/char/mem.c linux/drivers/char/mem.c
--- linux-old/drivers/char/mem.c	2002-05-21 07:07:40.000000000 +0200
+++ linux/drivers/char/mem.c	2002-05-22 11:26:13.000000000 +0200
@@ -324,46 +324,6 @@
  	return virtr + wrote;
 }
 
-#if !defined(__mc68000__)
-static ssize_t read_port(struct file * file, char * buf,
-			 size_t count, loff_t *ppos)
-{
-	unsigned long i = *ppos;
-	char *tmp = buf;
-
-	if (verify_area(VERIFY_WRITE,buf,count))
-		return -EFAULT; 
-	while (count-- > 0 && i < 65536) {
-		if (__put_user(inb(i),tmp) < 0) 
-			return -EFAULT;  
-		i++;
-		tmp++;
-	}
-	*ppos = i;
-	return tmp-buf;
-}
-
-static ssize_t write_port(struct file * file, const char * buf,
-			  size_t count, loff_t *ppos)
-{
-	unsigned long i = *ppos;
-	const char * tmp = buf;
-
-	if (verify_area(VERIFY_READ,buf,count))
-		return -EFAULT;
-	while (count-- > 0 && i < 65536) {
-		char c;
-		if (__get_user(c, tmp)) 
-			return -EFAULT; 
-		outb(c,i);
-		i++;
-		tmp++;
-	}
-	*ppos = i;
-	return tmp-buf;
-}
-#endif
-
 static ssize_t read_null(struct file * file, char * buf,
 			 size_t count, loff_t *ppos)
 {
@@ -522,7 +482,7 @@
 	return ret;
 }
 
-static int open_port(struct inode * inode, struct file * filp)
+static int open_mem(struct inode * inode, struct file * filp)
 {
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
 }
@@ -532,7 +492,6 @@
 #define full_lseek      null_lseek
 #define write_zero	write_null
 #define read_full       read_zero
-#define open_mem	open_port
 #define open_kmem	open_mem
 
 static struct file_operations mem_fops = {
@@ -557,15 +516,6 @@
 	write:		write_null,
 };
 
-#if !defined(__mc68000__)
-static struct file_operations port_fops = {
-	llseek:		memory_lseek,
-	read:		read_port,
-	write:		write_port,
-	open:		open_port,
-};
-#endif
-
 static struct file_operations zero_fops = {
 	llseek:		zero_lseek,
 	read:		read_zero,
@@ -591,11 +541,6 @@
 		case 3:
 			filp->f_op = &null_fops;
 			break;
-#if !defined(__mc68000__)
-		case 4:
-			filp->f_op = &port_fops;
-			break;
-#endif
 		case 5:
 			filp->f_op = &zero_fops;
 			break;
@@ -628,7 +573,6 @@
 	{1, "mem",     S_IRUSR | S_IWUSR | S_IRGRP, &mem_fops},
 	{2, "kmem",    S_IRUSR | S_IWUSR | S_IRGRP, &kmem_fops},
 	{3, "null",    S_IRUGO | S_IWUGO,           &null_fops},
-	{4, "port",    S_IRUSR | S_IWUSR | S_IRGRP, &port_fops},
 	{5, "zero",    S_IRUGO | S_IWUGO,           &zero_fops},
 	{7, "full",    S_IRUGO | S_IWUGO,           &full_fops},
 	{8, "random",  S_IRUGO | S_IWUSR,           &random_fops},

--------------090001080003000307020103--

