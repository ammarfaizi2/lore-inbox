Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTEQWYW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 18:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbTEQWYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 18:24:22 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:47023 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261868AbTEQWYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 18:24:20 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scheduling problem with 2.4?
References: <x54r3tddhs.fsf@lola.goethe.zz>
	<20030517174100.GT1429@dualathlon.random>
	<x5r86x74ci.fsf@lola.goethe.zz>
	<20030517203045.GZ1429@dualathlon.random>
	<x565o9717j.fsf@lola.goethe.zz>
	<20030517215345.GA1429@dualathlon.random>
Reply-To: dak@gnu.org
From: David.Kastrup@t-online.de (David Kastrup)
Date: 18 May 2003 00:37:01 +0200
In-Reply-To: <20030517215345.GA1429@dualathlon.random>
Message-ID: <x53cjd5hf6.fsf@lola.goethe.zz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> On Sat, May 17, 2003 at 10:44:16PM +0200, David Kastrup wrote:
> > Which kernel?  Oh, and of course: on a SMP machine the problem would
> 
> I run it on smp.

Then the results are worthless.  The problem is that the write to the
pipe causes an immediate context switch, keeping the pipe from
gathering useful amounts of information.

> but I understood what's going on.
> 
> --- testio.el.orig	2003-05-17 22:22:24.000000000 +0200
> +++ testio.el	2003-05-17 23:39:49.000000000 +0200
> @@ -19,7 +19,7 @@
>    (setq test-pattern nil test-start (float-time))
>    (let ((process (start-process
>  		  "test" (and (bufferp printer) printer) "sh"
> -		  "-c" "od -v /dev/zero|dd bs=1 count=100k")))
> +		  "-c" "od -v /dev/zero| dd bs=100k count=1")))
>      (set-process-filter process `(lambda (process string)
>  				   (test-filter process string
>  						',printer)))

That utterly and entirely defeats the purpose of my demonstration.
Emacs crawls as a terminal/shell/whatever exactly because programs
writing to a pty do not write in chunks of 100k.

> The reason you get the 1 char reads in your version is because dd will
> only write 1 char at time to emacs.

Of course it does.  I told it to do so.  But there is no necessity to
do an immediate context switch: it would be completely sufficient if
Emacs (which is waiting on select) were put in the run queue and
scheduled when the time slice of dd was up.  Performance gets better
at some time only because Emacs spends some time with other business
(like garbage collection) and gets preempted outside of the select
system call, and only _then_ can dd fill the pipe in a whiff.

> This has nothing to do with emacs, this is about dd writing 1 char
> at time. If you don't write 1 char at time, emacs won't read 1 char
> at time.

But if I am doing process communication with other processes, the I/O
_will_ arrive in small portions, and when the generating processes are
running on the same CPU instead of being I/O bound, I don't stand a
chance of working efficiently, namely utilizing the pipes, if I do a
quasi-synchronous context switch by force even if the time slice has
been hardly touched.

Pipes that never fill up cause overhead.  I think it amusing that a
pipeline on a single processor system will yield _vastly_ increased
performance the moment the receiving end works as _slowly_ as to get
preempted.  Only then will the sender be able to fill the pipe,
causing a large performance gain.

> The only thing you could do to decrease the cxt switch flood is to put a
> buffer with timeout in between, but by default having a buffer with
> timeout in the kernel would be an overkill overhead and depending on the
> timeout it could be visible for normal shells. So the kernel behaviour
> is right and it isn't going to change.

Visible for normal shells?  Hardly.  We are talking about letting the
output generating process live out its time slice (10ms) or being
scheduled because of waiting for something else.  Do you think you
will negatively notice that the first letter of the prompt appears
10ms later together with the complete rest of the prompt, instead of
the letters appearing one by one, but the first immediately?

> If one important app of yours is dumb and writes flood of data 1
> char at time

All interactive apps, which includes almost anything run in a pty,
write data in small chunks.  If you context switch them away from the
pipe the moment they have placed a small chunk in, performance will
suffer.

Wasn't the idea behind the anticipative I/O scheduler something like
that?  I remember vaguely.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
