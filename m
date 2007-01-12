Return-Path: <linux-kernel-owner+w=401wt.eu-S1161151AbXALXZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161151AbXALXZS (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 18:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161156AbXALXZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 18:25:18 -0500
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:14108 "EHLO
	mis011-1.exch011.intermedia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161151AbXALXZQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 18:25:16 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [kvm-devel] kvm & dyntick
Date: Fri, 12 Jan 2007 15:25:14 -0800
Message-ID: <64F9B87B6B770947A9F8391472E0321609F7A0E2@ehost011-8.exch011.intermedia.net>
In-Reply-To: <20070112101931.GA11635@elte.hu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [kvm-devel] kvm & dyntick
Thread-Index: Acc2OJQMDvcEO5ZvR+S0EUsPiWlbHAAZt3Gw
References: <45A66106.5030608@qumranet.com> <20070112062006.GA32714@elte.hu> <20070112101931.GA11635@elte.hu>
From: "Dor Laor" <dor.laor@qumranet.com>
To: "Ingo Molnar" <mingo@elte.hu>, "Avi Kivity" <avik@qumranet.com>
Cc: "kvm-devel" <kvm-devel@lists.sourceforge.net>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Jan 2007 23:25:16.0342 (UTC) FILETIME=[EAB00560:01C736A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>* Ingo Molnar <mingo@elte.hu> wrote:
>
>> > dyntick-enabled guest:
>> > - reduce the load on the host when the guest is idling
>> >   (currently an idle guest consumes a few percent cpu)
>>
>> yeah. KVM under -rt already works with dynticks enabled on both the
>> host and the guest. (but it's more optimal to use a dedicated
>> hypercall to set the next guest-interrupt)
>
>using the dynticks code from the -rt kernel makes the overhead of an
>idle guest go down by a factor of 10-15:
>
>  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
> 2556 mingo     15   0  598m 159m 157m R  1.5  8.0   0:26.20 qemu
>
>( for this to work on my system i have added a 'hyper' clocksource
>  hypercall API for KVM guests to use - this is needed instead of the
>  running-to-slowly TSC. )
>
>	Ingo

This is great news for PV guests.

Never-the-less we still need to improve our full virtualized guest
support. 
First we need a mechanism (can we use the timeout_granularity?) to
dynamically change the host timer frequency so we can support guests
with 100hz that dynamically change their freq to 1000hz and back.

Afterwards we'll need to compensate the lost alarm signals to the guests
by using one of 
 - hrtimers to inject the lost interrupts for specific guests. The
problem this will increase the overall load.
 - Injecting several virtual irq to the guests one after another (using
interrupt window exit). The question is how the guest will be effected
from this unfair behavior.

Can dyntick help HVMs? Will the answer be the same for guest-dense
hosts? I understood that the main gain of dyn-tick is for idle time.
