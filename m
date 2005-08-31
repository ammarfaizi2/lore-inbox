Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbVHaWQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbVHaWQb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 18:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbVHaWQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 18:16:31 -0400
Received: from fmr20.intel.com ([134.134.136.19]:7056 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S964932AbVHaWQ3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 18:16:29 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: FW: [RFC] A more general timeout specification
Date: Wed, 31 Aug 2005 15:15:12 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A042B0192@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW: [RFC] A more general timeout specification
Thread-Index: AcWueNkkAo57MBRtQT2PlWHMlHBaLAAAB5ow
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Roman Zippel" <zippel@linux-m68k.org>
Cc: <akpm@osdl.org>, <joe.korty@ccur.com>, <george@mvista.com>,
       <johnstul@us.ibm.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 31 Aug 2005 22:15:34.0054 (UTC) FILETIME=[81B84460:01C5AE79]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Roman Zippel [mailto:zippel@linux-m68k.org]
>On Wed, 31 Aug 2005, Perez-Gonzalez, Inaky wrote:
>
>> +	flags = tp->clock_id & TIMEOUT_FLAGS_MASK;
>> +	clock_id = tp->clock_id & TIMEOUT_CLOCK_MASK;
>> +
>> +	result = -EINVAL;
>> +	if (flags & ~TIMEOUT_RELATIVE)
>> +	    goto out;
>> +
>> +	/* someday, we should support *all* clocks available to us */
>> +	if (clock_id != CLOCK_REALTIME && clock_id != CLOCK_MONOTONIC)
>> +		goto out;
>> +	if ((unsigned long)tp->ts.tv_nsec >= NSEC_PER_SEC)
>> +		goto out;
>
>Why is that needed in a _general_ timeout API? What exactly makes it so
>useful for everyone and not just more complex for everyone?

Because if a system call gets a timeout specification it needs to
verify its correctness first. Instead of doing that at the point
where it goes to sleep, that could be deep in an atomic section,
we provide a separate function [timeout_validate()] which is the
one you mention, to do that.

Usefulness: (see the rationale in the patch), but in a nutshell;
most POSIX timeout specs have to be absolute in CLOCK_REALTIME
(eg: pthread_mutex_timed_lock()). Current kernel needs the timeout
relative, so glibc calls the kernel/however gets the time, computes
relative times and syscalls. Race conditions, overhead...etc. 

This mechanism supports both. That's why it is more general.

-- Inaky
