Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161015AbWGIOMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbWGIOMg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 10:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161017AbWGIOMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 10:12:36 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:9607 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161012AbWGIOMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 10:12:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=k2DAPC6gunttVWvCKiN4zPbklt01B0qgolPGXmN3FSidQQT6WuHi6xMQeWCuScmaeEGbinI78LfpOFxGySV8+PIzMSDx+aa1X/RwiEh3jKCEHrgBB/o23ojjzybG+oosTIU5jFuYOpBCTfEXNLzisFjwWGuqYsYtno8IrfE8Ht4=  ;
Message-ID: <44B0F87F.70503@yahoo.com.au>
Date: Sun, 09 Jul 2006 22:37:19 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Fabio Comolli <fabio.comolli@gmail.com>, mingo@redhat.com,
       linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: 2.6.18-rc1-mm1
References: <20060709021106.9310d4d1.akpm@osdl.org>	<b637ec0b0607090326w5a1702d1l9b7619fba7e4bc41@mail.gmail.com> <20060709034509.c4652caa.akpm@osdl.org>
In-Reply-To: <20060709034509.c4652caa.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sun, 9 Jul 2006 12:26:45 +0200
> "Fabio Comolli" <fabio.comolli@gmail.com> wrote:
> 
> 
>>=======================================================
>>[ INFO: possible circular locking dependency detected ]
>>-------------------------------------------------------
>>cpuspeed/1520 is trying to acquire lock:
>> (&policy->lock){--..}, at: [<c02c130f>] mutex_lock+0x21/0x24
>>
>>but task is already holding lock:
>> (cpucontrol){--..}, at: [<c02c130f>] mutex_lock+0x21/0x24
>>
>>which lock already depends on the new lock.
> 
> 
> Yeah, that's lock_cpu_hotplug().  We've made a complete and utter mess of
> that thing.
> 
> And I don't know how to fix it, really.  Is it a highly-localised innermost
> lock?  Or a broad-coverage outermost lock?  Nobody knows, neither suits.
> 
> I'm suspecting is was a bad idea and we should just rip it out altogether.
> 
> - If a piece of kernel code is dealing with cpu-local data it needs to be
>   running atomically, and that'll hold off hot hotplug anyway.

These guys don't need lock_cpu_hotplug() today.

> 
> - If a piece of kernel code is dealing with per-cpu data and cannot run
>   atomically then it should have its own cpu hotplug handlers anyway.  It
>   is up to that code (ie: cpufreq) to provide its own locking against its
>   own CPU hotplug callback.

This still does not solve this cpufreq problem where it is trying to
take the same lock twice down the same call path. Whether it is the
lock_cpu_hotplug mutex or another one, the code must be just busted.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
