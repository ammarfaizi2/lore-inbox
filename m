Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267782AbRGQHNI>; Tue, 17 Jul 2001 03:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267783AbRGQHM5>; Tue, 17 Jul 2001 03:12:57 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:2715 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S267782AbRGQHMp>;
	Tue, 17 Jul 2001 03:12:45 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.4.6] PPID of a process is set to itself
In-Reply-To: <Pine.LNX.4.33.0107162325120.933-100000@penguin.transmeta.com>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 17 Jul 2001 00:08:27 -0700
In-Reply-To: Linus Torvalds's message of "Mon, 16 Jul 2001 23:40:02 -0700 (PDT)"
Message-ID: <m3ae24m3ro.fsf@otr.mynet>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> 	if (!has_created_master_process) {
> 		new_me = clone(CLONE_VM | SIGCHLD);
> 		if (new_me > 0) {
> 			/* Original thread turns into master process */
> 			printf("I am the new master process, bow down before me!\n");
> 			has_created_master_process = 1;
> 			for (;;) {
> 				if (!waitpid(-1, NULL, 0))
> 					continue;
> 				if (errno == ENOCHLD)
> 					exit(0);
> 				.. we could do signal propagation here ..
> 			}
> 		}
> 		/* This child now takes over the role of the original thread */

A bit more complicated due to switching of stacks but that's basically
it.  With this clone model using n+1 threads is the only way to get
the semantics right.

> Also, please do notice that one fundamental part of the CLONE_THREAD logic
> never made it into a stable kernel: the shared signal handling. So while
> CLONE_THREAD allows for many pthread-like things (one common process ID
> shared by all threads, for example), the most fundamental part of it was
> not actually merged into the standard kernel because of stability concerns
> in late pre-2.4 test cycle.

Exactly.  This is holding off everything.  The way this is solved
(basically: the limitations imposed on the userland implementation)
will determine much of the implementation.

I've done already a great deal of the implementation when Linus first
put the code in the late 2.3 kernels.  If somebody finally would get
the signal handling stuff done (and a few more little things, some
Linus already agreed on) we could have a compliant pthread
implementation soon.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
