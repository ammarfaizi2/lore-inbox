Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030508AbWJCXFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030508AbWJCXFU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 19:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030652AbWJCXFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 19:05:20 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:41638 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1030508AbWJCXFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 19:05:14 -0400
Message-ID: <4522ECA8.4090906@oracle.com>
Date: Tue, 03 Oct 2006 16:05:12 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: [PATCH take2 1/5] dio: centralize completion in dio_complete()
References: <20061002232119.18827.96966.sendpatchset@tetsuo.zabbo.net>	<20061002232125.18827.52078.sendpatchset@tetsuo.zabbo.net> <20061003152603.3de68390.akpm@osdl.org>
In-Reply-To: <20061003152603.3de68390.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> -static void dio_complete(struct dio *dio, loff_t offset, ssize_t bytes)
>> +static int dio_complete(struct dio *dio, loff_t offset, int ret)
>>  {
>> +	ssize_t transferred = 0;
>> +
>> +	if (dio->result) {
>> +		transferred = dio->result;
>> +
>> +		/* Check for short read case */
>> +		if ((dio->rw == READ) && ((offset + transferred) > dio->i_size))
>> +			transferred = dio->i_size - offset;
> 
> On 32-bit machines ssize_t is `int' and loff_t is `long long'.  I guess
> `transferred' cannot overflow because you can't write >4G.  And I guess
> `transferred' cannot go negative because you cannot write >=2G.  Can you
> confirm that thinking?

Well, I think this ssize_t mirrors the return types for the read and
write syscalls and match the ssize_t wrapping checks on input by
rw_verify_area() and do_readv_writev().  I *think* that covers it,
though I haven't really audited all the ways to get to this code.

- z
