Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315171AbSEaHOd>; Fri, 31 May 2002 03:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315178AbSEaHOc>; Fri, 31 May 2002 03:14:32 -0400
Received: from relay1.pair.com ([209.68.1.20]:52492 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S315171AbSEaHOa>;
	Fri, 31 May 2002 03:14:30 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3CF7230D.47EDC94C@kegel.com>
Date: Fri, 31 May 2002 00:15:25 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: trivial@rustcorp.com.au,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [patch] byteorder.h, ntohl, and compiling userspace programs
Content-Type: multipart/mixed;
 boundary="------------D33FC4E2CC8BC91E9AE2ED84"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D33FC4E2CC8BC91E9AE2ED84
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On 5/14, I wrote:
> Dimi Shahbaz wrote:
> > I'm trying to build glibc ...
> > [but get a compile error:]
> > ../inet/netinet/in.h:259: parse error before '(' token
> > [caused by linux's #define of ntohl when compiling glibc's
> >  function prototype for ntohl]
> 
> I think the conflict is with the ntohl macros defined in
> /usr/src/linux/include/linux/byteorder/generic.h
> 
> These days, I don't see why the Linux kernel headers
> should be defining ntohl for userspace; libc's headers
> do that.  So how about simplifying generic.h so it
> only does anything when compiling the kernel:

Here's that patch again (MIME this time, so tabs don't get
lost by my silly gui mailer); applies cleanly against against 2.4.19-pre8.
Nobody commented on it last time I posted it, and it does
make compiling gcc easier, so I guess that makes it trivial patch
monkey fodder.  Or am I making a silly mistake?
- Dan
--------------D33FC4E2CC8BC91E9AE2ED84
Content-Type: text/plain; charset=us-ascii;
 name="htonl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="htonl.patch"

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

--------------D33FC4E2CC8BC91E9AE2ED84--

