Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbVCBQpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbVCBQpc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 11:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVCBQpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 11:45:31 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:52989 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262351AbVCBQok
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 11:44:40 -0500
Date: Wed, 2 Mar 2005 17:44:39 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 2/9] s390: gcc4 compile fixes.
Message-ID: <20050302164439.GB27829@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 2/9] s390: gcc4 compile fixes.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Make s390 compile and work with gcc4.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/char/keyboard.c |   10 +++++-----
 drivers/s390/cio/chsc.h      |    2 --
 include/asm-s390/system.h    |   16 ++++++++++++----
 include/asm-s390/uaccess.h   |    9 ++++-----
 4 files changed, 21 insertions(+), 16 deletions(-)

diff -urN linux-2.6/drivers/s390/char/keyboard.c linux-2.6-patched/drivers/s390/char/keyboard.c
--- linux-2.6/drivers/s390/char/keyboard.c	2005-03-02 08:38:01.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/keyboard.c	2005-03-02 17:00:07.000000000 +0100
@@ -32,11 +32,11 @@
 static k_handler_fn *k_handler[16] = { K_HANDLERS };
 
 /* maximum values each key_handler can handle */
-static const int max_vals[] = {
+static const int kbd_max_vals[] = {
 	255, ARRAY_SIZE(func_table) - 1, NR_FN_HANDLER - 1, 0,
 	NR_DEAD - 1, 0, 0, 0, 0, 0, 0, 0, 0, 0
 };
-static const int NR_TYPES = ARRAY_SIZE(max_vals);
+static const int KBD_NR_TYPES = ARRAY_SIZE(kbd_max_vals);
 
 static unsigned char ret_diacr[NR_DEAD] = {
 	'`', '\'', '^', '~', '"', ','
@@ -360,7 +360,7 @@
 		key_map = kbd->key_maps[tmp.kb_table];
 		if (key_map) {
 		    val = U(key_map[tmp.kb_index]);
-		    if (KTYP(val) >= NR_TYPES)
+		    if (KTYP(val) >= KBD_NR_TYPES)
 			val = K_HOLE;
 		} else
 		    val = (tmp.kb_index ? K_HOLE : K_NOSUCHMAP);
@@ -378,9 +378,9 @@
 			break;
 		}
 
-		if (KTYP(tmp.kb_value) >= NR_TYPES)
+		if (KTYP(tmp.kb_value) >= KBD_NR_TYPES)
 			return -EINVAL;
-		if (KVAL(tmp.kb_value) > max_vals[KTYP(tmp.kb_value)])
+		if (KVAL(tmp.kb_value) > kbd_max_vals[KTYP(tmp.kb_value)])
 			return -EINVAL;
 
 		if (!(key_map = kbd->key_maps[tmp.kb_table])) {
diff -urN linux-2.6/drivers/s390/cio/chsc.h linux-2.6-patched/drivers/s390/cio/chsc.h
--- linux-2.6/drivers/s390/cio/chsc.h	2005-03-02 08:38:19.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/chsc.h	2005-03-02 17:00:07.000000000 +0100
@@ -18,8 +18,6 @@
 	struct device dev;
 };
 
-extern struct channel_path *chps[];
-
 extern void s390_process_css( void );
 extern void chsc_validate_chpids(struct subchannel *);
 extern void chpid_is_actually_online(int);
diff -urN linux-2.6/include/asm-s390/system.h linux-2.6-patched/include/asm-s390/system.h
--- linux-2.6/include/asm-s390/system.h	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/system.h	2005-03-02 17:00:07.000000000 +0100
@@ -335,19 +335,23 @@
         __asm__ __volatile__("lpswe 0(%0)" : : "a" (&psw), "m" (psw) : "cc" );
 
 #define __ctl_load(array, low, high) ({ \
+	typedef struct { char _[sizeof(array)]; } addrtype; \
 	__asm__ __volatile__ ( \
 		"   bras  1,0f\n" \
                 "   lctlg 0,0,0(%0)\n" \
 		"0: ex    %1,0(1)" \
-		: : "a" (&array), "a" (((low)<<4)+(high)) : "1" ); \
+		: : "a" (&array), "a" (((low)<<4)+(high)), \
+		    "m" (*(addrtype *)(array)) : "1" ); \
 	})
 
 #define __ctl_store(array, low, high) ({ \
+	typedef struct { char _[sizeof(array)]; } addrtype; \
 	__asm__ __volatile__ ( \
 		"   bras  1,0f\n" \
 		"   stctg 0,0,0(%1)\n" \
 		"0: ex    %2,0(1)" \
-		: "=m" (array) : "a" (&array), "a" (((low)<<4)+(high)) : "1" ); \
+		: "=m" (*(addrtype *)(array)) \
+		: "a" (&array), "a" (((low)<<4)+(high)) : "1" ); \
 	})
 
 #define __ctl_set_bit(cr, bit) ({ \
@@ -390,19 +394,23 @@
 	__asm__ __volatile__("lpsw 0(%0)" : : "a" (&psw) : "cc" );
 
 #define __ctl_load(array, low, high) ({ \
+	typedef struct { char _[sizeof(array)]; } addrtype; \
 	__asm__ __volatile__ ( \
 		"   bras  1,0f\n" \
                 "   lctl 0,0,0(%0)\n" \
 		"0: ex    %1,0(1)" \
-		: : "a" (&array), "a" (((low)<<4)+(high)) : "1" ); \
+		: : "a" (&array), "a" (((low)<<4)+(high)), \
+		    "m" (*(addrtype *)(array)) : "1" ); \
 	})
 
 #define __ctl_store(array, low, high) ({ \
+	typedef struct { char _[sizeof(array)]; } addrtype; \
 	__asm__ __volatile__ ( \
 		"   bras  1,0f\n" \
 		"   stctl 0,0,0(%1)\n" \
 		"0: ex    %2,0(1)" \
-		: "=m" (array) : "a" (&array), "a" (((low)<<4)+(high)): "1" ); \
+		: "=m" (*(addrtype *)(array)) \
+		: "a" (&array), "a" (((low)<<4)+(high)): "1" ); \
 	})
 
 #define __ctl_set_bit(cr, bit) ({ \
diff -urN linux-2.6/include/asm-s390/uaccess.h linux-2.6-patched/include/asm-s390/uaccess.h
--- linux-2.6/include/asm-s390/uaccess.h	2005-03-02 08:37:49.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/uaccess.h	2005-03-02 17:00:07.000000000 +0100
@@ -161,7 +161,7 @@
 		__put_user_asm(__x, ptr, __pu_err);		\
 		break;						\
 	default:						\
-		__pu_err = __put_user_bad();			\
+		__put_user_bad();				\
 		break;						\
 	 }							\
 	__pu_err;						\
@@ -182,7 +182,7 @@
 })
 
 
-extern int __put_user_bad(void);
+extern int __put_user_bad(void) __attribute__((noreturn));
 
 #if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
 #define __get_user_asm(x, ptr, err) \
@@ -225,8 +225,7 @@
 		__get_user_asm(__x, ptr, __gu_err);		\
 		break;						\
 	default:						\
-		__x = 0;					\
-		__gu_err = __get_user_bad();			\
+		__get_user_bad();				\
 		break;						\
 	}							\
 	(x) = __x;						\
@@ -248,7 +247,7 @@
 	__get_user(x, ptr);					\
 })
 
-extern int __get_user_bad(void);
+extern int __get_user_bad(void) __attribute__((noreturn));
 
 #define __put_user_unaligned __put_user
 #define __get_user_unaligned __get_user
