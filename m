Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVHEWPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVHEWPW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 18:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbVHEWNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 18:13:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10112 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263161AbVHEWKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 18:10:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: george@mvista.com
X-Fcc: ~/Mail/linus
Cc: Gerd Knorr <kraxel@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Re: 2.6.12: itimer_real timers don't survive execve()
 any more
In-Reply-To: George Anzinger's message of  Friday, 5 August 2005 08:33:24 -0700 <42F386C4.2080103@mvista.com>
X-Antipastobozoticataclysm: Bariumenemanilow
Message-Id: <20050805221041.D574B180988@magilla.sf.frob.com>
Date: Fri,  5 Aug 2005 15:10:41 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There are other concerns.  Let me see if I understand this.  A thread 
> (other than the leader) can exec and we then need to change the 
> real_timer to wake the new task which will NOT be using the same task 
> struct.

That's correct.  de_thread will turn the thread calling exec into the new
leader and kill off all the other threads, including the old leader.  The
exec'ing thread's existing task_struct is reassigned to the PID of the
original leader.

> My looking at the code shows that the thread leader can exit and then 
> stays around as a zombi until the last thread in the group exits.  

That is correct.

> If an alarm comes during this wait I suspect it will wake this zombi and
> cause problems.

You are mistaken.  The signal code handles process signals sent when the
leader is a zombie.  The group leader sticks around with the PID that
matches the TGID, until there are no live threads with its TGID.  That is
how process-wide kill can still work.


Thanks,
Roland
