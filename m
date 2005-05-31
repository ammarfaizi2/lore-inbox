Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVEaP4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVEaP4D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 11:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVEaP4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 11:56:03 -0400
Received: from cog1.w2cog.org ([206.251.188.12]:8832 "EHLO w2cog.org")
	by vger.kernel.org with ESMTP id S261918AbVEaPz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 11:55:56 -0400
Date: Tue, 31 May 2005 10:55:53 -0500 (CDT)
From: Roy Keene <rkeene@psislidell.com>
To: linux-kernel@vger.kernel.org
Subject: Problem with 2.6 kernel and lots of I/O
Message-ID: <Pine.LNX.4.62.0505311042470.7546@hammer.psislidell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 	I have a (well, at least one) show-stopping problems with the 2.6 
kernel while doing heavy I/O.  I have a (software) RAID1 of network block 
devices (nbd0 and nbd1) set up on two identical machines in an 
active-passive HA cluster configuration.  When the "primary" node goes 
down and comes back up it recovers the RAID as follows:

 	Start RAID in degraded mode with remote device (nbd1)
 	Hot-add local device (nbd0)

This all works.  Hot-adding the local device causes a resync and that is 
where the problems begin.  Once the resync begins the system becomes 
unusable.  Anything that wants to write something to the syslog socket 
("/dev/log") syncronously hangs until the resync completes.  The system 
load goes up to 18 or so.  Writing stuff to the local disk ("/etc" for 
example, which is not part of the RAID) sometimes hangs.  When the resync 
is complete everything is happy again.  Resyncing takes about 25 minutes 
(20GB over a dedicated network interface to the client at 1000Mbps) and 
makes the recovery time unacceptable.  Also, during this recovery the OOM 
killer will occasionally be invoked and kill something randomly even 
though there is typically plenty of unused swap lying around before 
(though perhaps "java" just decides to eat all of that VERY quickly and I 
don't notice this, since that is what the OOM killer choses to kill.)

Does anyone have any ideas ?


Information about the systems:

Info: Linux cog1 2.6.9-5.0.5.ELsmp #1 SMP Fri Apr 8 14:29:47 EDT 2005 i686 i686 i386 GNU/Linux
Dist: RedHat Enterprise Linux 4
Spec:
     2 x 3.2GHz Xeon (each system, with hyperthreading so 4 logical processors)
     4GB of physical RAM
     2GB of configured swap (partition, contigious)
     2 x 1000Mbps (Intel 82546GB) network cards (HA cluster link is
               provided by a cross over cable between the two nodes)
