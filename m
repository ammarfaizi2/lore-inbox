Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129466AbRCMKvz>; Tue, 13 Mar 2001 05:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130541AbRCMKvo>; Tue, 13 Mar 2001 05:51:44 -0500
Received: from www.wen-online.de ([212.223.88.39]:64266 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129466AbRCMKvg>;
	Tue, 13 Mar 2001 05:51:36 -0500
Date: Tue, 13 Mar 2001 11:50:34 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: David Shoon <dave@zylotech.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        <alan@lxorguk.ukuu.org.uka.redhat.com>,
        Rik van Riel <riel@conectiva.com.br>,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: Re: system hang with "__alloc_page: 1-order allocation failed"
In-Reply-To: <3AAD7A73.C81750FD@zylotech.com.au>
Message-ID: <Pine.LNX.4.33.0103131011250.1413-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2001, David Shoon wrote:

> Hi,

Greetings,

> After some testing, 2.4.2, 2.4.2-pre3, and 2.4.3-ac18 and ac19 both
> crash/hang when a fork loop (bomb) is executed (under a normal user) and
> killed (by a superuser). This isn't what you'd expect in previous
> kernels (2.2.x, and 2.0.x), as they both return to normal after killing
> the process.
>
> (This might be related to an earlier post about memory allocation?)
>
> Anyway, a 'forkbomb' just looks like this (sorry, just clarifying the
> obvious):
>
> int main() {
>     while (1)
>         fork();
> }

Allowing users to run in an unlimited environment is bad of course, and
setting a process limit will cure that.  However...

> With 2.4.2, 2.4.2-pre3 after killing the process (ctrl-c or killall -9
> prog) the kernel dumps error messages of: "__alloc_page: 1-order
> allocation failed" continuously for a few minutes and then starts to
> (randomly?) kill other processes which are active (such as xfs, bash)
> with "Out of Memory: Killed process ### (etc.)". Keyboard input doesn't
> work, but you can still switch vconsoles.

(The oom killer doesn't activate here.. bummer)

First problem is that since high order allocations (>0) can fail for
root just as for any user.  It can (and does currently) happen that
root can't fork a task in order to kill the forkbombs.  Here, I even
modified __alloc_pages() to never allow root allocations to fail..
that alone isn't enough, because it can (does) happen that even though
I never give up, the little memory which is free is so fragmented that
I cannot allocate a task struct (order 1).  Everything swappable has
been swapped and the freed memory consumed by the greedy little user
processes.. so it never gets better and the kernel just pages forever.

(A workaround is to lower max_threads to 25% of memory.. works, but is
really cheezy.  OTOH, allowing half of memory to be allocated in task
structs is a bit cheezy looking too.  That means that these tasks can't
be big enough to be doing real work.. no?)

Second problem is that even SysRq-E doesn't always kill reliably when
you're very low on memory, so your fork bomb may take off all over again..
and it does exactly that.

Third problem _appears_ (heavy emphasis required) to be the scheduler.
Even with the allocator never giving up on root allocations and reducing
max_threads, it happens here that root's killall -9 forkbomb never RUNS
despite order 1 being available.. unless root's shell is set SCHED_RR.
[maybe I wasn't patient enough, but minutes seems long enough to wait]

None of these problems seem to be a 'big hairy deal' with real workloads..
but they are smudges on the otherwise perfect ;-) kernel.

> Under 2.4.2-ac18/19, the system doesn't show the error messages, but it
> still hangs after you kill the process. All keyboard input freezes
> eventually (can't switch vconsoles).
>
> I'm not sure if it helps, but the system I'm testing this on is a PIII
> 500mhz, with 196megs of ram, with swap disabled just so I know it's not
> device read/writes.

Running oom without swap is guaranteed doom.

	-Mike

