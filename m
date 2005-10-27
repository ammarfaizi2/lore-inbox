Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbVJ0Ii1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbVJ0Ii1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 04:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbVJ0Ii1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 04:38:27 -0400
Received: from cantor2.suse.de ([195.135.220.15]:63927 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965002AbVJ0Ii0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 04:38:26 -0400
From: Andi Kleen <ak@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: Weird schedule delay time for cache_reap()
Date: Thu, 27 Oct 2005 10:37:08 +0200
User-Agent: KMail/1.8
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, manfred@colorfullife.com
References: <200510270228.j9R2SWg27777@unix-os.sc.intel.com>
In-Reply-To: <200510270228.j9R2SWg27777@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510271037.08853.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 October 2005 04:28, Chen, Kenneth W wrote:
> can't convince myself that the 2nd argument in schedule_delayed_work
>called from cache_reap() function make any sense:


>static void cache_reap(void *unused)
>{ ...
>schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC + 
smp_processor_id());
>
> Suppose one have a lucky 1024-processor big iron numa box,
> cpu0 will do cache_reap every 2 sec (REAPTIMEOUT_CPUC = 2*HZ).
> cpu512 will do cache_reap every 4 sec,
> cpu1023 will do cache_reap every 6 sec.
>
> Is the skew intentional on different CPU?  Why different interval for
> different cpu#?

It looks like a buggy attempt to make the timers not cluster.
The +smp_processor_id() should be probably only done on the first iteration.
start_cpu_timer() does this already, so removing it should be ok.

-Andi
