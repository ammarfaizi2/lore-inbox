Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUGTVER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUGTVER (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 17:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUGTVER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 17:04:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:44198 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266274AbUGTVEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 17:04:14 -0400
Subject: Re: device_suspend() levels [was Re: [patch] ACPI work on aic7xxx]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Bryant <nbryant@optonline.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <40FD85A3.2060502@optonline.net>
References: <40FD38A0.3000603@optonline.net>
	 <20040720155928.GC10921@atrey.karlin.mff.cuni.cz>
	 <40FD4CFA.6070603@optonline.net>
	 <20040720174611.GI10921@atrey.karlin.mff.cuni.cz>
	 <40FD6002.4070206@optonline.net> <1090347939.1993.7.camel@gaston>
	 <40FD65C2.7060408@optonline.net> <1090350609.2003.9.camel@gaston>
	 <40FD82B1.8030704@optonline.net> <1090356079.1993.12.camel@gaston>
	 <40FD85A3.2060502@optonline.net>
Content-Type: text/plain
Message-Id: <1090357324.1993.15.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Jul 2004 17:02:06 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-20 at 16:50, Nathan Bryant wrote:
> Benjamin Herrenschmidt wrote:
> 
> > Note regarding aix7xxx, we also need proper hooks in the SCSI stack to
> > block the queue correctly etc... in the same way we do on IDE. I didn't
> > have time to look into this yet.
> 
> Here's what we currently do, aic7xxx_core.c - looks like it attempts to 
> quiesce, and then refuse to suspend if we happen to be busy. This is a 
> little messy because it's done in the suspend call rather than the 
> save_state call, therefore resume will still be called if this routine 
> returns an error code, which will reinitialize the device when we didn't 
> really need to.

save_state is a nonsense, didn't we kill it ? queue quiescing must be
done by the upper level, which is a bit nasty with things like md &
multipath... basically, the low level driver must have a way to notify
it's functional parent (as opposed to it's bus parent) that it's going
to sleep, and any path using this low level driver must then be
quiesced, the parent must resume only when all the drivers it relies
on are back up.

> int
> ahc_suspend(struct ahc_softc *ahc)
> {
> 
>          ahc_pause_and_flushwork(ahc);
> 
>          if (LIST_FIRST(&ahc->pending_scbs) != NULL) {
>                  ahc_unpause(ahc);
>                  return (EBUSY);
>          }
> 
> #ifdef AHC_TARGET_MODE
>          /*
>           * XXX What about ATIOs that have not yet been serviced?
>           * Perhaps we should just refuse to be suspended if we
>           * are acting in a target role.
>           */
>          if (ahc->pending_device != NULL) {
>                  ahc_unpause(ahc);
>                  return (EBUSY);
>          }
> #endif
>          ahc_shutdown(ahc);
>          return (0);
> }
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

