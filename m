Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293078AbSCAOA4>; Fri, 1 Mar 2002 09:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293091AbSCAOAr>; Fri, 1 Mar 2002 09:00:47 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:3808 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S293078AbSCAOAe>; Fri, 1 Mar 2002 09:00:34 -0500
From: <benh@kernel.crashing.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        Hubertus Franke <frankeh@watson.ibm.com>
Subject: Re: [PATCH] Fast Userspace Mutexes. 
Date: Fri, 1 Mar 2002 01:46:19 +0100
Message-Id: <20020301004619.5314@mailhost.mipsys.com>
In-Reply-To: <E16gmF8-00057N-00@wagner.rustcorp.com.au>
In-Reply-To: <E16gmF8-00057N-00@wagner.rustcorp.com.au>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seem to be a problem with PPC, you didn't put back the
PPC405_ERR77 macro in your new implementation. That means you
may hit a PPC 405gp CPU bugs and lose atomicity of lwarx/stwcx.

+#define __HAVE_ARCH_UPDATE_COUNT
+static inline int __update_count(atomic_t *count, int incr)
+{
+	int old_count, tmp;
+
+	__asm__ __volatile__("\n"
+"1:	lwarx	%0,0,%3\n"
+"	srawi	%1,%0,31\n"
+"	andc	%1,%0,%1\n"
+"	add	%1,%1,%4\n"
++	PPC405_ERR77(0,%3)
+"	stwcx.	%1,0,%3\n"
+"	bne	1b"
+	: "=&r" (old_count), "=&r" (tmp), "=m" (*count)
+	: "r" (count), "r" (incr), "m" (*count)
+	: "cc");

Ben.




