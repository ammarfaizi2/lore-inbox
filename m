Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264142AbTDKJ4i (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 05:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264086AbTDKJ4i (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 05:56:38 -0400
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:8970 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP id S263621AbTDKJ4f (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 05:56:35 -0400
Message-ID: <3E96945E.8080900@torque.net>
Date: Fri, 11 Apr 2003 20:09:34 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain
 backward compatibility
References: <UTC200304102353.h3ANrXv10792.aeb@smtp.cwi.nl> <200304101809.55311.pbadari@us.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> On Thursday 10 April 2003 04:53 pm, Andries.Brouwer@cwi.nl wrote:
> 
>>    From: Badari Pulavarty <pbadari@us.ibm.com>
>>
>>    >     I am more worried about names slipping. I atleast hope
>>    >     to see device names not changing by just doing
>>    >     rmmod/insmod.
>>    >
>>    > But you see, the present sd_index_bits[] gives no such
>>    > guarantee. In sd_detach a bit is cleared, in sd_attach
>>    > the first free bit is given out. There is no memory.
>>
>>    But the disks are probed in the same manner as last time
>>    (if the disks/controllers are not moved, crashed etc..).
>>    So we will end up getting same names.
>>
>>Oh, but if next_index is 0 in the module (or reset by the
>>init_module code), then also with index = next_index++
>>things will be the same after rmmod/insmod.
> 
> 
> Here is my problem..
> 
> #insmod ips.o
>   < found 10 disks>
> #insmod qla2300.o
>   < found 10 disks>
> #rmmod ips.o
>    <removed 10 disks>
> #insmod ips.o
>   <found 10 disks - but new names>

Badari,
In 2.5 lets assume the /dev/sd[a-z][a-z][a-z]
device addressing is left as is (more or less). To
identify lots of disks the Vital Product Data page 0x83
(failing that, the disk serial number) should be used.

This information is available via sysfs (thanks to
Patrick Mansfield and Mike Anderson).

# cd /sys/bus/scsi/devices
# find . -follow -name 'name' -exec cat {} \; -print
SIBM     DNES-309170W            AJF98887
./1:0:4:0/name
SFUJITSU MAM3184MP       UKS0P2300CK0
./0:0:1:0/name

It is relatively easy to write user space tools to show
this information:
# lsscsi -n
[0:0:1:0]    disk    FUJITSU  MAM3184MP        0106  /dev/sda
   name: SFUJITSU MAM3184MP       UKS0P2300CK0
[1:0:4:0]    disk    IBM      DNES-309170W     SA30  /dev/sdb
   name: SIBM     DNES-309170W            AJF98887

Each pair of lines links the transient topological and device
node name ("0:0:1:0" and "dev/sda" respectively) with a
(hopefully) invariant "name" for that device.

So if that name was hashed there would be a reasonable mapping
from that name to the current Linux scsi disk device node name
(e.g. /dev/sda). So user space tools could work out the mapping
and provide the "memory" from one boot to the next (and across
the deletion and re-addition of HBA modules).

Doug Gilbert




