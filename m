Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267275AbTCESEy>; Wed, 5 Mar 2003 13:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267322AbTCESEy>; Wed, 5 Mar 2003 13:04:54 -0500
Received: from PACIFIC-CARRIER-ANNEX.MIT.EDU ([18.7.21.83]:27828 "EHLO
	pacific-carrier-annex.mit.edu") by vger.kernel.org with ESMTP
	id <S267275AbTCESEw>; Wed, 5 Mar 2003 13:04:52 -0500
To: Kostadin Karaivanov <larry@minfin.bg>
Cc: linux-kernel@vger.kernel.org
From: Derek Atkins <derek@ihtfp.com>
Subject: Re: ipsec-tools 0.1 + kernel 2.5.64
Date: 05 Mar 2003 13:15:00 -0500
Message-ID: <sjmof4pvfx7.fsf@kikki.mit.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>   If you mention www.sf.net/projects/ipsec-tools
>   they does not compiles for me I cot following error

Yes, this is what we mean...

> grabmyaddr.c:69:1: warning: "HAVE_GETIFADDRS" redefined
> <command line>:1:1: warning: this is the location of the previous definition
> grabmyaddr.c:88: redefinition of `struct ifaddrs'
> grabmyaddr.c:200: warning: static declaration for `getifaddrs' follows
> non-static
> grabmyaddr.c:254: warning: static declaration for `freeifaddrs' follows
> non-static
> make[3]: *** [grabmyaddr.o] Error 1
> make[3]: Leaving directory `/usr/src/ipsec-tools-0.1/src/racoon'

Hmm...  What version of glibc are you using?  This seems to imply that
getifaddrs() and freeifaddrs() is now in libc, where it wasn't before.
I didn't know it got added -- I wonder when that happened?

>   I can provide additional info if needed (gcc-3.2.2) 

Please.  Feel free to follow up personally rather than to this list
(or at least be sure to CC me on all your replies, as I'm not actually
subscribed directly).

Can you try this patch and see if that fixes the problem?

diff -u -r1.3 grabmyaddr.c
--- src/racoon/grabmyaddr.c	3 Mar 2003 23:56:56 -0000	1.3
+++ src/racoon/grabmyaddr.c	5 Mar 2003 18:12:28 -0000
@@ -65,7 +65,7 @@
 #include "isakmp_var.h"
 #include "gcmalloc.h"
 
-#ifdef __linux__
+#if defined(__linux__) && !defined(HAVE_GETIFADDRS)
 #define HAVE_GETIFADDRS
 #endif
 
@@ -78,7 +78,7 @@
 static int suitable_ifaddr6 __P((const char *, const struct sockaddr *));
 #endif
 
-#ifdef __linux__
+#if defined(__linux__) && !defined(HAVE_GETIFADDRS)
 
 /* We could do this _much_ better. kame racoon in its current form
  * will esentially die at frequent changes of address configuration.

Thanks,

-derek, ipsec-tools maintainer
-- 
       Derek Atkins
       Computer and Internet Security Consultant
       derek@ihtfp.com             www.ihtfp.com
