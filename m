Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSG3VW1>; Tue, 30 Jul 2002 17:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSG3VW1>; Tue, 30 Jul 2002 17:22:27 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:43530 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316580AbSG3VWZ>; Tue, 30 Jul 2002 17:22:25 -0400
Date: Tue, 30 Jul 2002 23:26:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: async-io API registration for 2.5.29
Message-ID: <20020730212657.GL1181@dualathlon.random>
References: <20020730054111.GA1159@dualathlon.random> <20020730091140.A6726@infradead.org> <20020730164320.GH1181@dualathlon.random> <20020730125943.B10315@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020730125943.B10315@redhat.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 12:59:43PM -0400, Benjamin LaHaise wrote:
> is what the 2.4.18 patches are, as they still cause that VM to OOM under 
> rather trivial io patterns).

I would like if you could reproduce with the aio in my tree after an:

	echo 1 >/proc/sys/vm/vm_gfp_debug

that will give you stack traces that you should send back to me, and I
will tell you exactly what the problem is (if you can reproduce).

> 
> > Really last thing: one of the major reasons I don't like the above code
> > besides the overhead and complexity it introduces is that it doesn't
> > guarantee 100% that it will be forward compatible with 2.5 applications
> > (the syscall 250 looks not to check even for the payload, I guess they
> > changed it because it was too slow to be forward compatible in most
> > cases), the /dev/urandom payload may match the user arguments if you're
> > unlucky and since we can guarantee correct operations by doing a syscall
> > registration, I don't see why we should make it work by luck.
> 
> You haven't looked at the code very closely then.  It checks that the 
> payload matches, and that the caller is coming from the vsyscall pages.  

I didn't noticed the caller needed to came from the vsyscall pages, that
makes it safer but still it's an huge complexity that you apparently
disabled in your test tree because it was harming performance.

> that x86-64 gets wrong by not requiring the vsyscall page to need an 
> mmap into the user's address space: UML cannot emulate vsyscalls by 

I don't want vma overhead in the rbtree, nor in the mm_struct, nor I
want mmap in general to deal with vsyscalls for obvious performance
reasons.

> faking the mmap.

the fix for uml is trivial, the simplest approch is to add a prctl that
disables vsyscalls for a certain process and that cannot be re-enabled
by the userspace (so a one-way prctl), the vsyscall will be swapped with
a vsyscall that invokes the real syscall and uml will trap gettimeofday
syscall like it does on x86. We also discussed some more complicated and
sophisticated approch but I like the prctl that forces the
gettimeofday/time syscalls because that could be used trivially for
strace too (of course ltrace will just show the gettimeofday call
because we pass through glibc, infact uml for 99% of cases could simply
use LD_PRELOAD, but Jeff didn't like it for good reasons: because it's
not transparent enough for userspace and of course it doesn't work with
statically linked binaries).

In short the prctl that redirects the program and all childs to use the
real syscall would be my preferred approch, as said the uml kernel
should still be able to use the vgettimeofday, only the childs (the
userspace running under the uml kernel) will be executed with the prctl
enabled and the fact userspace cannot disable the prctl (once enabled
before execve) will guarantee the system will function correctly.  It
will require a per-task information and a switch_to hack that will
change the fixmap entry and inlvpg if needed.

Now I don't remeber anymore if I just suggested the above prctl way to
Jeff and he just found any weakness in it that could make it not a
feasible way for uml, but in such case he will remind me about it now :)

Infact we will use the same tecnique of using a vsyscall that redirect
to a real syscalls for all kind of vsyscalls that in some hardware may
need to know what cpu they are running on to return the result, this is
never been needed so far but it was one of the possibilities that our
vsyscall design offered.

Andrea
