Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318739AbSHWKKq>; Fri, 23 Aug 2002 06:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318743AbSHWKKq>; Fri, 23 Aug 2002 06:10:46 -0400
Received: from h-64-105-137-141.SNVACAID.covad.net ([64.105.137.141]:18326
	"EHLO freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S318739AbSHWKKk>; Fri, 23 Aug 2002 06:10:40 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 23 Aug 2002 03:14:42 -0700
Message-Id: <200208231014.DAA02571@adam.yggdrasil.com>
To: andre@linux-ide.org
Subject: Re: IDE-flash device and hard disk on same controller
Cc: ebiederm@xmission.com, jgarzik@mandrakesoft.com,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
>Section 6.10

>EXECUTE DIAGNOSTICS:  Host Shall assert Reset (SRST) prior to issuing.

>Section 6.2 SoftReset (SRST)

>Device side State Diagram: D0SR3 "Set_Status_State"

>second paragraph

>"All actions required in this state shall be completed within 31 s"

>Page 86  Volume 3 ATA/ATAPI 7 rev 0, 5 November 2001.

>Sorry for the old reference it was the quickest hard copy I could find.


	Okay.  I found it on page 90  Volume 2 ATA/ATAPI 7 rev 0d,
8 July 2002 (http://www.t13.org/docs2002/d1532v2r0d.pdf).  Thanks for
the pointer.  I don't think I would have found it otherwise.

	As far as I can tell from looking at the state diagram, if the
BSY bit is clear, the DOSR3-->idle_S transition has occurred, as that
is the only transition in the entire diagram that clears the BSY bit.
The transition is labelled with BSY=0, and all other states are explicitly
labelled with BSY=1.  Likewise for the device 1 reset state diagram on
page 92 of the same document.

	There should also be no race before the busy bit is set
because "the device shall set BSY to one within 400ns after entering
this state [DOSR0: SRST]" (I think SRST means "software reset start"),
at least if we assume that it takes at least 400 *nanoseconds* to get
this far in the boot process.

	31 seconds seems to be the maximum amount of time that the drive
will take to reach the idle_S state, but it looks OK to poll BSY to see
if it has gotten there sooner.

	It looks to me like the scenario that Eric W. Biederman wanted
(the POST takes less than than 31 seconds and the IDE driver checks
BSY until it clears) is "in spec" with respect to those device 0 and
device 1 software reset state diagrams.

	Do you concur?  Do you see another problem?

	By the way, it might still be useful to have a timeout after
31 seconds, and fail the initialization if BSY is still set at that
point, so that the computer might be able to boot up far enough to
call for help if its a non-critical drive.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
