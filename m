Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTE0IaD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 04:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTE0IaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 04:30:03 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:17103 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S262771AbTE0IaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 04:30:01 -0400
Message-ID: <3ED324DD.1050806@wipro.com>
Date: Tue, 27 May 2003 14:12:05 +0530
From: Arvind Kandhare <arvind.kan@wipro.com>
Reply-To: arvind.kan@wipro.com
Organization: Wipro Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: indou.takao@jp.fujitsu.com, Arvind Kandhare <arvind.kan@wipro.com>
Subject: Changing SEMVMX to a tuneable parameter.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2003 08:42:57.0482 (UTC) FILETIME=[F8EA8AA0:01C3242B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
	through.This is due to the existing check of semval against the limit in 
try_atomic_semop ().


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



