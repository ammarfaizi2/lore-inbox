Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbULBQOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbULBQOQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 11:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbULBQK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 11:10:56 -0500
Received: from webapps.arcom.com ([194.200.159.168]:16392 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S261686AbULBQFl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 11:05:41 -0500
Message-ID: <41AF3D50.4090707@arcom.com>
Date: Thu, 02 Dec 2004 16:05:36 +0000
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Jiffy based timers/timeouts can expire too soon.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Dec 2004 16:07:31.0531 (UTC) FILETIME=[0726A9B0:01C4D889]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jiffy based timers and timeouts can expire too soon because the timer 
interrupt accounts for lost ticks and can increment jiffies by more than 1.

Consider the following:

     unsigned long timeout = jiffies + 1;

    <--- timer interrupt here:
         jiffies += 2 (i.e., catching up one missed interrupt)

    if (time_after(jiffies, timeout))
	/* but 1 tick worth of time hasn't (necessarily) elapsed */

This was originally observed on an ARM platform[1] but the i386 timer 
interrupt appears to behave in a similar way.

Is this solution here to:

1. Not use jiffies for timers/timeouts with only a few ticks?

or

2. Have two independant "jiffies": the existing one which is used for 
the wallclock only; and one which counts the number of timer interrupts 
and will guarantee that timers don't expire prematurely?

or

3. Something else?

David Vrabel

[1] 
http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2004-December/025695.html
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
