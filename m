Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVDLVCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVDLVCN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbVDLUme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:42:34 -0400
Received: from fmr20.intel.com ([134.134.136.19]:45195 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262171AbVDLTfj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 15:35:39 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: FUSYN and RT
Date: Tue, 12 Apr 2005 12:35:17 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A02FD4330@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FUSYN and RT
Thread-Index: AcU/i457ydIt7K1ZRSOEYEH4uCGbuAACVf+A
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: <dwalker@mvista.com>, <linux-kernel@vger.kernel.org>
Cc: <mingo@elte.hu>
X-OriginalArrivalTime: 12 Apr 2005 19:35:19.0187 (UTC) FILETIME=[C2913E30:01C53F96]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Daniel Walker [mailto:dwalker@mvista.com]
>
>I just wanted to discuss the problem a little more. From all the
>conversations that I've had it seem that everyone is worried about
>having PI in Fusyn, and PI in the RT mutex.

It sure is overlapping functionalities.

> ...
>The RT mutex will never lower a tasks priority lower than the priority
>given to it by locking a Fusyn lock.
>
>At least, both mutexes will need to use the same API to raise and lower
>priorities.

This would be step one. This would also mean they'd need to share
some data structures to protect transitivity (like when you own
more than one mutex that is PI or PP).

>The next question is deadlocks. Because one mutex is only in the
kernel,
>and the other is only in user space, it seems that deadlocks will only
>occur when a process holds locks that are all the same type.

Actually, I think it would occur in both cases. It all boils down 
at the end to locks in the kernel. Some of them are not visible to 
user space, some are (and with those we implement mutexes):

Task B owns FUSYN-MUTEX 2
Task A owns RT-MUTEX 1
Task B is waiting for RT-MUTEX 1
TASK A wants to wait for FUSYN-MUTEX 2
[deadlock]

[replace at will RT for FUSYN, FUSYN for RT, both, it doesn't
matter, the problem stays the same].

In any case, if let's say we have both implementations coexisting, 
then verifying deadlock becomes a daunting tasks, because there
are two lists of ownerships that we have to verify: the chain 
becomes a graph.

Whatever happens at the end: the kernel implementation needs to
be only one. Whichever (I particularly don't care, although I'd
like to see fusyns take it, I think they are able). The one that
exposes user space mutexes has to be built on top of that. And
exposing to user space is the toughest task (unless you don't
care about the fast-path).

-- Inaky
