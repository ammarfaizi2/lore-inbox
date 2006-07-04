Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWGDHv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWGDHv2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 03:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWGDHv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 03:51:28 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:32400 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751207AbWGDHv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 03:51:27 -0400
Message-ID: <44AA1DF5.7050204@sgi.com>
Date: Tue, 04 Jul 2006 09:51:17 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Keith Owens <kaos@sgi.com>, torvalds@osdl.org, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] reduce IPI noise due to /dev/cdrom open/close
References: <yq0mzbqhfdp.fsf@jaguar.mkp.net>	<21169.1151991139@kao2.melbourne.sgi.com> <20060703234134.786944f1.akpm@osdl.org>
In-Reply-To: <20060703234134.786944f1.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 04 Jul 2006 15:32:19 +1000
> I expect raw_smp_processor_id() is used here as a a microoptimisation -
> avoid a might_sleep() which obviously will never trigger.
> 
> But I think it'd be better to do just a single raw_smp_processor_id() for
> this entire function:

I agree, should have done that instead.

>> Racy?  Start with an empty lru_in_use.
>>
>> Cpu A                         Cpu B
>> invalidate_bh_lrus()
>> mask = lru_in_use;
>> preempted
>>                               block I/O
>> 			      bh_lru_install()
>> 			      cpu_set(cpu, lru_in_use);
>> resume
>> cpus_clear(lru_in_use);
>> schedule_on_each_cpu_mask() - does not send IPI to cpu B
> 
> Yup.  I think we can fix that by doing a single cpu_clear() on each CPU
> just prior to that CPU clearing out its array, in invalidate_bh_lru().

I deliberately tried to avoid that to avoid the bitmask turning into a
bouncing cacheline.

> There's a possibility of course that new bh's will get installed somewhere,
> but higher-level code must ensure that those bh's do not belong to the
> device which we're trying to clean up.

Cheers,
Jes
