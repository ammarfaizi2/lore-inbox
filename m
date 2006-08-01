Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932612AbWHAJ6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbWHAJ6F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 05:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWHAJ6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 05:58:04 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:11794 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932612AbWHAJ6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 05:58:03 -0400
Date: Tue, 1 Aug 2006 10:57:51 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Hua Zhong <hzhong@gmail.com>,
       "'Heiko Carstens'" <heiko.carstens@de.ibm.com>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "'Martin Schwidefsky'" <schwidefsky@de.ibm.com>
Subject: Re: do { } while (0) question
Message-ID: <20060801095751.GC9556@flint.arm.linux.org.uk>
Mail-Followup-To: Jiri Slaby <jirislaby@gmail.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Hua Zhong <hzhong@gmail.com>,
	'Heiko Carstens' <heiko.carstens@de.ibm.com>,
	'Andrew Morton' <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	'Martin Schwidefsky' <schwidefsky@de.ibm.com>
References: <008e01c6b549$59e52f70$493d010a@nuitysystems.com> <1154425171.32739.2.camel@taijtu> <44CF22E8.9020307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CF22E8.9020307@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 11:45:53AM +0159, Jiri Slaby wrote:
> Peter Zijlstra wrote:
> >On Tue, 2006-08-01 at 02:03 -0700, Hua Zhong wrote:
> >>>#if KILLER == 1
> >>>#define MACRO
> >>>#else
> >>>#define MACRO do { } while (0)
> >>>#endif
> >>>
> >>>{
> >>>	if (some_condition)
> >>>		MACRO
> >>>
> >>>	if_this_is_not_called_you_loose_your_data();
> >>>}
> >>>
> >>>How do you want to define KILLER, 0 or 1? I personally choose 0.
> >>Really? Does it compile?
> >
> >No, and that is the whole point.
> >
> >The empty 'do {} while (0)' makes the missing semicolon a syntax error.
> 
> Bulls^WNope, it was a bad example (we don't want to break the compilation, 
> just not want to emit a warn or an err).

Your sentence does not make sense, but I'm going to take it as saying
that you disagree that the above will cause a syntax error.  Try it:

$ cat t.c
#if KILLER == 1
#define MACRO
#else
#define MACRO do { } while (0)
#endif

void foo(int some_condition)
{
     if (some_condition)
             MACRO

     if_this_is_not_called_you_loose_your_data();
}
$ gcc -O2 -o - -E t.c
# 1 "t.c"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "t.c"






void foo(int some_condition)
{
     if (some_condition)
             do { } while (0)

     if_this_is_not_called_you_loose_your_data();
}
$ gcc -O2 -o - -S t.c >/dev/null
t.c: In function `foo':
t.c:12: error: parse error before "if_this_is_not_called_you_loose_your_data"
$ gcc -O2 -o - -E t.c -DKILLER
# 1 "t.c"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "t.c"






void foo(int some_condition)
{
     if (some_condition)


     if_this_is_not_called_you_loose_your_data();
}
$ gcc -O2 -o - -S t.c -DKILLER >/dev/null
$

Hence, using do { } while (0) has had the desired effect - the missing
semicolon causes a compile error, while the empty macro results in
unintentional successful compilation without warning or error.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
