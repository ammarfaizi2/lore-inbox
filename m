Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310168AbSB1WcA>; Thu, 28 Feb 2002 17:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310172AbSB1W3x>; Thu, 28 Feb 2002 17:29:53 -0500
Received: from courage.cs.stevens-tech.edu ([155.246.89.70]:51454 "HELO
	courage.cs.stevens-tech.edu") by vger.kernel.org with SMTP
	id <S310178AbSB1WYN>; Thu, 28 Feb 2002 17:24:13 -0500
Newsgroups: comp.os.linux.development.system
Date: Thu, 28 Feb 2002 17:23:54 -0500 (EST)
From: Marek Zawadzki <mzawadzk@cs.stevens-tech.edu>
To: <kernelnewbies@nl.linux.org>
Subject: simple problem with sleeping/waking up
Message-ID: <Pine.NEB.4.33.0202281617001.3356-100000@courage.cs.stevens-tech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I want to implement the 2 following functions in 2.4.17 kernel:

fun1(struct sock *sk)
{
	GO_TO_SLEEP_SOMEHOW(sk->sleep???);
	while (some_pointer == NULL) {
		/* do nothing */
	}
}

fun2(struct sock *sk)
{
	/* some event occured -- data vailable */
	some_pointer == something;
	WAKE_SLEEPING_PROCESS(sk->sleep)
}

I am doing it in networking stack (not a module) to implement accept(fun1)
function. fun2 is supposed to be my main receiving function, which should
wake accept up after receiving some data.
So far I tried this:
accept(struct sock sk*)
{
	DECLARE_WAITQUEUE(wait, current);
	current->state = TASK_INTERRUPTIBLE;
	while (1) {
		schedule_timeout(timeo); /* process sleeps after that */
		if (some_pointer != NULL) {
			break;
		}
	}
	current->state = TASK_RUNNING;
	remove_wait_queue(sk->sleep, &wait);
}

receive(struct sock sk*)
{
	/* after getting the data */A
	some_pointer = sk;
	wake_up_interruptible(sk->sleep); /* this hangs my machine :-(*/
}

Please help, it'll be so greatly appreciated, since I've spent almost a
week trying to do that...
-marek

