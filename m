Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262173AbSJASRI>; Tue, 1 Oct 2002 14:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262177AbSJASRI>; Tue, 1 Oct 2002 14:17:08 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:33975 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262173AbSJASRE>;
	Tue, 1 Oct 2002 14:17:04 -0400
Message-ID: <3D99E722.8020704@us.ibm.com>
Date: Tue, 01 Oct 2002 11:19:14 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Patrick Mochel <mochel@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Martin Bligh <mjbligh@us.ibm.com>
Subject: Re: [rfc][patch] driverfs multi-node(board) patch [2/2]
References: <3D98F3AD.2030607@us.ibm.com> <3D98F450.8080003@us.ibm.com> <20021001054112.GB5177@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Can you show an example output of what the directory structure now looks
> like with this patch?
> 
> Curious,
> 
> greg k-h
Surely, Greg!  Something I definitely should have put in the original 
post...  here's the before:

*****************BEFORE****************************
[root@elm3b79 devices]# tree -d bus/system/devices/
bus/system/devices/
|-- cpu0 -> ../../../root/sys/cpu0
|-- cpu1 -> ../../../root/sys/cpu1
|-- cpu2 -> ../../../root/sys/cpu2
|-- cpu3 -> ../../../root/sys/cpu3
|-- cpu4 -> ../../../root/sys/cpu4
|-- cpu5 -> ../../../root/sys/cpu5
|-- cpu6 -> ../../../root/sys/cpu6
|-- cpu7 -> ../../../root/sys/cpu7
|-- pic0 -> ../../../root/sys/pic0
`-- rtc0 -> ../../../root/sys/rtc0

10 directories
[root@elm3b79 devices]# tree -d class/
class/
|-- cpu
|   |-- devices
|   |   |-- 0 -> ../../../root/sys/cpu0
|   |   |-- 1 -> ../../../root/sys/cpu1
|   |   |-- 2 -> ../../../root/sys/cpu2
|   |   |-- 3 -> ../../../root/sys/cpu3
|   |   |-- 4 -> ../../../root/sys/cpu4
|   |   |-- 5 -> ../../../root/sys/cpu5
|   |   |-- 6 -> ../../../root/sys/cpu6
|   |   `-- 7 -> ../../../root/sys/cpu7
|   `-- drivers
|-- disk
|   |-- devices
|   `-- drivers
`-- input
     |-- devices
     `-- drivers

17 directories
[root@elm3b79 devices]# tree -d root/sys/
root/sys/
|-- cpu0
|-- cpu1
|-- cpu2
|-- cpu3
|-- cpu4
|-- cpu5
|-- cpu6
|-- cpu7
|-- pic0
`-- rtc0

10 directories
*****************BEFORE****************************

And here is the output after my changes:
******************AFTER****************************
[root@elm3b79 devices]# tree -d bus/system/devices/
bus/system/devices/
|-- cpu0 -> ../../../root/sys/node0/sys/cpu0
|-- cpu1 -> ../../../root/sys/node0/sys/cpu1
|-- cpu2 -> ../../../root/sys/node0/sys/cpu2
|-- cpu3 -> ../../../root/sys/node0/sys/cpu3
|-- cpu4 -> ../../../root/sys/node1/sys/cpu4
|-- cpu5 -> ../../../root/sys/node1/sys/cpu5
|-- cpu6 -> ../../../root/sys/node1/sys/cpu6
|-- cpu7 -> ../../../root/sys/node1/sys/cpu7
|-- memblk0 -> ../../../root/sys/node0/sys/memblk0
|-- memblk1 -> ../../../root/sys/node1/sys/memblk1
|-- node0 -> ../../../root/sys/node0
|-- node1 -> ../../../root/sys/node1
|-- pic0 -> ../../../root/sys/pic0
`-- rtc0 -> ../../../root/sys/rtc0

14 directories
[root@elm3b79 devices]# tree -d class/
class/
|-- cpu
|   |-- devices
|   |   |-- 0 -> ../../../root/sys/node0/sys/cpu0
|   |   |-- 1 -> ../../../root/sys/node0/sys/cpu1
|   |   |-- 2 -> ../../../root/sys/node0/sys/cpu2
|   |   |-- 3 -> ../../../root/sys/node0/sys/cpu3
|   |   |-- 4 -> ../../../root/sys/node1/sys/cpu4
|   |   |-- 5 -> ../../../root/sys/node1/sys/cpu5
|   |   |-- 6 -> ../../../root/sys/node1/sys/cpu6
|   |   `-- 7 -> ../../../root/sys/node1/sys/cpu7
|   `-- drivers
|-- disk
|   |-- devices
|   `-- drivers
|-- input
|   |-- devices
|   `-- drivers
|-- memblk
|   |-- devices
|   |   |-- 0 -> ../../../root/sys/node0/sys/memblk0
|   |   `-- 1 -> ../../../root/sys/node1/sys/memblk1
|   `-- drivers
`-- node
     |-- devices
     |   |-- 0 -> ../../../root/sys/node0
     |   `-- 1 -> ../../../root/sys/node1
     `-- drivers

27 directories
[root@elm3b79 devices]# tree -d root/sys/
root/sys/
|-- node0
|   `-- sys
|       |-- cpu0
|       |-- cpu1
|       |-- cpu2
|       |-- cpu3
|       `-- memblk0
|-- node1
|   `-- sys
|       |-- cpu4
|       |-- cpu5
|       |-- cpu6
|       |-- cpu7
|       `-- memblk1
|-- pic0
`-- rtc0

16 directories
******************AFTER****************************

Basically, the patch just adds nodes and memblks to the topology and 
nests the cpus/memblks under the nodes.  I'd like to add more 
information to these directories (node-node distances, cpu speeds, 
memory block sizes/physical page ranges, etc, etc, etc), but this is 
just a first-pass.

Cheers!

-Matt

