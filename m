Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268378AbUILAWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268378AbUILAWZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 20:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268381AbUILAWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 20:22:25 -0400
Received: from the-village.bc.nu ([81.2.110.252]:63411 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268378AbUILAWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 20:22:19 -0400
Subject: Re: radeon-pre-2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hamie <hamish@travellingkiwi.com>
Cc: DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <41434DA0.3050408@travellingkiwi.com>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409110137590.26651@skynet>
	 <1094873412.4838.49.camel@admin.tel.thor.asgaard.local>
	 <Pine.LNX.4.58.0409110600120.26651@skynet>
	 <1094913222.21157.61.camel@localhost.localdomain>
	 <9e47339104091109463694ffd3@mail.gmail.com>
	 <1094919681.21157.119.camel@localhost.localdomain>
	 <41434DA0.3050408@travellingkiwi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094944787.21702.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 12 Sep 2004 00:20:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What about if you want to use fb when in text mode (Because you get 
> 200x75 on a 1600x1200 screen) AND run DRI because the rest of the time 
> you want to run fast 3D. Plus you want to be able to CTRL-ALT-F1/F2/F7 
> back & forth between X & fb... (i.e. how I currently use it but with 
> unaccelerated x.org radeon drivers, becaus ethe 3D ones WON'T play nicely).

Thats actually the easy case. We don't care if it takes another 30th of
a second to flip console. The hard one Jon was trying to point out is
a dual head card. Head 0 has someone running bzflag, head 1 has someone
editing an open office document. You have one accelerator set for both
heads. At that point you do care about the switch over, but the drivers
can co-operate for it. So it would always work, but it would work better
with friendly drivers when there is a need to do so.

> Currently this fails to work... Presumably because the fb & DRI code 
> (fglrx here BTW) don't talk to each other & so the display gets garbled 
> if you're lucky... Lockup if you're not.

fglrx stomps blindly on everything including your AGP. Not much we can
do about it.

> although Alan's probably works for DRI & fb on separate heads, how does 
> it guarantee that the chipset is all setup the same way for each process 
> on different heads... (When they have to share some of the hardware). Or 
> is that necessary?

You assume someone else crapped on the hardware. That is how DRI works
for example. You have multiple rendering clients each of which when it
takes the lock finds out if it was the last user (thats one thing Linus
sketch lacked but is easy to add).

My code ends up looking like

	lock
	if(someone_else_used_it)
		restore_my_state()
	blah 
	unlock

