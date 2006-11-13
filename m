Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933079AbWKMVke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933079AbWKMVke (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933080AbWKMVkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:40:31 -0500
Received: from 66-117-159-244.lmi.net ([66.117.159.244]:41347 "EHLO slick.org")
	by vger.kernel.org with ESMTP id S933079AbWKMVk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:40:28 -0500
Message-ID: <4558E64C.10309@imvu.com>
Date: Mon, 13 Nov 2006 13:40:28 -0800
From: "Brett G. Durrett" <brett@imvu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "Brett G. Durrett" <brett@imvu.com>,
       "David N. Welton" <d.welton@webster.it>
Subject: Re: megaraid_sas waiting for command and then offline
References: <453F2454.1000707@webster.it> <453FE9C4.1090504@imvu.com>
In-Reply-To: <453FE9C4.1090504@imvu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bad news - I just reproduced the failure using EXT3 on a system that had 
a complete install 4 days ago, so it looks like the megaraid_sas driver 
fails with both XFS and EXT3 (although EXT3 seems more reliable).

I was running EXT with no read ahead:
# ./MegaCli -LDGetProp -Cache -L0 -A0
Adapter 0-VD 0: Cache Policy:WriteBack, ReadAheadNone, Direct
# mount
/dev/sda1 on / type ext3 (rw,errors=remount-ro)
# uname -a
Linux AF001158 2.6.18-imvuamd64smpmsastest #1 SMP Mon Oct 9 21:26:46 PDT 
2006 x86_64 GNU/Linux

Here are the megaraid entries from syslog:

FACILITY 	DATE TIME 	MESSAGE
kern-warning 	2006-11-13 12:56:25 	kernel: megasas[0]: 64 bit SGLs were 
sent to FW
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Pending OS cmds in FW :
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0x15351800 : <3>megasas[0]: frame count : 0x8, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe238b77, lba_hi : 0x0, sense_buf addr : 0x1534d900,sge count 
: 0x47
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0x1535c800 : <3>megasas[0]: frame count : 0x8, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe23991f, lba_hi : 0x0, sense_buf addr : 0x15356d00,sge count 
: 0x50
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0x15375000 : <3>megasas[0]: frame count : 0x6, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe23aaaf, lba_hi : 0x0, sense_buf addr : 0x15371800,sge count 
: 0x1a
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0x15377c00 : <3>megasas[0]: frame count : 0x1, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xae0005f, lba_hi : 0x0, sense_buf addr : 0x15371d80,sge count 
: 0x2
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0x1537b400 : <3>megasas[0]: frame count : 0x1, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe208367, lba_hi : 0x0, sense_buf addr : 0x1537a280,sge count 
: 0x1
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0x1537d400 : <3>megasas[0]: frame count : 0x1, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe239697, lba_hi : 0x0, sense_buf addr : 0x1537a680,sge count 
: 0x1
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0xcff00000 : <3>megasas[0]: frame count : 0x8, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe238f17, lba_hi : 0x0, sense_buf addr : 0x1537ac00,sge count 
: 0x45
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0xcff01400 : <3>megasas[0]: frame count : 0x7, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe238df7, lba_hi : 0x0, sense_buf addr : 0x1537ae80,sge count 
: 0x22
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0xcff06400 : <3>megasas[0]: frame count : 0x1, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xa68d66f, lba_hi : 0x0, sense_buf addr : 0xcff03680,sge count 
: 0x1
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0xcff18400 : <3>megasas[0]: frame count : 0x8, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe239e27, lba_hi : 0x0, sense_buf addr : 0xcff15680,sge count 
: 0x50
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0xcff1f000 : <3>megasas[0]: frame count : 0x8, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe239b9f, lba_hi : 0x0, sense_buf addr : 0xcff1e200,sge count 
: 0x50
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0xcff20000 : <3>megasas[0]: frame count : 0x4, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe23c41f, lba_hi : 0x0, sense_buf addr : 0xcff1e400,sge count 
: 0xf
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0xcff2b000 : <3>megasas[0]: frame count : 0x3, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe23a377, lba_hi : 0x0, sense_buf addr : 0xcff27800,sge count 
: 0xa
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0xcff35c00 : <3>megasas[0]: frame count : 0x1, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xa601697, lba_hi : 0x0, sense_buf addr : 0xcff30b80,sge count 
: 0x1
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0xcff44400 : <3>megasas[0]: frame count : 0x1, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe238b6f, lba_hi : 0x0, sense_buf addr : 0xcff42480,sge count 
: 0x1
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0xcff4cc00 : <3>megasas[0]: frame count : 0x1, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe20a287, lba_hi : 0x0, sense_buf addr : 0xcff4b380,sge count 
: 0x1
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0xcff4f800 : <3>megasas[0]: frame count : 0x8, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe23a0f7, lba_hi : 0x0, sense_buf addr : 0xcff4b900,sge count 
: 0x38
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0xcff52400 : <3>megasas[0]: frame count : 0x1, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0x5f4009f, lba_hi : 0x0, sense_buf addr : 0xcff4be80,sge count 
: 0x1
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0xcff5fc00 : <3>megasas[0]: frame count : 0x1, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe238f0f, lba_hi : 0x0, sense_buf addr : 0xcff5d580,sge count 
: 0x1
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0xcff60000 : <3>megasas[0]: frame count : 0x1, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xa6000df, lba_hi : 0x0, sense_buf addr : 0xcff5d600,sge count 
: 0x1
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0xcff6bc00 : <3>megasas[0]: frame count : 0x1, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe239e1f, lba_hi : 0x0, sense_buf addr : 0xcff66b80,sge count 
: 0x1
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0xcff75800 : <3>megasas[0]: frame count : 0x8, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe239197, lba_hi : 0x0, sense_buf addr : 0xcff6fd00,sge count 
: 0x50
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0xcff76400 : <3>megasas[0]: frame count : 0x3, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe23a0a7, lba_hi : 0x0, sense_buf addr : 0xcff6fe80,sge count 
: 0xa
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0xcff7b400 : <3>megasas[0]: frame count : 0x8, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe23969f, lba_hi : 0x0, sense_buf addr : 0xcff78680,sge count 
: 0x50
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0xcff7e400 : <3>megasas[0]: frame count : 0x1, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe23aaa7, lba_hi : 0x0, sense_buf addr : 0xcff78c80,sge count 
: 0x1
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0x15391400 : <3>megasas[0]: frame count : 0x2, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xd0c004f, lba_hi : 0x0, sense_buf addr : 0x1538ae80,sge count 
: 0x3
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0x153a3000 : <3>megasas[0]: frame count : 0x1, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0x5f40217, lba_hi : 0x0, sense_buf addr : 0x1539ce00,sge count 
: 0x1
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0x153adc00 : <3>megasas[0]: frame count : 0x1, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe2343e7, lba_hi : 0x0, sense_buf addr : 0x153ae180,sge count 
: 0x1
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0x153bdc00 : <3>megasas[0]: frame count : 0x1, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xa601657, lba_hi : 0x0, sense_buf addr : 0x153b7d80,sge count 
: 0x1
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0x153c3000 : <3>megasas[0]: frame count : 0x1, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xae00057, lba_hi : 0x0, sense_buf addr : 0x153c0600,sge count 
: 0x1
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0x153c4000 : <3>megasas[0]: frame count : 0x1, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe2324af, lba_hi : 0x0, sense_buf addr : 0x153c0800,sge count 
: 0x1
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Frame addr 
:0x153c7400 : <3>megasas[0]: frame count : 0x8, Cmd : 0x2, Tgt id : 0x0, 
lba lo : 0xe239417, lba_hi : 0x0, sense_buf addr : 0x153c0e80,sge count 
: 0x50
kern-warning 	2006-11-13 12:56:25 	kernel: megasas[0]: Pending Internal 
cmds in FW :
kern-err 	2006-11-13 12:56:25 	kernel: megasas[0]: Dumping Done.
kern-err 	2006-11-13 12:56:25 	kernel: megasas: failed to do reset
kern-notice 	2006-11-13 12:56:25 	kernel: sd 0:2:0:0: megasas: RESET 
-20487153 cmd=2a
kern-err 	2006-11-13 12:56:25 	kernel: megasas: cannot recover from 
previous reset failures
kern-notice 	2006-11-13 12:56:25 	kernel: sd 0:2:0:0: megasas: RESET 
-20487153 cmd=2a
kern-err 	2006-11-13 12:56:25 	kernel: megasas: cannot recover from 
previous reset failures
kern-notice 	2006-11-13 12:56:24 	kernel: megasas: [100]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:56:24 	kernel: megasas: [105]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:56:24 	kernel: megasas: [110]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:56:24 	kernel: megasas: [115]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:56:24 	kernel: megasas: [120]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:56:24 	kernel: megasas: [125]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:56:24 	kernel: megasas: [130]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:56:24 	kernel: megasas: [135]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:56:24 	kernel: megasas: [140]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:56:24 	kernel: megasas: [145]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:56:24 	kernel: megasas: [150]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:56:24 	kernel: megasas: [155]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:56:24 	kernel: megasas: [160]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:56:24 	kernel: megasas: [165]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:56:24 	kernel: megasas: [170]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:56:24 	kernel: megasas: [175]waiting for 32 
commands to complete
kern-warning 	2006-11-13 12:56:24 	kernel: megasas[0]: Dumping Frame 
Phys Address of all pending cmds in FW
kern-err 	2006-11-13 12:56:24 	kernel: megasas[0]: Total OS Pending cmds 
: 32
kern-notice 	2006-11-13 12:54:59 	kernel: megasas: [95]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:54:54 	kernel: megasas: [90]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:54:49 	kernel: megasas: [85]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:54:44 	kernel: megasas: [80]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:54:39 	kernel: megasas: [75]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:54:34 	kernel: megasas: [70]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:54:29 	kernel: megasas: [65]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:54:24 	kernel: megasas: [60]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:54:19 	kernel: megasas: [55]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:54:14 	kernel: megasas: [50]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:54:09 	kernel: megasas: [45]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:54:04 	kernel: megasas: [40]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:53:59 	kernel: megasas: [35]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:53:54 	kernel: megasas: [30]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:53:49 	kernel: megasas: [25]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:53:44 	kernel: megasas: [20]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:53:39 	kernel: megasas: [15]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:53:34 	kernel: megasas: [10]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:53:29 	kernel: megasas: [ 5]waiting for 32 
commands to complete
kern-notice 	2006-11-13 12:53:24 	kernel: sd 0:2:0:0: megasas: RESET 
-20487153 cmd=2a
kern-notice 	2006-11-13 12:53:24 	kernel: megasas: [ 0]waiting for 32 
commands to complete





Brett G. Durrett wrote:

>
> David,
>
> We switched to 2.6.18 (SMP) and applied the latest patches from LSI 
> (got them directly from Sumant Patro).  Also, he told me to make sure 
> "read ahead" was set to "off".  This seems to have reduced the 
> frequency of the failures to about once per week (across 10+ 
> machines), down from several times per week.
>
> After I reported an additional failure, Sumant said they were able to 
> reproduce the problems with XFS but they have not seen it with EXT3.  
> I prefer XFS but I prefer to have reliable databases even more...
>
> I now have a couple of systems running in the new configuration and I 
> am slowly migrating others to it as well.  I have not seen a failure 
> with EXT3 but I statistically it would have been unlikely... I won't 
> declare victory until I have more systems converted with a few weeks 
> of reliable use.
>
> Hope this helps... if anybody solves the root cause I will happily 
> offer them a small gift to show my gratitude.
>
> B-
>
>
>
> David N. Welton wrote:
>
>> Hi,
>>
>> I found someone corresponding to your name writing about a problem with
>> the megaraid sas driver/hardware on the LKML:
>>
>> http://lkml.org/lkml/2006/9/6/12
>>
>> We have a Dell (2950, running 2.6.18 #1 SMP) as well, and the way I
>> managed to kill the thing dead in its tracks (symptoms basically what
>> you you describe) is with smartctl:
>>
>> root@salgari:~# smartctl --all /dev/sda
>> smartctl version 5.34 [i686-pc-linux-gnu] Copyright (C) 2002-5 Bruce 
>> Allen
>> Home page is http://smartmontools.sourceforge.net/
>>
>> Device: DELL     PERC 5/i         Version: 1.00
>> Device type: disk
>> Local Time is: Wed Oct 25 10:14:40 2006 CEST
>> Device does not support SMART
>>
>> Error Counter logging not supported
>>
>>
>> Device does not support Self Test logging
>>
>> ----
>>
>> [61101.681857] sd 0:2:0:0: rejecting I/O to offline device
>> [61101.681944] EXT3-fs error (device sda1): ext3_readdir: directory
>> #7553069 contains a hole at offset 0
>> [61103.944794] sd 0:2:0:0: rejecting I/O to offline device
>> [61103.944879] EXT3-fs error (device sda1): ext3_readdir: directory
>> #7553069 contains a hole at offset 0
>> [61104.672212] sd 0:2:0:0: rejecting I/O to offline device
>> [61104.672295] EXT3-fs error (device sda1): ext3_readdir: directory
>> #7553069 contains a hole at offset 0
>> [61105.255981] sd 0:2:0:0: rejecting I/O to offline device
>> [61105.256066] EXT3-fs error (device sda1): ext3_readdir: directory
>> #7553069 contains a hole at offset 0
>>
>> ----
>>
>> Dead in the water.  We suspect that in any case there are some disk
>> problems, which is why we were trying to use smartctl in the first 
>> place.
>>
>> I was just curious if you managed to figure anything out...
>>
>> Thanks,
>> Dave Welton
>>  
>>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

