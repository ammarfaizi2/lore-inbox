Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131872AbQKZUB6>; Sun, 26 Nov 2000 15:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131463AbQKZUBv>; Sun, 26 Nov 2000 15:01:51 -0500
Received: from sith.mimuw.edu.pl ([193.0.97.1]:17925 "HELO sith.mimuw.edu.pl")
        by vger.kernel.org with SMTP id <S129770AbQKZUBk>;
        Sun, 26 Nov 2000 15:01:40 -0500
Date: Sun, 26 Nov 2000 20:33:07 +0100
From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: Re: setrlimit() and 2.4.0-test11
Message-ID: <20001126203307.A24710@sith.mimuw.edu.pl>
Mail-Followup-To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20001122171731.B13272@pld.ORG.PL>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001122171731.B13272@pld.ORG.PL>; from misiek@pld.ORG.PL on Wed, Nov 22, 2000 at 05:17:31PM +0100
X-Operating-System: Linux 2.4.0-test6 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2000, Arkadiusz Miskiewicz wrote:

> 
> Is probably broken (I didnt't saw any disscusion about this here,
> I missed it?).
> 
> when I try to start first user process I get:
> 4366  fork()                            = -1 EAGAIN (Resource temporarily unavailable)
> but strace show proper value passed to setrlimit() -- 40 max number of processes:
> 4366  setrlimit(0x6 /* RLIMIT_??? */, {rlim_cur=40, rlim_max=40}) = 0
> 
> On test10 everything is ok.

No, you are just lucky.
The problem is that root (uid=0) is not a special case anymore, and you can't
do something like this:

setrlimit(NPROC)
fork()
setuid(user)

setrlimit() and fork() are executed in root context, so sterlimit
apllies to root, not the user you're setuid to :(

Why is this so? root should be able to do fork() regardless of any limits,
and IMHO the following patch is the right thing.

--- linux/kernel/fork.c~	Tue Sep  5 23:48:59 2000
+++ linux/kernel/fork.c	Sun Nov 26 20:22:20 2000
@@ -560,7 +560,8 @@
 	*p = *current;
 
 	retval = -EAGAIN;
-	if (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur)
+	if (p->user->uid &&
+	   (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur))
 		goto bad_fork_free;
 	atomic_inc(&p->user->__count);
 	atomic_inc(&p->user->processes);

Jan
-- 
Jan Rêkorajski            |  ALL SUSPECTS ARE GUILTY. PERIOD!
baggins<at>mimuw.edu.pl   |  OTHERWISE THEY WOULDN'T BE SUSPECTS, WOULD THEY?
BOFH, type MANIAC         |                   -- TROOPS by Kevin Rubio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
