Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131039AbQKNOeh>; Tue, 14 Nov 2000 09:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130414AbQKNOe1>; Tue, 14 Nov 2000 09:34:27 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:43760 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S131039AbQKNOeQ>;
	Tue, 14 Nov 2000 09:34:16 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <8urb58$k07$1@alfie.demon.co.uk> 
In-Reply-To: <8urb58$k07$1@alfie.demon.co.uk>  <14864.6812.849398.988598@ns.caldera.de> <Pine.LNX.4.21.0011131655430.22139-100000@ferret.lmh.ox.ac.uk> <14864.12007.216381.254700@ns.caldera.de> 
To: torvalds@transmeta.com, Nick.Holloway@pyrites.org.uk (Nick Holloway)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Modprobe local root exploit 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Nov 2000 14:01:15 +0000
Message-ID: <19770.974210475@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nick.Holloway@pyrites.org.uk said:
>  Someone could make it a bit smaller by patching fs/jffs/interp.c and
> arch/ppc/xmon/xmon.c to use the kernel lib, rather than their own
> versions. 

Makes sense to me. Patch attached. As an added bonus, this patch (not the
ctype change) also speeds up JFFS mounting by about an order of magnitude - 
by reading from the flash 4KiB at a time into a RAM cache, rather than 
scanning it a word at a time. Yeah, alright - I was looking for an excuse 
to update intrep.c anyway :)

Index: intrep.c
===================================================================
RCS file: /inst/cvs/linux/fs/jffs/Attic/intrep.c,v
retrieving revision 1.1.2.4
diff -u -r1.1.2.4 intrep.c
--- intrep.c	2000/09/11 08:19:11	1.1.2.4
+++ intrep.c	2000/11/14 13:58:20
@@ -10,7 +10,8 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
- * $Id: intrep.c,v 1.69 2000/08/24 09:35:47 dwmw2 Exp $
+ * - Based on Id: intrep.c,v 1.71 2000/10/27 16:51:29 dwmw2 Exp
+ * - With the ctype() changes from v1.77.
  *
  * Ported to Linux 2.3.x and MTD:
  * Copyright (C) 2000  Alexander Larsson (alex@cendio.se), Cendio Systems AB
@@ -68,15 +69,11 @@
 #include <linux/version.h>
 #include <linux/smp_lock.h>
 #include <linux/sched.h>
+#include <linux/ctype.h>
 
-
 #include "intrep.h"
 #include "jffs_fm.h"
 
-#if LINUX_VERSION_CODE < 0x20300
-#define set_current_state(x) do{current->state = x;} while (0)
-#endif
-
 #if defined(JFFS_MEMORY_DEBUG) && JFFS_MEMORY_DEBUG
 long no_jffs_file = 0;
 long no_jffs_node = 0;
@@ -94,48 +91,7 @@
 static __u8 flash_read_u8(struct mtd_info *mtd, loff_t from);
 
 #if 1
