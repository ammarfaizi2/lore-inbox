Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWA2Flk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWA2Flk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 00:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWA2Flk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 00:41:40 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:32424 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP
	id S1750834AbWA2Flk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 00:41:40 -0500
X-ORBL: [67.39.188.224]
Message-ID: <43DC5587.9010908@gmail.com>
Date: Sat, 28 Jan 2006 23:41:27 -0600
From: Hareesh Nagarajan <hnagar2@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Potentially racy del_timer(&timer);  ... ; add_timer(&timer) sequence
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was going through the kernel sources looking for places where the 
following sequence occurs:
	
	del_timer(&timer);
	... modify timer ...
	add_timer(&timer)

To my surprise, I found numerous place where such code appears. I 
figured this kind of code will always be (potentially) racy on SMP machines.

Examples are:
1. net/lapb/lapb_timer.c

void lapb_start_t1timer(struct lapb_cb *lapb)
{
         del_timer(&lapb->t1timer);

         lapb->t1timer.data     = (unsigned long)lapb;
         lapb->t1timer.function = &lapb_t1timer_expiry;
         lapb->t1timer.expires  = jiffies + lapb->t1;

         add_timer(&lapb->t1timer);
}

mod_timer could have been used.

2. arch/i386/mach-voyager/voyager_thread.c
3. kernel/acct.c

         del_timer(&acct_globals.timer);
         acct_globals.needcheck = 0;
         acct_globals.timer.expires = jiffies + ACCT_TIMEOUT*HZ;
         add_timer(&acct_globals.timer);

Would anyone on LKML interested in getting this cleaned up? I could do 
it, if it would be useful. Or perhaps someone on Kernel Janitors is 
already working on it.

Thanks,

Hareesh Nagarajan
www.cs.uic.edu/~hnagaraj
