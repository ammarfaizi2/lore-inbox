Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVCWN6C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVCWN6C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 08:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbVCWN6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 08:58:01 -0500
Received: from smtp-out.tiscali.no ([213.142.64.144]:36358 "EHLO
	smtp-out.tiscali.no") by vger.kernel.org with ESMTP id S261599AbVCWNyV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 08:54:21 -0500
Subject: Re: forkbombing Linux distributions
From: Natanael Copa <mlists@tanael.org>
To: aq <aquynh@gmail.com>
Cc: "Hikaru1@verizon.net" <Hikaru1@verizon.net>, linux-kernel@vger.kernel.org
In-Reply-To: <9cde8bff05032305044f55acf3@mail.gmail.com>
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
	 <20050322112628.GA18256@roll>
	 <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>
	 <20050322124812.GB18256@roll> <20050322125025.GA9038@roll>
	 <9cde8bff050323025663637241@mail.gmail.com> <1111581459.27969.36.camel@nc>
	 <9cde8bff05032305044f55acf3@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 14:54:18 +0100
Message-Id: <1111586058.27969.72.camel@nc>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 22:04 +0900, aq wrote:
> On Wed, 23 Mar 2005 13:37:38 +0100, Natanael Copa <mlists@tanael.org> wrote:
> > > > This is an example of a program in C my friends gave me that forkbombs.
> > > > My previous sysctl.conf hack can't stop this, but the /etc/limits solution
> > > > enables the owner of the computer to do something about it as root.
> > > >
> > > > int main() { while(1) { fork(); } }
> > 
> > I guess that "fork twice and exit" is worse than this?
> 
> you meant code like this 
> 
> int main() { while(1) { fork(); fork(); exit(); } }
> 
>  is more harmful ? I dont see why (?)

Because the parent disappears. When things like killall tries to kill
the process its already gone but there are 2 new with new pids.

> > > I find that this forkbomb doesnt always kill the machine. Trying a
> > > small forkbomb, I saw that either the forkbomb process, or the parent
> > > process (of forkbomb) will be killed after a while (by the kernel)
> > > because of "out of memory" error. The problem is that which process
> > > would be chosen to kill? (I have no idea on how kernel choose the
> > > would-be-kill process).
> > 
> > It kills the process that reaches the limit (max proc's / out of mem)?
> 
> If so, forkbomb doesnt cause much problem like they said, since
> eventually it would be killed once it reach the limit of memory. the
> system will recover automatically after awhile.

well, the problem here has that stupid fork bombs like:

:() { :|:& };:

brings down almost all linux distro's while other *nixes survives.

So in theory, you are right, but in real world the system dies. (when I
tried here the system was completely dead for at least 30mins wihtout
any possiblity to even move the mouse) It would probably recover after
hours or days, but who waits so long if the production server does not
respond?

> > Limit the default maximum of user processes. If someone needs more, let
> > the sysadmin raise it (with ulimit -u, /etc/limits, sysctl.conf
> > whatever)
> > 
> > This should do the trick:
> > 
> > --- kernel/fork.c.orig  2005-03-02 08:37:48.000000000 +0100
> > +++ kernel/fork.c       2005-03-21 15:22:50.000000000 +0100
> > @@ -119,7 +119,7 @@
> >          * value: the thread structures can take up at most half
> >          * of memory.
> >          */
> > -       max_threads = mempages / (8 * THREAD_SIZE / PAGE_SIZE);
> > +       max_threads = mempages / (16 * THREAD_SIZE / PAGE_SIZE);
> 
> I dont see any advantages of halving the max_threads like this at all.

If you take a look at the lines below this patch you will find:

        max_threads = mempages / (16 * THREAD_SIZE / PAGE_SIZE);

        /*
         * we need to allow at least 20 threads to boot a system
         */
        if(max_threads < 20)
                max_threads = 20;

        init_task.signal->rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
        init_task.signal->rlim[RLIMIT_NPROC].rlim_max = max_threads/2;

Default RLIMIT_NPROC (ulimit -u) is calculated from max_threads so
maximum allowed proc's is halved too.

> That doesnt solve the problem. 

It actually does. Try yourself.

This was actually the default in 2.4.7-acl
http://marc.theaimsgroup.com/?l=linux-kernel&m=99617386529767&w=2

I don't know why it was doubled again afterwards.

IMHO its better to set a lower default and let the sysadmin raise the
limit if needed instead of the opposite.

> You should focus elsewhere.

Any suggestions what I should focus on if not on default maximum user
processes?

BTW... its not first time this is discussed:
http://marc.theaimsgroup.com/?t=105769009100003&r=1&w=2

However, the limits should apply to the daemons started from boot
scripts too, not only the logged in users. That is why I'd like to see
the default max_threads limit halved.

--
Natanael Copa


