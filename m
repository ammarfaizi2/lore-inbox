Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267786AbTBYPoa>; Tue, 25 Feb 2003 10:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268000AbTBYPoa>; Tue, 25 Feb 2003 10:44:30 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:53764 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S267786AbTBYPoL>; Tue, 25 Feb 2003 10:44:11 -0500
Date: Wed, 26 Feb 2003 00:36:25 +0900 (JST)
Message-Id: <20030226.003625.90530451.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Privacy Extensions for Stateless Address
 Autoconfiguration in IPv6
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030223.225251.119557134.davem@redhat.com>
References: <20030223.223114.65976206.davem@redhat.com>
	<20030224.155852.611429637.yoshfuji@linux-ipv6.org>
	<20030223.225251.119557134.davem@redhat.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In article <20030223.225251.119557134.davem@redhat.com> (at Sun, 23 Feb 2003 22:52:51 -0800 (PST)), "David S. Miller" <davem@redhat.com> says:

>    MD5 code in linux-2.4.x patch what I sent you was taken from 
>    Colin Plumb's public domain implementation.  
>    (USAGI itself uses KAME implementation.)
> 
> Please send me the 2.4.x version of the privacy
> extension patch so that I may have a look.

Here's the patch for linux-2.4.21-pre4.
Thanks.

Index: Documentation/Configure.help
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/Documentation/Configure.help,v
retrieving revision 1.1.1.4
retrieving revision 1.1.1.4.2.1
diff -u -r1.1.1.4 -r1.1.1.4.2.1
--- Documentation/Configure.help	24 Feb 2003 09:48:53 -0000	1.1.1.4
+++ Documentation/Configure.help	24 Feb 2003 10:40:59 -0000	1.1.1.4.2.1
@@ -5627,6 +5627,19 @@
 
   It is safe to say N here for now.
 
+IPv6: Privacy Extensions (RFC 3041) support
+CONFIG_IPV6_PRIVACY
+  Privacy Extensions for Stateless Address Autoconfiguration in IPv6
+  support.  With this option, additional periodically-alter 
+  pseudo-random global-scope unicast address(es) will assigned to
+  your interface(s).
+
+  By default, kernel generates temporary addresses but it won't use 
+  them unless application explicitly bind them.  To prefer temporary 
+  address, do
+
+	echo 2 >/proc/sys/net/ipv6/conf/all/use_tempaddr 
+
 Kernel httpd acceleration
 CONFIG_KHTTPD
   The kernel httpd acceleration daemon (kHTTPd) is a (limited) web
Index: Documentation/networking/ip-sysctl.txt
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/Documentation/networking/ip-sysctl.txt,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.2.2.1
diff -u -r1.1.1.2 -r1.1.1.2.2.1
--- Documentation/networking/ip-sysctl.txt	24 Feb 2003 09:48:56 -0000	1.1.1.2
+++ Documentation/networking/ip-sysctl.txt	24 Feb 2003 10:40:59 -0000	1.1.1.2.2.1
@@ -613,6 +613,36 @@
 	routers are present.
 	Default: 3
 
+use_tempaddr - INTEGER
+	Preference for Privacy Extensions (RFC3041).
+	  <= 0 : disable Privacy Extensions
+	  == 1 : enable Privacy Extensions, but prefer public
+	         addresses over temporary addresses.
+	  >  1 : enable Privacy Extensions and prefer temporary
+	         addresses over public addresses.
+	Default: 1 (for most devices)
+		 0 (for point-to-point devices and loopback devices)
+
+temp_valid_lft - INTEGER
+	valid lifetime (in seconds) for temporary addresses.
+	Default: 604800 (7 days)
+
+temp_prefered_lft - INTEGER
+	Preferred lifetime (in seconds) for temorary addresses.
+	Default: 86400 (1 day)
+
+max_desync_factor - INTEGER
+	Maximum value for DESYNC_FACTOR, which is a random value
+	that ensures that clients don't synchronize with each 
+	other and generage new addresses at exactly the same time.
+	value is in seconds.
+	Default: 600
+	
+regen_max_retry - INTEGER
+	Number of attempts before give up attempting to generate
+	valid temporary addresses.
+	Default: 5
+
 icmp/*:
 ratelimit - INTEGER
 	Limit the maximal rates for sending ICMPv6 packets.
Index: include/linux/md5.h
===================================================================
RCS file: include/linux/md5.h
diff -N include/linux/md5.h
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ include/linux/md5.h	24 Feb 2003 10:40:59 -0000	1.1.6.1
@@ -0,0 +1,23 @@
+/*
+ * md5.h - for lib/md5.c
+ *
+ * $USAGI: md5.h,v 1.1.6.1 2003/02/24 10:40:59 yoshfuji Exp $
+ */
+
+#ifndef _LINUX_MD5_H
+#define _LINUX_MD5_H
+
+typedef struct MD5Context {
+	__u32 buf[4];
+	__u32 bits[2];
+	__u8 in[64];
+} MD5_CTX;
+
+void MD5Init(struct MD5Context *context);
+void MD5Update(struct MD5Context *context,
+	       __u8 const *buf, unsigned int len);
+void MD5Final(__u8 digest[16],
+	      struct MD5Context *context);
+void MD5Transform(__u32 buf[4], __u32 const in[16]);
+
+#endif	/* !_LINUX_MD5_H */
Index: include/linux/rtnetlink.h
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/include/linux/rtnetlink.h,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.2.30.1
diff -u -r1.1.1.2 -r1.1.1.2.30.1
--- include/linux/rtnetlink.h	9 Oct 2002 01:35:37 -0000	1.1.1.2
+++ include/linux/rtnetlink.h	24 Feb 2003 10:40:59 -0000	1.1.1.2.30.1
@@ -315,6 +315,7 @@
 /* ifa_flags */
 
 #define IFA_F_SECONDARY		0x01
+#define IFA_F_TEMPORARY		IFA_F_SECONDARY
 
 #define IFA_F_DEPRECATED	0x20
 #define IFA_F_TENTATIVE		0x40
Index: include/linux/sysctl.h
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/include/linux/sysctl.h,v
retrieving revision 1.1.1.3
retrieving revision 1.1.1.3.2.1
diff -u -r1.1.1.3 -r1.1.1.3.2.1
--- include/linux/sysctl.h	24 Feb 2003 09:47:45 -0000	1.1.1.3
+++ include/linux/sysctl.h	24 Feb 2003 10:40:59 -0000	1.1.1.3.2.1
@@ -375,7 +375,12 @@
 	NET_IPV6_DAD_TRANSMITS=7,
 	NET_IPV6_RTR_SOLICITS=8,
 	NET_IPV6_RTR_SOLICIT_INTERVAL=9,
