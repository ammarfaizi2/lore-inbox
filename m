Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262840AbULRGBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbULRGBY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 01:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbULRGBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 01:01:24 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:30088
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262840AbULRGBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 01:01:21 -0500
Subject: Re: Linux 2.6.9-ac16
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Chris Ross <chris@tebibyte.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <41C2FF09.5020005@tebibyte.org>
References: <1103222616.21920.12.camel@localhost.localdomain>
	 <41C2DA43.9070900@tebibyte.org> <41C2F273.6010707@nortelnetworks.com>
	 <41C2FF09.5020005@tebibyte.org>
Content-Type: text/plain
Date: Sat, 18 Dec 2004 07:01:15 +0100
Message-Id: <1103349675.27708.39.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-17 at 16:45 +0100, Chris Ross wrote:
> Hi Chris,
> 
> Chris Friesen escreveu:
> > As it stands, 2.6.10-rc2-mm4 still shows nasty behaviour in OOM
> > conditions, killing off more tasks than strictly required, and
> > locking up the system for 10-15secs while doing it.
> > 
> > I'd be much happier doing a quick and dirty scan and knocking off 
> > something *now* rather than locking up the system.  Surely it can't
> > take 60 billion cycles of cpu time to pick a task to kill.
> 
> Thomas Gleixner has been particularly interested the algorithms for 
> deciding which task to kill (like me he got fed up with it picking the 
> ssh daemon first).
> 
> See for example the thread at 
> http://marc.theaimsgroup.com/?t=110189482200001&r=1&w=2
> 
> Some of the delay is by design: when OOM is reached we kill something 
> off, wait a bit for the memory to be freed and become available to the 
> system again, check whether now have enough memory, if not rinse and 
> repeat. However, as I recall this is compounded by 2.6.9 having some 
> nasty rentrancy problems causing the OOM killer to be called something 
> like 100 times instead of once.
> 
> Perhaps Thomas could enlighten us as to the current state of play here?

Andrea fixed the invocation problem, which also handles the reentrancy
problem in a clean way. It get's us rid of the ugly count, time,
whatever mechanisms in out_of_memory which was designed to cover the
invocation problem but was not able to prevent reentrancy and the
resulting overkill (kill a random amount of processes even if enough
memory is available). 

I added the "Take child processes into account" modification for the
whom to kill selection on top of that and I was not able to make it
missbehave with my different test scenarios.

The patches are available in parts in this thread and the final combined
patch is there:
http://marc.theaimsgroup.com/?l=linux-kernel&m=110269783227867&w=2

2.6.10-rc3 contains a partial fix for the erroneous invocation problem,
but it is not as effective as Andrea's solution and it still runs into
overkill once the oom mechanism is invoked.

Andrea's fix and the selection changes should go into 2.6.10, but I
suspect that the VM gurus havent still reached a point, where they
agree. I also have the feeling that the problem is partially ignored.
Obviously has everybody plenty of memory in his boxes. </rant off>

Andrea's fix revealed some GFP_ flag related problems, which should be
addressed seperately. Detailed explanation is in the mail thread.

tglx


