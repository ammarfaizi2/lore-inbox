Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264753AbTFAWoh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 18:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264755AbTFAWoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 18:44:37 -0400
Received: from cs.columbia.edu ([128.59.16.20]:29093 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id S264753AbTFAWof convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 18:44:35 -0400
From: Gong Su <gongsu@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.x block device driver question
Date: Sun, 01 Jun 2003 18:54:56 -0400
Organization: CS Dept., Columbia Univ.
Message-ID: <5sukdv4jvcd417f7chvla92je3su1le1r8@4ax.com>
X-Mailer: Forte Agent 1.93/32.576 English (American)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[please cc: me as not subscribed to list]

I was trying to see how __make_request throttles a fast writing process
from overrunning a slow device. So I took Alessandro Rubini's spull.c
code from his device driver book (2nd edition) and ran it in "pseudo irq"
mode. What the driver does basically is to schedule an alarm in its
request service function (spull_irqdriven_request) and return immediately
without calling end_request. And when the alarm fires it finishes the IO
by calling end_request(1). I made the following change to the driver:

1. make the ram disk size infinite by setting blk_size[MAJOR_NR]=NULL.
2. disable the actual copying to/from the ram disk by commenting out
   spull_transfer in the spull_irqdriven_request function.

I load the driver with a 3 second delay for the alarm. So basically, the
driver simulates a "very slow" device that takes 3 seconds to service
each request (without actually doing anything). Now I do:

dd if=/dev/zero of=/dev/pda bs=1024 count=1000000

What I expect is that the kernel will quickly stop dd after all 128 (64
on machines with less than 32MB of ram) free request slots are taken.
Of course it will take forever for dd to finish. But what happened is
that the system quickly becomes unusable. It still handles a request
every 3 seconds but is otherwise oblivious of any input (I can still
switch virtual console but that's it). Is this the expected behavior of
2.4 or am I just doing something stupid? Your insight will be highly
appreciated. Thanks in advance.

-- 
/Gong