-	NET_IPV6_RTR_SOLICIT_DELAY=10
+	NET_IPV6_RTR_SOLICIT_DELAY=10,
+	NET_IPV6_USE_TEMPADDR=11,
+	NET_IPV6_TEMP_VALID_LFT=12,
+	NET_IPV6_TEMP_PREFERED_LFT=13,
+	NET_IPV6_REGEN_MAX_RETRY=14,
+	NET_IPV6_MAX_DESYNC_FACTOR=15
 };
 
 /* /proc/sys/net/ipv6/icmp */
Index: include/net/addrconf.h
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/include/net/addrconf.h,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.2.2.1
diff -u -r1.1.1.2 -r1.1.1.2.2.1
--- include/net/addrconf.h	24 Feb 2003 09:47:49 -0000	1.1.1.2
+++ include/net/addrconf.h	24 Feb 2003 10:40:59 -0000	1.1.1.2.2.1
@@ -6,6 +6,11 @@
 #define MAX_RTR_SOLICITATIONS		3
 #define RTR_SOLICITATION_INTERVAL	(4*HZ)
 
+#define TEMP_VALID_LIFETIME		(7*86400)
+#define TEMP_PREFERRED_LIFETIME		(86400)
+#define REGEN_MAX_RETRY			(5)
+#define MAX_DESYNC_FACTOR		(600)
+
 #define ADDR_CHECK_FREQUENCY		(120*HZ)
 
 struct prefix_info {
Index: include/net/if_inet6.h
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/include/net/if_inet6.h,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.54.1
diff -u -r1.1.1.1 -r1.1.1.1.54.1
--- include/net/if_inet6.h	20 Aug 2002 09:46:45 -0000	1.1.1.1
+++ include/net/if_inet6.h	24 Feb 2003 10:40:59 -0000	1.1.1.1.54.1
@@ -43,6 +43,12 @@
 	struct inet6_ifaddr	*lst_next;      /* next addr in addr_lst */
 	struct inet6_ifaddr	*if_next;       /* next addr in inet6_dev */
 
+#ifdef CONFIG_IPV6_PRIVACY
+	struct inet6_ifaddr	*tmp_next;	/* next addr in tempaddr_lst */
+	struct inet6_ifaddr	*ifpub;
+	int			regen_count;
+#endif
+
 	int			dead;
 };
 
@@ -86,7 +92,13 @@
 	int		rtr_solicits;
 	int		rtr_solicit_interval;
 	int		rtr_solicit_delay;
-
+#ifdef CONFIG_IPV6_PRIVACY
+	int		use_tempaddr;
+	int		temp_valid_lft;
+	int		temp_prefered_lft;
+	int		regen_max_retry;
+	int		max_desync_factor;
+#endif
 	void		*sysctl;
 };
 
@@ -100,6 +112,13 @@
 	atomic_t		refcnt;
 	__u32			if_flags;
 	int			dead;
+
+#ifdef CONFIG_IPV6_PRIVACY
+	u8			rndid[8];
+	u8			entropy[8];
+	struct timer_list	regen_timer;
+	struct inet6_ifaddr	*tempaddr_list;
+#endif
 
 	struct neigh_parms	*nd_parms;
 	struct inet6_dev	*next;
Index: lib/Config.in
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/lib/Config.in,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.26.1
diff -u -r1.1.1.1 -r1.1.1.1.26.1
--- lib/Config.in	9 Oct 2002 01:35:37 -0000	1.1.1.1
+++ lib/Config.in	24 Feb 2003 10:40:59 -0000	1.1.1.1.26.1
@@ -5,6 +5,19 @@
 comment 'Library routines'
 
 #
