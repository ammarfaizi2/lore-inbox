Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264418AbRFIRVY>; Sat, 9 Jun 2001 13:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264415AbRFIRVQ>; Sat, 9 Jun 2001 13:21:16 -0400
Received: from gear.torque.net ([204.138.244.1]:15114 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S263797AbRFIRVF>;
	Sat, 9 Jun 2001 13:21:05 -0400
Message-ID: <3B225A8B.C03306AD@torque.net>
Date: Sat, 09 Jun 2001 13:19:07 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-ac9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: hiren_mehta@agilent.com
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: question about scsi generic behavior
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880AA8@xsj02.sjs.agilent.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hiren_mehta@agilent.com wrote:
> 
> Hi List,
> 
> I am trying to use sg_dd which goes through the scsi generic driver.
> This is how use it.
> 
> sg_dd if=/dev/zero of=/dev/sg5 bs=4096 count=1
> 
> And sg5 is actually a disk.

See "man sg_dd" which is provided with the sg_utils
package. The "bs" argument given to sg_dd must match
the physical block size of the device. [This is different from
"dd" in which bs can sensibly be an integral multiple of the 
physical block size.] The above command would have written 
zeroes over the first 512 byte block on the disk.  So the 
above should probably read:
  sg_dd if=/dev/zero of=/dev/sg5 bs=512 count=8
 
> The question that I have is, does the scsi generic driver have a knowledge
> about what kind of device it is dealing with ? 

No. It assumes as little as possible. It only does a
READ CAPACITY if a "count" argument is not given.
One reason is that not all devices that I may wish
to use sg_dd on support READ CAPACITY (or the figure
is wrong (e.g. cdroms)). In the case of the above 
command, only one WRITE(10) SCSI command should be 
issued to the disk.

> As you know, all disk drives
> have block size of 512 bytes. So, according to the above command, I am
> suppose
> write 4096 bytes of data. But when my driver gets the CDB, I see that
> the transfer length is set to 1 block instead of 8 blocks. 

As expected.

> And to transfer
> 4096 bytes, obviously we need transfer length=8 in CDB. Since, the transfer
> length
> is set to 1, the drive comes back with 1 512 byte block and then comes back
> with
> a good status because of which sg_dd command is not able to transfer all
> 4096 bytes
> of data.
> 
> Any input on this ?

To control the number of blocks transferred with each SCSI
command, the sg_dd command has a "bpt" (blocks per transfer)
command. Its default value is 128. The command:
  sg_dd if=/dev/zero of=/dev/sg5 bs=512 count=8 bpt=5
will transmit two SCSI commands, the first writing 5
512 byte blocks from block number 0, while the second
SCSI command will write 3 blocks from block number 5.
[/dev/sg5 is again assumed to be a disk blocked to 512 bytes.]
This is a finer grain of control than offered by the
generic dd command.

Doug Gilbert
