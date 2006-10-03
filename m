Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbWJCTzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWJCTzw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 15:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWJCTzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 15:55:52 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:28641 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030237AbWJCTzu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 15:55:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:to:subject:from:content-type:mime-version:content-transfer-encoding:message-id:user-agent;
        b=Mpw7ch1mSiaqTZEx8ARem1G9HMKZIQjtOXSdg3iz2AyQNSlwSX+Jyr1He/i/0lS8SpJBvRU6dFlDy5AZNol/fFdFPNM08EI1ahXPrXFclmHxS3FnN8Z39RZfBCiZOtJtxnQElQpIng/KbI2uX/lkKAyaGDByeuJTYoCDB+kuoSk=
Date: Tue, 03 Oct 2006 20:55:55 +0100
To: linux-kernel@vger.kernel.org
Subject: BUGHUNTING: sata_sil, Silicon Image 3114 controllers, 2.6.18 and numerous errors
From: "Jonathan Bell" <doggs.lay.eggs@googlemail.com>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <op.tgu2zhvzxci36i@akima>
User-Agent: Opera Mail/9.00 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a long-winded explanation of events so I'll try to keep it concise.

I am running the following system (a large file server):

Athlon XP 2600+ CPU
1GB PC2700 RAM
A7N8X (nForce2) motherboard, BIOS 1008 (latest)
2x Silicon Image SiI3114 SATA controllers, output of LSPCI in [1]lspci.gz
D-Link DG530-T Gigabit PCI network card
Twinhan VisionPlus VisionDTV TV card

Drives =

2xWD3000JD 300GB western digital
2xWD3200JD 320GB western digital

3x6L300S0 300GB maxtor
3x6B300S0 300GB maxtor (identical to above but slightly older firmware and  
non-RoHS compliant)

The mess of problems began with _all_ these drives whilst using kernel  
2.6.15-26-k7 in the Ubuntu Dapper distribution. I got hit with a bug  
concerning FUA:

http://groups.google.com/group/fa.linux.kernel/browse_thread/thread/b0c495e4cf9d6d2/6ac40ae91be51b23?lnk=st&q=libpata+code+issues&rnum=1#6ac40ae91be51b23

At this stage my testing methodology was the following:

1) Make filesystems (reiserfs) on each of the drives
2) Make a huge file (11GB) by piping the output of /bin/yes "0123456789"  
to a file
3) Sync the disks
4) Calculate MD5 checksum of the file
5) Copy hugefile across to the next drive
6) Calculate MD5sum on new file

The writing of the hugefile to EACH drive would fill up the kernel log  
with errors seen all over the above linked thread, about one every 20  
seconds and the MD5sums of the files copied were different.

Noting that the problem occured on both the maxtor drives (with much more  
severity leading to device resets) and the western digitals I manually  
installed the 2.6.18 kernel from kernel.org which disabled FUA by default.  
This made the errors "disappear" on the maxtor drives but the western  
digital drives still displayed errors the same as the ones before.

Because I am naiive I went out and purchased another four drives, Seagates  
this time. I replaced the Western Digitals in the machine with the  
following model: 4xST3250824NS (250GB) and started testing again. This  
time I get errors like:

[ 1876.112335] attempt to access beyond end of device
[ 1876.112429] sdc1: rw=0, want=4517265416, limit=488392002
[ 1876.112516] attempt to access beyond end of device
[ 1876.112588] sdc1: rw=0, want=2110783496, limit=488392002
[ 1876.112723] attempt to access beyond end of device
[ 1876.112793] sdc1: rw=0, want=4656529416, limit=488392002
[ 1876.122250] attempt to access beyond end of device
[ 1876.122339] sdc1: rw=0, want=4517265416, limit=488392002

and even a kernel Oops: [2]reiseroops.gz

These errors occured after I copied hugefile to a destination drive and  
during the calculation of the md5sum, i.e. upon reading the new file.

Digging deeper, I am now at the stage where I can report the following:

The errors are happening independent of the controller hardware. One  
brand-new controller and one used and verified working (on Windows) with  
the same errors happening in each case.
The errors are independent of type of drive - Seagates and Maxtors both  
exhibit the same errors.
The errors are independent of filesystem - I tried and got the same result  
with ext2, ext3 and reiserfs 3.6.
The errors ONLY occur when reading from newly-created files. I am  
currently badblocks -n'ing the drives which will obviously take some time  
on drives this large in order to find out if this does happen with simple  
block read/writes.

Also I can say this:

The hugefile copied from the FIRST drive on one controller to the FIRST  
drive on the other controller exhibited NO ERRORS in either direction. By  
this I mean a Seagate attached to port0 and a Maxtor attached to port0.  
[3]dmesg-detection.gz may help with this - it is the kernel's detection of  
the drives. Whether this is due to dumb luck or a quirk in this "bug", I  
don't know but I will keep trying to make this error happen on the first  
drives in the system.

The hugefile copied from the FIRST Seagate drive to the SECOND, THIRD and  
FOURTH Seagate drives all make md5sum say "input/output error" and  
associated "access beyond end of device" errors in dmesg. The same thing  
happens when I copy from the FIRST maxtor drive to the second and third  
(not fourth as it contains NTFS data).

I will keep copying back and forth between drives in an effort to map out  
what is causing the error, but I'm going to need some pointers to track  
this to the source.

Any help appreciated,
Jonathan

