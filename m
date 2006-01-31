Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWAaKer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWAaKer (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 05:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWAaKer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 05:34:47 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:60808 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1750707AbWAaKeq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 05:34:46 -0500
Message-ID: <43DF3D0D.6080409@cosmosbay.com>
Date: Tue, 31 Jan 2006 11:33:49 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, paulmck@us.ibm.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       nickpiggin@yahoo.com.au, hch@infradead.org
Subject: Re: [patch 2/2] fix file counting
References: <20060126184010.GD4166@in.ibm.com> <20060126184127.GE4166@in.ibm.com> <20060126184233.GF4166@in.ibm.com> <43D92DD6.6090607@cosmosbay.com> <20060127145412.7d23e004.akpm@osdl.org> <20060127231420.GA10075@us.ibm.com> <20060127152857.32066a69.akpm@osdl.org> <20060130170028.GA6264@in.ibm.com>
In-Reply-To: <20060130170028.GA6264@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Tue, 31 Jan 2006 11:33:52 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma a écrit :
> On Fri, Jan 27, 2006 at 03:28:57PM -0800, Andrew Morton wrote:
>> "Paul E. McKenney" <paulmck@us.ibm.com> wrote:
>>>>> I am using a patch that seems sligthly better : It removes the filp_count_lock 
>>>>> as yours but introduces a percpu variable, and a lazy nr_files . (Its value 
>>>>> can be off with a delta of +/- 16*num_possible_cpus()
>>>> Yes, I think that is better.
>>> I agree that Eric's approach likely improves performance on large systems
>>> due to decreased cache thrashing.  However, the real problem is getting
>>> both good throughput and good latency in RCU callback processing, given
>>> Lee Revell's latency testing results.  Once we get that in hand, then
>>> we should consider Eric's approach.
>> Dipankar's patch risks worsening large-SMP scalability, doesn't it? 
>> Putting an atomic op into the file_free path?
> 
> Here are some numbers from a 32-way (HT) P4 xeon box with kernbench -
> 

Hi Dipankar, thank you very much for doing these tests.

To have an idea of the number of files that are allocated/freed during a 
kernel build, I added 4 fields in struct files_stat.

4th field is the central atomic_t nr_files.
5th field is the counter of allocated files.
6th field is the counter of freed files.
7th field is the counter of changes done on central atomic_t.

(Test machine is a dual Xeon HT, 2 GHz)
# make clean
# cat /proc/sys/fs/file-nr
119     0       206071  119     39169   39022   1131
[root@localhost linux-2.6.16-rc1-mm4]# time make -j4 bzImage
798.49user 82.36system 4:56.56elapsed 297%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (62major+7223263minor)pagefaults 0swaps

# cat /proc/sys/fs/file-nr
153     0       206071  153     755767  755620  5119

So thats (755767-39169)/(4*60+56) = 2420 files opened per second.

Number of changes on central atomic_t was :
(5119-1131)/(4*60+56) = 13 per second.


13 atomic ops per second (instead of 2420*2 per second if I had one atomic_t 
as in your patch), this is certainly not something we can notice in a typical 
SMP machine... maybe on a big NUMA machine it could be different ?

Eric
