Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751753AbVJTFLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbVJTFLr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 01:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbVJTFLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 01:11:47 -0400
Received: from petasus.ims.intel.com ([62.118.80.130]:23766 "EHLO
	petasus.ims.intel.com") by vger.kernel.org with ESMTP
	id S1751753AbVJTFLq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 01:11:46 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: [PATCH 1/1] indirect function calls elimination in IO scheduler
Date: Thu, 20 Oct 2005 09:11:35 +0400
Message-ID: <6694B22B6436BC43B429958787E45498937626@mssmsx402nb>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] indirect function calls elimination in IO scheduler
thread-index: AcXUtP3RpXcBMqjFT06Z5eorJS5sgwAcdnTg
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
X-OriginalArrivalTime: 20 Oct 2005 05:11:40.0208 (UTC) FILETIME=[C0F2CB00:01C5D534]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven writes
> does it really reduce those function calls?

This patch does not delete indirect function calls. It reduces number of
indirection steps or pointers to be followed only. You are right.
I should say:
	The patch eliminates one of indirection steps in 45 function
calls in 16 elevator functions.
A deleting one only indirection step is a good compromise between memory
waste and run time.
	From the very beginning the patch had deleted two additional
steps in indirect function calls and had returned to 2.6.9 stile. Chen
Kenneth proposed to delete only one indirection step and test it:
> Leonid,
> It looks reasonable to me, though your patch significantly increases
the 
> size of request_queue structure.  This in turn increases kernel cache
> footprint since you are embedding entire elevator_ops and
elevator_queue
> inside each and every block layer request queue
> (increased from 712 to 936 bytes).

> Do you have any benchmark result to show that saving pointer
indirection > > is a win over larger memory foot-print for request_queue
structure?
> I don't think it's a win-win case on large system where it might have
> hundreds or more disk queues etc.  But if you have benchmark result,
let
> the data speak for itself.
> - Ken
	A testing with SysBench fileio had shown that there is no
throughput increasing if one more indirection step is deleted. Hardware
is able to win two of three MOV instructions before function call.
	It should be noted that ops structure size is different for
different I/O schedulers. And while imbedding 'ops' structure the
maximal structure size should be used. First 'elevator' structure
embedding only increases wasted memory size by 104 bytes for each disk;
decreases Itanium's kernel object code by 856 bytes and increases
throughput by 2% at least. 
	
Leonid

-----Original Message-----
From: Arjan van de Ven [mailto:arjan@infradead.org] 
Sent: Wednesday, October 19, 2005 5:56 PM
To: Ananiev, Leonid I
Cc: linux-kernel@vger.kernel.org; rdunlap@xenotime.net
Subject: Re: [PATCH 1/1] indirect function calls elimination in IO
scheduler

On Wed, 2005-10-19 at 17:08 +0400, Ananiev, Leonid I wrote:
> >From Leonid Ananiev
> 
>       Fully modular io schedulers and enables online switching between
> them was introduced in Linux 2.6.10 but as a result percentage of CPU
> using by kernel was increased and performance degradation is marked on
> Itanium. A cause of degradation is in more steps for indirect IO
> scheduler type specific function calls.
>       The patch eliminates 45 indirect function calls in 16 elevator
> functions. 

does it really reduce those function calls? I thought it only reduced a
few pointers to be followed, but not the actual indirect function calls!



