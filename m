Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131368AbRCWTel>; Fri, 23 Mar 2001 14:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131369AbRCWTeb>; Fri, 23 Mar 2001 14:34:31 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:43062 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S131368AbRCWTeW>; Fri, 23 Mar 2001 14:34:22 -0500
Message-Id: <4.3.2.7.2.20010323113258.00b57b30@mail.fluent-access.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 23 Mar 2001 11:33:29 -0800
To: linux-kernel@vger.kernel.org
From: Stephen Satchell <satch@fluent-access.com>
Subject: RE: [PATCH] Prevent OOM from killing init
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:28 AM 3/23/01 +0100, you wrote:
>Ehrm, I would like to re-state that it still would be nice if
>some mechanism got introduced which enables one to set certain
>processes to "cannot be killed".
>For example: I would hate it it the UPS monitoring daemon got
>killed for obvious reasons :o)

Hey, my new flame-proof suit arrived today, so let me give it a try-out...

1)  If you have a daemon that absolutely positively has to be there, why 
not put the damn thing in "inittab" with the RESPAWN attribute?  OOM kills 
it, init notices it, init respawns it, you have your UPS monitoring daemon 
back.

2)  Why is task #1 (init) considered at all by the OOM task-killer 
code?  Sounds like a possible off-by-one bug to me.

3)  If random task-killing is such a problem, one solution is to add yet 
another word to the process table entry, something on the order of 
"oom_importance".  Off the top of my head, this 16-bit value would be 
0x4000 for "normal" processes, and would be the value at start-up.  A value 
of 0xFFFF would be the "never-kill" value, while the value of 0x0000 would 
be the equivalent of the guy who ALWAYS gives up his airplane seat.  The 
process could set this value between 0x0000 and 0xBFFF for processes 
running without root privs, the full range for root processes.  The big 
advantage here is that a daemon or major system can set the value to zero 
during start-up (to ensure being killed if there aren't enough system 
resources) and then boost the immunity once it is going strong.  I can see 
this being of particular value in windows desktops where an attempt to 
start a widget causes an out-of memory condition and THAT WIDGET is the one 
that then dies.  That would be the expected behavior.

 From a debug perspective, it means that the programmer can avoid killing 
something on his development system "by accident" by attracting all the 
task-killing lightning during initial debug.  This would be a sure-fire 
improvement over accidentally killing your debugger, for example.

I call it "nice for memory".

Satch

