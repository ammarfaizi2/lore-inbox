Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266222AbUGTUu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266222AbUGTUu0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 16:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266227AbUGTUu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 16:50:26 -0400
Received: from thunderdog.allegientsystems.com ([208.251.178.238]:53142 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id S266222AbUGTUuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 16:50:23 -0400
Message-ID: <40FD85A3.2060502@optonline.net>
Date: Tue, 20 Jul 2004 16:50:43 -0400
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: device_suspend() levels [was Re: [patch] ACPI work on aic7xxx]
References: <40FD38A0.3000603@optonline.net> <20040720155928.GC10921@atrey.karlin.mff.cuni.cz> <40FD4CFA.6070603@optonline.net> <20040720174611.GI10921@atrey.karlin.mff.cuni.cz> <40FD6002.4070206@optonline.net> <1090347939.1993.7.camel@gaston> <40FD65C2.7060408@optonline.net> <1090350609.2003.9.camel@gaston> <40FD82B1.8030704@optonline.net> <1090356079.1993.12.camel@gaston>
In-Reply-To: <1090356079.1993.12.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

> Note regarding aix7xxx, we also need proper hooks in the SCSI stack to
> block the queue correctly etc... in the same way we do on IDE. I didn't
> have time to look into this yet.

Here's what we currently do, aic7xxx_core.c - looks like it attempts to 
quiesce, and then refuse to suspend if we happen to be busy. This is a 
little messy because it's done in the suspend call rather than the 
save_state call, therefore resume will still be called if this routine 
returns an error code, which will reinitialize the device when we didn't 
really need to.

int
ahc_suspend(struct ahc_softc *ahc)
{

         ahc_pause_and_flushwork(ahc);

         if (LIST_FIRST(&ahc->pending_scbs) != NULL) {
                 ahc_unpause(ahc);
                 return (EBUSY);
         }

#ifdef AHC_TARGET_MODE
         /*
          * XXX What about ATIOs that have not yet been serviced?
          * Perhaps we should just refuse to be suspended if we
          * are acting in a target role.
          */
         if (ahc->pending_device != NULL) {
                 ahc_unpause(ahc);
                 return (EBUSY);
         }
#endif
         ahc_shutdown(ahc);
         return (0);
}

