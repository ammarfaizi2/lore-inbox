Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284916AbRLKHAQ>; Tue, 11 Dec 2001 02:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284913AbRLKG75>; Tue, 11 Dec 2001 01:59:57 -0500
Received: from hal.astr.lu.lv ([195.13.134.67]:59784 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S284899AbRLKG7o>;
	Tue, 11 Dec 2001 01:59:44 -0500
Message-Id: <200112110659.fBB6xLt24936@hal.astr.lu.lv>
Content-Type: text/plain; charset=US-ASCII
From: Andris Pavenis <pavenis@latnet.lv>
To: Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] i810_audio fix for version 0.11
Date: Tue, 11 Dec 2001 08:59:20 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Nathan Bryant <nbryant@optonline.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.A41.4.05.10112081022560.23064-100000@ieva06> <200112080945.fB89jAC00998@hal.astr.lu.lv> <3C15566B.7010803@redhat.com>
In-Reply-To: <3C15566B.7010803@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 December 2001 02:42, Doug Ledford wrote:
> Andris Pavenis wrote:
> > Why returning non zero from __start_dac() and similar procedures when
> > something real has been done there is so bad.
>
> Personal preference.

Thought about slightly different idea but didn't test it (I'm now about 300 km
away from a box where I did the tests and it will be so up to Cristmas):

	move both port operations used before and after call to
	__start_dac() and __start_adc() inside these inline procedures.
	In this case we would have waiting for results of __start_dac
	only when it really needed, so no possibility of deadlock
	there

>
> > Using such return code would
> > ensure we never try to wait for results of __start_dac() if nothing is
> > done by this procedure.
>
> That's part of the point.  In this driver, I try to control when things are
> done and keep track of them in a deterministic way.  Using a return code to
> tell us a function we called did nothing when we shouldn't have called it
> in the first place if it wasn't going to do anything is backwards from the
> way I prefer to handle things.  Namely, find out why the function was
> called when it shouldn't have been and solve the problem.  Note: I don't

If we moved 
                outb((inb(port+OFF_CIV)+1)&31, port+OFF_LVI);
and 
                while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;
from inside __i810_update_lvi to __start_adc and __start_dac (inside
if block) we would avoid deadlocks. If You like to have noticed that
__start_dac ot __start_adc is called when they should not, then
add printk with message there (or even disable sound support totally with 
additional error message in log, so user will complain). I think leaving out 
possiblility of deadlocks is too dangerous.

> follow that philosophy on all functions, only on very simple ones like
> this, there are a lot of complex functions where you want the function to
> make those decisions.  So, like I said, personal preference on how to
> handle these things.
>
> > I think such way is also more safe against possible future
> > modifications as real conditions are only in a single place. Keeping them
> > in 2 places is possible source of bitrot if driver will be updated in
> > future.
>
> It's intended to do exactly that.  A lot of what makes this driver work
> properly right now is the LVI handling.  That was severly busted when I
> first got hold of the driver.  I *want* things to break if the LVI handling
> is changed by someone else because that will alert me to the fact that the
> LVI handling is then busted (at least, if they change it incorrectly, if
> they do things right then they will catch problems like this and fix them
> properly and I won't have to do anything).

I would suggest to disable sound support and give reasonable error message
in this case. So user will able to complain if this happens. It's more 
difficult to get usefull report when deadlock happens (and many users may not 
want to debug and provide additional info it in this case any more)

Andris


