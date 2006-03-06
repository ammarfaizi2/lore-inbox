Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWCFB2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWCFB2c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 20:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWCFB2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 20:28:32 -0500
Received: from smtp-out.google.com ([216.239.45.12]:38491 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751465AbWCFB2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 20:28:31 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=mVZu2mj9WcKV/exRRArg70f1g1yjuoLWZmMYstnMHF8/Oza6uXU05x1LoV+KvE2oY
	jO9V0MPsE7QXfezEdyCZQ==
Message-ID: <440B9035.1070404@google.com>
Date: Sun, 05 Mar 2006 17:28:21 -0800
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: Ocfs2 performance bugs of doom
References: <4408C2E8.4010600@google.com> <20060303233617.51718c8e.akpm@osdl.org>
In-Reply-To: <20060303233617.51718c8e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Daniel Phillips <phillips@google.com> wrote:
>>   	assert_spin_locked(&dlm->spinlock);
>> +	bucket = dlm->lockres_hash + full_name_hash(name, len) % DLM_HASH_BUCKETS;
>>
>> -	hash = full_name_hash(name, len);
>
> err, you might want to calculate that hash outside the spinlock.

Yah.

> Maybe have a lock per bucket, too.

So the lock memory is as much as the hash table? ;-)

> A 1MB hashtable is verging on comical.  How may data are there in total?

Even with the 256K entry hash table, __dlm_lookup_lockres is still the
top systime gobbler:

-------------
real 31.01
user 25.29
sys 3.09
-------------

CPU: P4 / Xeon, speed 2793.37 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not stopped) with a unit mask of 0x01 (mandatory) count 240000
samples  %        image name               app name                 symbol name
-------------------------------------------------------------------------------
17071831 71.2700  libbz2.so.1.0.2          libbz2.so.1.0.2          (no symbols)
   17071831 100.000  libbz2.so.1.0.2          libbz2.so.1.0.2          (no symbols) [self]
-------------------------------------------------------------------------------
2638066  11.0132  vmlinux                  vmlinux                  __dlm_lookup_lockres
   2638066  100.000  vmlinux                  vmlinux                  __dlm_lookup_lockres [self]
-------------------------------------------------------------------------------
332683    1.3889  oprofiled                oprofiled                (no symbols)
   332683   100.000  oprofiled                oprofiled                (no symbols) [self]
-------------------------------------------------------------------------------
254736    1.0634  vmlinux                  vmlinux                  ocfs2_local_alloc_count_bits
   254736   100.000  vmlinux                  vmlinux                  ocfs2_local_alloc_count_bits [self]
-------------------------------------------------------------------------------
176794    0.7381  tar                      tar                      (no symbols)
   176794   100.000  tar                      tar                      (no symbols) [self]
-------------------------------------------------------------------------------

Note, this is uniprocessor, single node on a local disk.  Something
pretty badly broken all right.  Tomorrow I will take a look at the hash
distribution and see what's up.

I guess there are about 250k symbols in the table before purging
finally kicks in, which happens 5th or 6th time I untar a kernel tree.
So, 20,000 names times 5-6 times the three locks per inode Mark
mentioned.  I'll actually measure that tomorrow instead of inferring
it.

I think this table is per-ocfs2-mount, and really really, a meg is
nothing if it makes CPU cycles  go away.  That's .05% of the memory
on this box, which is a small box where clusters are concerned.  But
there is also some gratuitous cpu suck still happening in there that
needs investigating.  I would not be surprised at all to learn that
full_name_hash is a terrible hash function.

Regards,

Daniel
