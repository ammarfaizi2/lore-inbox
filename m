Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318812AbSICQvk>; Tue, 3 Sep 2002 12:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318814AbSICQvk>; Tue, 3 Sep 2002 12:51:40 -0400
Received: from mx1.elte.hu ([157.181.1.137]:61345 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318812AbSICQvj>;
	Tue, 3 Sep 2002 12:51:39 -0400
Date: Tue, 3 Sep 2002 19:00:12 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: John Alvord <jalvo@mbay.net>
Cc: Tobias Ringstrom <tori@ringstrom.mine.nu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with the O(1) scheduler in 2.4.19
In-Reply-To: <mmp9nukto4k7halscs3tq8gc8tqtdlf8l0@4ax.com>
Message-ID: <Pine.LNX.4.44.0209031852180.30462-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Sep 2002, John Alvord wrote:

> It seems to me that this condition could arise for any server process
> which is used by many interactive processes. Imagine 300 users and a
> server process which needs 70% to do the work. This could be a database
> server as well as the current game server.

well, if there is enough CPU power around then there is no problem -
everyone gets enough CPU time.

if CPU power becomes scarce then the kernel will do like it does for every
other resource: it starts to partition the resource, and no-one will get
the absolute maximum it has asked for.

the 2.5 scheduler adds another thing to the mix: if a task behaves in an
'interactive' way then it will get more CPU time than what it got in 2.4 -
if it behaves like a 'CPU hog' then it will get less CPU time than what it
used to get in 2.4.

the penalty is at most +-5 priority levels, so you can always offset (much
of) this effect by moving the task 10 priority levels lower. (Hence the
magic '-10' priority level i keep suggesting, and hence the magic -5
priority levels i'd like to allow ordinary tasks to lower their priority.)

[the scheduler also has other code to ensure fairness in highly loaded
situations, it makes sure that no task waits CPU-less for more than 3
seconds due to the interactiveness bonuses. This effect does not play in
this current situation, it needs a couple of tens of currently running
agressive tasks to trigger on most normal boxes.]

those tasks that need a disproportionate amount of CPU time need to be
reniced, so that the penalty for being an 'unfair' CPU user is offset.  
There is no way the scheduler could figure out how important a task is -
some people have a game server have higher priority, other people would
give httpd (or remote shells) a higher priority. Since this information is
only available in the administrator's head, it needs help from the
administrator to handle the situation. The kernel has a good default, but
it cannot work in every case, this is why we have the ability to renice
tasks.

	Ingo

