Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265235AbSJaTvm>; Thu, 31 Oct 2002 14:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265237AbSJaTvm>; Thu, 31 Oct 2002 14:51:42 -0500
Received: from ns.suse.de ([213.95.15.193]:60421 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265235AbSJaTvj>;
	Thu, 31 Oct 2002 14:51:39 -0500
Date: Thu, 31 Oct 2002 20:58:02 +0100 (CET)
From: Bernhard Kaindl <bk@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: What's left over.
In-Reply-To: <3DC17354.943DAC97@digeo.com>
Message-ID: <Pine.LNX.4.33.0210311938150.6945-100000@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Andrew Morton wrote:
>
> We'll be spending the next six months stabilising and hardening
> the used-to-be-2.5 kernel.  If grunts like me can get hold a
> copy of the other person's kernel image from time-of-crash, that
> has a ton of value.

Exactly, sometimes you don't even need the dump itself, The user
who has the dump just types lcrash and report -w file.txt and
lcrash writes a consolidated report with the most interesting
information from the dump to the file.txt and he can sent it
to you and you've much information you often miss in problem
reports.

The report consists of: time when the dump was created, time
when the report was created, the architecture, the hostname,
kernel version and compile time, the kernel (dmesg) buffer
with all the oopses logged into it, a short task list with
process adress, id's, state, flags, cpu and process name,
and finally a full CPU dump of every CPU with all registers,
current process and function and a symbolic stack backtrace
of the CPU.

Sometimes this is all you need to know and if you need to
know e.g. the stack backtrace of a not running process at
the time of the dump, you can ask the user to simply run
trace <process address> and lcrash gives you the backtrace
of this process:

lcrash> t[race] 0x1408000
================================================================
STACK TRACE FOR TASK: 0x1408000 (kjournald)

 STACK:
 0 schedule+894 [0x3164e]
 1 interruptible_sleep_on+174 [0x31eae]
 2 journal_revoke+<ERROR> [0x10889c0c]
 3 kernel_thread+70 [0x18c1e]

showing the full task scruct, a sub-struct or a field is also simple:

p[rint] ((struct task_struct *)0x1408000)->pending
struct sigpending {
        head = (nil)
        tail = 0x1598700
        signal = sigset_t {
                sig = {
                        [0] 0
                }
        }
}

"feels" a bit like gdb

> (Disclaimer: I've never used lkcd.  I'm assuming that it's
> possible to gdb around in a dump)

I don't know if there is an lkcd->ELF core converter yet, but
it should be doable. However, lcrash is quite powerful, it comes
with sial, an integrated C interpreter that permits easy access to the
symbol and type information, obviosly, it allows to write code like this:

        void
        showprocs()
        {
        	struct proc* p;
                for(p=*(struct proc**)procs; p; p=p->p_next)
                        do something...
                }
        }

Looks nice... :-)

I also don't know if (k)gdb knows about tasks, lcrash at least
knows about them and this may when you look into a specific
task(I'm not an expert)

Of cource lcrash can do dissembing, find symbols,
> So.  _If_ lkcd gives me gdb-able images from time-of-crash, I'd
> like it please.  And I'm the grunt who spent nearly two years
> doing not much else apart from working 2.3/2.4 oops reports.

Maybe the lkcd people can do so, but I think they can also give
a hands-on workshop to lcrash.

You can use lcrash also on running system to browse around,
learn and save dumps from it without interrupting it, you
just need lcrash, the System.map and the Kerntypes file from
kernel for using it.

> Oh, and as Rusty has pointed out, we lose a *lot* of oops reports
> because users are in X and the backtrace doesn't make it to the
> logs.

Yep, I think it would be good even if Linus just accepts the
infrastructure patch of lkcd which needs to be in the kernel,
the vafourite dump method module can then be downloaded, compiled
installed and configured without much pain, I think that people
can start using it in a broader range without the hassle of
needing to patching and booting a special kernel.

Bernd

PS: lcrash is only one of the many frontends, as I've read in
this thread, there is also Dave Anderson's "crash" tool which
works with LKCD dumps, netdump dumps, etc. There is also qlcrash,
an qt frontend for lcrash for people who like to click!

