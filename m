Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265825AbUFSFUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbUFSFUy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 01:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUFSFUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 01:20:54 -0400
Received: from mail017.syd.optusnet.com.au ([211.29.132.168]:12255 "EHLO
	mail017.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265825AbUFSFUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 01:20:52 -0400
Message-ID: <40D3CD2D.5040004@kolivas.org>
Date: Sat, 19 Jun 2004 15:20:45 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7a (X11/20040614)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-ck1
References: <200406162122.51430.kernel@kolivas.org> <1087576093.2057.1.camel@teapot.felipe-alfaro.com> <200406191348.57383.kernel@kolivas.org>
In-Reply-To: <200406191348.57383.kernel@kolivas.org>
Content-Type: multipart/mixed;
 boundary="------------000202020801010502030104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000202020801010502030104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Con Kolivas wrote:
> On Sat, 19 Jun 2004 02:28, Felipe Alfaro Solana wrote:
> 
>>On Wed, 2004-06-16 at 21:22 +1000, Con Kolivas wrote:
>>
>>>-----BEGIN PGP SIGNED MESSAGE-----
>>>Hash: SHA1
>>>
>>>Patchset update. The focus of this patchset is on system responsiveness
>>>with emphasis on desktops, but the scope of scheduler changes now makes
>>>this patch suitable to servers as well.
>>
>>I've found some interaction problems between, what I think it's, the
>>staircase scheduler and swsusp. With vanilla 2.6.7, swsusp is able to
>>save ~9000 pages to disk in less than 5 seconds, where as 2.6.7-ck1
>>takes more than 1 minute to save the same amount of pages when
>>suspending to disk.
> 
> 
> If you're using -ck1 it may even be the autoswappiness. Try disabling that and 
> setting a static value for swappiness. If it still exhibits the problem then 
> it's probably a bug somewhere in staircase. While the overall design is 
> finished (it doesn't really lend itself to tuning), surely there are bugs I 
> haven't sorted out even though there are no serious bugs or stability issues 
> that have come up. I'm auditing the code as we speak.

You might want to try the attached patch which addresses an issue with 
kernel threads that is going into staircase 7.1

Con

--------------000202020801010502030104
Content-Type: text/x-troff-man;
 name="from-2.6.7-ck1_to_staircase7.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="from-2.6.7-ck1_to_staircase7.1"

--- linux-2.6.7-ck2pre/kernel/sched.c	2004-06-19 15:12:15.280924354 +1000
+++ linux-2.6.7-ck1/kernel/sched.c	2004-06-19 14:58:08.000000000 +1000
@@ -334,8 +334,7 @@ static int effective_prio(task_t *p)
 
 	if (used_slice < first_slice)
 		return prio;
-	if (p->mm)
-		prio += 1 + (used_slice - first_slice) / rr;
+	prio += 1 + (used_slice - first_slice) / rr;
 	if (prio > MAX_PRIO - 2)
 		prio = MAX_PRIO - 2;
 	return prio;

--------------000202020801010502030104--
