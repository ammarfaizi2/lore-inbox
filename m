Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWAYATw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWAYATw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 19:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWAYATv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 19:19:51 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:60148 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750854AbWAYATv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 19:19:51 -0500
Message-ID: <43D6C425.90901@comcast.net>
Date: Tue, 24 Jan 2006 19:19:49 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: poor raid0 performance in 2.6.16-rc1-mm2?
References: <43D6B7F9.3020407@comcast.net> <20060125011211.337169ac@werewolf.auna.net>
In-Reply-To: <20060125011211.337169ac@werewolf.auna.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:

>On Tue, 24 Jan 2006 18:27:53 -0500, Ed Sweetman <safemode@comcast.net> wrote:
>
>  
>
>>I'll have to reboot to double check that this is specific to the above 
>>kernel version, but It seems something is either wrong with my 
>>particular kernel config for raid0, or my raid0 is setup wrong.
>>
>>my raid0 uses 64k chunk sizes on an ext3 fs that's 367GB large, (across 
>>two identical sata disks on nforce4 chipset)
>>
>>I have partitions on both drives of equal size (2 altogether) that are 
>>outside of the raid0.  I dbenched those partitions, the raid0 device, 
>>and libata pata devices i also have (same rpm, less cache, same company).  
>>
>>pata disk : 403MB/sec
>>sata disk 1: 446MB/sec
>>raid0 : between 336MB/sec and 386MB/sec
>>
>>    
>>
>
>Uh ? I want some of those disks....
>How are you measuring that ?
>
>Some more real numbers.
>
>A SATA raid5:
>nada:~# lsscsi
>[1:0:0:0]    disk    ATA      Maxtor 7Y250M0   YAR5  -       
>[2:0:0:0]    disk    ATA      Maxtor 7Y250M0   YAR5  -       
>[3:0:0:0]    disk    ATA      Maxtor 7Y250M0   YAR5  -       
>[4:0:0:0]    disk    ATA      Maxtor 7Y250M0   YAR5  -       
>[5:0:0:0]    disk    ATA      Maxtor 7Y250M0   YAR5  -       
>[6:0:0:0]    disk    ATA      Maxtor 7Y250M0   YAR5  -       
>[7:0:0:0]    disk    ATA      Maxtor 7Y250M0   YAR5  -
>nada:~# hdparm -t /dev/sdb /dev/sdc
>
>/dev/sdb:
> Timing buffered disk reads:  156 MB in  3.02 seconds =  51.70 MB/sec
>
>/dev/sdc:
> Timing buffered disk reads:  154 MB in  3.02 seconds =  50.96 MB/sec
>
>nada:~# hdparm -t /dev/md0
>
>/dev/md0:
> Timing buffered disk reads:  148 MB in  3.01 seconds =  49.20 MB/sec
>
>An SCSI raid0 one (160 and 320 mixed...)
>
>annwn:~# hdparm -t /dev/sdc /dev/sdb
>
>/dev/sdc:
> Timing buffered disk reads:  226 MB in  3.02 seconds =  74.72 MB/sec
>
>/dev/sdb:
> Timing buffered disk reads:  122 MB in  3.00 seconds =  40.64 MB/sec
>
>annwn:~# hdparm -t /dev/md0
>
>/dev/md0:
> Timing buffered disk reads:  242 MB in  3.00 seconds =  80.62 MB/sec
>  
>

I was using dbench  with three threads.  In retrospect, I am pretty sure 
my 2GB of ram was creating that performance.  Though, the poor 
performance when run on the raid0 device still stands.

This performance hit doesn't exist when using hdparm to test the 
bandwidth of the devices

/dev/sdc:
 Timing buffered disk reads:  166 MB in  3.01 seconds =  55.19 MB/sec
psuedomode:/mnt# hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:  126 MB in  3.02 seconds =  41.72 MB/sec
psuedomode:/mnt# hdparm -t /dev/md0

/dev/md0:
 Timing buffered disk reads:  338 MB in  3.02 seconds = 112.07 MB/sec


sda is pata libata
sdc is sata libata
md0 is two identical sata libata devices (sdc and sdd) in RAID0

So apparently, this may be filesystem related, as it pertains to being 
in a raid setup (since the filesystems are all the same otherwise except 
size).



>  
>
>>now the sata disks alone, get 446MB/sec, but the raid device that's 
>>comprised of them is getting >60MB/sec less throughput. 
>>
>>This difference is much more drastic when say only 1 process is used 
>>with dbench,
>>
>>sata disk 1: 230MB/sec
>>raid0 : 96MB/sec
>>
>>
>>Something definitely feels wrong with these numbers. 
>>
>>All filesystems are ext3, on an athlon 64 x2 system, during each test no 
>>other io was performed, there is no swap and no other cpu intensive 
>>operations were going on. 
>>
>>the filesystems were all created the same way, and all have the same 
>>blocksizes and such.  All are mounted with default options too. 
>>-
>>    
>>

