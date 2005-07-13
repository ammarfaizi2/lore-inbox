Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVGMWte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVGMWte (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 18:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVGMWtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 18:49:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17332 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262285AbVGMSng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:43:36 -0400
Date: Wed, 13 Jul 2005 11:42:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: "Martin J. Bligh" <mbligh@mbligh.org>, Lee Revell <rlrevell@joe-job.com>,
       "Kjetil Svalastog Matheussen <k.s.matheussen@notam02.no>" 
	<k.s.matheussen@notam02.no>,
       Chris Friesen <cfriesen@nortel.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       christoph@lameter.org
Subject: High irq load (Re: [PATCH] i386: Selectable Frequency of the Timer
 Interrupt)
In-Reply-To: <Pine.LNX.4.61.0507131237130.14635@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.58.0507131128100.17536@g5.osdl.org>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
 <20050708214908.GA31225@taniwha.stupidest.org> <20050708145953.0b2d8030.akpm@osdl.org>
 <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe>
 <20050709203920.394e970d.diegocg@gmail.com> <1120934466.6488.77.camel@mindpipe>
  <176640000.1121107087@flay> <1121113532.2383.6.camel@mindpipe> 
 <42D2D912.3090505@nortel.com> <1121128260.2632.12.camel@mindpipe> 
 <165840000.1121141256@[10.10.2.4]> <1121141602.2632.31.camel@mindpipe> 
 <188690000.1121142633@[10.10.2.4]> <1121201925.10580.24.camel@mindpipe>
 <278570000.1121206956@flay> <Pine.LNX.4.61.0507131237130.14635@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Jul 2005, Jan Engelhardt wrote:
> 
> No, some kernel code causes a triple-fault-and-reboot when the HZ is >=
> 10KHz. Maybe the highest possible value is 8192 Hz, not sure.

Can you post the triple-fault message? It really shouldn't triple-fault, 
although it _will_ obviously spend all time just doing timer interrupts, 
so it shouldn't get much (if any) real work done either.

A triple fault implies that there's something strange going on, like the
timer interrupt allowing itself to interrupt itself (ie we migt get a 
timer interrupt that takes so long that another timer interrupt happens 
while the first one is still running).

The irq code should protect against that kind of nested irq's, though, 
which is why I'd like to hear more about this. It might be somebody 
touching the timer chip at an inopportune time without holding the proper 
locks, or something nasty - a real bug that you just don't see normally 
and that a high timer frequency just happens to make obvious.

There should be no conceptual "highest possible HZ", although there are 
certainly obvious practical limits to it (both on the timer hw itself, and 
just the fact that at some point we'll spend all time on the timer 
interrupt and won't get anything done..)

			Linus
