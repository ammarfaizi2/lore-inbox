Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315889AbSENRLz>; Tue, 14 May 2002 13:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315890AbSENRLy>; Tue, 14 May 2002 13:11:54 -0400
Received: from relay1.pair.com ([209.68.1.20]:63496 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S315889AbSENRLx>;
	Tue, 14 May 2002 13:11:53 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3CE14637.47A50895@kegel.com>
Date: Tue, 14 May 2002 10:15:35 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dimi Shahbaz <dshahbaz@ixiacom.com>
CC: crossgcc@sources.redhat.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [patch] byteorder.h, ntohl, and compiling userspace programs
In-Reply-To: <3CE06DC6.4080707@ixiacom.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimi Shahbaz wrote:
> I'm trying to build glibc ...
> [but get a compile error:]
> ../inet/netinet/in.h:259: parse error before '(' token
> [caused by linux's #define of ntohl when compiling glibc's
>  function prototype for ntohl]

I think the conflict is with the ntohl macros defined in
/usr/src/linux/include/linux/byteorder/generic.h

These days, I don't see why the Linux kernel headers
should be defining htohl for userspace; libc's headers
do that.  So how about simplifying generic.h so it
only does anything when compiling the kernel:

--- linux/include/linux/byteorder/generic.h.orig	Tue May 14 10:02:49 2002
+++ linux/include/linux/byteorder/generic.h	Tue May 14 10:06:48 2002
@@ -123,6 +123,7 @@
 #endif
 
 
+#if defined(__KERNEL__)
 /*
  * Handle ntohl and suches. These have various compatibility
  * issues - like we want to give the prototype even though we
@@ -146,17 +147,11 @@
  * Do the prototypes. Somebody might want to take the
  * address or some such sick thing..
  */
-#if defined(__KERNEL__) || (defined (__GLIBC__) && __GLIBC__ >= 2)
 extern __u32			ntohl(__u32);
 extern __u32			htonl(__u32);
-#else
-extern unsigned long int	ntohl(unsigned long int);
-extern unsigned long int	htonl(unsigned long int);
-#endif
 extern unsigned short int	ntohs(unsigned short int);
 extern unsigned short int	htons(unsigned short int);
 
-
 #if defined(__GNUC__) && (__GNUC__ >= 2) && defined(__OPTIMIZE__)
 
 #define ___htonl(x) __cpu_to_be32(x)
@@ -164,17 +159,14 @@
 #define ___ntohl(x) __be32_to_cpu(x)
 #define ___ntohs(x) __be16_to_cpu(x)
 
-#if defined(__KERNEL__) || (defined (__GLIBC__) && __GLIBC__ >= 2)
 #define htonl(x) ___htonl(x)
 #define ntohl(x) ___ntohl(x)
-#else
-#define htonl(x) ((unsigned long)___htonl(x))
-#define ntohl(x) ((unsigned long)___ntohl(x))
-#endif
 #define htons(x) ___htons(x)
 #define ntohs(x) ___ntohs(x)
 
 #endif /* OPTIMIZE */
 
+#endif /* KERNEL */
+
 
 #endif /* _LINUX_BYTEORDER_GENERIC_H */
