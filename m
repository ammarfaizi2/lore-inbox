Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRC2WIq>; Thu, 29 Mar 2001 17:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129166AbRC2WIf>; Thu, 29 Mar 2001 17:08:35 -0500
Received: from godzilla.monsters.org ([204.180.109.4]:33287 "EHLO
	godzilla.monsters.org") by vger.kernel.org with ESMTP
	id <S129143AbRC2WIU>; Thu, 29 Mar 2001 17:08:20 -0500
Message-Id: <200103292206.f2TM6sJ10808@zero.monsters.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: Memory leak in the ramfs file system
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 29 Mar 2001 16:06:54 -0600
From: Stephen L Johnson <sjohnson@monsters.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A group of us from the handhelds.org site think that we have found a memory 
leak in the ramfs file system. After a long period of create and deleting 
small files in a mounted ramfs partition we have substantially less freemem.  
The problem has been confirmed on 2.4.2 on an i386 and StormARM ports.

The problem was found by a developer running an application on an iPAQ that 
quickly writes a 4K file to the ramfs, does some editing of the file and it 
then deleted. The application will quickly eat up all free memory and cause 
the platform to fail within 5 minutes.

Test case: from a shell, run this short script for a long period of time (over 
1 hour):

   i=0 ; while : ; do echo 1 >$i ; rm $i ; i=`expr $i + 1` ; done

This test was run  on an Compaq iPAQ 3650 using the 2.4.2-rmk1-np3 kernel from 
the CVS repository on cvs.handhelds.org.

The following two data points are the output from /proc/meminfo.  The first  
'cat' was done about 1 minute after the loop has been running. The second 
'cat' was done 10 minutes after the script loop had been killed.

# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  31686656 21446656 10240000        0        0 11264000
Swap:        0        0        0
MemTotal:        30944 kB
MemFree:         10000 kB
MemShared:           0 kB
Buffers:             0 kB
Cached:          11000 kB
Active:           4656 kB
Inact_dirty:      4220 kB
Inact_clean:      2124 kB
Inact_target:        0 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        30944 kB
LowFree:         10000 kB
SwapTotal:           0 kB
SwapFree:            0 kB

# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  31686656 24178688  7507968        0        0 12357632
Swap:        0        0        0
MemTotal:        30944 kB
MemFree:          7332 kB
MemShared:           0 kB
Buffers:             0 kB
Cached:          12068 kB
Active:           4560 kB
Inact_dirty:      5384 kB
Inact_clean:      2124 kB
Inact_target:       16 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        30944 kB
LowFree:          7332 kB
SwapTotal:           0 kB
SwapFree:            0 kB

--
Stephen L Johnson  <sjohnson@monsters.org>


