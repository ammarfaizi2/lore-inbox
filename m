Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbVEME1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVEME1v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 00:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVEME1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 00:27:51 -0400
Received: from Boole.cs.uh.edu ([129.7.240.11]:36300 "EHLO boole.cs.uh.edu")
	by vger.kernel.org with ESMTP id S262232AbVEME1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 00:27:46 -0400
Message-ID: <3445.24.160.120.233.1115958466.squirrel@24.160.120.233>
Date: Thu, 12 May 2005 23:27:46 -0500 (CDT)
Subject: Unexpected behaviour of O(1) scheduler on SMP 2.6 Kernel
From: "Deepti Vyas" <dvyas@cs.uh.edu>
To: linux-kernel@vger.kernel.org
Reply-To: dvyas@cs.uh.edu
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running some experiments with the new O(1) scheduler. I am running my
experiments on a cluster of 10 machines, running Rocks4.0 Beta (which
comes with 2.6 kernel and hence the new scheduler)

The behaviour of scheduler is unexplained, and am getting some very
unexpected results. I read about the design of O(1) scheduler, and my
results completely DISAGREE with the theory. Any insight into explaining
this will be helpful.

--------------------------CASE 1-------------------------------------------

On a dual processor CPU, I have 2 processes running P1 and P2.

Here is snapshot of CPU utilization:

	User	Sys	Nice
CPU1	40	30	0	P1
CPU2	40	30	0	P2

Now I add a niced process with nice value =19. So I expect it to utilize
the left over 30% CPU on either one of the CPUs. But instead the new
snapshot of the system is


	User	Sys	Nice
CPU1	0	0	100	niced_process
CPU2	50	40	0	P1 & P2

So overall the nice process finishes in time. And normal process gets
slowed down by 30-40 %.

**NOTE: P1 and P2 and MPI jobs, so they wait on gettting data from other
nodes and consume only 70% CPU max.
nice process is cpu hog and consume 100% CPU
---------------------------------------------------------------------



--------------------------CASE 2-------------------------------------------

On a dual processor CPU, I have 2 processes running P1 and P2. But this
time P1 and P2 are CPU hogs themselves

Here is snapshot of CPU utilization:

	User	Sys	Nice
CPU1	100	0	0	P1
CPU2	100	0	0	P2

Now I add a niced process with nice value =19.

	User	Sys	Nice
CPU1	100	0	0	P1
CPU2	95	0	5	P2 & niced_process

This is GREAT! As expected.


But the CATCH is, if the niced_process is started first, and then P1 and
P2 are initiated, the behaviour is completely unexpected.

	User	Sys	Nice
CPU1	0	0	100	niced_process
CPU2	0	0	0	-

Now I add P1 and P2

	User	Sys	Nice
CPU1	0	0	100	niced_process
CPU2	100	0	0	P1 & P2


I expected the nice process to give up CPU to either P1 and P2.

NOTE: Here P1 , P2 and Niced_process are CPU hogs, and run at 100% cpu
utilization

---------------------------------------------------------------------


Any comments will be appreciated.


PLEASE EMAIL ME AT : dvyas@cs.uh.edu

Thanks
Deepti

