Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267102AbTCES7g>; Wed, 5 Mar 2003 13:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267472AbTCES7g>; Wed, 5 Mar 2003 13:59:36 -0500
Received: from PACIFIC-CARRIER-ANNEX.MIT.EDU ([18.7.21.83]:19925 "EHLO
	pacific-carrier-annex.mit.edu") by vger.kernel.org with ESMTP
	id <S267102AbTCES7d>; Wed, 5 Mar 2003 13:59:33 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: Kostadin Karaivanov <larry@minfin.bg>, linux-kernel@vger.kernel.org
From: Derek Atkins <derek@ihtfp.com>
Subject: Re: ipsec-tools 0.1 + kernel 2.5.64
References: <sjmof4pvfx7.fsf@kikki.mit.edu>
	<20030305182715.A27888@infradead.org> <sjmbs0pvelp.fsf@kikki.mit.edu>
	<20030305185149.A28243@infradead.org>
Date: 05 Mar 2003 14:00:47 -0500
In-Reply-To: <20030305185149.A28243@infradead.org>
Message-ID: <sjm7kbdvdsw.fsf@kikki.mit.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Wed, Mar 05, 2003 at 01:43:30PM -0500, Derek Atkins wrote:
> > Well, the problem is that the replacement function is only valid on
> > Linux, so I need to have the <OS> test in there anyways.
> 
> It's probably not valid on Linux but on OSes that support the functionality
> you use to implement it.  It might e.g. work on the Hurd that uses old
> Linux networking code.

I find it extremely unlikely that the hurd would have the include file
<linux/rtnetlink.h>, which is part of the code chunk in question.  As
I said, the code is extremely linux-specific.

> Checking for OSes is wrong because you couldn't care less for the
> OS, you care for the functionality that is provided.  This is the
> nice idea behind autoconf (the implementation of autoconf is a completly
> different issue, though).

As I said, the current code is OS specific.  I find is EXTREMELY
unlikely it would work on anything that isn't Linux.  I wont argue
about autoconf implementation.

However, I will acknowledge that my original patch was broken.  Here
is a better one.  This should work on both pre- and post- glibc-2.3
linux systems.

-derek

diff -u -r1.3 -r1.4
--- src/racoon/grabmyaddr.c	3 Mar 2003 23:56:56 -0000	1.3
+++ src/racoon/grabmyaddr.c	5 Mar 2003 18:54:08 -0000	1.4
@@ -65,8 +65,9 @@
 #include "isakmp_var.h"
 #include "gcmalloc.h"
 
-#ifdef __linux__
+#if defined(__linux__) && !defined(HAVE_GETIFADDRS)
 #define HAVE_GETIFADDRS
+#define NEED_LINUX_GETIFADDRS
 #endif
 
 #ifndef HAVE_GETIFADDRS
@@ -78,7 +79,7 @@
 static int suitable_ifaddr6 __P((const char *, const struct sockaddr *));
 #endif
 
-#ifdef __linux__
+#ifdef NEED_LINUX_GETIFADDRS
 
 /* We could do this _much_ better. kame racoon in its current form
  * will esentially die at frequent changes of address configuration.

-- 
       Derek Atkins
       Computer and Internet Security Consultant
       derek@ihtfp.com             www.ihtfp.com
