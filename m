Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWEUANB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWEUANB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 20:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWEUANA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 20:13:00 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:52684 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932234AbWEUAM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 20:12:58 -0400
To: trenn@suse.de
cc: "Yu, Luming" <luming.yu@intel.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>,
       Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de,
       mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, Brian Marete <bgmarete@gmail.com>,
       Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>,
       jgarzik@pobox.com, linux-ide@vger.kernel.org,
       Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>,
       linux-input@atrey.karlin.mff.cuni.cz, Meelis Roos <mroos@linux.ee>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Fri, 19 May 2006 15:44:17 +0200."
             <1148046258.9319.441.camel@queen.suse.de> 
Date: Sun, 21 May 2006 01:12:52 +0100
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FhbYy-0005jL-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This sounds like the problem Daniel had on his Samsung P35 recently.
> He could fix it by getting rid of some asus_unhide_smbus stuff or the
> otherway around, adding asus_unhide_smbus quirks in the S3 resume code.
> 
> This thread was recently posted on lkml:
> Re: [patch] smbus unhiding kills thermal management
> 

That seems likely, thanks for the pointer: Besides the ACPI sleep
hangs, this machine (TP 600X) has fan troubles upon S3 resume.  The
problems don't do harm (the damn fan keeps turning on when it
shouldn't), but that's probably chance.  Various patches that I tested
for S3 resume hangs reversed this fan behavior, making the fan refuse
to turn on when it should have.  The same problem happened after
resume from swsusp (bugzilla #5000).

> https://bugzilla.novell.com/show_bug.cgi?id=173420

>From Comment #30 at the above url: "The Linux ACPI code seems to
actively prevent the fan from running and that worries me."

I saw that as well, and found the following recipe would work around
the problem:

1. Set the trip point to, say, 70 C -- well above the actual
   temperature.

2. Then set the trip to anything reasonable that's under the current
   temperature (27 C always works).  Now the fan turns on, and behaves
   fine from then.

My explanation is that, before step 1, the fan is off but the OS
thinks it's on.  So the dialogue goes something like:

Hardware (from EC or BIOS?): Ack, I'm overheating, turn on the fan now!
OS: There, there, take it easy.  I've checked bit fields in my
     memory, and the fan is on.  So I don't have to do anything.
Hardware: Ack, ...
OS: There, there, ...
[Hence the 100% kacpid CPU usage]

Based on this explanation, I added a resume method to the fan driver.
It would turn on the fan and mark it as on.  So then the internal OS
state matched the actual state.  The fix didn't work for at least one
reason: ACPI drivers didn't have suspend/resume methods (though now
there are test patches to add those methods).

Another fix, probably worth doing anyway, is to turn on the fan if the
BIOS asks for it, whether or not the OS thinks it's on.  The chance of
the two pieces of information getting out of synch, and the hardware
damage it can cause, is enough to make it worthwhile.  The reverse
case can try to optimize (if BIOS asks to shut off the fan, shut it
off only if OS thinks it's on).  That creates no danger: just extra
fan noise if the fan is on but the OS thinks it's off.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
