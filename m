Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262556AbVDLUpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbVDLUpi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbVDLUp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:45:28 -0400
Received: from fmr17.intel.com ([134.134.136.16]:27352 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262556AbVDLUff convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 16:35:35 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: FUSYN and RT
Date: Tue, 12 Apr 2005 13:35:00 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A02FD4458@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FUSYN and RT
Thread-Index: AcU/nmRSD4cz0l1mTT6d6EqfB0q4SAAACdRA
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Esben Nielsen" <simlo@phys.au.dk>, "Daniel Walker" <dwalker@mvista.com>
Cc: <linux-kernel@vger.kernel.org>, <mingo@elte.hu>
X-OriginalArrivalTime: 12 Apr 2005 20:35:03.0878 (UTC) FILETIME=[1B35AE60:01C53F9F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Esben Nielsen [mailto:simlo@phys.au.dk]
>On 12 Apr 2005, Daniel Walker wrote:
>
>>
>>
>> At least, both mutexes will need to use the same API to raise and
lower
>> priorities.
>
>You basicly need 3 priorities:
>1) Actual: task->prio
>2) Base prio with no RT locks taken: task->static_prio
>3) Base prio with no Fusyn locks taken: task->??
>
>So no, you will not need the same API, at all :-) Fusyn manipulates
>task->static_prio and only task->prio when no RT lock is taken. When
the
>first RT-lock is taken/released it manipulates task->prio only. A
release
>of a Fusyn will manipulate task->static_prio as well as task->prio.

Yes you do. You took care of the simple case. Things get funnier
when you own more than one PI lock, or you need to promote a
task that is blocked on other PI locks whose owners are blocked
on PI locks (transitivity), or when you mix PI and PP (priority
protection/ priority ceiling).

In that case not having a sim{pl,g}e API for doing it is nuts.

>> The next question is deadlocks. Because one mutex is only in the
kernel,
>> and the other is only in user space, it seems that deadlocks will
only
>> occur when a process holds locks that are all the same type.
>
>Yes.
>All these things assumes a clear lock nesting: Fusyns are on the outer
>level, RT locks on the inner level. What happens if there is a bug in
RT
>locking code will be unclear. On the other hand errors in Fusyn locking
>(user space) should not give problems in the kernel.

Wrong. Fusyns are kernel locks that are exposed to user space (much as
a file descriptor is a kernel object exposed to user space through
a system call). Of course if the user does something mean with them
they will cause an error, but should not have undesired consequences
in the kernel. But BUGS in the code will be as unclear as in RT mutexes.

>it is is bad maintainance to have to maintain two seperate systems. The
>best way ought to be to try to only have one PI system. The kernel is
big
>and confusing enough as it is!

Ayeh for the big...it is not that confusing :)

-- Inaky
