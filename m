Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263630AbRFFREa>; Wed, 6 Jun 2001 13:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263648AbRFFREU>; Wed, 6 Jun 2001 13:04:20 -0400
Received: from i1724.vwr.wanadoo.nl ([194.134.214.195]:21120 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S263630AbRFFREG>; Wed, 6 Jun 2001 13:04:06 -0400
Date: Wed, 6 Jun 2001 19:03:09 +0200
From: Remi Turk <remi@a2zis.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac8 hardlocks when going to standby
Message-ID: <20010606190309.A893@localhost.localdomain>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <200106061310.PAA14058@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106061310.PAA14058@harpo.it.uu.se>; from mikpe@csd.uu.se on Wed, Jun 06, 2001 at 03:10:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 03:10:11PM +0200, Mikael Pettersson wrote:
> > On Tue, Jun 05, 2001 at 10:18:07PM +0100, Alan Cox wrote:
> > > Thanks. UP-APIC is a real candidate for this case.
> 
> Actually, I suspect apm.c is at fault here. Suspend works,
> which proves that the PM code in apic.c and nmi.c works.
> 
> But note how apm.c:send_event() ignores standby events and fails
> to propagate them to PM clients. Thus, Remi's box will have an
> activated local APIC and live NMI watchdog when the APM BIOS
> finally gets to do whatever it does at standby.
> It is fatal to have an active local APIC and NMI watchdog at suspend,
> and I can only assume that this is true for standby as well.
> 
> Please try changing apm.c:send_event() to propagate standbys to PM
> clients just like suspends. Does this fix the problem?

By applying the following patch (lookalike)?

arch/i386/kernel/apm.c:send_event():

	case APM_SYS_SUSPEND:
	case APM_CRITICAL_SUSPEND:
	case APM_USER_SUSPEND:
+	case APM_USER_STANDBY:
+	case APM_SYS_STANDBY:
		/* map all suspends to ACPI D3 */
		if (pm_send_all(PM_SUSPEND, (void
			*)3)) {

> 
> (Any why use standby in the first place? Any reason you don't
> want to / can't use suspend?)

Because IIRC I can only choose between power-off and standby
as functions of my powerbutton ;-)

> 
> /Mikael

-- 
Linux 2.4.5-ac9 #5 Wed Jun 6 18:30:24 CEST 2001
