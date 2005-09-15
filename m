Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030353AbVIODJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbVIODJG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 23:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbVIODJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 23:09:05 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:31716 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1030353AbVIODJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 23:09:04 -0400
X-Envelope-From: hpa@zytor.com
Message-ID: <4328E5BD.7040903@zytor.com>
Date: Wed, 14 Sep 2005 20:08:45 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] RAID6 Altivec fix
Content-Type: multipart/mixed;
 boundary="------------080804000407080000000804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080804000407080000000804
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes a signedness bug with RAID6 for Altivec, and makes the 
Altivec code testable in userspace.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>


--------------080804000407080000000804
Content-Type: text/x-patch;
 name="raid6-altivec-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="raid6-altivec-fix.patch"

Fix signedness of RAID6 Altivec, and make it testable in userspace

---
commit c79b28cf265a0b750bb939000942f70c73cd238e
tree 64c061f3fc7180a9f6a55a5c581b1418e38539a2
parent d8ac10639b6a1ed900efbee38c18baaca31e64dc
author H. Peter Anvin <hpa@asperta.(none)> Wed, 14 Sep 2005 20:03:30 -0700
committer H. Peter Anvin <hpa@asperta.(none)> Wed, 14 Sep 2005 20:03:30 -0700

 drivers/md/raid6.h            |    4 ++++
 drivers/md/raid6algos.c       |    1 +
 drivers/md/raid6altivec.uc    |   18 +++++++++++++-----
 drivers/md/raid6test/Makefile |   27 ++++++++++++++++++++++-----
 4 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/md/raid6.h b/drivers/md/raid6.h
--- a/drivers/md/raid6.h
+++ b/drivers/md/raid6.h
@@ -69,9 +69,13 @@ extern const char raid6_empty_zero_page[
 #define __init
 #define __exit
 #define __attribute_const__ __attribute__((const))
+#define noinline __attribute__((noinline))
 
 #define preempt_enable()
 #define preempt_disable()
+#define cpu_has_feature(x) 1
+#define enable_kernel_altivec()
+#define disable_kernel_altivec()
 
 #endif /* __KERNEL__ */
 
diff --git a/drivers/md/raid6algos.c b/drivers/md/raid6algos.c
--- a/drivers/md/raid6algos.c
+++ b/drivers/md/raid6algos.c
@@ -19,6 +19,7 @@
 #include "raid6.h"
 #ifndef __KERNEL__
 #include <sys/mman.h>
+#include <stdio.h>
 #endif
 
 struct raid6_calls raid6_call;
diff --git a/drivers/md/raid6altivec.uc b/drivers/md/raid6altivec.uc
--- a/drivers/md/raid6altivec.uc
+++ b/drivers/md/raid6altivec.uc
@@ -27,16 +27,20 @@
 #ifdef CONFIG_ALTIVEC
 
 #include <altivec.h>
-#include <asm/system.h>
-#include <asm/cputable.h>
+#ifdef __KERNEL__
+# include <asm/system.h>
+# include <asm/cputable.h>
+#endif
 
 /*
- * This is the C data type to use
+ * This is the C data type to use.  We use a vector of
+ * signed char so vec_cmpgt() will generate the right
+ * instruction.
  */
 
-typedef vector unsigned char unative_t;
+typedef vector signed char unative_t;
 
-#define NBYTES(x) ((vector unsigned char) {x,x,x,x, x,x,x,x, x,x,x,x, x,x,x,x})
+#define NBYTES(x) ((vector signed char) {x,x,x,x, x,x,x,x, x,x,x,x, x,x,x,x})
 #define NSIZE	sizeof(unative_t)
 
 /*
@@ -108,7 +112,11 @@ int raid6_have_altivec(void);
 int raid6_have_altivec(void)
 {
 	/* This assumes either all CPUs have Altivec or none does */
+# ifdef __KERNEL__
 	return cpu_has_feature(CPU_FTR_ALTIVEC);
+# else
+	return 1;
+# endif
 }
 #endif
 
diff --git a/drivers/md/raid6test/Makefile b/drivers/md/raid6test/Makefile
--- a/drivers/md/raid6test/Makefile
+++ b/drivers/md/raid6test/Makefile
@@ -8,6 +8,8 @@ OPTFLAGS = -O2			# Adjust as desired
 CFLAGS	 = -I.. -g $(OPTFLAGS)
 LD	 = ld
 PERL	 = perl
+AR	 = ar
+RANLIB	 = ranlib
 
 .c.o:
 	$(CC) $(CFLAGS) -c -o $@ $<
@@ -18,18 +20,33 @@ PERL	 = perl
 %.uc: ../%.uc
 	cp -f $< $@
 
-all:	raid6.o raid6test
+all:	raid6.a raid6test
 
-raid6.o: raid6int1.o raid6int2.o raid6int4.o raid6int8.o raid6int16.o \
+raid6.a: raid6int1.o raid6int2.o raid6int4.o raid6int8.o raid6int16.o \
 	 raid6int32.o \
 	 raid6mmx.o raid6sse1.o raid6sse2.o \
+	 raid6altivec1.o raid6altivec2.o raid6altivec4.o raid6altivec8.o \
 	 raid6recov.o raid6algos.o \
 	 raid6tables.o
-	$(LD) -r -o $@ $^
+	 rm -f $@
+	 $(AR) cq $@ $^
+	 $(RANLIB) $@
 
-raid6test: raid6.o test.c
+raid6test: test.c raid6.a
 	$(CC) $(CFLAGS) -o raid6test $^
 
+raid6altivec1.c: raid6altivec.uc ../unroll.pl
+	$(PERL) ../unroll.pl 1 < raid6altivec.uc > $@
+
+raid6altivec2.c: raid6altivec.uc ../unroll.pl
+	$(PERL) ../unroll.pl 2 < raid6altivec.uc > $@
+
+raid6altivec4.c: raid6altivec.uc ../unroll.pl
+	$(PERL) ../unroll.pl 4 < raid6altivec.uc > $@
+
+raid6altivec8.c: raid6altivec.uc ../unroll.pl
+	$(PERL) ../unroll.pl 8 < raid6altivec.uc > $@
+
 raid6int1.c: raid6int.uc ../unroll.pl
 	$(PERL) ../unroll.pl 1 < raid6int.uc > $@
 
@@ -52,7 +69,7 @@ raid6tables.c: mktables
 	./mktables > raid6tables.c
 
 clean:
-	rm -f *.o mktables mktables.c raid6int.uc raid6*.c raid6test
+	rm -f *.o *.a mktables mktables.c raid6int.uc raid6*.c raid6test
 
 spotless: clean
 	rm -f *~

--------------080804000407080000000804--
