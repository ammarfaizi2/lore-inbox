Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbTGOGIS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 02:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbTGOGIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 02:08:18 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:42184 "HELO
	develer.com") by vger.kernel.org with SMTP id S263103AbTGOGIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 02:08:17 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
To: Andrew Morton <akpm@osdl.org>
Subject: Re: do_div64 generic
Date: Tue, 15 Jul 2003 08:23:00 +0200
User-Agent: KMail/1.5.9
Cc: george@mvista.com, linux-kernel@vger.kernel.org, akpm@zip.com.au,
       rmk@arm.linux.org.uk, torvalds@osdl.org
References: <3F1360F4.2040602@mvista.com> <200307150717.54981.bernie@develer.com> <20030714223805.4e5bee3f.akpm@osdl.org>
In-Reply-To: <20030714223805.4e5bee3f.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307150823.01602.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 July 2003 07:38, Andrew Morton wrote:

> >  Here's a patch that takes care of all architectures.
>
> AFAICT, we can just rework posix-timers.c to use the standard do_div() and
> be done with it, can we not?  ie: no div_long_long_rem(), no
> div_ll_X_l_rem().  Just do_div().

We could, and it would be easy and almost as efficient in all places
where div_long_long_rem() is being used:

   value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_nsec);

becomes:

   value->tv_nsec = do_div(nsec, NSEC_PER_SEC);
   value->tv_sec = nsec;

George, do you agree? May I go on and post a patch killing
div_long_long_rem() everywhere?

> Please use `static inline', not `extern inline', btw.

Oops. Fixed. I had just copied it over from asm-i386/div64.h.

Is it worth posting a big patch to replace all remaining
occurrences of 'extern inline' all over the kernel?

I'd also like to point out that __inline__ is often being
used inconsistently. We should be using __inline__ rather
than inline in public headers needed by glibc for apps
compiled with -ansi. Since it's so ugly, it shouldn't
be used in other places.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


