Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbTEGLsu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 07:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbTEGLst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 07:48:49 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:43250 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S263124AbTEGLrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 07:47:41 -0400
Message-ID: <3EB8F54C.CC5488F0@Bull.Net>
Date: Wed, 07 May 2003 14:00:12 +0200
From: Eric Piel <Eric.Piel@Bull.Net>
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: george anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: DELAYTIMER_MAX is defined
References: <3EB7E3DA.C50258A9@Bull.Net> <3EB81719.3050705@mvista.com> <3EB8B5EA.BD5D1C19@Bull.Net> <3EB8BA67.4060708@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> This is not correct.  The constant does not have to be defined.  Like
> all the various *_MAX constants they only have to be defined if there is
> a fixed limit the implementation has.  If there is none or it can only
> be defined dynamically at runtime the the macro must not be defined.
> Instead sysconf() can provide the value.  But not even this is
> necessary.  sysconf() can return -1.
Sorry, I wasn't aware about this POSIX rule, thank you for pointing out
this. Knowing that it would obviously be better providing support of the
constant _SC_DELAYTIMER_MAX for sysconf() and return a value. 

This would imply there is now some job for glibc. However it's still
unclear for me how the glibc would know about wich value it should 
return while this question would be so easy to answer for the kernel!
Also AFAIK, right now, only the NPTL supports the new syscalls for the
timers (and none supports the clocks syscalls). Does it mean a special
__sysconf() is necessary in the NPTL? Well, probably that's why you 
suggested -1 as a return value I guess :-) 

> 
> Anyway, in this specific case the implementation should be protected
> against the ever so improbable overflow of the counter, yes.  If you
> want a fixed value, fine.  If you want to use ULONG_MAX (or whatever),
> good too.  Whether we advertise this limit is another thing.
> Advertising it in the macro means it never can be changed.
> 
You are right also here, of course with this point of view it's
better not putting any constant.
So the patch could become something like that: ?

diff -ur linux-2.5.67-ia64-hrtcore/include/linux/posix-timers.h linux-2.5.67-ia64-hrtimers/include/linux/posix-timers.h
--- linux-2.5.67-ia64-hrtcore/include/linux/posix-timers.h      2003-04-22 11:10:44.000000000 +0200
+++ linux-2.5.67-ia64-hrtimers/include/linux/posix-timers.h     2003-05-06 16:07:56.000000000 +0200
@@ -25,6 +59,7 @@
 
 #define posix_bump_timer(timr) do { \
                         (timr)->it_timer.expires += (timr)->it_incr; \
-                        (timr)->it_overrun++;               \
+                        if ((timr)->it_overrun < INT_MAX)\
+                            (timr)->it_overrun++;               \
                        }while (0)
 #endif

Eric
