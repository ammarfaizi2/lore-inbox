Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWGJIJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWGJIJU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 04:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWGJIJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 04:09:20 -0400
Received: from mail.gmx.net ([213.165.64.21]:61849 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751306AbWGJIJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 04:09:18 -0400
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, vendor-sec@lst.de,
       lcapitulino@mandriva.com.br
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 10 Jul 2006 10:09:17 +0200
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
In-Reply-To: <20060710064355.GB4141@suse.de>
Message-ID: <20060710080917.286970@gmx.net>
MIME-Version: 1.0
References: <20060707070703.165520@gmx.net>
 <20060707040749.97f8c1fc.akpm@osdl.org>
 <20060707131310.0e382585@doriath.conectiva> <20060708064131.GG4188@suse.de>
 <20060708180926.00b1c0f8@home.brethil> <20060709103606.GU4188@suse.de>
 <20060709111629.GV4188@suse.de> <20060709134703.0aa5bc41@home.brethil>
 <20060709175744.GZ4188@suse.de> <20060710062551.307040@gmx.net>
 <20060710064355.GB4141@suse.de>
Subject: Re: splice/tee bugs?
To: Jens Axboe <axboe@suse.de>, michael.kerrisk@gmx.net
X-Authenticated: #24879014
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Could you post a 2.6.17 patch please.
> 
> Here's a 2.6.17.x version.

Jens,

Thanks.  I applied your patch against 2.6.17(.0), and did some
testing using my modified version of your test program, using 
the same command line: ls *.c | ktee r | wc, and also running 
several instances of the program in parallel using the 
command line:

find . | ktee r | wc

which in my test directory produces this output:

tee returned 65536
splice returned 65536
tee returned 65536
splice returned 65536
tee returned 53248
splice returned 53248
tee returned 57344
splice returned 57344
tee returned 7245
splice returned 7245
tee returned 0
   6212    6213  248909

Things look good so far: runs produce the results I expect, and 
no OOPSes (which Luiz Fernando reported when running multiple
instances in parallel, but I didn't see myself because I didn't
try doing that with vanilla 2.6.17) and no command-line hangs.

I'll quote my original mail in this thread, with a few questions,
and then note one lingering strange behaviour.

> The most notable differences between my program and yours
> are:
>
> * I print some debugging info to stderr.
>
> * I don't pass SPLICE_F_NONBLOCK to tee().
[...]
> On different runs I see:
>
> a) No output from ls through the pipeline:
>
> tee returned 0
>       0       0       0

I am no longer seeing results like this. So am I correct in 
understanding that tee() should only return 0 on EOF?

And is the same true of splice()?  (There is no statement 
about 0 returns from splice() in your draft manual page.)

> b) Very many instances of EAGAIN followed by expected results:
>
> ...
> EAGAIN
> EAGAIN
> EAGAIN
> EAGAIN
> EAGAIN
> EAGAIN
> tee returned 19
> splice returned 19
> tee returned 0
>       2       2      19
[...]

I no longer see results like this.  From another of your mails
in this thread, I gather that intended behaviour is that EAGAIN
will only occur if SPLICE_F_NONBLOCK has been set, right?

> c) Occasionally the command line just hangs, producing no output.
>    In this case I can't kill it with ^C or ^\.  This is a
>    hard-to-reproduce behaviour on my (x86) system, but I have
>    seen it several times by now.

I no longer see this behaviour (at least so far, after quite a
bit of testing).

One slight strangeness.  Most of the time, the 
"find . | ktee r | wc" command line takes about 0.1 seconds to 
execute, but about 1 time in 5 on my x86 system, it takes about 
1.5 to 2 seconds to execute.  Any ideas about what's happening 
there?

Cheers,

Michael
-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
