Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266545AbUBFWdh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 17:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266641AbUBFWde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 17:33:34 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:12983 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266545AbUBFWc5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 17:32:57 -0500
Message-Id: <200402062230.i16MU8313429@owlet.beaverton.ibm.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, mjbligh@us.ibm.com,
       dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1 
In-reply-to: Your message of "Sat, 07 Feb 2004 08:57:56 +1100."
             <40240DE4.8030705@cyberone.com.au> 
Date: Fri, 06 Feb 2004 14:30:08 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    We also shouldn't need load_diff, because if (avg_load <= this_load)
    then imbalance will be zero, so I'll fix that up.

Are we sure imbalance will be zero?  I think we still need that.  We can
turn it into a single C statement if we want to be clever but what you
save in temporary variable we'd better replace in comments to make the
cleverness plain.  We need there to be no "negative" numbers in the
min() statement in case max-avg is non-zero but avg-this is "negative".

Imagine loads of

    cpu0	0
    cpu1	0
    cpu2	3 
    cpu3	2
    cpu4	0

and we're running on cpu3.

    max_load=3
    avg_load=1
    this_load=2

min(max-avg, avg-this) will be min(3-1,1-2) or two, and we'll choose to
try to pull two to cpu3 instead of just leaving it alone which is the
right thing to do.

Rick
