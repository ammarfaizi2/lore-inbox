Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131758AbQKJVZg>; Fri, 10 Nov 2000 16:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131734AbQKJVZa>; Fri, 10 Nov 2000 16:25:30 -0500
Received: from [194.213.32.137] ([194.213.32.137]:6148 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131815AbQKJVZQ>;
	Fri, 10 Nov 2000 16:25:16 -0500
Message-ID: <20001110232148.A591@bug.ucw.cz>
Date: Fri, 10 Nov 2000 23:21:48 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: better asm-generic/bitops.h
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It might be usefull to someone..
							Pavel

Index: bitops.h
===================================================================
RCS file: /home/cvs/Repository/linux/include/asm-generic/bitops.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 bitops.h
--- bitops.h	2000/09/04 16:50:34	1.1.1.1
+++ bitops.h	2000/11/09 13:23:02
@@ -1,5 +1,6 @@
 #ifndef _ASM_GENERIC_BITOPS_H_
 #define _ASM_GENERIC_BITOPS_H_
+#include <asm/system.h>
 
 /*
  * For the benefit of those who are trying to port Linux to another
@@ -13,43 +14,120 @@
  * You will have to change this if you are trying to port Linux to the
  * Alpha architecture or to a Cray.  :-)
  * 
- * C language equivalents written by Theodore Ts'o, 9/26/92
+ * C language equivalents written by Theodore Ts'o, 9/26/92 
  */
 
-extern __inline__ int set_bit(int nr,int * addr)
+extern __inline__ int set_bit(int nr, void * a)
 {
 	int	mask, retval;
+	int	*addr = a;
+	unsigned long flags;
 
 	addr += nr >> 5;
 	mask = 1 << (nr & 0x1f);
-	cli();
+	save_flags(flags); cli();
 	retval = (mask & *addr) != 0;
 	*addr |= mask;
-	sti();
+	restore_flags(flags);
 	return retval;
 }
 
-extern __inline__ int clear_bit(int nr, int * addr)
+extern __inline__ int clear_bit(int nr, void * a)
 {
 	int	mask, retval;
+	int	*addr = a;
+	unsigned long flags;
 
 	addr += nr >> 5;
 	mask = 1 << (nr & 0x1f);
-	cli();
+	save_flags(flags); cli();
 	retval = (mask & *addr) != 0;
 	*addr &= ~mask;
-	sti();
+	restore_flags(flags);
 	return retval;
 }
 
-extern __inline__ int test_bit(int nr, int * addr)
+extern __inline__ int change_bit(int nr, void * a)
 {
+	int	mask, retval;
+	int	*addr = a;
+	unsigned long flags;
+
+	addr += nr >> 5;
+	mask = 1 << (nr & 0x1f);
+	save_flags(flags); cli();
+	retval = (mask & *addr) != 0;
+	*addr ^= mask;
+	restore_flags(flags);
+	return retval;
+}
+
+#define test_and_set_bit set_bit
+#define test_and_clear_bit clear_bit
+#define test_and_change_bit change_bit
+
+extern __inline__ int test_bit(int nr, void * a)
+{
 	int	mask;
+	int	*addr = a;
 
 	addr += nr >> 5;
 	mask = 1 << (nr & 0x1f);
 	return ((mask & *addr) != 0);
 }
+
+
+/*
+ * ffz = Find First Zero in word. Undefined if no zero exists,
+ * so code should check against ~0UL first..
+ */
+extern __inline__ unsigned long ffz(unsigned long word)
+{
+	int i;
+	for (i=0; i<64; i++)
+		if (!(word & (1<<i)))
+			return i;
+	return -1;
+}
+
+extern __inline__ int find_next_zero_bit(void *addr, int size, int offset)
+{
+	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
+	unsigned long result = offset & ~31UL;
+	unsigned long tmp;
+
+	if (offset >= size)
+		return size;
+	size -= result;
+	offset &= 31UL;
+	if (offset) {
+		tmp = *(p++);
+		tmp |= ~0UL >> (32-offset);
+		if (size < 32)
+			goto found_first;
+		if (~tmp)
+			goto found_middle;
+		size -= 32;
+		result += 32;
+	}
+	while (size & ~31UL) {
+		if (~(tmp = *(p++)))
+			goto found_middle;
+		result += 32;
+		size -= 32;
+	}
+	if (!size)
+		return result;
+	tmp = *p;
+
+found_first:
+	tmp |= ~0UL << size;
+found_middle:
+	return result + ffz(tmp);
+}
+
+#define find_first_zero_bit(addr, size) \
+        find_next_zero_bit((addr), (size), 0)
 
 #ifdef __KERNEL__
 


----- End forwarded message -----

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
