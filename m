Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbTCRBCy>; Mon, 17 Mar 2003 20:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262076AbTCRBCy>; Mon, 17 Mar 2003 20:02:54 -0500
Received: from mail.inw.de ([217.6.75.131]:20444 "EHLO mail.internetwork-ag.de")
	by vger.kernel.org with ESMTP id <S262067AbTCRBCx>;
	Mon, 17 Mar 2003 20:02:53 -0500
Message-ID: <3E7672C2.635C7D58@inw.de>
Date: Mon, 17 Mar 2003 17:13:38 -0800
From: Till Immanuel Patzschke <tip@inw.de>
Organization: interNetwork AG
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-4GB i686)
X-Accept-Language: en
MIME-Version: 1.0
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
CC: Mitchell Blank Jr <mitch@sfgoth.com>,
       linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ATM] first pass at fixing atm spinlock
References: <200303172325.h2HNPpGi015350@locutus.cmf.nrl.navy.mil>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chas,

good job, cleaning the ATM stuff up -- on the note below: I've been having lots of
problems w/ the close and "dangeling" vccs, since in my scenarios traffic was
coming in AFTER the close.  I tried to defer the destruction and it got rid of the
bad crashes.  The ones left are more subtle - getting sporadic messages "device
already in use" since close worked, but open fails, since the VCC list is still
linked... (Are you sure - and sorry for asking) there is no place this structure
sleeps and therefor "jumps" the sequence?
Anyway, how about re-doing the VCC stuff mor in the way you did it for the
HE device driver - having an array, indexed by a pvc hash -- and one could easily
move that code into the drivers since it is unlikely to have a receiving PVC on
one card and the sending part (of the same PVC) on a different one...
There is only one ATM card - as far as I know the PCE/A200-E - which allows
arbitrary PVCs.  All others start at 0.0 counting up, or splitting bits like the
HE...

Besides, I am happy to give your changes a try on our SMP system (2.4.20) once you
have a version for 2.4. ready.  I am using PPPoA trying to utilise as many PVCs as
possible (up to 4096).

BTW: Have you addressed the difficulty that, depending on the ATM board, some
packet receives are handled while still in the IRQ and others (the newer/better)
ones always go through a tasklet?

Another note on the PPPoA driver -- it creates/destroys the tasklet for each PVC
(on open/close) potentially resulting in lots of allocated tasklet structures if
you do heavy logon/logoff w/ PPPoA.  I have a version having a single tasklet for
doing all the work, but since you've changed some of the locks, I'd like to try it
first before I'll submit.

Keep continuing the you great work!
Thanks

Immanuel
chas williams wrote:

> >sock/vcc combo can't go away while a processor's bh still is using a reference
> >to the vcc.  I think this has been the result of many of the reported SMP
> >crashes (it's probably not that hard to trigger; just close an ATM socket
> >that's receiving a flood of traffic)
>
> i dont know.  i believe all of the adapters do a synchronous close.  after
> the close finishes, no more traffic should arrive for a particular vcc.
> the bottom halfs (halves?) should not have references to vcc after a close()
> for it finishes.

