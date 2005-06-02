Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVFBBW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVFBBW4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 21:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVFBBW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 21:22:56 -0400
Received: from fmr17.intel.com ([134.134.136.16]:17567 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261532AbVFBBW3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 21:22:29 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Abstracted Priority Inheritance for RT
Date: Wed, 1 Jun 2005 18:21:10 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A036671E4@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Abstracted Priority Inheritance for RT
Thread-Index: AcVnDYSISWuV2uHsT+yGYlu+jZGbAQAAxwVQ
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: <linux@horizon.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Jun 2005 01:22:24.0104 (UTC) FILETIME=[87D6E680:01C56711]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: linux@horizon.com [mailto:linux@horizon.com]
>>> I'm not sure I see how this could become recursive, could you
explain
>>> more?
>?
>> Maybe he is referring to the case?
>>
>> A owns M
>> B owns N and is waiting for M
>> A is trying to wait for N
>
>No, that's just a straight deadlock and a bug whether you have PI oir
not.
>The recursive concern is the following case:

Agreed, it is deadlock (as I said), but it is where your
code can go to infinite recursion if you don't have the safeguards
in. 

Calling it a bug depends on what are the "standards" of your code.
Some people consider it good enough and just expect that if you
get an -EDEADLK it means you have already locked the structure and
can go into the atomic section. 

Not that I agree, but the point is YMMV depending on who is using it
and for how.

>Process priorities: A < B < C < ...
>
>Process A holds lock 1
>Process B holds lock 2 and is trying for lock 1
>Process C holds lock 3 and is trying for lock 2
>Process D holds lock 4 and is trying for lock 3
>
>Now see what happens when high-priority process E tries to
>take lock 4.  We need to push its priority all the way down
>the chain to process A.

Well, this is normal priority propagation to a not-trivial
ownership-wait chain. Or PI transitivity (I think I've heard
it called like this).

>If a process is only allowed to try for one lock at a time, that could,
>in theory, be done iteratively, but it might take some care.

It can be done iteratively in all cases (at least the fusyn code
does). 

>Actually, the tricky part of priority inheritance implementation is
>usually dropping the priority properly when locks are released.

No if you stack the priorities (again, look at the fusyn code,
or better at the OLS paper, don't have time to give the full
rundown again). Then it becomes a very simple matter of popping 
the first item in your priority stack. 

-- Inaky
