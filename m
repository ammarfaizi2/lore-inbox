Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268565AbRGZRsr>; Thu, 26 Jul 2001 13:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268592AbRGZRsb>; Thu, 26 Jul 2001 13:48:31 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:61201 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S268565AbRGZRsO>;
	Thu, 26 Jul 2001 13:48:14 -0400
Date: Thu, 26 Jul 2001 19:48:00 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] gcc-3.0.1 and 2.4.7-ac1
Message-ID: <20010726194800.A32053@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi Alan,
  following is patch which was needed for compiling 2.4.7-ac1
on box equipped with 'gcc version 3.0.1 20010721 (Debian prerelease)'.
As I did not see such complaint yet - here it is.

  Patch does NOT change all extern inline -> static inline, but only
changes extern -> static on functions which were not inlined and
due to which build failed (except one of get_pgd_slow, but I changed
both just for symmetry). There is high probability that other
sound drivers are affected too...

  If you think that gcc is too lazy on inlining (I think so...),
tell me and I'll complain to gcc team instead of here.
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz


diff -urdN linux/drivers/sound/es1370.c linux/drivers/sound/es1370.c
--- linux/drivers/sound/es1370.c	Thu Jul 26 15:46:55 2001
+++ linux/drivers/sound/es1370.c	Thu Jul 26 16:53:41 2001
@@ -649,7 +649,7 @@
 	return diff;
 }
 
-extern inline void clear_advance(void *buf, unsigned bsize, unsigned bptr, unsigned len, unsigned char c)
+static inline void clear_advance(void *buf, unsigned bsize, unsigned bptr, unsigned len, unsigned char c)
 {
 	if (bptr + len > bsize) {
 		unsigned x = bsize - bptr;
diff -urdN linux/drivers/sound/es1371.c linux/drivers/sound/es1371.c
--- linux/drivers/sound/es1371.c	Thu Jul 26 15:46:55 2001
+++ linux/drivers/sound/es1371.c	Thu Jul 26 16:53:31 2001
@@ -983,7 +983,7 @@
 	return diff;
 }
 
-extern inline void clear_advance(void *buf, unsigned bsize, unsigned bptr, unsigned len, unsigned char c)
+static inline void clear_advance(void *buf, unsigned bsize, unsigned bptr, unsigned len, unsigned char c)
 {
 	if (bptr + len > bsize) {
 		unsigned x = bsize - bptr;
diff -urdN linux/drivers/sound/esssolo1.c linux/drivers/sound/esssolo1.c
--- linux/drivers/sound/esssolo1.c	Sun Jul 15 23:22:23 2001
+++ linux/drivers/sound/esssolo1.c	Thu Jul 26 16:54:13 2001
@@ -480,7 +480,7 @@
 	return 0;
 }
 
-extern inline int prog_dmabuf_adc(struct solo1_state *s)
+static inline int prog_dmabuf_adc(struct solo1_state *s)
 {
 	unsigned long va;
 	int c;
@@ -508,7 +508,7 @@
 	return 0;
 }
 
-extern inline int prog_dmabuf_dac(struct solo1_state *s)
+static inline int prog_dmabuf_dac(struct solo1_state *s)
 {
 	unsigned long va;
 	int c;
@@ -531,7 +531,7 @@
 	return 0;
 }
 
-extern inline void clear_advance(void *buf, unsigned bsize, unsigned bptr, unsigned len, unsigned char c)
+static inline void clear_advance(void *buf, unsigned bsize, unsigned bptr, unsigned len, unsigned char c)
 {
 	if (bptr + len > bsize) {
 		unsigned x = bsize - bptr;
diff -urdN linux/include/asm-i386/pgalloc.h linux/include/asm-i386/pgalloc.h
--- linux/include/asm-i386/pgalloc.h	Thu Jul 26 15:46:58 2001
+++ linux/include/asm-i386/pgalloc.h	Thu Jul 26 16:33:44 2001
@@ -29,7 +29,7 @@
 
 extern void init_pae_pgd_cache(void);
 
-extern __inline__ pgd_t *get_pgd_slow(void)
+static __inline__ pgd_t *get_pgd_slow(void)
 {
 	int i;
 	pgd_t *pgd = kmem_cache_alloc(pae_pgd_cachep, GFP_KERNEL);
@@ -54,7 +54,7 @@
 
 #else
 
-extern __inline__ pgd_t *get_pgd_slow(void)
+static __inline__ pgd_t *get_pgd_slow(void)
 {
 	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
 
diff -urdN linux/include/asm-i386/siginfo.h linux/include/asm-i386/siginfo.h
--- linux/include/asm-i386/siginfo.h	Fri Jul 20 19:52:18 2001
+++ linux/include/asm-i386/siginfo.h	Thu Jul 26 16:33:01 2001
@@ -216,7 +216,7 @@
 #ifdef __KERNEL__
 #include <linux/string.h>
 
-extern inline void copy_siginfo(siginfo_t *to, siginfo_t *from)
+static inline void copy_siginfo(siginfo_t *to, siginfo_t *from)
 {
 	if (from->si_code < 0)
 		memcpy(to, from, sizeof(siginfo_t));
diff -urdN linux/net/core/rtnetlink.c linux/net/core/rtnetlink.c
--- linux/net/core/rtnetlink.c	Mon Feb 28 02:45:10 2000
+++ linux/net/core/rtnetlink.c	Thu Jul 26 16:27:03 2001
@@ -274,7 +274,7 @@
 
 /* Process one rtnetlink message. */
 
-extern __inline__ int
+static __inline__ int
 rtnetlink_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, int *errp)
 {
 	struct rtnetlink_link *link;
