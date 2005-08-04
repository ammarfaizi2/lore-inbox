Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVHDBJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVHDBJv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 21:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVHDBH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 21:07:56 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:30373 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261736AbVHDBGT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 21:06:19 -0400
Date: Wed, 3 Aug 2005 18:06:17 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: HZ==250 and rounding issues?
Message-ID: <20050804010617.GD4255@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

While discussing milliseconds and jiffies and their inter-relations with
Roman Zippel in a separate thread, I came across an interesting and
perhaps problematic rounding issue with directly using HZ when HZ==250.

Consider requesting a 10 millisecond sleep, in jiffies. This is
accomplished via HZ/100, as there are HZ jiffies in a second and, thus,
1/100th of HZ should be 10 milliseconds in jiffies (this is the common
interpretation, I think, and the flaw may simply lie in the
interpretation). But, if HZ==250, then HZ/100 = 2 (integer division with
truncation), which when translated to milliseconds, is 8 ms (250
interrupts per second means a jiffy is 4 milliseconds in duration).

Now, combine this with the potential corner case (explained in
http://marc.theaimsgroup.com/?l=linux-kernel&m=112311712414431&w=2)
where a schedule_timeout(HZ/100) request occurs immediately before a
timer interrupt occurs. We now might get a 4 millisecond sleep *and*
have schedule_timeout() return 0, indicating falsely that a full 10
millisecond sleep has elapsed.

Could be, though, that my analysis is flawed here too :) Please correct
me if that's the case!

I will try to audit the direct users of HZ; maybe this isn't really a
problem. Just some food for thought.

Thanks,
Nish
