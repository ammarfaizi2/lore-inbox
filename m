Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVFHF1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVFHF1a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 01:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVFHF13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 01:27:29 -0400
Received: from ozlabs.org ([203.10.76.45]:24270 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262101AbVFHF06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 01:26:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17062.32288.345218.748743@cargo.ozlabs.ibm.com>
Date: Wed, 8 Jun 2005 15:12:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org, akpm@osdl.org
CC: anton@samba.org, linux-kernel@vger.kernel.org, olh@suse.de
Subject: [PATCH] ppc64: print negative numbers correctly in boot wrapper
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olaf Hering <olh@suse.de>

if num has a value of -1, accessing the digits[] array will fail and the
format string will be printed in funny way, or not at all. This happens if
one prints negative numbers.
Just change the code to match lib/vsprintf.c
asm/div64.h cant be used because u64 maps to u32 for this build.

Signed-off-by: Olaf Hering <olh@suse.de>
Signed-off-by: Paul Mackerras <paulus@samba.org>

Index: linux-2.6.12-rc4-olh/arch/ppc64/boot/prom.c
===================================================================
--- linux-2.6.12-rc4-olh.orig/arch/ppc64/boot/prom.c
+++ linux-2.6.12-rc4-olh/arch/ppc64/boot/prom.c
@@ -11,6 +11,23 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 
+extern __u32 __div64_32(unsigned long long *dividend, __u32 divisor);
+
+/* The unnecessary pointer compare is there
+ * to check for type safety (n must be 64bit)
+ */
+# define do_div(n,base) ({				\
+	__u32 __base = (base);			\
+	__u32 __rem;					\
+	(void)(((typeof((n)) *)0) == ((unsigned long long *)0));	\
+	if (((n) >> 32) == 0) {			\
+		__rem = (__u32)(n) % __base;		\
+		(n) = (__u32)(n) / __base;		\
+	} else 						\
+		__rem = __div64_32(&(n), __base);	\
+	__rem;						\
+ })
+
 int (*prom)(void *);
 
 void *chosen_handle;
@@ -352,7 +369,7 @@ static int skip_atoi(const char **s)
 #define SPECIAL	32		/* 0x */
 #define LARGE	64		/* use 'ABCDEF' instead of 'abcdef' */
 
-static char * number(char * str, long num, int base, int size, int precision, int type)
+static char * number(char * str, unsigned long long num, int base, int size, int precision, int type)
 {
 	char c,sign,tmp[66];
 	const char *digits="0123456789abcdefghijklmnopqrstuvwxyz";
@@ -367,9 +384,9 @@ static char * number(char * str, long nu
 	c = (type & ZEROPAD) ? '0' : ' ';
 	sign = 0;
 	if (type & SIGN) {
-		if (num < 0) {
+		if ((signed long long)num < 0) {
 			sign = '-';
-			num = -num;
+			num = - (signed long long)num;
 			size--;
 		} else if (type & PLUS) {
 			sign = '+';
@@ -389,8 +406,7 @@ static char * number(char * str, long nu
 	if (num == 0)
 		tmp[i++]='0';
 	else while (num != 0) {
-		tmp[i++] = digits[num % base];
-		num /= base;
+		tmp[i++] = digits[do_div(num, base)];
 	}
 	if (i > precision)
 		precision = i;
@@ -426,7 +442,7 @@ int sprintf(char * buf, const char *fmt,
 int vsprintf(char *buf, const char *fmt, va_list args)
 {
 	int len;
-	unsigned long num;
+	unsigned long long num;
 	int i, base;
 	char * str;
 	const char *s;
