Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVBPOm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVBPOm2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 09:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVBPOm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 09:42:28 -0500
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.78]:59067 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S262028AbVBPOlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 09:41:55 -0500
Date: Wed, 16 Feb 2005 09:39:19 -0500
From: Vincent C Jones <vcjones@networkingunlimited.com>
Subject: Re: Radeon FB troubles with recent kernels
In-reply-to: <1108521681.13376.77.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Message-id: <20050216143919.GA7672@NetworkingUnlimited.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.6i
References: <3y1SR-5K6-1@gated-at.bofh.it>
 <20050215150713.EE7721DE4A@X31.nui.nul> <1108504921.13376.21.camel@gaston>
 <20050216015323.GA7223@NetworkingUnlimited.com>
 <1108521681.13376.77.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2005 at 01:41:20PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2005-02-15 at 20:53 -0500, Vincent C Jones wrote:
> 
> > 
> > Kernel command line: auto BOOT_IMAGE=Test_9.2 ro root=306 pci=usepirqmask desktop idebus=66 video=radeonfb:1024x768-24@60
> > 
> > Note the "video=radeonfb:1024x768-24@60" which used to be required to
> > get the console into 1024x768 mode but is documented in "modefb.txt"
> > as an invalid combination of mode specifications (and also states
> > that radeonfb does not support mode specification...). So other
> > than the loss of temporary working of backlight controls, I just
> > see undocumented progress :-)
> > 
> > Thanks again, and keep up the great work!
> 
> Heh, good. Well, the mode spec should work in fact, provided that you
> get the syntax right, though I haven't tried. I'll have a look later,
> but if it doesn't work, then it was always broken and it's not a
> regression :) I still want to fix more stuff in this area, but for now,
> I'm concerned mostly about regressions.
> 
> Can you remind me exactly what's up with the backlight control ?
> 
> Ben.

Out of the box (SuSE 9.2) with kernel 2.6.11-rc2, powersaved
successfully suspends to RAM and resumes correctly (can't speak for
earlier versions). With 2.6.11-rc3, suspend to RAM works except that the
backlight on the display does not stay turned off. Once suspended, the
backlight is on even if the lid switch is closed!

Others with X31's (and I assume, other ThinkPads, and probably other
notebooks) have only gotten ACPI to work with earlier kernels by using
the radeontool to turn off the back light. See, for example, 

http://www.summet.com/x31/ which includes the following:

Suspend to memory works well if you configure a few files like this:

    * Create an /etc/acpi/events/sleepbtn file as follows:

		event=button[ /]sleep
		action=/etc/acpi/actions/sleepbtn.sh
		

    * Create an /etc/acpi/actions/sleepbtn.sh file as follows:

 #!/bin/bash

 #Stop the bluetooth service.
 service bluetooth stop

 #sync the disks.
 sync && sync && sync
 #Change the screen to VT1 (text mode)
 /usr/bin/chvt 1
 #turn off the backlight on the laptop
 # (Note: You must have the radeontool installed....)
 /usr/sbin/radeontool light off
 #perform the actual "go-to-sleep" function.
 echo "mem" > /sys/power/state

 #Pause a second or two to let us sleep.
 sleep 2
 #Sleepytime...Everything after this line gets exectued
 #after the user resumes...

 #switch back to the Xterminal (automatically turns on backlight)
 /usr/bin/chvt 7
 #restart services...
 service bluetooth start
     
                       # # #

-- 
Dr. Vincent C. Jones, PE              Expert advice and a helping hand
Computer Network Consultant           for those who want to manage and
Networking Unlimited, Inc.            control their networking destiny
Phone: +1 201 568-7810
14 Dogwood Lane, Tenafly, NJ 07670
VCJones@NetworkingUnlimited.com     http://www.networkingunlimited.com
