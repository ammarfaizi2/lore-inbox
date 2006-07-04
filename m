Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWGDReG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWGDReG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 13:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWGDReG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 13:34:06 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:32847 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932197AbWGDReE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 13:34:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=gB8S8kM2gq5tGZgeLicehF83CczrV3zlAM1mANkunTLoENzQTPZGSUJCTuGFZRS2o+U1ntcQtFpOOTNu+w+iGtTfBMeix/ZxO3unJsCHYD9EawOgafb+gxXwofk4K3+J0l1PfLcnOmeKkebuditSo82yxcVroz1rMzA/cD17Eug=  ;
Message-ID: <44AAA64D.8030907@yahoo.com.au>
Date: Wed, 05 Jul 2006 03:33:01 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Keith Owens <kaos@sgi.com>, jes@sgi.com, torvalds@osdl.org,
       viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [patch] reduce IPI noise due to /dev/cdrom open/close
References: <yq0mzbqhfdp.fsf@jaguar.mkp.net>	<21169.1151991139@kao2.melbourne.sgi.com> <20060703234134.786944f1.akpm@osdl.org>
In-Reply-To: <20060703234134.786944f1.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 04 Jul 2006 15:32:19 +1000
> Keith Owens <kaos@sgi.com> wrote:

>>Why raw_smp_processor_id?  That normally indicates code that wants a
>>lazy cpu number, but this code requires the exact cpu number, IMHO
>>using raw_smp_processor_id is confusing.  smp_processor_id can safely
>>be used here, bh_lru_lock has disabled irq or preempt.
> 
> 
> I expect raw_smp_processor_id() is used here as a a microoptimisation -
> avoid a might_sleep() which obviously will never trigger.

A microoptimisation because they've turned on DEBUG_PREEMPT and found
that smp_processor_id slows down? ;) Wouldn't it be better to just stick
to the normal rules (ie. what Keith said)?

It may be obvious in this case (though that doesn't help people who make
obvious mistakes, or mismerge patches) but this just seems like a nasty
precedent to set (or has it already been?).

> 
> But I think it'd be better to do just a single raw_smp_processor_id() for
> this entire function:
> 
>   static void bh_lru_install(struct buffer_head *bh)
>   {
> 	struct buffer_head *evictee = NULL;
> 	struct bh_lru *lru;
> +	int cpu;
> 
> 	check_irqs_on();
> 	bh_lru_lock();
> +	cpu = raw_smp_processor_id();
> -	lru = &__get_cpu_var(bh_lrus);
> +	lru = per_cpu(bh_lrus, cpu);
> 
> etcetera.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
