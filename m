Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262769AbTCKBQP>; Mon, 10 Mar 2003 20:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262773AbTCKBQO>; Mon, 10 Mar 2003 20:16:14 -0500
Received: from fmr01.intel.com ([192.55.52.18]:40652 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S262769AbTCKBQL> convert rfc822-to-8bit;
	Mon, 10 Mar 2003 20:16:11 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C780AFB088B@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [patch] "HT scheduler", sched-2.5.63-B3
Date: Mon, 10 Mar 2003 11:53:29 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 7 Mar 2003, Perez-Gonzalez, Inaky wrote:
> 
> > Question: does this apply also to tasks that are current on another CPU
> > other than the local?
> >
> > Or, can I change the prio of a task that is current on another CPU
> > directly and then set_tsk_need_resched()? Or I also have to unqueue it
> > first?
> 
> any task must be unqueued before changing its priority - the runqueues are
> indexed by the priority field. The special case in wakeup is that 'p' is
> not on any runqueues (hence the wakeup ...), so we have a cheap
> opportunity there to fix up priority. But it's not a problem for an
> already running process either - it needs to be requeued.

Thanks, I was suspecting that [when something makes full sense, it is
easy to suspect it :)].

How friendly would you be to a hook into setscheduler()? I have this 
same problem with real-time futexes, specially wrt to effective priority 
in priority-inheritance & prio-protection. Basically, I need to know 
right away when a waiting tasks' priority has been changed so I can
properly reposition it into the waiting list.

As well, whenever I change the priority of an active/running task, it needs
to activate the hooks (for my proof-of-concept I did that manually; however,
it is limited and non-extensible), and I am looking into unfolding
setscheduler() into setscheduler() and do_setscheduler(), the later taking
the task struct, policy and priority to set, so that it can be called
from inside the kernel. setscheduler() would only do the user-space 
stuff handling.

Would that be ok with you?

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)


