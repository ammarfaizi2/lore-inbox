Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbVCOEtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbVCOEtx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 23:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVCOEtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 23:49:52 -0500
Received: from c-67-177-11-111.client.comcast.net ([67.177.11.111]:46977 "EHLO
	vger") by vger.kernel.org with ESMTP id S262247AbVCOEtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 23:49:13 -0500
Message-ID: <4236669C.7010706@utah-nac.org>
Date: Mon, 14 Mar 2005 21:37:48 -0700
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: adilger@shaw.ca, strombrg@dcs.nac.uci.edu, linux-kernel@vger.kernel.org
Subject: Re: huge filesystems
References: <pan.2005.03.09.18.53.47.428199@dcs.nac.uci.edu>	<20050314164137.GC1451@schnapps.adilger.int>	<4235C251.7000801@utah-nac.org>	<20050314192140.1b3680da.akpm@osdl.org>	<4236587E.5060200@utah-nac.org> <20050314200241.0f079062.akpm@osdl.org>
In-Reply-To: <20050314200241.0f079062.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>jmerkey <jmerkey@utah-nac.org> wrote:
>  
>
>> >I don't recall you reporting any of them.  How can we expect to fix
>> >anything if we aren't told about it?
>> >
>> >  
>> >
>> I report them when I can't get around them myself. I've been able to get
>> around most of them.
>>    
>>
>
>Jeff, that's all take and no give.
>
>Please give: what problems have you observed in the current VFS for devices
>and files less than 16TB?u
>  
>

1. Scaling issues with readdir() with huge numbers of files (not even 
huge really. 87000 files in a dir takes a while
for readdir() to return results). I average 2-3 million files per 
directory on 2.6.9. It can take a up to a minute for
readdir() to return from initial reading from on of these directories 
with readdir() through the VFS.

2. NFS performance and stability issues with mapping NFS on top of dsfs. 
All sorts of problems (performance)
with system slowdowns -- in some cases can copy a file to a floppy 
system to system faster than I can copy over
100 mbit ethernet.

3. RCU and interrupt state problems with concurrent Network I/O and VFS 
interaction. Lots of places, I
reordered the code in these sections to hold more course grained locking.

4. BIO multiple chained requests has never worked correctly, so I have 
to submit 4K / BIO always. The design
and concept behind BIO's was great -- the implementation has a lot of 
problems. When I submit a chain
larger than 32 MB of 4K pages, the system looses state and the BIO's 
don't get returned or completed. And I see
some bizarre error returns from sumission. Jens classic response is 
always "Merkey you don't understand the interface" --
I have the code, I understand quite well, it does not work as advertised 
with these big sizes.

5. Files larger than 2TB work fine through the VFS provided I force mmap 
to use the internal interface. Files larger than
4 TB also seem to work fine. I have also tested with files larger than 
7TB, they also seem to work fine. I have not tested
individual files larger than 10 TB yet, but this will be happening in a 
month or so based on the units we are selling. When I
enable page cache mmap through the VFS, the system gets into trouble 
with these five memory pools from hell (slab, and the
various allocators in Linux -- I would think one byte level allocator 
would be enough) and the system has problems with
low memory conditions. I don't use the buffer cache because I post these 
huge coalesced sector runs to disk and need
memory in contuguous chunks, so the page cache/buffer cache don't 
optimize well in dsfs. I am achieving over 700 MB/S
megabytes per second to disk with custom hardware with the architecture 
I am using -- 6 % processor utilization on 2.6.9.

6. fdisk does not support drives arger than 2TB, so I have to hack the 
partition tables and fake out dsfs with 3TB abd 4TB
drives created with RAID 0 controllers and hardware. This needs to get 
fixed.

I will always give back changes to GPL code if folks ask for them -- buy 
an appliance through OSDL (they are really cool)
and request the GPL changes to Linux and I'll provide it as requested.

Order one from www.soleranetworks.com. Ask for Troy.

Jeff



>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

