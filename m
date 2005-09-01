Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbVIATw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbVIATw4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 15:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030332AbVIATw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 15:52:56 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:1217 "EHLO gw1.cosmosbay.com")
	by vger.kernel.org with ESMTP id S1030329AbVIATwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 15:52:55 -0400
Message-ID: <43175BE9.6030808@cosmosbay.com>
Date: Thu, 01 Sep 2005 21:52:09 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] : struct dentry : place d_hash close to d_parent and
 d_name to speedup lookups
References: <20050901035542.1c621af6.akpm@osdl.org> <431721F0.6090402@cosmosbay.com> <431722CC.8040204@cosmosbay.com> <20050901173634.GA4767@in.ibm.com>
In-Reply-To: <20050901173634.GA4767@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 01 Sep 2005 21:52:12 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma a écrit :
> On Thu, Sep 01, 2005 at 05:48:28PM +0200, Eric Dumazet wrote:
> 
>>dentry cache uses sophisticated RCU technology (and prefetching if 
>>available) but touches 2 cache lines per dentry during hlist lookup.
>>
>>This patch moves d_hash in the same cache line than d_parent and d_name 
>>fields so that :
>>
>>1) One cache line is needed instead of two.
>>2) the hlist_for_each_rcu() prefetching has a chance to bring all the 
>>needed data in advance, not only the part that includes d_hash.next.
>>
>>I also changed one old comment that was wrong for 64bits.
>>
>>A further optimisation would be to separate dentry in two parts, one that 
>>is mostly read, and one writen (d_count/d_lock) to avoid false sharing on 
>>SMP/NUMA but this would need different field placement depending on 32bits 
>>or 64bits platform.
> 
> 
> Do you have performance numbers that show the benefits ? In the
> past, I did try some optimizations like this but found no demonstrable
> benefits. If it ain't broken .....
> 

You mean... a microbenchmark ? :)

Well, the dentry cache hash table is so large that it's difficult to see the 
benefit, because chain length average is < 1 on most setups.
I suspect the sizing strategy of this hash table was made a long time ago...
Reducing the number of cache lines touched per dentry in lookup could let us 
shrink the hash table and save some ram.

Facts now :
------------

On a 512MB ia32 machine, the default sizing of the hash table gives 131072 
slots (0.5 MB of ram). So it's quite hard to populate the cache without eating 
all ram.

To see a benefit, I had to force a smaller hash size (appending in kernel 
params "dhash_entries=8191")

On this 512MB PIII 866MHz machine (L1_CACHE_SIZE=32), with 563887 files or 
directories the results are :

Remount the disk with noatime to make sure no disk access will be done

# mount -o remount /dev/hda2 / -o noatime

Populate the caches (dentry and disk buffers for directories)
# find / -name foofoo >/dev/null

# grep dentry_cache /proc/slabinfo
dentry_cache      131104 131370    136   29    1 : tunables  120   60    0 : 
slabdata   4530   4530      0

So average chain length is now 16

then time new searches using data in cache
time / -name foofoo >/dev/null

# time find / -name foofoo

real    0m3.077s
user    0m1.724s
sys     0m1.344s
# time find / -name foofoo

real    0m3.077s
user    0m1.728s
sys     0m1.348s
# time find / -name foofoo

real    0m3.084s
user    0m1.784s
sys     0m1.276s
# time find / -name foofoo

real    0m3.108s
user    0m1.716s
sys     0m1.348s
# time find / -name foofoo

real    0m3.061s
user    0m1.672s
sys     0m1.384s
# time find / -name foofoo

real    0m3.067s
user    0m1.644s
sys     0m1.424s
# time find / -name foofoo

real    0m3.061s
user    0m1.804s
sys     0m1.252s

kernel 2.6.13 build time
------------------------
mount -o remount /dev/hda2 /
make clean
time make bzImage
real    12m21.755s
user    11m5.070s
sys     1m0.756s


------------------------------------------------------------------

Results with a patched kernel


# time find / -name foofoo

real    0m3.017s
user    0m1.700s
sys     0m1.316s
# time find / -name foofoo

real    0m3.018s
user    0m1.592s
sys     0m1.424s
# time find / -name foofoo

real    0m3.017s
user    0m1.624s
sys     0m1.396s
# time find / -name foofoo

real    0m3.019s
user    0m1.680s
sys     0m1.340s
# time find / -name foofoo

real    0m3.021s
user    0m1.676s
sys     0m1.344s
# time find / -name foofoo

real    0m3.022s
user    0m1.644s
sys     0m1.376s
# time find / -name foofoo

real    0m3.021s
user    0m1.620s
sys     0m1.404s

kernel 2.6.13 build time
------------------------
mount -o remount /dev/hda2 /
make clean
time make bzImage
real    12m8.814s
user    11m2.129s
sys     0m52.187s

Conclusions:
-----------

1) There is a clear benefit, even without a microbenchmark :)

2) As sizeof(struct dentry)=136 on ia32 UP (140 on SMP), and dentry slab is 
not using SLAB_HWCACHE_ALIGN, I suspect lot of dentries are not aligned on a 
cache line boundary, so maybe reducing DNAME_INLINE_LEN_MIN (or increasing it) 
so that sizeof(struct dentry)%L1_CACHE_BYTES = {0 or (L1_CACHE_BYTES/2)} would 
even give better results.

Thank you

Eric