+# MD5 digest
+#
+if [ "$CONFIG_IPV6_PRIVACY" = "y" ]; then
+  if [ "$CONFIG_IPV6" = "y" ]; then
+    define_tristate CONFIG_MD5 y
+  else
+    define_tristate CONFIG_MD5 m
+  fi
+else
+  tristate 'MD5 digest support' CONFIG_MD5
+fi
+
+#
 # Do we need the compression support?
 #
 if [ "$CONFIG_CRAMFS" = "y" -o \
Index: lib/Makefile
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/lib/Makefile,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.2.30.1
diff -u -r1.1.1.2 -r1.1.1.2.30.1
--- lib/Makefile	9 Oct 2002 01:35:37 -0000	1.1.1.2
+++ lib/Makefile	24 Feb 2003 10:40:59 -0000	1.1.1.2.30.1
@@ -20,6 +20,11 @@
   obj-y += dec_and_lock.o
 endif
 
+obj-$(CONFIG_MD5) += md5.o
+ifeq ($(CONFIG_MD5),y)
+  export-objs += md5.o
+endif
+
 subdir-$(CONFIG_ZLIB_INFLATE) += zlib_inflate
 subdir-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate
 
Index: lib/md5.c
===================================================================
RCS file: lib/md5.c
diff -N lib/md5.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ lib/md5.c	24 Feb 2003 10:40:59 -0000	1.1.6.1
@@ -0,0 +1,252 @@
+/*
+ * This code implements the MD5 message-digest algorithm.
+ * The algorithm is due to Ron Rivest.  This code was
+ * written by Colin Plumb in 1993, no copyright is claimed.
+ * This code is in the public domain; do with it what you wish.
+ *
+ * Equivalent code is available from RSA Data Security, Inc.
+ * This code has been tested against that, and is equivalent,
+ * except that you don't need to include two pages of legalese
+ * with every copy.
+ *
+ * To compute the message digest of a chunk of bytes, declare an
+ * MD5Context structure, pass it to MD5Init, call MD5Update as
+ * needed on buffers full of bytes, and then call MD5Final, which
+ * will fill a supplied 16-byte array with the digest.
+ *
+ * Modified for Linux kernel by YOSHIFUJI Hideaki / USAGI Project.
+ * $USAGI: md5.c,v 1.1.6.1 2003/02/24 10:40:59 yoshfuji Exp $
+ */
+#include <asm/byteorder.h>
+#include <linux/module.h>
+#include <linux/string.h>		/* for memcpy() */
+#include <linux/md5.h>
+
+#ifndef __LITTLE_ENDIAN
+#define byteReverse(buf, len)	do { } while(0)
+#else
+static inline void byteReverse(u32 *p, int longs)
+{
+	do {
+		*p = cpu_to_le32p(p);
+		p++;
+	} while (--longs);
+}
+#endif
+
+/*
+ * Start MD5 accumulation.  Set bit count to 0 and buffer to mysterious
+ * initialization constants.
+ */
+void MD5Init(struct MD5Context *ctx)
+{
+	ctx->buf[0] = 0x67452301;
+	ctx->buf[1] = 0xefcdab89;
+	ctx->buf[2] = 0x98badcfe;
+	ctx->buf[3] = 0x10325476;
+
+	ctx->bits[0] = 0;
+	ctx->bits[1] = 0;
+}
+
+/*
+ * Update context to reflect the concatenation of another buffer full
+ * of bytes.
+ */
+void
+MD5Update(struct MD5Context *ctx, u8 const *buf, unsigned int len)
+{
+	unsigned int t;
+
+	/* Update bitcount */
+
+	t = ctx->bits[0];
+	if ((ctx->bits[0] = t + ((u32) len << 3)) < t)
+		ctx->bits[1]++;	/* Carry from low to high */
+	ctx->bits[1] += len >> 29;
+
+	t = (t >> 3) & 0x3f;	/* Bytes already in shsInfo->data */
+
+	/* Handle any leading odd-sized chunks */
+
+	if (t) {
+		u8 *p = (u8 *) ctx->in + t;
+
+		t = 64 - t;
+		if (len < t) {
+			memcpy(p, buf, len);
+			return;
+		}
+		memcpy(p, buf, t);
+		byteReverse((u32*)ctx->in, 16);
+		MD5Transform(ctx->buf, (u32 *) ctx->in);
+		buf += t;
+		len -= t;
+	}
+	/* Process data in 64-byte chunks */
+
+	while (len >= 64) {
+		memcpy(ctx->in, buf, 64);
+		byteReverse((u32*)ctx->in, 16);
+		MD5Transform(ctx->buf, (u32 *) ctx->in);
+		buf += 64;
+		len -= 64;
+	}
+
+	/* Handle any remaining bytes of data. */
+
+	memcpy(ctx->in, buf, len);
+}
+
+/*
+ * Final wrapup - pad to 64-byte boundary with the bit pattern
+ * 1 0* (64-bit count of bits processed, MSB-first)
+ */
+void MD5Final(u8 digest[16], struct MD5Context *ctx)
+{
+	u32 count;
+	u8 *p;
+
+	/* Compute number of bytes mod 64 */
+	count = (ctx->bits[0] >> 3) & 0x3F;
+
+	/* Set the first char of padding to 0x80.  This is safe since there is
+	 *         always at least one byte free */
+	p = ctx->in + count;
+	*p++ = 0x80;
+
+	/* Bytes of padding needed to make 64 bytes */
+	count = 64 - 1 - count;
+
+	/* Pad out to 56 mod 64 */
+	if (count < 8) {
+		/* Two lots of padding:  Pad the first block to 64 bytes */
+		memset(p, 0, count);
+		byteReverse((u32*)ctx->in, 16);
+		MD5Transform(ctx->buf, (u32 *) ctx->in);
+
+		/* Now fill the next block with 56 bytes */
+		memset(ctx->in, 0, 56);
+	} else {
+		/* Pad block to 56 bytes */
+		memset(p, 0, count - 8);
+	}
+	byteReverse((u32*)ctx->in, 14);
+
+	/* Append length in bits and transform */
+	((u32 *) ctx->in)[14] = ctx->bits[0];
+	((u32 *) ctx->in)[15] = ctx->bits[1];
+
+	MD5Transform(ctx->buf, (u32 *) ctx->in);
+	byteReverse(ctx->buf, 4);
+	memcpy(digest, ctx->buf, 16);
+	memset((char *) ctx, 0, sizeof(ctx));	/* In case it's sensitive */
+}
+
+/* The four core functions - F1 is optimized somewhat */
+
+/* #define F1(x, y, z) (x & y | ~x & z) */
+#define F1(x, y, z) (z ^ (x & (y ^ z)))
+#define F2(x, y, z) F1(z, x, y)
+#define F3(x, y, z) (x ^ y ^ z)
+#define F4(x, y, z) (y ^ (x | ~z))
+
+/* This is the central step in the MD5 algorithm. */
+#define MD5STEP(f, w, x, y, z, data, s) 	\
+	( w += f(x, y, z) + data, w = w<<s | w>>(32-s), w += x )
+
+/*
+ * The core of the MD5 algorithm, this alters an existing MD5 hash to
+ * reflect the addition of 16 longwords of new data.  MD5Update blocks
+ * the data and converts bytes into longwords for this routine.
+ */
+void MD5Transform(__u32 buf[4], __u32 const in[16])
+{
+	register u32 a, b, c, d;
+
+	a = buf[0];
+	b = buf[1];
+	c = buf[2];
+	d = buf[3];
+
+	MD5STEP(F1, a, b, c, d, in[0] + 0xd76aa478, 7);
+	MD5STEP(F1, d, a, b, c, in[1] + 0xe8c7b756, 12);
+	MD5STEP(F1, c, d, a, b, in[2] + 0x242070db, 17);
+	MD5STEP(F1, b, c, d, a, in[3] + 0xc1bdceee, 22);
+	MD5STEP(F1, a, b, c, d, in[4] + 0xf57c0faf, 7);
+	MD5STEP(F1, d, a, b, c, in[5] + 0x4787c62a, 12);
+	MD5STEP(F1, c, d, a, b, in[6] + 0xa8304613, 17);
+	MD5STEP(F1, b, c, d, a, in[7] + 0xfd469501, 22);
+	MD5STEP(F1, a, b, c, d, in[8] + 0x698098d8, 7);
+	MD5STEP(F1, d, a, b, c, in[9] + 0x8b44f7af, 12);
+	MD5STEP(F1, c, d, a, b, in[10] + 0xffff5bb1, 17);
+	MD5STEP(F1, b, c, d, a, in[11] + 0x895cd7be, 22);
+	MD5STEP(F1, a, b, c, d, in[12] + 0x6b901122, 7);
+	MD5STEP(F1, d, a, b, c, in[13] + 0xfd987193, 12);
+	MD5STEP(F1, c, d, a, b, in[14] + 0xa679438e, 17);
+	MD5STEP(F1, b, c, d, a, in[15] + 0x49b40821, 22);
+
+	MD5STEP(F2, a, b, c, d, in[1] + 0xf61e2562, 5);
+	MD5STEP(F2, d, a, b, c, in[6] + 0xc040b340, 9);
+	MD5STEP(F2, c, d, a, b, in[11] + 0x265e5a51, 14);
+	MD5STEP(F2, b, c, d, a, in[0] + 0xe9b6c7aa, 20);
+	MD5STEP(F2, a, b, c, d, in[5] + 0xd62f105d, 5);
+	MD5STEP(F2, d, a, b, c, in[10] + 0x02441453, 9);
+	MD5STEP(F2, c, d, a, b, in[15] + 0xd8a1e681, 14);
+	MD5STEP(F2, b, c, d, a, in[4] + 0xe7d3fbc8, 20);
+	MD5STEP(F2, a, b, c, d, in[9] + 0x21e1cde6, 5);
+	MD5STEP(F2, d, a, b, c, in[14] + 0xc33707d6, 9);
+	MD5STEP(F2, c, d, a, b, in[3] + 0xf4d50d87, 14);
+	MD5STEP(F2, b, c, d, a, in[8] + 0x455a14ed, 20);
+	MD5STEP(F2, a, b, c, d, in[13] + 0xa9e3e905, 5);
+	MD5STEP(F2, d, a, b, c, in[2] + 0xfcefa3f8, 9);
+	MD5STEP(F2, c, d, a, b, in[7] + 0x676f02d9, 14);
+	MD5STEP(F2, b, c, d, a, in[12] + 0x8d2a4c8a, 20);
+
+	MD5STEP(F3, a, b, c, d, in[5] + 0xfffa3942, 4);
+	MD5STEP(F3, d, a, b, c, in[8] + 0x8771f681, 11);
+	MD5STEP(F3, c, d, a, b, in[11] + 0x6d9d6122, 16);
+	MD5STEP(F3, b, c, d, a, in[14] + 0xfde5380c, 23);
+	MD5STEP(F3, a, b, c, d, in[1] + 0xa4beea44, 4);
+	MD5STEP(F3, d, a, b, c, in[4] + 0x4bdecfa9, 11);
+	MD5STEP(F3, c, d, a, b, in[7] + 0xf6bb4b60, 16);
+	MD5STEP(F3, b, c, d, a, in[10] + 0xbebfbc70, 23);
+	MD5STEP(F3, a, b, c, d, in[13] + 0x289b7ec6, 4);
+	MD5STEP(F3, d, a, b, c, in[0] + 0xeaa127fa, 11);
+	MD5STEP(F3, c, d, a, b, in[3] + 0xd4ef3085, 16);
+	MD5STEP(F3, b, c, d, a, in[6] + 0x04881d05, 23);
+	MD5STEP(F3, a, b, c, d, in[9] + 0xd9d4d039, 4);
+	MD5STEP(F3, d, a, b, c, in[12] + 0xe6db99e5, 11);
+	MD5STEP(F3, c, d, a, b, in[15] + 0x1fa27cf8, 16);
+	MD5STEP(F3, b, c, d, a, in[2] + 0xc4ac5665, 23);
+
+	MD5STEP(F4, a, b, c, d, in[0] + 0xf4292244, 6);
+	MD5STEP(F4, d, a, b, c, in[7] + 0x432aff97, 10);
+	MD5STEP(F4, c, d, a, b, in[14] + 0xab9423a7, 15);
+	MD5STEP(F4, b, c, d, a, in[5] + 0xfc93a039, 21);
+	MD5STEP(F4, a, b, c, d, in[12] + 0x655b59c3, 6);
+	MD5STEP(F4, d, a, b, c, in[3] + 0x8f0ccc92, 10);
+	MD5STEP(F4, c, d, a, b, in[10] + 0xffeff47d, 15);
+	MD5STEP(F4, b, c, d, a, in[1] + 0x85845dd1, 21);
+	MD5STEP(F4, a, b, c, d, in[8] + 0x6fa87e4f, 6);
+	MD5STEP(F4, d, a, b, c, in[15] + 0xfe2ce6e0, 10);
+	MD5STEP(F4, c, d, a, b, in[6] + 0xa3014314, 15);
+	MD5STEP(F4, b, c, d, a, in[13] + 0x4e0811a1, 21);
+	MD5STEP(F4, a, b, c, d, in[4] + 0xf7537e82, 6);
+	MD5STEP(F4, d, a, b, c, in[11] + 0xbd3af235, 10);
+	MD5STEP(F4, c, d, a, b, in[2] + 0x2ad7d2bb, 15);
+	MD5STEP(F4, b, c, d, a, in[9] + 0xeb86d391, 21);
+
+	buf[0] += a;
+	buf[1] += b;
+	buf[2] += c;
+	buf[3] += d;
+}
+
+#ifdef CONFIG_MD5
+EXPORT_SYMBOL(MD5Init);
+EXPORT_SYMBOL(MD5Update);
+EXPORT_SYMBOL(MD5Final);
+EXPORT_SYMBOL(MD5Transform);
+#endif
+
Index: net/ipv6/Config.in
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/Config.in,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.50.1
diff -u -r1.1.1.1 -r1.1.1.1.50.1
--- net/ipv6/Config.in	20 Aug 2002 09:47:02 -0000	1.1.1.1
+++ net/ipv6/Config.in	24 Feb 2003 10:40:59 -0000	1.1.1.1.50.1
@@ -5,6 +5,8 @@
 #bool '    IPv6: flow policy support' CONFIG_RT6_POLICY
 #bool '    IPv6: firewall support' CONFIG_IPV6_FIREWALL
 
+bool '    IPv6: Privacy Extentions (RFC 3041) support' CONFIG_IPV6_PRIVACY
+
 if [ "$CONFIG_NETFILTER" != "n" ]; then
    source net/ipv6/netfilter/Config.in
 fi
Index: net/ipv6/addrconf.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/addrconf.c,v
retrieving revision 1.1.1.4
retrieving revision 1.1.1.4.2.3
diff -u -r1.1.1.4 -r1.1.1.4.2.3
--- net/ipv6/addrconf.c	24 Feb 2003 09:47:55 -0000	1.1.1.4
+++ net/ipv6/addrconf.c	25 Feb 2003 07:45:16 -0000	1.1.1.4.2.3
@@ -28,6 +28,8 @@
  *						packets.
  *	YOSHIFUJI Hideaki @USAGI	:	improved accuracy of
  *						address validation timer.
+ *	YOSHIFUJI Hideaki @USAGI	:	Privacy Extensions (RFC3041)
+ *						support.
  */
 
 #include <linux/config.h>
@@ -62,6 +64,11 @@
 #include <linux/if_tunnel.h>
 #include <linux/rtnetlink.h>
 
+#ifdef CONFIG_IPV6_PRIVACY
+#include <linux/random.h>
+#include <linux/md5.h>
+#endif
+
 #include <asm/uaccess.h>
 
 #define IPV6_MAX_ADDRESSES 16
@@ -83,6 +90,16 @@
 int inet6_dev_count;
 int inet6_ifa_count;
 
+#ifdef CONFIG_IPV6_PRIVACY
+static int __ipv6_regen_rndid(struct inet6_dev *idev);
+static int __ipv6_try_regen_rndid(struct inet6_dev *idev, struct in6_addr *tmpaddr); 
+static void ipv6_regen_rndid(unsigned long data);
+
+static int desync_factor = MAX_DESYNC_FACTOR * HZ;
+#endif
+
+int ipv6_count_addresses(struct inet6_dev *idev);
+
 /*
  *	Configured unicast address hash table
  */
@@ -119,6 +136,13 @@
 	MAX_RTR_SOLICITATIONS,		/* router solicits	*/
 	RTR_SOLICITATION_INTERVAL,	/* rtr solicit interval	*/
 	MAX_RTR_SOLICITATION_DELAY,	/* rtr solicit delay	*/
+#ifdef CONFIG_IPV6_PRIVACY
+	.use_tempaddr 			= 1,
+	.temp_valid_lft			= TEMP_VALID_LIFETIME,
+	.temp_prefered_lft		= TEMP_PREFERRED_LIFETIME,
+	.regen_max_retry		= REGEN_MAX_RETRY,
+	.max_desync_factor		= MAX_DESYNC_FACTOR,
+#endif
 };
 
 static struct ipv6_devconf ipv6_devconf_dflt =
