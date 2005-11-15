Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbVKOOhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbVKOOhV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 09:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbVKOOhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 09:37:21 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:27030 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751429AbVKOOhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 09:37:20 -0500
Message-ID: <4379F29D.3090306@watson.ibm.com>
Date: Tue, 15 Nov 2005 09:37:17 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
References: <20051114212341.724084000@sergelap> <20051114153649.75e265e7.pj@sgi.com> <20051115010155.GA3792@IBM-BWN8ZTBWAO1> <20051114175140.06c5493a.pj@sgi.com> <20051115022931.GB6343@sergelap.austin.ibm.com> <20051114193715.1dd80786.pj@sgi.com> <20051115051501.GA3252@IBM-BWN8ZTBWAO1> <20051114223513.3145db39.pj@sgi.com> <20051115081100.GA2488@IBM-BWN8ZTBWAO1> <20051115010624.2ca9237d.pj@sgi.com> <20051115133222.GA2232@IBM-BWN8ZTBWAO1>
In-Reply-To: <20051115133222.GA2232@IBM-BWN8ZTBWAO1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn wrote:
> Quoting Paul Jackson (pj@sgi.com):
> 

There have been a few suggestions going fro and back.
Let me address them all at once.

(A) why a vpid?

For transparent checkpointing. Vserver for instance has not implemented
a checkpoint/restart yet, because without this concept it is not possible.
The moment you want transparent checkpoint, you need to deal with the fact
that the results of a getpid() are in register (worst case) and upon
restart the system must provide the same pid on the different machine.
That immediately suggest pid range reservation... but see point (B) below.

(B) syscall interception and LD_PRELOAD:

In principle that is possible, but it leads to potentially inefficient code
and at large leaves the issue of pid space creation and migration on the table.
However it makes clear that as long as I keep the transformation or mappings
consistent between virtual and real, that this is a quite useful concept.

The question now is how deep into the kernel do I have to drive it in order to
create an efficient implementation.

(C) Fixed PID range allocation:

That is completely unscalable and unnecessary:

First PID range allocation at a global level (e.g. cluster level) requires some agent.
Given that PID_MAX ~ 2**22 leaves us on 32-bit architectures with only 512 pidspaces (negative
range needs to be preserved I think).
However it is not unreasonable to assume that 512 different pidspaces per OS image is not
a restriction.
Hence, when a pidspace is migrated it will be assigned a different pidspace id.
Then going with   kernelpid =  (pidspace_id << 22) | vpid is an efficient means to
map between virtual pidspace and physical pidspace and vice versa.
All that needs to be managed is local pidspace allocation.
The translations from vpid <-> pid are very light weight as can be seen from the above
composition.

Take for example the vserver system. A local vserver agent could maintain the
pidspace allocation. On creation of a vserver it assigns the next available pidspace.
That pidspace id is internal to vserver and is not exported as a property of a vserver.
When a vserver is migrated to a different machine, a potentially different pidspace
is allocate, yet all the vpids remain the same.

(D) Cross compilation

I do all stuff on s390 so that space is covered.

If I missed some of the issues that were raised let me know and we will try to address
those.

I am part of Serge's team and have been working on intercepting the various places
where virtual to real pid translations have to occur in the kernel.
It's still in pretty bad shape, but it boots for the default pid space (:- ).
Of my head I say there are about 40 places each to do the translation.
Many are in the /proc/fs, some in the signal handling

I hope by end of the week I have something to post that gives idea how we are thinking
this could be realized.
