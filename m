Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVDKXa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVDKXa2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 19:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVDKXa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 19:30:28 -0400
Received: from fmr17.intel.com ([134.134.136.16]:458 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261988AbVDKXaQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 19:30:16 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Priority Lists for the RT mutex
Date: Mon, 11 Apr 2005 16:28:25 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A02FA3BFF@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Priority Lists for the RT mutex
Thread-Index: AcU+68Wg31QasG0JQZGwayGqVb4RRAAARUjg
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Bill Huey \(hui\)" <bhuey@lnxw.com>
Cc: "Ingo Molnar" <mingo@elte.hu>,
       "Sven-Thorsten Dietrich" <sdietrich@mvista.com>,
       "Daniel Walker" <dwalker@mvista.com>, <linux-kernel@vger.kernel.org>,
       "Steven Rostedt" <rostedt@goodmis.org>,
       "Esben Nielsen" <simlo@phys.au.dk>, "Joe Korty" <joe.korty@ccur.com>
X-OriginalArrivalTime: 11 Apr 2005 23:28:23.0656 (UTC) FILETIME=[278C1E80:01C53EEE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Bill Huey (hui) [mailto:bhuey@lnxw.com]
>On Mon, Apr 11, 2005 at 03:31:41PM -0700, Perez-Gonzalez, Inaky wrote:
>> If you are exposing the kernel locks to userspace to implement
>> mutexes (eg POSIX mutexes), deadlock checking is a feature you want
>> to have to complain with POSIX. According to some off the record
>> requirements I've been given, some applications badly need it (I have
>> a hard time believing that they are so broken, but heck...).
>
>I'd like to read about those requirements, but, IMO a lot of the value

More than a formal requirement is a "practical" one. Some
company (leader in their field, of course) has this huge
blobl of code they want to use in Linux and it has the typical
API than once upon a time was made multithreaded by just adding
a bunch of pthread_mutex_[un]lock() at the API entry point...
without realizing that some of the top level API calls also 
called other top level API calls, so they'd deadlock.

Quick fix: the usual. Enable deadlock detection and if it
returns deadlock, assume it is locked already and proceed (or
do a recursive mutex, or a trylock).

And so on, and so forth...

>of various priority protocols varies greatly on the context and size (N
>threads) of the application using it. If user/kernel space have to be
>coupled via some thread of execution, (IMO) then it's better to
seperate
>them with some event notification queues like signals (wake a thread
>via an queue event) than to mix locks across the user/kernel space
> ...

I wonder if we are confusing apples and oranges here--I don't think
we were considering cases about mixing kernel locks that are accessible
both from kernel and user space. 

The focus is to have a kernel lock entity and that user space can
use it for implementing the user space mutexes, but *not* mix
them (like in user and kernel space sharing this lock for doing 
whatever).

It is certainly something to explore, but I'd better drive your
way than do it. It's cleaner. Hides implementation details.

>It's important to outline the requirements of the applications and then
>see what you can do using minimal synchronization objects before
>exploding that divide.

I agree, but it doesn't work that well when talking about legacy 
systems...that's the problem.

>Also, Posix isn't always politically neutral nor complete regarding
>various things. You have to consider the context of these things.
>I'll have to think about this a bit more and review your patch more
>carefully.

Sure--and because most was for legacy reasons that adhered to 
POSIX strictly, it was very simple: we need POSIX this, that and
that (PI, proper adherence to scheduler policy wake up/rt-behaviour,
deadlock detection, etc). 

Fortunately in those areas POSIX is not too gray; code to the book.
Deal. 

Of course, selling it to the lkml is another story.

-- Inaky