@@ -133,6 +157,13 @@
 	MAX_RTR_SOLICITATIONS,		/* router solicits	*/
 	RTR_SOLICITATION_INTERVAL,	/* rtr solicit interval	*/
 	MAX_RTR_SOLICITATION_DELAY,	/* rtr solicit delay	*/
+#ifdef CONFIG_IPV6_PRIVACY
+	.use_tempaddr			= 1,
+	.temp_valid_lft			= TEMP_VALID_LIFETIME,
+	.temp_prefered_lft		= TEMP_PREFERRED_LIFETIME,
+	.regen_max_retry		= REGEN_MAX_RETRY,
+	.max_desync_factor		= MAX_DESYNC_FACTOR,
+#endif
 };
 
 int ipv6_addr_type(struct in6_addr *addr)
@@ -272,6 +303,24 @@
 		/* We refer to the device */
 		dev_hold(dev);
 
+#ifdef CONFIG_IPV6_PRIVACY
+		get_random_bytes(ndev->rndid, sizeof(ndev->rndid));
+		get_random_bytes(ndev->entropy, sizeof(ndev->entropy));
+		init_timer(&ndev->regen_timer);
+		ndev->regen_timer.function = ipv6_regen_rndid;
+		ndev->regen_timer.data = (unsigned long) ndev;
+		if ((dev->flags&IFF_LOOPBACK) ||
+		    dev->type == ARPHRD_TUNNEL ||
+		    dev->type == ARPHRD_SIT) {
+			printk(KERN_INFO
+				"Disabled Privacy Extensions on device %p(%s)\n",
+				dev, dev->name);
+			ndev->cnf.use_tempaddr = -1;
+		} else {
+			__ipv6_regen_rndid(ndev);
+		}
+#endif
+
 		write_lock_bh(&addrconf_lock);
 		dev->ip6_ptr = ndev;
 		/* One reference from device */
