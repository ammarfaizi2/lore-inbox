Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbTL3CGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 21:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264325AbTL3CGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 21:06:17 -0500
Received: from dp.samba.org ([66.70.73.150]:32491 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264321AbTL3CGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 21:06:14 -0500
Date: Tue, 30 Dec 2003 12:37:18 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Chris Meadors <clubneon@hereintown.net>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, trivial@rustcorp.com.au
Subject: Re: GCC 3.4 Heads-up
Message-Id: <20031230123718.504d08b0.rusty@rustcorp.com.au>
In-Reply-To: <1072403207.17036.37.camel@clubneon.clubneon.com>
References: <1072403207.17036.37.camel@clubneon.clubneon.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Dec 2003 20:46:48 -0500
Chris Meadors <clubneon@hereintown.net> wrote:

> I know it isn't the recommended compiler, heck it isn't even released
> yet, but I was messing around with a GCC 3.4 snapshot, and figured I'd
> give compiling the 2.6.0 kernel a shot.
> 
> Other than the constant barrage of warnings about the use of compound
> expressions as lvalues being deprecated* (mostly because of lines 114,
> 116, and 117 of rcupdate.h, which is included everywhere), the build
> goes very well.

Thanks, downloaded this and tried it.  It's complaining about:

#define per_cpu(var, cpu)			((void)cpu, per_cpu__##var)

There are several ways of fixing this, but the simplest is:

#define per_cpu(var, cpu)			(*((void)cpu, &per_cpu__##var))

Cheers,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0/include/asm-generic/percpu.h working-2.6.0-new-gcc/include/asm-generic/percpu.h
--- linux-2.6.0/include/asm-generic/percpu.h	2003-09-22 10:26:12.000000000 +1000
+++ working-2.6.0-new-gcc/include/asm-generic/percpu.h	2003-12-30 12:35:20.000000000 +1100
@@ -29,7 +29,7 @@ do {								\
 #define DEFINE_PER_CPU(type, name) \
     __typeof__(type) per_cpu__##name
 
-#define per_cpu(var, cpu)			((void)cpu, per_cpu__##var)
+#define per_cpu(var, cpu)			(*((void)cpu, &per_cpu__##var))
 #define __get_cpu_var(var)			per_cpu__##var
 
 #endif	/* SMP */