-#define _U      01
-#define _L      02
-#define _N      04
-#define _S      010
-#define _P      020
-#define _C      040
-#define _X      0100
-#define _B      0200
-
-const unsigned char jffs_ctype_[1 + 256] = {
-	0,
-	_C,     _C,     _C,     _C,     _C,     _C,     _C,     _C,
-	_C,     _C|_S,  _C|_S,  _C|_S,  _C|_S,  _C|_S,  _C,     _C,
-	_C,     _C,     _C,     _C,     _C,     _C,     _C,     _C,
-	_C,     _C,     _C,     _C,     _C,     _C,     _C,     _C,
-	_S|_B,  _P,     _P,     _P,     _P,     _P,     _P,     _P,
-	_P,     _P,     _P,     _P,     _P,     _P,     _P,     _P,
-	_N,     _N,     _N,     _N,     _N,     _N,     _N,     _N,
-	_N,     _N,     _P,     _P,     _P,     _P,     _P,     _P,
-	_P,     _U|_X,  _U|_X,  _U|_X,  _U|_X,  _U|_X,  _U|_X,  _U,
-	_U,     _U,     _U,     _U,     _U,     _U,     _U,     _U,
-	_U,     _U,     _U,     _U,     _U,     _U,     _U,     _U,
-	_U,     _U,     _U,     _P,     _P,     _P,     _P,     _P,
-	_P,     _L|_X,  _L|_X,  _L|_X,  _L|_X,  _L|_X,  _L|_X,  _L,
-	_L,     _L,     _L,     _L,     _L,     _L,     _L,     _L,
-	_L,     _L,     _L,     _L,     _L,     _L,     _L,     _L,
-	_L,     _L,     _L,     _P,     _P,     _P,     _P,     _C
-};
-
-#define jffs_isalpha(c)      ((jffs_ctype_+1)[(int)c]&(_U|_L))
-#define jffs_isupper(c)      ((jffs_ctype_+1)[(int)c]&_U)
-#define jffs_islower(c)      ((jffs_ctype_+1)[(int)c]&_L)
-#define jffs_isdigit(c)      ((jffs_ctype_+1)[(int)c]&_N)
-#define jffs_isxdigit(c)     ((jffs_ctype_+1)[(int)c]&(_X|_N))
-#define jffs_isspace(c)      ((jffs_ctype_+1)[(int)c]&_S)
-#define jffs_ispunct(c)      ((jffs_ctype_+1)[(int)c]&_P)
-#define jffs_isalnum(c)      ((jffs_ctype_+1)[(int)c]&(_U|_L|_N))
-#define jffs_isprint(c)      ((jffs_ctype_+1)[(int)c]&(_P|_U|_L|_N|_B))
-#define jffs_isgraph(c)      ((jffs_ctype_+1)[(int)c]&(_P|_U|_L|_N))
-#define jffs_iscntrl(c)      ((jffs_ctype_+1)[(int)c]&_C)
-
-void
+static void
 jffs_hexdump(struct mtd_info *mtd, loff_t pos, int size)
 {
 	char line[16];
@@ -169,7 +125,7 @@
 		printk("  ");
 
 		for (i = 0; i < j; i++) {
-			if (jffs_isgraph(line[i])) {
+			if (isgraph(line[i])) {
 				printk("%c", line[i]);
 			}
 			else {
@@ -193,9 +149,12 @@
 	size_t retlen;
 	int res;
 
+	D3(printk(KERN_NOTICE "flash_safe_read(%p, %08x, %p, %08x)\n",
+		  mtd, from, buf, count));
+
 	res = MTD_READ(mtd, from, count, &retlen, buf);
 	if (retlen != count) {
-		printk("Didn't read all bytes in flash_safe_read(). Returned %d\n", res);
+		panic("Didn't read all bytes in flash_safe_read(). Returned %d\n", res);
 	}
 	return res?res:retlen;
 }
@@ -367,9 +326,37 @@
 {
 	__u32 sum = 0;
 	loff_t ptr = start;
-	while (size-- > 0) {
-		sum += flash_read_u8(mtd, ptr++);
+	__u8 *read_buf;
+	int i, length;
+
+	/* Allocate read buffer */
+	read_buf = (__u8 *) kmalloc (sizeof(__u8) * 4096, GFP_KERNEL);
+
+	/* Loop until checksum done */
+	while (size) {
+		/* Get amount of data to read */
+		if (size < 4096)
+			length = size;
+		else
+			length = 4096;
+
+		/* Perform flash read */
+		D3(printk(KERN_NOTICE "jffs_checksum_flash\n"));
+		flash_safe_read(mtd, ptr, &read_buf[0], length);
+
+		/* Compute checksum */
+		for (i=0; i < length ; i++)
+			sum += read_buf[i];
+
+		/* Update pointer and size */
+		size -= length;
+		ptr += length;
 	}
+
+	/* Free read buffer */
+	kfree (read_buf);
+
+	/* Return result */
 	D3(printk("checksum result: 0x%08x\n", sum));
 	return sum;
 }
@@ -609,12 +596,17 @@
 	loff_t pos = fmc->flash_start;
 	loff_t start;
 	loff_t end = fmc->flash_start + fmc->flash_size;
+	__u8 *read_buf;
+	int i, len, retlen;
 
 	D1(printk("jffs_scan_flash(): start pos = 0x%lx, end = 0x%lx\n",
 		  (long)pos, (long)end));
 
 	flash_safe_acquire(fmc->mtd);
 
+	/* Allocate read buffer */
+	read_buf = (__u8 *) kmalloc (sizeof(__u8) * 4096, GFP_KERNEL);
+
 	/* Start the scan.  */
 	while (pos < end) {
 		deleted_file = 0;
@@ -629,9 +621,22 @@
 			   something else than 0xff is found.  */
 			D1(printk("jffs_scan_flash(): 0xff at pos 0x%lx.\n",
 				  (long)pos));
-			for (; pos < end
-			       && JFFS_EMPTY_BITMASK == flash_read_u32(fmc->mtd, pos);
-			     pos += 4);
+
+			len = end - pos < 4096 ? end - pos : 4096;
+
+			retlen = flash_safe_read(fmc->mtd, pos,
+						 &read_buf[0], len);
+
+			retlen &= ~3;
+
+			for (i=0 ; i < retlen ; i+=4, pos += 4) {
+				if(*((__u32 *) &read_buf[i]) !=
+						JFFS_EMPTY_BITMASK)
+					break;
+			}
+			if (i == retlen)
+				continue;
+
 			D1(printk("jffs_scan_flash(): 0xff ended at "
 				  "pos 0x%lx.\n", (long)pos));
 
@@ -748,7 +753,12 @@
 			if (!(node = (struct jffs_node *)
 				     kmalloc(sizeof(struct jffs_node),
 					     GFP_KERNEL))) {
+				/* Free read buffer */
+				kfree (read_buf);
+
+				/* Release the flash device */
 				flash_safe_release(fmc->mtd);
+	
 				return -ENOMEM;
 			}
 			DJM(no_jffs_node++);
@@ -893,7 +903,13 @@
 				D(printk("jffs_scan_flash(): !node->fm\n"));
 				kfree(node);
 				DJM(no_jffs_node--);
+
+				/* Free read buffer */
+				kfree (read_buf);
+
+				/* Release the flash device */
 				flash_safe_release(fmc->mtd);
+
 				return -ENOMEM;
 			}
 			if ((err = jffs_insert_node(c, 0, &raw_inode,
@@ -911,7 +927,13 @@
 					D(printk("jffs_scan_flash: !dl\n"));
 					kfree(node);
 					DJM(no_jffs_node--);
+
+					/* Release the flash device */
 					flash_safe_release(fmc->flash_part);
+
+					/* Free read buffer */
+					kfree (read_buf);
+
 					return -ENOMEM;
 				}
 				dl->ino = deleted_file;
@@ -936,6 +958,11 @@
 		DJM(no_jffs_node--);
 	}
 	jffs_build_end(fmc);
+
+	/* Free read buffer */
+	kfree (read_buf);
+
+	/* Return happy */
 	D3(printk("jffs_scan_flash(): Leaving...\n"));
 	flash_safe_release(fmc->mtd);
 	return 0;
@@ -1598,6 +1625,7 @@
 		  f->name, node->ino, node->version, node_offset));
 
 	r = jffs_min(avail, max_size);
+	D3(printk(KERN_NOTICE "jffs_get_node_data\n"));
 	flash_safe_read(fmc->mtd, pos, buf, r);
 
 	D3(printk("  jffs_get_node_data(): Read %u byte%s.\n",


--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