@@ -396,6 +445,18 @@
 	/* Add to inet6_dev unicast addr list. */
 	ifa->if_next = idev->addr_list;
 	idev->addr_list = ifa;
+
+#ifdef CONFIG_IPV6_PRIVACY
+	ifa->regen_count = 0;
+	if (ifa->flags&IFA_F_TEMPORARY) {
+		ifa->tmp_next = idev->tempaddr_list;
+		idev->tempaddr_list = ifa;
+		in6_ifa_hold(ifa);
+	} else {
+		ifa->tmp_next = NULL;
+	}
+#endif
+
 	in6_ifa_hold(ifa);
 	write_unlock_bh(&idev->lock);
 	read_unlock(&addrconf_lock);
@@ -417,6 +478,15 @@
 
 	ifp->dead = 1;
 
+#ifdef CONFIG_IPV6_PRIVACY
+	spin_lock_bh(&ifp->lock);
+	if (ifp->ifpub) {
+		__in6_ifa_put(ifp->ifpub);
+		ifp->ifpub = NULL;
+	}
+	spin_unlock_bh(&ifp->lock);
+#endif
+
 	write_lock_bh(&addrconf_hash_lock);
 	for (ifap = &inet6_addr_lst[hash]; (ifa=*ifap) != NULL;
 	     ifap = &ifa->lst_next) {
@@ -430,6 +500,24 @@
 	write_unlock_bh(&addrconf_hash_lock);
 
 	write_lock_bh(&idev->lock);
+#ifdef CONFIG_IPV6_PRIVACY
+	if (ifp->flags&IFA_F_TEMPORARY) {
+		for (ifap = &idev->tempaddr_list; (ifa=*ifap) != NULL;
+		     ifap = &ifa->tmp_next) {
+			if (ifa == ifp) {
+				*ifap = ifa->tmp_next;
+				if (ifp->ifpub) {
+					__in6_ifa_put(ifp->ifpub);
+					ifp->ifpub = NULL;
+				}
+				__in6_ifa_put(ifp);
+				ifa->tmp_next = NULL;
+				break;
+			}
+		}
+	}
+#endif
+
 	for (ifap = &idev->addr_list; (ifa=*ifap) != NULL;
 	     ifap = &ifa->if_next) {
 		if (ifa == ifp) {
@@ -450,6 +538,96 @@
 	in6_ifa_put(ifp);
 }
 
+#ifdef CONFIG_IPV6_PRIVACY
+static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, struct inet6_ifaddr *ift)
+{
+	struct inet6_dev *idev;
+	struct in6_addr addr, *tmpaddr;
+	unsigned long tmp_prefered_lft, tmp_valid_lft;
+	int tmp_plen;
+	int ret = 0;
+
+	if (ift) {
+		spin_lock_bh(&ift->lock);
+		memcpy(&addr.s6_addr[8], &ift->addr.s6_addr[8], 8);
+		spin_unlock_bh(&ift->lock);
+		tmpaddr = &addr;
+	} else {
+		tmpaddr = NULL;
+	}
+retry:
+	spin_lock_bh(&ifp->lock);
+	in6_ifa_hold(ifp);
+	idev = ifp->idev;
+	in6_dev_hold(idev);
+	memcpy(addr.s6_addr, ifp->addr.s6_addr, 8);
+	write_lock(&idev->lock);
+	if (idev->cnf.use_tempaddr <= 0) {
+		write_unlock(&idev->lock);
+		spin_unlock_bh(&ifp->lock);
+		printk(KERN_INFO
+			"ipv6_create_tempaddr(): use_tempaddr is disabled.\n");
+		in6_dev_put(idev);
+		in6_ifa_put(ifp);
+		ret = -1;
+		goto out;
+	}
+	if (ifp->regen_count++ >= idev->cnf.regen_max_retry) {
+		idev->cnf.use_tempaddr = -1;	/*XXX*/
+		write_unlock(&idev->lock);
+		spin_unlock_bh(&ifp->lock);
+		printk(KERN_WARNING
+			"ipv6_create_tempaddr(): regeneration time exceeded. disabled temporary address support.\n");
+		in6_dev_put(idev);
+		in6_ifa_put(ifp);
+		ret = -1;
+		goto out;
+	}
+	if (__ipv6_try_regen_rndid(idev, tmpaddr) < 0) {
+		write_unlock(&idev->lock);
+		spin_unlock_bh(&ifp->lock);
+		printk(KERN_WARNING
+			"ipv6_create_tempaddr(): regeneration of randomized interface id failed.\n");
+		in6_dev_put(idev);
+		in6_ifa_put(ifp);
+		ret = -1;
+		goto out;
+	}
+	memcpy(&addr.s6_addr[8], idev->rndid, 8);
+	tmp_valid_lft = min_t(__u32,
+			      ifp->valid_lft,
+			      idev->cnf.temp_valid_lft);
+	tmp_prefered_lft = min_t(__u32, 
+				 ifp->prefered_lft, 
+				 idev->cnf.temp_prefered_lft - desync_factor / HZ);
+	tmp_plen = ifp->prefix_len;
+	write_unlock(&idev->lock);
+	spin_unlock_bh(&ifp->lock);
+	ift = ipv6_count_addresses(idev) < IPV6_MAX_ADDRESSES ?
+		ipv6_add_addr(idev, &addr, tmp_plen,
+			      ipv6_addr_type(&addr)&IPV6_ADDR_SCOPE_MASK, IFA_F_TEMPORARY) : 0;
+	if (!ift) {
+		in6_dev_put(idev);
+		in6_ifa_put(ifp);
+		printk(KERN_INFO
+			"ipv6_create_tempaddr(): retry temporary address regeneration.\n");
+		tmpaddr = &addr;
+		goto retry;
+	}
+	spin_lock_bh(&ift->lock);
+	ift->ifpub = ifp;
+	ift->valid_lft = tmp_valid_lft;
+	ift->prefered_lft = tmp_prefered_lft;
+	ift->tstamp = ifp->tstamp;
+	spin_unlock_bh(&ift->lock);
+	addrconf_dad_start(ift);
+	in6_ifa_put(ift);
+	in6_dev_put(idev);
+out:
+	return ret;
+}
+#endif
+
 /*
  *	Choose an apropriate source address
  *	should do:
@@ -458,6 +636,22 @@
  *		an address of the attached interface 
  *	iii)	don't use deprecated addresses
  */
+static int inline ipv6_saddr_pref(const struct inet6_ifaddr *ifp, u8 invpref)
+{
+	int pref;
+	pref = ifp->flags&IFA_F_DEPRECATED ? 0 : 2;
+#ifdef CONFIG_IPV6_PRIVACY
+	pref |= (ifp->flags^invpref)&IFA_F_TEMPORARY ? 0 : 1;
+#endif
+	return pref;
+}
+
+#ifdef CONFIG_IPV6_PRIVACY
+#define IPV6_GET_SADDR_MAXSCORE(score)	((score) == 3)
+#else
+#define IPV6_GET_SADDR_MAXSCORE(score)	(score)
+#endif
+
 int ipv6_get_saddr(struct dst_entry *dst,
 		   struct in6_addr *daddr, struct in6_addr *saddr)
 {
@@ -468,6 +662,7 @@
 	struct inet6_dev *idev;
 	struct rt6_info *rt;
 	int err;
+	int hiscore = -1, score;
 
 	rt = (struct rt6_info *) dst;
 	if (rt)
@@ -497,17 +692,27 @@
 			read_lock_bh(&idev->lock);
 			for (ifp=idev->addr_list; ifp; ifp=ifp->if_next) {
 				if (ifp->scope == scope) {
-					if (!(ifp->flags & (IFA_F_DEPRECATED|IFA_F_TENTATIVE))) {
-						in6_ifa_hold(ifp);
+					if (ifp->flags&IFA_F_TENTATIVE)
+						continue;
+#ifdef CONFIG_IPV6_PRIVACY
+					score = ipv6_saddr_pref(ifp, idev->cnf.use_tempaddr > 1 ? IFA_F_TEMPORARY : 0);
+#else
+					score = ipv6_saddr_pref(ifp, 0);
+#endif
+					if (score <= hiscore)
+						continue;
+
+					if (match)
+						in6_ifa_put(match);
+					match = ifp;
+					hiscore = score;
+					in6_ifa_hold(ifp);
+
+					if (IPV6_GET_SADDR_MAXSCORE(score)) {
 						read_unlock_bh(&idev->lock);
 						read_unlock(&addrconf_lock);
 						goto out;
 					}
-
-					if (!match && !(ifp->flags & IFA_F_TENTATIVE)) {
-						match = ifp;
-						in6_ifa_hold(ifp);
-					}
 				}
 			}
 			read_unlock_bh(&idev->lock);
@@ -530,16 +735,26 @@
 			read_lock_bh(&idev->lock);
 			for (ifp=idev->addr_list; ifp; ifp=ifp->if_next) {
 				if (ifp->scope == scope) {
-					if (!(ifp->flags&(IFA_F_DEPRECATED|IFA_F_TENTATIVE))) {
-						in6_ifa_hold(ifp);
+					if (ifp->flags&IFA_F_TENTATIVE)
+						continue;
+#ifdef CONFIG_IPV6_PRIVACY
+					score = ipv6_saddr_pref(ifp, idev->cnf.use_tempaddr > 1 ? IFA_F_TEMPORARY : 0);
+#else
+					score = ipv6_saddr_pref(ifp, 0);
+#endif
+					if (score <= hiscore)
+						continue;
+
+					if (match)
+						in6_ifa_put(match);
+					match = ifp;
+					hiscore = score;
+					in6_ifa_hold(ifp);
+
+					if (IPV6_GET_SADDR_MAXSCORE(score)) {
 						read_unlock_bh(&idev->lock);
 						goto out_unlock_base;
 					}
-
-					if (!match && !(ifp->flags&IFA_F_TENTATIVE)) {
-						match = ifp;
-						in6_ifa_hold(ifp);
-					}
 				}
 			}
 			read_unlock_bh(&idev->lock);
@@ -551,19 +766,12 @@
 	read_unlock(&dev_base_lock);
 
 out:
-	if (ifp == NULL) {
-		ifp = match;
-		match = NULL;
-	}
-
 	err = -EADDRNOTAVAIL;
-	if (ifp) {
-		ipv6_addr_copy(saddr, &ifp->addr);
+	if (match) {
+		ipv6_addr_copy(saddr, &match->addr);
 		err = 0;
-		in6_ifa_put(ifp);
-	}
-	if (match)
 		in6_ifa_put(match);
+	}
 
 	return err;
 }
@@ -653,6 +861,21 @@
 		ifp->flags |= IFA_F_TENTATIVE;
 		spin_unlock_bh(&ifp->lock);
 		in6_ifa_put(ifp);
+#ifdef CONFIG_IPV6_PRIVACY
+	} else if (ifp->flags&IFA_F_TEMPORARY) {
+		struct inet6_ifaddr *ifpub;
+		spin_lock_bh(&ifp->lock);
+		ifpub = ifp->ifpub;
+		if (ifpub) {
+			in6_ifa_hold(ifpub);
+			spin_unlock_bh(&ifp->lock);
+			ipv6_create_tempaddr(ifpub, ifp);
+			in6_ifa_put(ifpub);
+		} else {
+			spin_unlock_bh(&ifp->lock);
+		}
+		ipv6_del_addr(ifp);
+#endif
 	} else
 		ipv6_del_addr(ifp);
 }
@@ -718,6 +941,91 @@
 	return err;
 }
 
