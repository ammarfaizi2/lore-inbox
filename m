Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268516AbTANC06>; Mon, 13 Jan 2003 21:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268514AbTANC0z>; Mon, 13 Jan 2003 21:26:55 -0500
Received: from dp.samba.org ([66.70.73.150]:36487 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268511AbTANC0y>;
	Mon, 13 Jan 2003 21:26:54 -0500
From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15907.30411.916585.622130@argo.ozlabs.ibm.com>
Date: Tue, 14 Jan 2003 13:32:43 +1100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       benh@kernel.crashing.org
Subject: ide-cs problem (was Re: any chance of 2.6.0-test*?)
In-Reply-To: <1042469960.18624.9.camel@irongate.swansea.linux.org.uk>
References: <20030110165441$1a8a@gated-at.bofh.it>
	<15906.13194.169834.758112@argo.ozlabs.ibm.com>
	<1042469960.18624.9.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:

> The ide release code isnt safe in any context.

Do you mean ide_release in ide-cs.c, or ide_unregister in ide.c?

> The code is currently written on the basis that people don't mangle
> free interfaces (the free up code restores stuff which I grant is

Well, the problem is that there is no way to say that there is a hwif
present without any drives.  The low-level driver (i.e. pmac.c) has to
leave hwif->present = 0, because if you set hwif->present = 1 then the
ide probe code won't go looking for drives.  The probe code then only
sets hwif->present = 1 if it finds a drive.  If hwif->present gets
left at 0 then it is liable to be taken over for a pcmcia card.

What would be good is a way to say "I know this hwif is definitely
present, please probe for devices attached to it, but don't decide
it's not present if you don't find any devices".  I would like pmac.c
to be able to set hwif->present = 1 but still have the probe code go
looking for devices.

Regards,
Paul.
