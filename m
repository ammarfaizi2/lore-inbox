Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263646AbUD0B0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbUD0B0r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 21:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbUD0B0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 21:26:46 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:17298 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263646AbUD0B0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 21:26:08 -0400
Date: Mon, 26 Apr 2004 20:25:54 -0500
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
From: Dave Boutcher <sleddog@us.ibm.com>
Organization: IBM
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr63cxglpl6e53g@us.ibm.com>
User-Agent: Opera7.23/Win32 M2 build 3227
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

So I've drunk the sysfs kool-aid, but I'm wrestling with the 
implementation.  And I apologize for a long-winded question...

I'm working on a SCSI target adapter....an adapter that lets a SCSI 
initiator in another system get at local block devices as if they were 
SCSI devices.  The adapter device driver wants to make mappings like:

0:1 -> /dev/hda3
0:2 -> /dev/loop1

(where "0:1" is the SCSI bus/target identifier presented to the 
initiator.)  The mapping is currently done through the /proc file system, 
and I would really like to do it via sysfs.  For context, the current 
implementation would do something like:
    echo "b 8 16 0 1" > /proc/drivers/ibmvscsis/30000005
to create a mapping from block device 8:16 (/dev/sdb) to 0:1

Currently my adapter shows up as
./bus/vio/drivers/ibmvscss/30000005
./bus/vio/devices/30000005
./devices/vio/30000005

Each of the mappings might have a number of attributes, (the mapping 
itself, whether it is active, read-only, etc.)  So I think I want a 
directory under the device for each mapping:

sys
|-- devices
|   |
|   `-- vio
|       |-- 30000005
|       |   |-- detach_state
|       |   |-- name
|       |   |-- 0
|       |   |   |-- 0
|       |   |   |   |-- device
|       |   |   |   |-- active
|       |   |   |   `-- read-only
|       |   |   |-- 1
|       |   |   |   |-- device
|       |   |   |   |-- active
|       |   |   |   `-- read-only

So now to establish the mapping you would

echo "/dev/sdb3" > /sys/devices/vio/30000005/0/0/device
echo 1           > /sys/devices/vio/30000005/0/0/active

I think this follows all the nice rules for one value per attribute, but 
I'm struggling with building the hierarchy in sysfs.  Obviously I am going 
to need a kobject for each set of attributes so that I can tell which one 
is being accessed.  I considered using struct devices for each level and 
registering them, which seems reasonable.  I also considered creating a 
bus, but this seems like overkill in a single device driver.

Ultimately this has to be sane enough that Mr. Bottomley will accept it 
 from a SCSI point of view, and you will accept it from a sysfs point of 
view.

All comments and suggestions welcomed...

Dave B
