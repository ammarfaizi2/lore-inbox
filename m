Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUIMAq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUIMAq3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 20:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbUIMAq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 20:46:29 -0400
Received: from fmr05.intel.com ([134.134.136.6]:8913 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S264668AbUIMAqR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 20:46:17 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Yielding processor resources during lock contention
Date: Sun, 12 Sep 2004 17:45:50 -0700
Message-ID: <7F740D512C7C1046AB53446D372001730232E115@scsmsx402.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Yielding processor resources during lock contention
Thread-Index: AcSYhtQ6GOpPNOQMTXW3u7umxEsRzQAoffTg
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Linus Torvalds" <torvalds@osdl.org>,
       "Zwane Mwaikambo" <zwane@fsmlabs.com>
Cc: "Paul Mackerras" <paulus@samba.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Anton Blanchard" <anton@samba.org>,
       "Andi Kleen" <ak@suse.de>, "Ingo Molnar" <mingo@elte.hu>
X-OriginalArrivalTime: 13 Sep 2004 00:45:51.0346 (UTC) FILETIME=[04A01520:01C4992B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Linus Torvalds [mailto:torvalds@osdl.org]
>Sent: Saturday, September 11, 2004 10:10 PM
>To: Zwane Mwaikambo
>Cc: Paul Mackerras; Linux Kernel; Andrew Morton; Anton Blanchard;
Nakajima,
>Jun; Andi Kleen; Ingo Molnar
>Subject: Re: [PATCH] Yielding processor resources during lock
contention
>
>
>
>On Sun, 12 Sep 2004, Zwane Mwaikambo wrote:
>>
>> On i386 processors with PNI this is achieved by using the
>> monitor/mwait opcodes to halt the processor until a write to the lock
is
>> done.
>
>I'd seriously suggest you ask Intel for an official opinion on this.
Last
>I heard (and that was, I believe, before monitor/mwait had been
officially
>announced, so it's certainly a bit dated now) it wasn't architecturally
>clear that it's a good idea using it for things like spinlocks.
>
>In particular, if the CPU idly waits for a cacheline to be dirtied, it
is
>entirely possible that the other CPU that owns the lock and releases it
>won't actually _tell_ the world that the lock has been released for
quite
>some time. After all, why should it - if it is the exclusive owner, and
it
>sees no memory traffic on the bus, it may have no reason to push out
the
>fact that it just released the lock. Just keep it dirty in its caches.
>
>In other words: monitor/mwait on purpose obviously causes fewer bus
>cycles. But that very fact may well mean (at least in theory) that you
get
>very high latencies. It could make spinlock contention very very unfair
>(the original CPU keeps getting the lock over and over again, while the
>monitor/mwait one never gets to play), and it might also make ping-pong
>locking latency be extremely high.
>
This is my personal comment, but the current monitor/mwait
implementation on Prescott is not proper for things like spinlock
because high latency. At this point, the idle loop in the kernel is one
of the intended usage models under that implementation. In the future,
the latency may be lowered, and we'll revisit spinlocks using
monitor/mwait in that case.

Jun

<snip>
>			Linus
