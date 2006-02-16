Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWBPWiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWBPWiP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 17:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWBPWiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 17:38:15 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:55952 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750728AbWBPWiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 17:38:14 -0500
Date: Thu, 16 Feb 2006 23:36:18 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Arjan van de Ven <arjan@infradead.org>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/6] lightweight robust futexes: -V3 - Why in userspace?
Message-ID: <20060216223618.GA8182@elte.hu>
References: <20060216203626.GB21415@elte.hu> <Pine.OSF.4.05.10602162301050.22107-100000@da410>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10602162301050.22107-100000@da410>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> As I understand the protocol the userspace task writes it's pid into 
> the lock atomically when locking it and erases it atomically when it 
> leaves the lock. If it is killed inbetween the pid is still there. Now 
> if another task comes along it reads the pid, sets the wait flag and 
> goes into the kernel. The kernel will now be able to see that the pid 
> is no longer valid and therefore the owner must be dead.

this is racy - we cannot know whether the PID wrapped around.

nor does this method offer any solution for the case where there are 
already waiters pending: they might be hung forever. With our solution 
one of those waiters gets woken up and notice that the lock is dead. 
(and in the unlikely even of that thread dying too while trying to 
recover the data, the kernel will do yet another wakeup, of the next 
waiter.)

	Ingo
