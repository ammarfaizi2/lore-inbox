Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbTE1OMw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 10:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264744AbTE1OMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 10:12:52 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:29435 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S262623AbTE1OMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 10:12:45 -0400
Message-ID: <3ED4C6B6.7050806@wipro.com>
Date: Wed, 28 May 2003 19:54:54 +0530
From: Arvind Kandhare <arvind.kan@wipro.com>
Reply-To: arvind.kan@wipro.com
Organization: Wipro Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: "indou.takao" <indou.takao@jp.fujitsu.com>, rml <rml@tech9.net>,
       Dave Jones <davej@suse.de>, manfreds <manfreds@colorfullife.com>
Subject: Re: Changing SEMVMX to a tunable parameter
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2003 14:25:47.0986 (UTC) FILETIME=[084E1B20:01C32525]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >>How?
 > > SEMVMX is right now 32k, because the value is stored in an signed
 > > short,
 > > both internally and in the SuSv2 ABI.


semval is a part of struct sem and it is an integer as of now (2.5.69).
That is, it doesn't comply with SuS v3 as far as data type is concerned.

SuS v3 specifies semval to be an unsigned short.i.e. we can have a 
maximum of 64K on this.

Irrespective of the maximum value, an option to tune this limit would be
highly desirable.


 > >
 > > Do you have an application that needs larger values?


One example:
Oracle installation for some specific purposes
(ref: http://www.cs.ndsu.nodak.edu/~vshi/cs366/OracleIns.pdf)

Will require this value to be tuned. As of now it requires a kernel
re-build.

SEMVMX is one among the list of proposed tunable parameters we are
planning to implement.These when implemented, will allow Linux OS to be 
used for high end severs without kernel re-build.


 > >What about other unices? Which value to they have for SEMVMX?


Solaris, HP-Ux etc have this as a tunable parameter with maximum value 
as 64K.

Please refer ::
http://docs.sun.com/db/doc/816-7137/6md5pauj6?q=Tunable+parameters&a=view

PS: Kindly let us know your opinion on the design strategy (ref: 
previous mail appended).

Thanks and regards,
Arvind

Previous mail :::
Hi,

The following query is posted on LKML. Your valuable comments shall be 
highly appreciated.

 From now on I'll CC such discussions to you when I mail LKML.

Thanks in advance,
Arvind


We are planning to implement a set of Kernel Tunable Parameters and one
of these paramters is semvmx for IPC semaphores.

The existing SEMVMX is hash defined as 32768. We intend to make this a
tunable parameter.

Two alternatives are considered for making this limit tunable as 
explained below.

A) Dynamically Tunable using /proc/sys interface.

Proposed implementation is to replace the hash defined SEMVMX in 
try_atomic_semop (), semctl_main () and semctl_nolock () by the 
configurable value.

This check returns -ERANGE if the current value of semaphore is more 
than semvmx limit. *but* there are some logical inconsistancies if 
semvmx limit is dynamically reduced below the value of the semaphore 
(semval). They are :

1.   Releasing the semaphore may fail whereas acquiring has gone
     through.This is due to the existing check of semval against the 
limit in try_atomic_semop ().


2.  Acquiring a semaphore may fail even if the semval > 0:
       If the resultant semaphore value (semval) after an acquire stays 
above the limit,the check and hence acquire operation fails.


To Overcome these problems following approaches may be considered:

1. Apply the check against the tuned limit only in semctl_main () call. 
If semctl and semop can be used interchangably to change the value of 
the semaphore this approach will not work.

2. Apply check only when +ve semop is done. So acquiring and 
decrementing the value will never fail. This approach solves the second 
inconsistency but first one will prevail.

3. Retain similar/same checks against the tuned limit and return an 
error to the caller on any inconsistancy (as mentioned in points 1 & 2 
above).


A cleaner solution would be:

B) Statically Tunable using boot time parameter:

Most important problem with dynamic tuneability is on a possible 
reduction of the limit when the system runs.Most of these could be 
avoided if sysadmin is not permitted to modify this limit 
dynamically.For this we can make this a static parameter.

A frame work for static tuning of parameters is not directly supported 
in Linux.

We propose to make it a boot time tuneable (with boot time command line 
interface). This limit can be viewed through /proc/sys interface as a 
read only parameter.

Though we loose slightly on flexibility to change this value (possible 
only at boot time), we gain on better run-time consistancies with a 
static implementation.

Please let us know your suggestions on above alternatives.

Note: We are planning to implement SEMAEM also as a tuneable parameter. 
A conclusion on above shall be considered while designing the same also.

Thanks and regards,
Arvind






