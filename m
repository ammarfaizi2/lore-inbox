Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030356AbWEYTPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbWEYTPm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 15:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbWEYTPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 15:15:42 -0400
Received: from cyrus.iparadigms.com ([64.140.48.8]:17654 "EHLO
	cyrus.iparadigms.com") by vger.kernel.org with ESMTP
	id S1030356AbWEYTPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 15:15:41 -0400
Message-ID: <44760255.2090408@iparadigms.com>
Date: Thu, 25 May 2006 12:15:33 -0700
From: fitzboy <fitzboy@iparadigms.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: tuning for large files in xfs
References: <447209A8.2040704@iparadigms.com> <20060523085116.B239136@wobbly.melbourne.sgi.com> <44725C27.90601@iparadigms.com> <20060523115938.A242207@wobbly.melbourne.sgi.com> <4473B9D0.5040602@iparadigms.com> <20060524122350.J270972@wobbly.melbourne.sgi.com>
In-Reply-To: <20060524122350.J270972@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

here are the results:

under 2.6.8 kernel with agsize=2g (440 some AGs): 6.9ms avg access
under 2.6.8 kernel with agcount=32: 6.2ms
under 2.6.17 kernel with partition made in 2.6.8 with agcount=32: 6.2ms
under 2.6.17 kernel just reading from /dev/sdb1: 6.2ms
under 2.6.17 kernel with new partition (made under 2.6.17) with 
agcount=32, file created via the xfs_io reserve call: 6.9 ms
under 2.6.17 kernel just reading from /dev/sdb1: 6.9ms (not sure why 
this changed from 6.2 the day before)...

So it seems like going to 32 AGs helped about 10%, but other then that 
not much else is making much of a difference... now I am moving on and 
trying to break the RAID up and testing individual disks to see their 
performance...

Nathan Scott wrote:
> On Tue, May 23, 2006 at 06:41:36PM -0700, fitzboy wrote:
> 
>>I read online in multiple places that the largest allocation groups 
>>should get is 4g,
> 
> 
> Thats not correct (for a few years now).
> 
> 
>>I was also thinking that the more AGs the better since I do a lot of 
>>parallel reads/writes... granted it doesn't change the file system all 
>>that much (the file only grows or get existing blocks get modified), so 
>>I am not sure if the number of AGs matter, does it?
> 
> 
> Yes, it can matter.  For large extents like you have here, AGs
> introduce a discontinuity that you'd otherwise not have.
> 
> 
>>Sorry, I meant that moving the Inode size to 2k (over 256bytes) gave me 
>>a sizeable increase in performance... I assume that is because the 
>>extent map can be smaller now (since blocks are much larger, less blocks 
>>to keep track of). Of course, ideal would be to have InodeSize be large 
>>and blocksize to be 32k... but I hit the limits on both...
> 
> 
> It means that more extents/btree records fit inline in the inode,
> as theres more space available after the stat data.  2k is your
> best choice for inode size, stick with that.
> 
> 
>>>- Preallocate the space in the file - i.e. before running the
>>>dd you can do an "xfs_io -c 'resvsp 0 2t' /mnt/array/disk1/xxx"
>>>(preallocates 2 terabytes) and then overwrite that.  Yhis will
>>>give you an optimal layout.
>>
>>I tried this a couple of times, but it seemed to wedge the machine... I 
>>would do: 1) touch a file (just to create it), 2) do the above command 
> 
> 
> Oh, use the -f (create) option and you won't need a touch.
> 
> 
>>which would then show effect in du, but the file size was still 0 3) I 
>>then opened that file (without O_TRUNC or O_APPEND) and started to write 
>>out to it. It would work fine for a few minutes but after about 5 or 7GB 
>>the machine would freeze... nothing in syslog, only a brief message on 
>>console about come cpu state being bad...
> 
> 
> Hmm - I'd be interested to hear if that happens with a recent
> kernel.
> 
> 
>>>- Your extent map is fairly large, the 2.6.17 kernel will have
>>>some improvements in the way the memory management is done here
>>>which may help you a bit too.
>>
>>we have plenty of memory on the machines, shouldn't be an issue... I am 
>>a little cautious about moving to a new kernel though...
> 
> 
> Its not the amount of memory that was the issue here, its more the
> way we were using it that was a problem for kernels of the vintage
> you're using here.  You will definately see better performance in
> a 2.6.17 kernel with that large extent map.
> 
> cheers.
> 

-- 
Timothy Fitz
Lead Programmer

iParadigms, LLC
1624 Franklin St., 7th Floor
Oakland, CA 94612

p. +1-510-287-9720 x233
f. +1-510-444-1952
e. fitzboy@iparadigms.com

The information contained in this message may be privileged and 
confidential and protected from disclosure. If the reader of this 
message is not the intended recipient, or an employee or agent 
responsible for delivering this message to the intended recipient, you 
are hereby notified that any dissemination, distribution or copying of 
this communication is strictly prohibited. If you have received this 
communication in error, please notify the sender immediately by replying 
to the message and deleting it from your computer.

