Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266296AbUA2T2g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 14:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266309AbUA2T2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 14:28:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:35538 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266296AbUA2T1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 14:27:47 -0500
X-Authenticated: #13243522
Message-ID: <40195A95.C675952C@gmx.de>
Date: Thu, 29 Jan 2004 20:10:13 +0100
From: Michael Schierl <schierlm@gmx.de>
X-Mailer: Mozilla 4.75 [de]C-CCK-MCD QXW0324v  (Win95; U)
X-Accept-Language: de,en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Stephen Rothwell <fr@canb.auug.org.au>, linux-laptop@vger.kernel.org,
       linux-kernel@vger.kernel.org, mochel@digitalimplant.org
Subject: Re: [PATCH] [APM] Is this the correct way to fix suspend bug introduced 
 in 2.6.0-test4?
References: <13zy7qdcyz1q7$.50e5l3rpbsyx$.dlg@40tude.net> <20040128174655.GE1200@elf.ucw.cz>
Content-Type: multipart/mixed;
 boundary="------------BE7EB52A260B9EC72C2D134E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dies ist eine mehrteilige Nachricht im MIME-Format.
--------------BE7EB52A260B9EC72C2D134E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Pavel Machek schrieb:
> 
> Hi!
> >
> > the patch below (against 2.6.1-mm5) fixes my APM problems (my laptop, Acer
> > TravelMate 210TEV (Celeron 700, 128 MB RAM), hangs after resuming from APM
> > since 2.6.0-test4).
> >
> > If you have any suggestions, tell me 

> I think you should use device_power_down() and device_power_up(),
> instead. Check it, but it looks to me like that's better way.

Works for me as well (Patch attached).

> > if you think that's okay like that, please submit that to the guy who is
> > responsible for 2.6 (is it Linus or Andrew? did not follow lkml
> > recently).
> 
> Andrew.

Thanks. BTW: I did not get any response from Stephen Rothwell (the guy
who is listed as maintainer for APM in the MAINTAINERS file). How long
should I wait for a response? Or should I simply submit the patch to
Andrew?

Michael
--------------BE7EB52A260B9EC72C2D134E
Content-Type: text/plain; charset=us-ascii;
 name="apm-bug-introduced-in-test4-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="apm-bug-introduced-in-test4-v2.patch"

--- linux-2.6.2-rc2-mm1/arch/i386/kernel/apm.c.old	Thu Jan 29 16:22:03 2004
+++ linux-2.6.2-rc2-mm1/arch/i386/kernel/apm.c	Thu Jan 29 16:22:07 2004
@@ -1201,6 +1201,7 @@ static int suspend(int vetoable)
 	}
 
 	device_suspend(3);
+	device_power_down(3);
 
 	/* serialize with the timer interrupt */
 	write_seqlock_irq(&xtime_lock);
@@ -1234,6 +1235,7 @@ static int suspend(int vetoable)
 	if (err != APM_SUCCESS)
 		apm_error("suspend", err);
 	err = (err == APM_SUCCESS) ? 0 : -EIO;
+	device_power_up();
 	device_resume();
 	pm_send_all(PM_RESUME, (void *)0);
 	queue_event(APM_NORMAL_RESUME, NULL);
@@ -1252,6 +1254,7 @@ static void standby(void)
 {
 	int	err;
 
+	device_power_down(3);
 	/* serialize with the timer interrupt */
 	write_seqlock_irq(&xtime_lock);
 	/* If needed, notify drivers here */
@@ -1261,6 +1264,7 @@ static void standby(void)
 	err = set_system_power_state(APM_STATE_STANDBY);
 	if ((err != APM_SUCCESS) && (err != APM_NO_ERROR))
 		apm_error("standby", err);
+	device_power_up();
 }
 
 static apm_event_t get_event(void)

--------------BE7EB52A260B9EC72C2D134E--


