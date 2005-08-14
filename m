Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbVHNLBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbVHNLBE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 07:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVHNLBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 07:01:03 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40968 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932486AbVHNLBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 07:01:02 -0400
Date: Sun, 14 Aug 2005 13:00:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>
Cc: gregkh@suse.de, NAGANO Daisuke <breeze.nagano@nifty.ne.jp>,
       alan@lxorguk.ukuu.org.uk, sailer@ife.ee.ethz.ch,
       linux-kernel@vger.kernel.org, perex@suse.cz,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zaitcev@yahoo.com,
       Christoph Eckert <ce@christeck.de>,
       linux-usb-devel@lists.sourceforge.net
Subject: [2.6 patch] schedule OSS USB drivers for removal
Message-ID: <20050814110058.GD8393@stusta.de>
References: <20050729153226.GE3563@stusta.de> <1123607633.5601.7.camel@mindpipe> <20050809174906.GA4006@stusta.de> <1123876729.12680.45.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123876729.12680.45.camel@mindpipe>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 03:58:48PM -0400, Lee Revell wrote:
> On Tue, 2005-08-09 at 19:49 +0200, Adrian Bunk wrote:
> > On Tue, Aug 09, 2005 at 01:13:51PM -0400, Lee Revell wrote:
> > > On Fri, 2005-07-29 at 17:32 +0200, Adrian Bunk wrote:
> > > > This patch schedules obsolete OSS drivers (with ALSA drivers that 
> > > > support the same hardware) for removal.
> > > > 
> > > > Scheduling the via82cxxx driver for removal was ACK'ed by Jeff Garzik.
> > > > 
> > > 
> > > Someone on linux-audio-user just pointed out that the OSS USB audio and
> > > midi modules were never deprecated, much less scheduled to be removed.
> > > 
> > > Maybe the best way to deprecate them is to move them to Sound -> OSS,
> > > that's where they belong anyway.
> > 
> > I'd deprecate them without moving them.
> > 
> 
> Here's the patch.  The bug was that CONFIG_USB_AUDIO and CONFIG_USB_MIDI
> need to depend on CONFIG_SOUND_PRIME.
>...

This doesn't deprecate them (I've deprecated only some of the options 
below CONFIG_SOUND_PRIME).

What about the patch below?

A second "deprecated OSS" option doesn't do much harm and seems to be 
the easiest solution.

cu
Adrian


<--  snip  -->


Deprecate the OSS USB drivers.

This patch includes spelling fixes by Lee Revell.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/feature-removal-schedule.txt |    2 +-
 drivers/usb/class/Kconfig                  |   21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 4 deletions(-)

--- linux-2.6.13-rc5-mm1-full/Documentation/feature-removal-schedule.txt.old	2005-08-14 12:53:46.000000000 +0200
+++ linux-2.6.13-rc5-mm1-full/Documentation/feature-removal-schedule.txt	2005-08-14 12:54:01.000000000 +0200
@@ -42,7 +42,7 @@
 
 ---------------------------
 
-What:	drivers depending on OBSOLETE_OSS_DRIVER
+What:	drivers depending on OBSOLETE_OSS_DRIVER or OBSOLETE_OSS_USB_DRIVER
 When:	October 2005
 Why:	OSS drivers with ALSA replacements
 Who:	Adrian Bunk <bunk@stusta.de>
--- linux-2.6.13-rc5-mm1-full/drivers/usb/class/Kconfig.old	2005-08-14 12:47:29.000000000 +0200
+++ linux-2.6.13-rc5-mm1-full/drivers/usb/class/Kconfig	2005-08-14 12:54:52.000000000 +0200
@@ -4,9 +4,22 @@
 comment "USB Device Class drivers"
 	depends on USB
 
+config OBSOLETE_OSS_USB_DRIVER
+	bool "Obsolete OSS USB drivers"
+	depends on USB && SOUND
+	help
+	  This option enables support for the obsolete USB Audio and Midi
+	  drivers that are scheduled for removal in the near future since
+	  there are ALSA drivers for the same hardware.
+
+	  Please contact Adrian Bunk <bunk@stusta.de> if you had to
+	  say Y here because of missing support in the ALSA drivers.
+
+	  If unsure, say N.
+
 config USB_AUDIO
 	tristate "USB Audio support"
-	depends on USB && SOUND
+	depends on USB && SOUND && OBSOLETE_OSS_USB_DRIVER
 	help
 	  Say Y here if you want to connect USB audio equipment such as
 	  speakers to your computer's USB port. You only need this if you use
@@ -40,10 +53,12 @@
 
 config USB_MIDI
 	tristate "USB MIDI support"
-	depends on USB && SOUND
+	depends on USB && SOUND && OBSOLETE_OSS_USB_DRIVER
 	---help---
 	  Say Y here if you want to connect a USB MIDI device to your
-	  computer's USB port. This driver is for devices that comply with
+	  computer's USB port.  You only need this if you use the OSS
+	  sound system; USB MIDI devices are supported by ALSA's USB
+	  audio driver. This driver is for devices that comply with
 	  'Universal Serial Bus Device Class Definition for MIDI Device'.
 
 	  The following devices are known to work:

