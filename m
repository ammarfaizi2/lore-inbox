Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbULJWXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbULJWXZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 17:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbULJWWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 17:22:07 -0500
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:39049 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261846AbULJWUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 17:20:54 -0500
Message-ID: <41BA2131.4040608@kolivas.org>
Date: Sat, 11 Dec 2004 09:20:33 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: linux <linux-kernel@vger.kernel.org>
Subject: time slice cfq comments
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens

Just thought I'd make a few comments about some of the code in your time 
sliced cfq.

+	if (p->array)
+		return min(cpu_curr(task_cpu(p))->time_slice,
+					(unsigned int)MAX_SLEEP_AVG);

MAX_SLEEP_AVG is basically 10 * the average time_slice so this will 
always return task_cpu(p)->time_slice as the min value (except for the 
race you described in your comments). What you probably want is

+		return min(cpu_curr(task_cpu(p))->time_slice,
+					(unsigned int)DEF_TIMESLICE);


Further down you do:
+	/*
+	 * for blocked tasks, return half of the average sleep time.
+	 * (because this is the average sleep-time we'll see if we
+	 * sample the period randomly.)
+	 */
+	return NS_TO_JIFFIES(p->sleep_avg) / 2;

unfortunately p->sleep_avg is a non-linear value (weighted upwards 
towards MAX_SLEEP_AVG). I suspect here you want

+	return NS_TO_JIFFIES(p->sleep_avg) / MAX_BONUS;

I don't see any need for / 2.

Cheers,
Con
