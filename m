Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130532AbRCTS2x>; Tue, 20 Mar 2001 13:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130565AbRCTS2n>; Tue, 20 Mar 2001 13:28:43 -0500
Received: from mailb.telia.com ([194.22.194.6]:65290 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S130532AbRCTS20>;
	Tue, 20 Mar 2001 13:28:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roger Larsson <roger.larsson@norran.net>
To: Nigel Gamble <nigel@nrg.org>
Subject: Re: [PATCH for 2.5] preemptible kernel
Date: Tue, 20 Mar 2001 19:25:32 +0100
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.05.10103141653350.3094-100000@cosmic.nrg.org>
In-Reply-To: <Pine.LNX.4.05.10103141653350.3094-100000@cosmic.nrg.org>
MIME-Version: 1.0
Message-Id: <01032019253200.01487@jeloin>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

One little readability thing I found.
The prev->state TASK_ value is mostly used as a plain value
but the new TASK_PREEMPTED is or:ed together with whatever was there.
Later when we switch to check the state it is checked against TASK_PREEMPTED
only. Since TASK_RUNNING is 0 it works OK but...

--- sched.c.nigel       Tue Mar 20 18:52:43 2001
+++ sched.c.roger       Tue Mar 20 19:03:28 2001
@@ -553,7 +553,7 @@
 #endif
                        del_from_runqueue(prev);
 #ifdef CONFIG_PREEMPT
-               case TASK_PREEMPTED:
+               case TASK_RUNNING | TASK_PREEMPTED:
 #endif
                case TASK_RUNNING:
        }


We could add all/(other common) combinations as cases 

	switch (prev->state) {
		case TASK_INTERRUPTIBLE:
			if (signal_pending(prev)) {
				prev->state = TASK_RUNNING;
				break;
			}
		default:
#ifdef CONFIG_PREEMPT
			if (prev->state & TASK_PREEMPTED)
				break;
#endif
			del_from_runqueue(prev);
#ifdef CONFIG_PREEMPT
		case TASK_RUNNING		| TASK_PREEMPTED:
		case TASK_INTERRUPTIBLE	| TASK_PREEMPTED:
		case TASK_UNINTERRUPTIBLE	| TASK_PREEMPTED:
#endif
		case TASK_RUNNING:
	}


Then the break in default case could almost be replaced with a BUG()...
(I have not checked the generated code)

/RogerL
