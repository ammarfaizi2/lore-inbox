Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVBMARI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVBMARI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 19:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVBMARI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 19:17:08 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:25286 "EHLO
	ti41.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S261223AbVBMARA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 19:17:00 -0500
Date: Sat, 12 Feb 2005 19:16:59 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lee Revell <rlrevell@joe-job.com>,
       Andries Brouwer <aebr@win.tue.nl>, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i8042 access timings
Message-ID: <20050213001659.GA7349@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Lee Revell <rlrevell@joe-job.com>, Andries Brouwer <aebr@win.tue.nl>,
	dtor_core@ameritech.net, linux-input@atrey.karlin.mff.cuni.cz,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200501250241.14695.dtor_core@ameritech.net> <20050125105139.GA3494@pclin040.win.tue.nl> <d120d5000501251117120a738a@mail.gmail.com> <20050125194647.GB3494@pclin040.win.tue.nl> <1106685456.10845.40.camel@krustophenia.net> <1106838875.14782.20.camel@localhost.localdomain> <20050127163431.GA31212@ti64.telemetry-investments.com> <20050127163714.GA15327@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127163714.GA15327@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 05:37:14PM +0100, Vojtech Pavlik wrote:
> On Thu, Jan 27, 2005 at 11:34:31AM -0500, Bill Rugolsky Jr. wrote:
> > I have a Digital HiNote collecting dust which had this keyboard problem
> > with the RH 6.x 2.2.x boot disk kernels, IIRC.  I can test if you like,
> > but I won't be able to get to it until the weekend.
>  
> That'd be very nice indeed.
 
Sorry for the long delay in replying; the HiNote needed some effort to get
the thing up and running again.  [Various bits of hardware are broken;
the power switch, floppy, and CD-ROM are busted/flakey.]  I've now got
Fedora Core 3 running on it. I was pleasantly surprised that the 2.6.9
i83265 PCMCIA module loads, and the internal Xircom CEM56 network/modem works.
[Broken with 2.6.10+ though; the fix is probably trivial.]

I wasn't sure exactly what to test.  I applied the following patch
to 2.6.11-rc3-bk9, and booted with i8042_debug=1.  So far, it works
as expected, and there is nothing of interest in the kernel log.
[Also worked with the FC3 2.6.9 kernel and this patch+DEBUG.]

Now that things are up and running, I will apply any patches that you
would like tested.

	Bill Rugolsky

--- linux/drivers/input/serio/i8042.c.udelay-backout	2005-02-12 16:22:48.647851998 -0500
+++ linux/drivers/input/serio/i8042.c	2005-02-12 16:23:39.963997609 -0500
@@ -131,9 +131,10 @@
 {
 	int i = 0;
 	while ((~i8042_read_status() & I8042_STR_OBF) && (i < I8042_CTL_TIMEOUT)) {
-		udelay(50);
+		udelay(I8042_STR_DELAY);
 		i++;
 	}
+	if (i > 0) dbg("i8042_wait_read: looped %d times",i);
 	return -(i == I8042_CTL_TIMEOUT);
 }
 
@@ -141,9 +142,10 @@
 {
 	int i = 0;
 	while ((i8042_read_status() & I8042_STR_IBF) && (i < I8042_CTL_TIMEOUT)) {
-		udelay(50);
+		udelay(I8042_STR_DELAY);
 		i++;
 	}
+	if (i > 0) dbg("i8042_wait_write: looped %d times",i);
 	return -(i == I8042_CTL_TIMEOUT);
 }
 
@@ -161,7 +163,6 @@
 	spin_lock_irqsave(&i8042_lock, flags);
 
 	while ((i8042_read_status() & I8042_STR_OBF) && (i++ < I8042_BUFFER_SIZE)) {
-		udelay(50);
 		data = i8042_read_data();
 		dbg("%02x <- i8042 (flush, %s)", data,
 			i8042_read_status() & I8042_STR_AUXDATA ? "aux" : "kbd");
--- linux/drivers/input/serio/i8042.h.udelay-backout	2005-02-12 16:22:48.647851998 -0500
+++ linux/drivers/input/serio/i8042.h	2005-02-12 16:23:39.964997456 -0500
@@ -30,12 +30,18 @@
 #endif
 
 /*
- * This is in 50us units, the time we wait for the i8042 to react. This
+ * The time (in us) that we wait for the i8042 to react.
+ */
+
+#define I8042_STR_DELAY                20
+
+/*
+ * This is in units of the time we wait for the i8042 to react. This
  * has to be long enough for the i8042 itself to timeout on sending a byte
  * to a non-existent mouse.
  */
 
-#define I8042_CTL_TIMEOUT	10000
+#define I8042_CTL_TIMEOUT	25000
 
 /*
  * When the device isn't opened and it's interrupts aren't used, we poll it at
