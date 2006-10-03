Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030678AbWJCXXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030678AbWJCXXd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 19:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030679AbWJCXXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 19:23:33 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:1455 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1030677AbWJCXXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 19:23:32 -0400
Message-ID: <4522F0F2.3030206@oracle.com>
Date: Tue, 03 Oct 2006 16:23:30 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: [PATCH take2 3/5] dio: formalize bio counters as a dio reference
 count
References: <20061002232119.18827.96966.sendpatchset@tetsuo.zabbo.net>	<20061002232135.18827.28686.sendpatchset@tetsuo.zabbo.net> <20061003154449.daab5dbd.akpm@osdl.org>
In-Reply-To: <20061003154449.daab5dbd.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> +static int wait_for_more_bios(struct dio *dio)
>> +{
>> +	assert_spin_locked(&dio->bio_lock);
>> +
>> +	return (atomic_read(&dio->refcount) > 1) && (dio->bio_list == NULL);
>> +}
> 
> This function isn't well-named.

Sure, I'll try harder.

> 
>> @@ -1103,7 +1088,11 @@ direct_io_worker(int rw, struct kiocb *i
>>  		}
>>  		if (ret == 0)
>>  			ret = dio->result;
>> -		finished_one_bio(dio);		/* This can free the dio */
>> +
>> +		/* this can free the dio */
>> +		if (atomic_dec_and_test(&dio->refcount))
>> +			dio_complete_aio(dio);
> 
> So...  how come it's legitimate to touch *dio if it can be freed by now? 

Indeed!  This point in the patchset is retaining the existing behaviour
where the 'should_wait' direct_io_worker() path and the
finished_one_bio() path very carefully keep their tests in sync so that
only one of them ends up freeing the dio.

This particular patch doesn't change this part of the behaviour, it's
just bringing the dec and complete that was previously hidden in
finished_one_bio() up into its caller.  So I kept the comment.

This mess is replaced with a proper

	if (dec_and_test(dio->refcount))
		kfree(dio)

construct in the final patch.  I hope that means we don't need to patch
in some comments that we later remove.

- z
