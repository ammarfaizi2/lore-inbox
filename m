Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262112AbTCVKtA>; Sat, 22 Mar 2003 05:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262107AbTCVKtA>; Sat, 22 Mar 2003 05:49:00 -0500
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:48646 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP
	id <S262103AbTCVKs4>; Sat, 22 Mar 2003 05:48:56 -0500
Message-ID: <3E7C4251.4010406@torque.net>
Date: Sat, 22 Mar 2003 21:00:33 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [patch for playing] 2.5.65 patch to support > 256 disks
References: <200303211056.04060.pbadari@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> Hi,
> 
> Andries Brouwer recently submitted 32 bit dev_t patches,
> which are in 2.5.65-mm2. This patch applies on those patches to support 
> more than 256 disks.  This is for playing only.
> 
> I tested this with 4000 disks using scsi_debug. I attached my actual
> disks (50) after 4000 scsi_debug disks. I am able to access my disks
> fine and do IO on them.
> 
> Problems (so far):
> 
> 1) sd.c -  sd_index_bits[] arrys became big - need to be fixed.
> 
> 2) 4000 disks eats up lots of low memory (~460 MB). Here is the
> /proc/meminfo output before & after insmod.
> 
> Before:
> MemTotal:      3883276 kB
> MemFree:       3808028 kB
> Buffers:          3240 kB
> Cached:          41860 kB
> SwapCached:          0 kB
> Active:          45360 kB
> Inactive:         7288 kB
> HighTotal:     3014616 kB
> HighFree:      2961856 kB
> LowTotal:       868660 kB
> LowFree:        846172 kB
> SwapTotal:     2040244 kB
> SwapFree:      2040244 kB
> Dirty:             192 kB
> Writeback:           0 kB
> Mapped:          14916 kB
> Slab:             7164 kB
> Committed_AS:    12952 kB
> PageTables:        312 kB
> ReverseMaps:      1895
> ====
> After:
> MemTotal:      3883276 kB
> MemFree:       3224140 kB
> Buffers:          3880 kB
> Cached:         140376 kB
> SwapCached:          0 kB
> Active:          47512 kB
> Inactive:       105508 kB
> HighTotal:     3014616 kB
> HighFree:      2838144 kB
> LowTotal:       868660 kB
> LowFree:        385996 kB
> SwapTotal:     2040244 kB
> SwapFree:      2040244 kB
> Dirty:              92 kB
> Writeback:           0 kB
> Mapped:          16172 kB
> Slab:           464364 kB
> Committed_AS:    14996 kB
> PageTables:        412 kB
> ReverseMaps:      2209

Badari,
I poked around looking for data on the size issue.
Here are the byte sizes for the per device and per host
structures in scsi_debug and the scsi mid level for
i386, non-smp in lk 2.5.65:
   sizeof(sdebug_dev_info)=60, sizeof(scsi_device)=376
     sizeof(sdebug_host_info)=24, sizeof(Scsi_Host)=224

So for 4000 disks they should be responsible for about
2 MB.

The scsi_cmd_cache slab info went from this before those
84 pseudo disks were added:
# cat slabinfo_pre.txt
scsi_cmd_cache         3     11    356    1    1    1 :   32   16 : 
22     301     6    5    0    0   43 :   3235     31   3264      0
to this afterwards:
# cat slabinfo_post.txt
scsi_cmd_cache        44     55    356    5    5    1 :   32   16 : 
66     398    12    7    0    0   43 :   5837     40   5833      0

I did notice a rather large growth of nodes
in sysfs. For 84 added scsi_debug pseudo disks the number
of sysfs nodes went from 686 to 3347.

Does anybody know what is the per node memory cost of sysfs?

Doug Gilbert



