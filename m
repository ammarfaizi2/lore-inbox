Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130983AbRADSVU>; Thu, 4 Jan 2001 13:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131541AbRADSVO>; Thu, 4 Jan 2001 13:21:14 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:11780 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130983AbRADSVB>; Thu, 4 Jan 2001 13:21:01 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: exit.c -prerelease-diff - Jan 4
Date: 4 Jan 2001 10:20:12 -0800
Organization: Transmeta Corporation
Message-ID: <932ess$ffm$1@penguin.transmeta.com>
In-Reply-To: <3A5468F0.AC7388AE@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A5468F0.AC7388AE@xmission.com>,
Frank Jacobberger  <f1j@xmission.com> wrote:
>+          current->state = TASK_ZOMBIE;
>
>Why the update on exit.c to include TASK_ZOMBIE?

There's a subtle race in the exit path, where we need to make sure that
"wait4()" does not pick up the process before it is ready to be picked
up. 

As the flag for "I'm ready to be picked up" is "TASK_ZOMBIE", we need to
make sure that it maintains serialization.  Look at how "exit_code" is
used, for example - as it used to be, we didn't actually have any
guarantees that "exit_code" had even been _written_ yet when wait4()
started using it. 

(That's the bug I _know_ about - there may be others here, because the
exit sequence is damn subtle sometimes.  So the prerelease-diff fixes at
least that one thing, but I'm still trying checking all the other
exit-paths, things like __exit_mm()/mmput()/swap_out() etc)

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
