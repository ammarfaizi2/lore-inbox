Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265678AbUAMVUk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 16:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265682AbUAMVUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 16:20:39 -0500
Received: from morbo.tjw.org ([208.47.40.253]:31360 "EHLO morbo.tjw.org")
	by vger.kernel.org with ESMTP id S265678AbUAMVUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 16:20:20 -0500
Date: Tue, 13 Jan 2004 15:20:18 -0600
From: "Tony J. White" <tjw@webteam.net>
To: linux-kernel@vger.kernel.org
Subject: DAC960 w/SAF-TE enclosure problems
Message-ID: <20040113212018.GA749@morbo.tjw.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I recently picked up a Mylex AcceleRAID 170 RAID controller and a 
SuperMicro CSE-M35S SCSI Accessed Fault-Tolerant Enclosure (SAF-TE) and have 
found a problem with my setup in testing.   When I simulate a disk failure
by pulling out one of the drives following things happen: 

1. Alarm sounds.
2. /proc/rd/status becomes ALERT
3. /proc/rd/c0/current_status displays "Disk Status: Dead, 17747968 blocks"
   for the physical device and "No Rebuild or Consistency Check in Progress"
4. The following is logged:
   Physical Device 0:0 Failed because Device Cannot Be Accessed
   Logical Drive 0 (/dev/rd/c0d0) Critical
   Physical Device 0:0 is now DEAD
   Logical Drive 0 (/dev/rd/c0d0) is now CRITICAL


When I reinsert the drive, the following things happen:

1. Alarm stops.
2. /proc/rd/c0/current_status displays "Disk Status: Rebuild, 17747968 blocks"
   for the physical device and continues to display 
   "No Rebuild or Consistency Check in Progress"
3. The following is logged:
   Physical Device 0:0 Found
   Physical Device 0:0 Automatic Rebuild Started
   Physical Device 0:0 is now REBUILD
   Logical Drive 0 (/dev/rd/c0d0) Automatic Rebuild Started
   Logical Drive 0 (/dev/rd/c0d0) Rebuild Completed
   Physical Device 0:0 Rebuild Completed
   Physical Device 0:0 Online
   Logical Drive 0 (/dev/rd/c0d0) Online

At this point, /proc/rd/c0/current_status changes the "No Rebuild or 
Consistency Check in Progress" message to "Logical Drive 0 (/dev/rd/c0d0) 
Rebuild Completed".  However the following problems occur:

1. /proc/rd/status is never set back to OK, it remains ALERT
2. The activity indicator light on the sled for the drive that has been 
   rebuilt never goes off, although the red error light does.
3. The Physical Device information in /proc/rd/c0/current_status remains as
   "Disk Status: Rebuild, 17747968 blocks" 

If I reboot the machine, all is well.  That sort of defeats the purpose of
all this expensive hardware though :)  I also tried to:
echo "flush-cache" > /proc/rd/c0/user_command
but that just locked up the terminal I was typing in with no messages
anywhere.

Is it possible that the DAC960 driver should be doing something here that
it's not?  Or is all this functionality supposed to be completely taken care 
of at the firmware level of the RAID card?  I noticed DAC960.c does do some 
things differently if a SAF-TE is present, but only in the _V1 functions,
this card uses the _V2 functions.  I have tested this with Linux 2.4.23 and 
2.6.1 which produce exactly the same results.

Please CC me on any responses.

-Tony
