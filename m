Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268501AbUILG7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268501AbUILG7P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 02:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268502AbUILG7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 02:59:15 -0400
Received: from holomorphy.com ([207.189.100.168]:47491 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268501AbUILG7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 02:59:04 -0400
Date: Sat, 11 Sep 2004 23:58:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, paulus@samba.org, linux-kernel@vger.kernel.org,
       jun.nakajima@intel.com, ak@suse.de, mingo@elte.hu
Subject: Re: [PATCH] Yielding processor resources during lock contention
Message-ID: <20040912065852.GG2660@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, paulus@samba.org,
	linux-kernel@vger.kernel.org, jun.nakajima@intel.com, ak@suse.de,
	mingo@elte.hu
References: <Pine.LNX.4.53.0409091107450.15087@montezuma.fsmlabs.com> <Pine.LNX.4.53.0409120009510.2297@montezuma.fsmlabs.com> <20040911220003.0e9061ad.akpm@osdl.org> <Pine.LNX.4.53.0409120108310.2297@montezuma.fsmlabs.com> <4143D16F.30500@yahoo.com.au> <Pine.LNX.4.53.0409120131000.2297@montezuma.fsmlabs.com> <4143D491.6070006@yahoo.com.au> <Pine.LNX.4.53.0409120146020.2297@montezuma.fsmlabs.com> <4143D855.9070005@yahoo.com.au> <20040912060904.GJ32755@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912060904.GJ32755@krispykreme>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Nick Piggin wrote:
>> OK that sounds alight.
>> If it is a "I'm going to be spinning for ages, so schedule me off *now*"
>> then I think it is wrong... but if it just allows you to keep the hypervisor
>> preemption turned on, then fine.

On Sun, Sep 12, 2004 at 04:09:04PM +1000, Anton Blanchard wrote:
> The hypervisor can preempt us anywhere but we can give it clues so it
> tends to preempt us at better times.
> Within a few instructions the hypervisor should be able to answer the
> big question: is the cpu Im waiting for currently scheduled on another
> cpu. If it is then it might be best for the hypervisor to leave us
> alone.
> If it isnt then the spin time will most likely be dominated by how
> long it takes to get that cpu scheduled again and the hypervisor should
> make an effort to schedule it.

Preemption of a guest holding a busywait-protected resource is
catastrophic, yes. Voluntarily yielding to the host is one of the
few tactics a guest can use, alongside more widespread use of blocking
locking primitives and using host-provided locking primitives.

Gang scheduling in the host is stronger medicine for this, and has the
further advantage that it does not confuse contention with host
preemption. It may be valuable for Linux likewise to implement gang
scheduling to accommodate its own usage as a host, as futexes are only
usable when the guest issues system calls natively (as is the case in
UML; guests in full CPU emulators may not even be executing native
instructions).

I suspect that the optimal configuration would use 2-tier locking in
addition to gang scheduling the guests, where the outer tier busywaits
for some interval before backing off to an inner tier using a host-
provided locking primitive (obviously the host should not suspend the
entire gang when a guest blocks on the host-provided locking primitive).
It's unclear whether some attempt should be made to avoid the host-
provided wakeup portion of the locking primitives. The 2-tier locking
algorithms are still beneficial in the absence of gang scheduling, as
spurious host context switches likely carry a high cost; the backoff
should be arranged so that busywait is only done as long as the
expected cost of a spurious host context switch remains greater than
the expected cost of busywaiting during a host preemption, where in
the presence of gang scheduling the latter cost is merely lock contention
(i.e. gang scheduling allows guests to busywait as long as they expect
the latency of lock acquisition to be smaller than a host context switch,
where the longer one has busywaited the longer one expectes to busywait).

I suppose the first step is to get a hook for the host primitives into
the locking algorithms, so I approve of all this etc.


-- wli
