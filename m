Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265903AbTFSTIZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 15:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265909AbTFSTIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 15:08:25 -0400
Received: from fmr06.intel.com ([134.134.136.7]:39892 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265903AbTFSTIT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 15:08:19 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780E0408B5@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Robert Love'" <rml@tech9.net>
Cc: "'Ingo Molnar'" <mingo@elte.hu>, "'Andrew Morton'" <akpm@digeo.com>,
       "'george anzinger'" <george@mvista.com>,
       "'joe.korty@ccur.com'" <joe.korty@ccur.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "Li, Adam" <adam.li@intel.com>
Subject: RE: O(1) scheduler seems to lock up on sched_FIFO and sched_RR ta
	sks
Date: Thu, 19 Jun 2003 12:22:13 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Robert Love [mailto:rml@tech9.net]
> 
> And we can prevent starvation just by running the kernel thread at
> FIFO/99, because then it will never be starved by a higher priority
> task. If the RT task being starved is also at priority 99, it will
> eventually block (as in our example, on console I/O) and let the kernel
> thread run. If the RT task being starved is lower priority, then there
> is nothing to worry about.

/me is quite uneasy with that assumption; not that it is not
correct (it should), but I can think of cases where that does 
not need to happen (for example, if you have another FIFO/99 
task B after your user task A that depends on kernel task K0),
and that task B happens to hold it for too long for A to miss
deadlines.

> I guess a real deadlock could only occur if the FIFO/99 task does not
> block on the resource the kernel thread is providing but busy loops
> waiting for it.

I can think of a OpenOffice + sched_yield() style or a brain-damaged 
poll for previous art. It would screw the whole equation.

Another example, I changed NGPT to do spin+futex for spinlocks, 
but then it was changed back by someone to spinning again -- 
performance reasons [they said] - of course, Thou Shall Not 
Use NGPT + Real-Time (tm). But how many of these are left? I am
so scared of JVMs...

This is even more prone to happen when you have priority
inheritance ... been there, done that, SysRq+E was my friend. 

It gets uncomfortably close to the "not my problem if you don't 
know to set up your system" area, but I would really prefer that
safeguard that then I can disable manually (by prioritizing down)
if I know where to push.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
