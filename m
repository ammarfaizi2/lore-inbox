Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbTLPTFG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 14:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTLPTFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 14:05:06 -0500
Received: from fmr06.intel.com ([134.134.136.7]:13202 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262078AbTLPTE6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 14:04:58 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [CFT][RFC] HT scheduler
Date: Tue, 16 Dec 2003 11:03:59 -0800
Message-ID: <7F740D512C7C1046AB53446D372001736187C2@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [CFT][RFC] HT scheduler
Thread-Index: AcPEApxoHxCwAhbYTjiiU1nJRAI6TAAA7N+w
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Linus Torvalds" <torvalds@osdl.org>, "Jamie Lokier" <jamie@shareable.org>
Cc: "Nick Piggin" <piggin@cyberone.com.au>, "bill davidsen" <davidsen@tmr.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Dec 2003 19:04:01.0330 (UTC) FILETIME=[5DC1C120:01C3C407]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Regarding the overhead of the shared runqueue lock:
> >
> > Is the "lock" prefix actually required for locking between x86
> > siblings which share the same L1 cache?
> 
> I bet it is. In a big way.

Of course it is.

> 
> The lock does two independent things:
>  - it tells the core that it can't just crack up the load and store.
>  - it also tells other memory ops that they can't re-order around it.
> 
> Neither of these have anything to do with the L1 cache.
> 
> In short, I'd be very very surprised if you didn't need a "lock"
prefix
> even between hyperthreaded cores. It might be true in some specific
> implementation of HT, but quite frankly I'd doubt it, and I'd be
willing
> to guarantee that Intel would never make that architectural even if it
was
> true today (ie it would then break on future versions).

Correct. If such a code happens to be working today, it would be broken
anytime.


> 
> It should be easy enough to test in user space.
> 
> [ Time passes ]
> 
> Done. Check this program out with and without the "lock ;" prefix.
With
> the "lock" it will run forever on a HT CPU. Without the lock, it will
show
> errors pretty much immediately when the two threads start accessing
"nr"
> concurrently.
> 
> 		Linus
> 
> ----
> #include <pthread.h>
> #include <signal.h>
> #include <unistd.h>
> #include <stdio.h>
> 
> unsigned long nr;
> 
> #define LOCK "lock ;"
> 
> void * check_bit(int bit)
> {
> 	int set, reset;
> 	do {
> 		asm(LOCK "btsl %1,%2; sbbl %0,%0": "=r" (set): "r"
(bit), "m"
> (nr):"memory");
> 		asm(LOCK "btcl %1,%2; sbbl %0,%0": "=r" (reset): "r"
(bit),
> "m" (nr):"memory");
> 	} while (reset && !set);
> 	fprintf(stderr, "bit %d: %d %d (%08x)\n", bit, set, reset, nr);
> 	return NULL;
> }
> 
> static void * thread1(void* dummy)
> {
> 	return check_bit(0);
> }
> 
> static void * thread2(void *dummy)
> {
> 	return check_bit(1);
> }
> 
> int main(int argc, char ** argv)
> {
> 	pthread_t p;
> 
> 	pthread_create(&p, NULL, thread1, NULL);
> 	sleep(1);
> 	thread2(NULL);
> 	return 1;
> }
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
