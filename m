Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129462AbRBPO0p>; Fri, 16 Feb 2001 09:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130088AbRBPO0f>; Fri, 16 Feb 2001 09:26:35 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:18763 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129462AbRBPO0S>; Fri, 16 Feb 2001 09:26:18 -0500
Date: Fri, 16 Feb 2001 15:26:26 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Roman Zippel <zippel@fh-brandenburg.de>
Cc: Andi Kleen <ak@suse.de>, Timur Tabi <ttabi@interactivesi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
Message-ID: <20010216152626.J14430@inspiron.random>
In-Reply-To: <20010129182633.A2522@gruyere.muc.suse.de> <Pine.GSO.4.10.10101292036070.17869-100000@zeus.fh-brandenburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10101292036070.17869-100000@zeus.fh-brandenburg.de>; from zippel@fh-brandenburg.de on Mon, Jan 29, 2001 at 08:47:50PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2001 at 08:47:50PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Mon, 29 Jan 2001, Andi Kleen wrote:
> 
> > You can miss wakeups. The standard pattern is:
> > 
> > 	get locks
> > 
> > 	add_wait_queue(&waitqueue, &wait);
> > 	for (;;) { 
> > 		if (condition you're waiting for is true) 
> > 			break; 
> > 		unlock any non sleeping locks you need for condition
> > 		__set_task_state(current, TASK_UNINTERRUPTIBLE); 
> > 		schedule(); 
> > 		__set_task_state(current, TASK_RUNNING); 
> > 		reaquire locks
> > 	}
> > 	remove_wait_queue(&waitqueue, &wait); 
> 
> You still miss wakeups. :)
> Always set the task state first, then check the condition. See the
> wait_event*() macros you mentioned for the right order.

If the wakeup happens with the spinlock acquired (as the above code seems to
assume) you don't need to set the task state as uninterruptible before checking
the condition, however the above is wrong anyways because it should do
__set_task_state _before_ releasing the lock and not after.

Andrea