+#ifdef CONFIG_IPV6_PRIVACY
+/* (re)generation of randomized interface identifier (RFC 3041 3.2, 3.5) */
+static int __ipv6_regen_rndid(struct inet6_dev *idev)
+{
+	struct net_device *dev;
+	u8 eui64[8];
+	u8 digest[16];
+	MD5_CTX ctx;
+
+	if (!del_timer(&idev->regen_timer))
+		in6_dev_hold(idev);
+
+	dev = idev->dev;
+
+	if (ipv6_generate_eui64(eui64, dev)) {
+		printk(KERN_INFO
+			"__ipv6_regen_rndid(idev=%p): cannot get EUI64 identifier; use random bytes.\n",
+			idev);
+		get_random_bytes(eui64, sizeof(eui64));
+	}
+regen:
+	MD5Init(&ctx);
+	MD5Update(&ctx, idev->entropy, 8);
+	MD5Update(&ctx, eui64, 8);
+	MD5Final(digest, &ctx);
+	memcpy(idev->rndid, &digest[0], 8);
+	idev->rndid[0] &= ~0x02;
+	memcpy(idev->entropy, &digest[8], 8);
+
+	/*
+	 * <draft-ietf-ipngwg-temp-addresses-v2-00.txt>:
+	 * check if generated address is not inappropriate
+	 *
+	 *  - Reserved subnet anycast (RFC 2526)
+	 *	11111101 11....11 1xxxxxxx
+	 *  - ISATAP (draft-ietf-ngtrans-isatap-01.txt) 4.3
+	 *	00-00-5E-FE-xx-xx-xx-xx
+	 *  - value 0
+	 *  - XXX: already assigned to an address on the device
+	 */
+	if (idev->rndid[0] == 0xfd && 
+	    (idev->rndid[1]&idev->rndid[2]&idev->rndid[3]&idev->rndid[4]&idev->rndid[5]&idev->rndid[6]) &&
+	    (idev->rndid[7]&0x80))
+		goto regen;
+	if ((idev->rndid[0]|idev->rndid[1]) == 0) {
+		if (idev->rndid[2] == 0x5e && idev->rndid[3] == 0xfe)
+			goto regen;
+		if ((idev->rndid[2]|idev->rndid[3]|idev->rndid[4]|idev->rndid[5]|idev->rndid[6]|idev->rndid[7]) == 0x00)
+			goto regen;
+	}
+	
+	if (time_before(idev->regen_timer.expires, jiffies)) {
+		idev->regen_timer.expires = 0;
+		printk(KERN_WARNING
+			"__ipv6_regen_rndid(): too short regeneration interval; timer diabled for %s.\n",
+			idev->dev->name);
+		in6_dev_put(idev);
+		return -1;
+	}
+
+	add_timer(&idev->regen_timer);
+	return 0;
+}
+
+static void ipv6_regen_rndid(unsigned long data)
+{
+	struct inet6_dev *idev = (struct inet6_dev *) data;
+
+	read_lock_bh(&addrconf_lock);
+	write_lock_bh(&idev->lock);
+	if (!idev->dead)
+		__ipv6_regen_rndid(idev);
+	write_unlock_bh(&idev->lock);
+	read_unlock_bh(&addrconf_lock);
+}
+
+static int __ipv6_try_regen_rndid(struct inet6_dev *idev, struct in6_addr *tmpaddr) {
+	int ret = 0;
+
+	if (tmpaddr && memcmp(idev->rndid, &tmpaddr->s6_addr[8], 8) == 0)
+		ret = __ipv6_regen_rndid(idev);
+	return ret;
+}
+#endif
+
 /*
  *	Add prefix route.
  */
