Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264433AbTIIT6R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbTIIT6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:58:16 -0400
Received: from law10-oe63.law10.hotmail.com ([64.4.14.198]:4107 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264433AbTIIT52
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:57:28 -0400
X-Originating-IP: [208.48.228.132]
X-Originating-Email: [jyau_kernel_dev@hotmail.com]
From: "John Yau" <jyau_kernel_dev@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Priority Inversion in Scheduling
Date: Tue, 9 Sep 2003 15:57:18 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <LAW10-OE63Zc1WPsAVe0000ab93@hotmail.com>
X-OriginalArrivalTime: 09 Sep 2003 19:57:26.0400 (UTC) FILETIME=[97A52000:01C3770C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I've noticed some very interesting priority inversion scenarios in the test4
scheduling.

For example let's say you have task dumps-a-lot, which is a CPU hog and
dumps a lot of data to stdout and task interactive/real-time (e.g. xmms,
Emacs, Mozilla).  When stdout of dumps-a-lot is directed to a terminal under
X, X's priority is demoted to 25, because X spends a lot of time rendering
data from dumps-a-lot.  In the mean while, because dumps-a-lot is not
actually doing much because it's sleeping quite a lot, it's priority is at
15-17 or so and continues to flood X whenever it gets a chance to.  This
leaves the interactive/real-time, who's priorities are at 15-17 as well have
an effective priority of 25 because they have to wait for X to service them,
thus making them feel not so interactive anymore to the user.  When the
stdout of dumps-a-lot is pointed to /dev/null, interactive/real-time
responds just fine.

To get around scenarios such as this and priority inversions in general, I
propose to have some sort of priority inheritance mechanism in futex and the
scheduler.  If a task is blocked by something of lower priority, the higher
priority task "donates" its time to the lower priority task in hopes of
resolving the block.  The time is charged to the higher priority task in
this situation so that it cannot do this forever without being penalized.
This way in the above scenario dumps-a-lot gets penalized for being a CPU
hog and interactive/real-time stays interactive though they get penalized
too.

I'd like some feedback on the above proposal, especially from folks working
heavily on the scheduler.  If the consensus is that it'd be worthwhile to
have such a mechanism, I'll go ahead and code a patch.  I haven't had a
chance to look at code outside of Linus' branch in detail, so Nick, Con,
Ingo, or Andrew have already dealt with this, let me know and point me to
the code.


John Yau
