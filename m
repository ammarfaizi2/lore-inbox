Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbUCYDDm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 22:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbUCYDDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 22:03:42 -0500
Received: from med-gwia-01a.med.umich.edu ([141.214.93.149]:41378 "EHLO
	med-gwia-01a.med.umich.edu") by vger.kernel.org with ESMTP
	id S263134AbUCYDDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 22:03:37 -0500
Message-Id: <s06205b8.017@med-gwia-01a.med.umich.edu>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Wed, 24 Mar 2004 22:04:17 -0500
From: "Robert Welsh" <rcwelsh@med.umich.edu>
To: <linux-kernel@vger.kernel.org>
Cc: <bcollins@debian.org>
Subject: sbp2 logging out causing raid1 to fail
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running kernel 2.4.25 which has the latest (1193) release of
ieee1394 as far as I can tell by comparing kernel source to ieee1394
branch. (Adam Kirchhoff - you reported back in feb that you had success
with 2.4.25 can you tell me how?)

Anyway I have built a raid1 array with two 200 gig lacie fw800  drives
using a lacie fw pci card (ohci compliant chip). The build went fine as
did the resync. But then I started copying alot over and it died. 

>From what I can gather in the log files it looks like sbp2 is logging
out of one of the drives when then manifests as a drive failure - which
it in a way is. 

I did see that Ben Collins had made change in 1016 of sbp2 to allow a
second to log back in after a bus reset. But what is causing this to
actually log out and is there a way to prevent?

I am using kernel 2.4.25 as the linux1394.org website says firewire is
more stable under 2.4.X vs. 2.6.X, which is what I have found as well,
but apparently not stable enough. While we are running an older kernel
2.4.18 (rh7.3) and the firewire seem to be fine - though we are not
running a raid there.

I am able to rmmod the appropriate modules, modprobe them back in and
rescan-scsi-bus to get the drives recognizable, but now of course md
thinks that my one drive is bad, when in a way it is not, just that it
dropped out for a short while.

Thanks,

Robert.

This is what I see in the /var/log/messages:

***************************************************
Mar 24 20:09:32 phobia kernel: md: md1: sync done.
Mar 24 20:10:28 phobia kernel: kjournald starting.  Commit interval 5
seconds
Mar 24 20:10:28 phobia kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on
md(9,0), internal journal
Mar 24 20:10:28 phobia kernel: EXT3-fs: mounted filesystem with ordered
data mode.
Mar 24 20:11:16 phobia kernel: kjournald starting.  Commit interval 5
seconds
Mar 24 20:11:16 phobia kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on
md(9,1), internal journal
Mar 24 20:11:16 phobia kernel: EXT3-fs: mounted filesystem with ordered
data mode.
Mar 24 20:24:43 phobia sshd(pam_unix)[15626]: session closed for user
root
Mar 24 20:24:54 phobia sshd(pam_unix)[18229]: session opened for user
root by (uid=0)
Mar 24 20:50:28 phobia kernel: ieee1394: sbp2: Logged out of SBP-2
device
Mar 24 20:50:28 phobia kernel: SCSI disk error : host 2 channel 0 id 0
lun 0 return code = 10000
Mar 24 20:50:28 phobia kernel:  I/O error: dev 08:31, sector 198546976
******************************************
and a little later in the log
******************************************
Mar 24 20:50:28 phobia kernel: SCSI disk error : host 2 channel 0 id 0
lcommand
Mar 24 20:50:28 phobia kernel: ieee1394: sbp2: Bus reset in progress -
rejecting command
Mar 24 20:50:28 phobia kernel: ieee1394: sbp2: Bus reset in progress -
rejecting command
Mar 24 20:50:28 phobia kernel: SCSI disk error : host 2 channel 0 id 1
lun 0 return code = 20000
Mar 24 20:50:28 phobia kernel:  I/O error: dev 08:41, sector 198773264
Mar 24 20:50:28 phobia kernel: ieee1394: sbp2: Bus reset in progress -
rejecting command
Mar 24 20:50:28 phobia last message repeated 4 times
Mar 24 20:50:28 phobia kernel: SCSI disk error : host 2 channel 0 id 1
lun 0 return code = 20000
Mar 24 20:50:28 phobia kernel:  I/O error: dev 08:41, sector 198773920
Mar 24 20:50:28 phobia kernel: ieee1394: sbp2: Bus reset in progress -
rejecting command
Mar 24 20:50:28 phobia last message repeated 4 times
************************************************

and what seems to be the last relevant stuff

************************************************
Mar 24 20:50:50 phobia devlabel: devlabel service started/restarted
Mar 24 20:50:50 phobia devlabel: devlabel service started/restarted
Mar 24 21:00:34 phobia kernel: ieee1394: sbp2: Logged out of SBP-2
device
Mar 24 21:00:36 phobia last message repeated 2 times
Mar 24 21:00:38 phobia kernel: ieee1394: sbp2: Logged into SBP-2 device
Mar 24 21:00:38 phobia kernel: ieee1394: sbp2: Node 0-00:1023: Max speed
[S800] - Max payload [4096]
Mar 24 21:00:38 phobia ieee1394.agent[28790]: missing kernel or user
mode driver sbp2 
Mar 24 21:00:39 phobia kernel: ieee1394: sbp2: Logged into SBP-2 device
Mar 24 21:00:39 phobia kernel: ieee1394: sbp2: Node 0-01:1023: Max speed
[S800] - Max payload [4096]
Mar 24 21:00:39 phobia ieee1394.agent[29130]: missing kernel or user
mode driver sbp2 
Mar 24 21:00:40 phobia kernel: ieee1394: sbp2: Logged into SBP-2 device
Mar 24 21:00:40 phobia kernel: ieee1394: sbp2: Node 0-02:1023: Max speed
[S800] - Max payload [4096]
Mar 24 21:00:40 phobia ieee1394.agent[29464]: missing kernel or user
mode driver sbp2 
Mar 24 21:00:47 phobia kernel: ieee1394: sbp2: aborting sbp2 command
Mar 24 21:00:47 phobia kernel: Inquiry 01 80 00 60 00 
*********************************************


-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
Robert C. Welsh, PhD
Research Investigator
Department of Radiology
University of Michigan
(734) - 764 - 2412 (fax)
rcwelsh@umich.edu