@@ -889,6 +1197,7 @@
 		struct inet6_ifaddr * ifp;
 		struct in6_addr addr;
 		int plen;
+		int create = 0;
 
 		plen = pinfo->prefix_len >> 3;
 
@@ -924,6 +1233,7 @@
 				return;
 			}
 
+			create = 1;
 			addrconf_dad_start(ifp);
 		}
 
@@ -934,6 +1244,9 @@
 
 		if (ifp) {
 			int flags;
+#ifdef CONFIG_IPV6_PRIVACY
+			struct inet6_ifaddr *ift;
+#endif
 
 			spin_lock(&ifp->lock);
 			ifp->valid_lft = valid_lft;
@@ -946,6 +1259,42 @@
 			if (!(flags&IFA_F_TENTATIVE))
 				ipv6_ifa_notify((flags&IFA_F_DEPRECATED) ?
 						0 : RTM_NEWADDR, ifp);
+
+#ifdef CONFIG_IPV6_PRIVACY
+			read_lock_bh(&in6_dev->lock);
+			/* update all temporary addresses in the list */
+			for (ift=in6_dev->tempaddr_list; ift; ift=ift->tmp_next) {
+				/*
+				 * When adjusting the lifetimes of an existing
+				 * temporary address, only lower the lifetimes.
+				 * Implementations must not increase the
+				 * lifetimes of an existing temporary address
+				 * when processing a Prefix Information Option.
+				 */
+				spin_lock(&ift->lock);
+				flags = ift->flags;
+				if (ift->valid_lft > valid_lft &&
+				    ift->valid_lft - valid_lft > (jiffies - ift->tstamp) / HZ)
+					ift->valid_lft = valid_lft + (jiffies - ift->tstamp) / HZ;
+				if (ift->prefered_lft > prefered_lft &&
+				    ift->prefered_lft - prefered_lft > (jiffies - ift->tstamp) / HZ)
+					ift->prefered_lft = prefered_lft + (jiffies - ift->tstamp) / HZ;
+				spin_unlock(&ift->lock);
+				if (!(flags&IFA_F_TENTATIVE))
+					ipv6_ifa_notify(0, ift);
+			}
+
+			if (create && in6_dev->cnf.use_tempaddr > 0) {
+				/*
+				 * When a new public address is created as described in [ADDRCONF],
+				 * also create a new temporary address.
+				 */
+				read_unlock_bh(&in6_dev->lock); 
+				ipv6_create_tempaddr(ifp, NULL);
+			} else {
+				read_unlock_bh(&in6_dev->lock);
+			}
+#endif
 			in6_ifa_put(ifp);
 			addrconf_verify(0);
 		}
