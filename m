Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWGJIWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWGJIWD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 04:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWGJIWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 04:22:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:42532 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751359AbWGJIWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 04:22:01 -0400
Date: Mon, 10 Jul 2006 10:24:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Michael Kerrisk <mtk-manpages@gmx.net>
Cc: michael.kerrisk@gmx.net, akpm@osdl.org, linux-kernel@vger.kernel.org,
       vendor-sec@lst.de, lcapitulino@mandriva.com.br
Subject: Re: splice/tee bugs?
Message-ID: <20060710082423.GI4141@suse.de>
References: <20060707131310.0e382585@doriath.conectiva> <20060708064131.GG4188@suse.de> <20060708180926.00b1c0f8@home.brethil> <20060709103606.GU4188@suse.de> <20060709111629.GV4188@suse.de> <20060709134703.0aa5bc41@home.brethil> <20060709175744.GZ4188@suse.de> <20060710062551.307040@gmx.net> <20060710064355.GB4141@suse.de> <20060710080917.286970@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060710080917.286970@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10 2006, Michael Kerrisk wrote:
> > > Could you post a 2.6.17 patch please.
> > 
> > Here's a 2.6.17.x version.
> 
> Jens,
> 
> Thanks.  I applied your patch against 2.6.17(.0), and did some
> testing using my modified version of your test program, using 
> the same command line: ls *.c | ktee r | wc, and also running 
> several instances of the program in parallel using the 
> command line:
> 
> find . | ktee r | wc
> 
> which in my test directory produces this output:
> 
> tee returned 65536
> splice returned 65536
> tee returned 65536
> splice returned 65536
> tee returned 53248
> splice returned 53248
> tee returned 57344
> splice returned 57344
> tee returned 7245
> splice returned 7245
> tee returned 0
>    6212    6213  248909
> 
> Things look good so far: runs produce the results I expect, and 
> no OOPSes (which Luiz Fernando reported when running multiple
> instances in parallel, but I didn't see myself because I didn't
> try doing that with vanilla 2.6.17) and no command-line hangs.

So far, so good.

> > The most notable differences between my program and yours
> > are:
> >
> > * I print some debugging info to stderr.
> >
> > * I don't pass SPLICE_F_NONBLOCK to tee().
> [...]
> > On different runs I see:
> >
> > a) No output from ls through the pipeline:
> >
> > tee returned 0
> >       0       0       0
> 
> I am no longer seeing results like this. So am I correct in 
> understanding that tee() should only return 0 on EOF?

tee() can still return 0 without SPLICE_F_NONBLOCK being set, if the
pipes are changed in between the _prep calls and link_pipe(). There's
really nothing we can do about that. There's no EOF condition for
link_pipe(), as it purely operates on pipes. A 0 return means that we
had no data to splice and could not wait for data, either because it
would be a locking violation or because it simply doesn't make sense to
wait (eg no writers attached to the pipe). It will only return EAGAIN
for a non-blocking tee() now though.

> And is the same true of splice()?  (There is no statement 
> about 0 returns from splice() in your draft manual page.)

Same holds true for splice. We can still return 0 even for a blocking
splice if there's no data to splice from the pipe and no writers
attached. This is identical to how pipes behave.

> > b) Very many instances of EAGAIN followed by expected results:
> >
> > ...
> > EAGAIN
> > EAGAIN
> > EAGAIN
> > EAGAIN
> > EAGAIN
> > EAGAIN
> > tee returned 19
> > splice returned 19
> > tee returned 0
> >       2       2      19
> [...]
> 
> I no longer see results like this.  From another of your mails
> in this thread, I gather that intended behaviour is that EAGAIN
> will only occur if SPLICE_F_NONBLOCK has been set, right?

Correct.

> > c) Occasionally the command line just hangs, producing no output.
> >    In this case I can't kill it with ^C or ^\.  This is a
> >    hard-to-reproduce behaviour on my (x86) system, but I have
> >    seen it several times by now.
> 
> I no longer see this behaviour (at least so far, after quite a
> bit of testing).

Good, it should be fixed with the blocking removal from link_pipe().

> One slight strangeness.  Most of the time, the 
> "find . | ktee r | wc" command line takes about 0.1 seconds to 
> execute, but about 1 time in 5 on my x86 system, it takes about 
> 1.5 to 2 seconds to execute.  Any ideas about what's happening 
> there?

That is pretty odd. Any chance you can do a quick sysrq-t and see where
find/ktee/wc is stuck when this happens? You should not be seeing that,
naturally, I'll see if I can reproduce that here. How much data does
find . return in your example?

-- 
Jens Axboe

