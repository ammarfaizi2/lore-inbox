Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131211AbQK1Vkx>; Tue, 28 Nov 2000 16:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131212AbQK1Vkf>; Tue, 28 Nov 2000 16:40:35 -0500
Received: from sith.mimuw.edu.pl ([193.0.97.1]:15623 "HELO sith.mimuw.edu.pl")
        by vger.kernel.org with SMTP id <S131211AbQK1Vk0>;
        Tue, 28 Nov 2000 16:40:26 -0500
Date: Tue, 28 Nov 2000 22:11:55 +0100
From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To: Tigran Aivazian <tigran@veritas.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] no RLIMIT_NPROC for root, please
Message-ID: <20001128221155.G2680@sith.mimuw.edu.pl>
Mail-Followup-To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
        Tigran Aivazian <tigran@veritas.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20001128214309.F2680@sith.mimuw.edu.pl> <Pine.LNX.4.21.0011282049470.1940-100000@penguin.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0011282049470.1940-100000@penguin.homenet>; from tigran@veritas.com on Tue, Nov 28, 2000 at 08:52:08PM +0000
X-Operating-System: Linux 2.4.0-test11-pre6 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2000, Tigran Aivazian wrote:

> On Tue, 28 Nov 2000, Jan Rekorajski wrote:
> > --- linux/kernel/fork.c~	Tue Sep  5 23:48:59 2000
> > +++ linux/kernel/fork.c	Sun Nov 26 20:22:20 2000
> > @@ -560,7 +560,8 @@
> >  	*p = *current;
> >  
> >  	retval = -EAGAIN;
> > -	if (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur)
> > +	if (p->user->uid &&
> > +	   (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur))
> 
> Jan,
> 
> Hardcoding things signifying special treatment of uid=0 is almost always a
> bad idea. If you _really_ think that superuser (whatever entity that might
> be) should be exempt from RLIMIT_NPROC and can prove that (SuSv2 seems to
> be silent so you may be right), then you should use capable() to do proper
> capability test and not that horrible explicit uid test as in your patch
> above.

Ok, how about setting limits on login? When this looks like:

--- uid = 0 here
setrlimit(RLIMIT_NPROC, n)
fork()		<- this will fail if root has >n processes
setuid(user)

and it is hard to change this sequence, all PAM enabled apps depend on it :(

The other scenario may be when root has already n processes,
call them system stuff, and cannot login or even kill anything
because of limits.

Is this patch better? I put CAP_SYS_RESOURCE, but maybe it should be
CAP_SYS_ADMIN.

--- linux/kernel/fork.c~	Fri Nov 17 15:09:26 2000
+++ linux/kernel/fork.c	Tue Nov 28 22:02:17 2000
@@ -562,7 +562,8 @@
 	*p = *current;
 
 	retval = -EAGAIN;
-	if (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur)
+	if ((atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur) &&
+	    !capable(CAP_SYS_RESOURCE))
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