@@ -1643,6 +1992,9 @@
 		write_lock(&addrconf_hash_lock);
 		for (ifp=inet6_addr_lst[i]; ifp; ifp=ifp->lst_next) {
 			unsigned long age;
+#ifdef CONFIG_IPV6_PRIVACY
+			unsigned long regen_advance;
+#endif
 
 			if (ifp->flags & IFA_F_PERMANENT)
 				continue;
@@ -1650,6 +2002,12 @@
 			spin_lock(&ifp->lock);
 			age = (now - ifp->tstamp) / HZ;
 
+#ifdef CONFIG_IPV6_PRIVACY
+			regen_advance = ifp->idev->cnf.regen_max_retry * 
+					ifp->idev->cnf.dad_transmits * 
+					ifp->idev->nd_parms->retrans_time / HZ;
+#endif
+
 			if (age >= ifp->valid_lft) {
 				spin_unlock(&ifp->lock);
 				in6_ifa_hold(ifp);
@@ -1678,6 +2036,28 @@
 					in6_ifa_put(ifp);
 					goto restart;
 				}
+#ifdef CONFIG_IPV6_PRIVACY
+			} else if ((ifp->flags&IFA_F_TEMPORARY) &&
+				   !(ifp->flags&IFA_F_TENTATIVE)) {
+				if (age >= ifp->prefered_lft - regen_advance) {
+					struct inet6_ifaddr *ifpub = ifp->ifpub;
+					if (time_before(ifp->tstamp + ifp->prefered_lft * HZ, next))
+						next = ifp->tstamp + ifp->prefered_lft * HZ;
+					if (!ifp->regen_count && ifpub) {
+						ifp->regen_count++;
+						in6_ifa_hold(ifp);
+						in6_ifa_hold(ifpub);
+						spin_unlock(&ifp->lock);
+						write_unlock(&addrconf_hash_lock);
+						ipv6_create_tempaddr(ifpub, ifp);
+						in6_ifa_put(ifpub);
+						in6_ifa_put(ifp);
+						goto restart;
+					}
+				} else if (time_before(ifp->tstamp + ifp->prefered_lft * HZ - regen_advance * HZ, next))
+					next = ifp->tstamp + ifp->prefered_lft * HZ - regen_advance * HZ;
+				spin_unlock(&ifp->lock);
+#endif
 			} else {
 				/* ifp->prefered_lft <= ifp->valid_lft */
 				if (time_before(ifp->tstamp + ifp->prefered_lft * HZ, next))
@@ -1910,7 +2290,7 @@
 static struct addrconf_sysctl_table
 {
 	struct ctl_table_header *sysctl_header;
-	ctl_table addrconf_vars[11];
+	ctl_table addrconf_vars[16];
 	ctl_table addrconf_dev[2];
 	ctl_table addrconf_conf_dir[2];
 	ctl_table addrconf_proto_dir[2];
@@ -1957,6 +2337,28 @@
          &ipv6_devconf.rtr_solicit_delay, sizeof(int), 0644, NULL,
          &proc_dointvec_jiffies},
 
+#ifdef CONFIG_IPV6_PRIVACY
+	{NET_IPV6_USE_TEMPADDR, "use_tempaddr",
+	 &ipv6_devconf.use_tempaddr, sizeof(int), 0644, NULL,
+	 &proc_dointvec},
+
+	{NET_IPV6_TEMP_VALID_LFT, "temp_valid_lft",
+	 &ipv6_devconf.temp_valid_lft, sizeof(int), 0644, NULL,
+	 &proc_dointvec},
+
+	{NET_IPV6_TEMP_PREFERED_LFT, "temp_prefered_lft",
+	 &ipv6_devconf.temp_prefered_lft, sizeof(int), 0644, NULL,
+	 &proc_dointvec},
+
+	{NET_IPV6_REGEN_MAX_RETRY, "regen_max_retry",
+	 &ipv6_devconf.regen_max_retry, sizeof(int), 0644, NULL,
+	 &proc_dointvec},
+
+	{NET_IPV6_MAX_DESYNC_FACTOR, "max_desync_factor",
+	 &ipv6_devconf.max_desync_factor, sizeof(int), 0644, NULL,
+	 &proc_dointvec},
+#endif
+
 	{0}},
 
 	{{NET_PROTO_CONF_ALL, "all", NULL, 0, 0555, addrconf_sysctl.addrconf_vars},{0}},
@@ -1975,7 +2377,7 @@
 	if (t == NULL)
 		return;
 	memcpy(t, &addrconf_sysctl, sizeof(*t));
-	for (i=0; i<sizeof(t->addrconf_vars)/sizeof(t->addrconf_vars[0])-1; i++) {
+	for (i=0; t->addrconf_vars[i].data; i++) {
 		t->addrconf_vars[i].data += (char*)p - (char*)&ipv6_devconf;
 		t->addrconf_vars[i].de = NULL;
 	}

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
