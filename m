Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbWEXBlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbWEXBlq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 21:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWEXBlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 21:41:45 -0400
Received: from cyrus.iparadigms.com ([64.140.48.8]:25081 "EHLO
	cyrus.iparadigms.com") by vger.kernel.org with ESMTP
	id S932539AbWEXBlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 21:41:44 -0400
Message-ID: <4473B9D0.5040602@iparadigms.com>
Date: Tue, 23 May 2006 18:41:36 -0700
From: fitzboy <fitzboy@iparadigms.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: tuning for large files in xfs
References: <447209A8.2040704@iparadigms.com> <20060523085116.B239136@wobbly.melbourne.sgi.com> <44725C27.90601@iparadigms.com> <20060523115938.A242207@wobbly.melbourne.sgi.com>
In-Reply-To: <20060523115938.A242207@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:
> Hi Tim,
> 
> On Mon, May 22, 2006 at 05:49:43PM -0700, fitzboy wrote:
> 
>>Nathan Scott wrote:
>>
>>>Can you send xfs_info output for the filesystem and the output
>>>from xfs_bmap -vvp on this file?
>>
>>xfs_info:
>>meta-data=/mnt/array/disk1       isize=2048   agcount=410, agsize=524288 
> 
> 
> Thats odd - why such a large number of allocation groups?

I read online in multiple places that the largest allocation groups 
should get is 4g, so I made mine 2g. However, having said that, I did 
test with different allocation sizes and the effect was not that 
dramatic. I will retest again though, just to verify.

I was also thinking that the more AGs the better since I do a lot of 
parallel reads/writes... granted it doesn't change the file system all 
that much (the file only grows or get existing blocks get modified), so 
I am not sure if the number of AGs matter, does it?

 >>meta-data=/mnt/array/disk1       isize=2048   agcount=410, 
agsize=524288 blks
 >>         =                       sectsz=512
>>data     =                       bsize=4096   blocks=214670562, imaxpct=25
>>          =                       sunit=16     swidth=192 blks, unwritten=1
>>naming   =version 2              bsize=4096
>>log      =internal               bsize=4096   blocks=8192, version=1
>>          =                       sectsz=512   sunit=0 blks
>>realtime =none                   extsz=65536  blocks=0, rtextents=0
>>
>>it is mounted rw,noatime,nodiratime
>>generally I am doing 32k reads from the application, so I would like 
>>larger blocksize (32k would be ideal), but can't go above 2k on intel...
> 
> 
> 4K you mean (thats what you've got above, and thats your max with
> a 4K pagesize).
> 

Sorry, I meant that moving the Inode size to 2k (over 256bytes) gave me 
a sizeable increase in performance... I assume that is because the 
extent map can be smaller now (since blocks are much larger, less blocks 
to keep track of). Of course, ideal would be to have InodeSize be large 
and blocksize to be 32k... but I hit the limits on both...

> I thought you said you had a 2TB file?  The filesystem above is
> 4096 * 214670562 blocks, i.e. 818GB.  Perhaps its a sparse file?
> I guess I could look closer at the bmap and figure that out for
> myself. ;)

On my production servers the file is 2TB, but on this testing enviroment 
I have, the file is only 767G of a 819G partition... This is sufficient 
to tell because the performance is already hindered alot even at 767G, 
going to 2TB just makes it worse...

>>I made the file my copying it over via dd from another machine onto a 
>>clean partition... then from that point we just append to the end of it, 
>>or modify existing data...
> 
> 
>>I am attaching the extent map
> 
> 
> Interesting.  So, the allocator did an OK job for you, at least
> initially - everything is contiguous (within the bounds of the
> small agsize you set) until extent #475, and I guess that'd have
> been the end of the initial copied file.  After that it chops
> about a bit (goes back to earlier AGs and uses the small amounts
> of space in each I'm guessing), then gets back into nice long
> contiguous extent allocations in the high AGs.
> 
> Anyway, you should be able to alleviate the problem by:
> 
> - Using a small number of larger AGs (say 32 or so) instead of
> a large number of small AGs.  this'll give you most bang for
> your buck I expect.
> [ If you use a mkfs.xfs binary from an xfsprogs anytime since
> November 2003, this will automatically scale for you - did you
> use a very old mkfs?  Or set the agcount/size values by hand?
> Current mkfs would give you this:
> # mkfs.xfs -isize=2k -dfile,name=/dev/null,size=214670562b -N
> meta-data=/dev/null    isize=2048  agcount=32, agsize=6708455 blks
> ...which is just what you want here. ]

I set it by hand. I rebuilt the partition and am now copying over the 
file again to see the results...

> 
> - Preallocate the space in the file - i.e. before running the
> dd you can do an "xfs_io -c 'resvsp 0 2t' /mnt/array/disk1/xxx"
> (preallocates 2 terabytes) and then overwrite that.  Yhis will
> give you an optimal layout.

I tried this a couple of times, but it seemed to wedge the machine... I 
would do: 1) touch a file (just to create it), 2) do the above command 
which would then show effect in du, but the file size was still 0 3) I 
then opened that file (without O_TRUNC or O_APPEND) and started to write 
out to it. It would work fine for a few minutes but after about 5 or 7GB 
the machine would freeze... nothing in syslog, only a brief message on 
console about come cpu state being bad...

> 
> - Not sure about your stripe unit/width settings, I would need
> to know details about your RAID.  But maybe theres tweaking that
> could be done there too.

stripe unit is 64k, array is a RAID5 with 14 disks, so I say sw=13 (one 
disk is parity). I set this when I made the array, though it doesn't 
seem to matter much either.

> 
> - Your extent map is fairly large, the 2.6.17 kernel will have
> some improvements in the way the memory management is done here
> which may help you a bit too.
> 

we have plenty of memory on the machines, shouldn't be an issue... I am 
a little cautious about moving to a new kernel though...
