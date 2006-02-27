Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWB0Lkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWB0Lkd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 06:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWB0Lkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 06:40:33 -0500
Received: from seldon.control.lth.se ([130.235.83.40]:49884 "EHLO
	seldon.control.lth.se") by vger.kernel.org with ESMTP
	id S1750754AbWB0Lkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 06:40:33 -0500
Message-ID: <4402E52F.6080409@control.lth.se>
Date: Mon, 27 Feb 2006 12:40:31 +0100
From: Martin Andersson <martin.andersson@control.lth.se>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Strange interactivity behaviour
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Possible Problem:
There may be a truncation error in kernel/sched.c triggered when the 
nice value is negative. The affected code is used in the 
TASK_INTERACTIVE macro.

The code is:
#define SCALE(v1,v1_max,v2_max) \
	(v1) * (v2_max) / (v1_max)

which is used in this way:
SCALE(TASK_NICE(p), 40, MAX_BONUS)

Comments in the code says:
  * This part scales the interactivity limit depending on niceness.
  *
  * We scale it linearly, offset by the INTERACTIVE_DELTA delta.
  * Here are a few examples of different nice levels:
  *
  *  TASK_INTERACTIVE(-20): [1,1,1,1,1,1,1,1,1,0,0]
  *  TASK_INTERACTIVE(-10): [1,1,1,1,1,1,1,0,0,0,0]
  *  TASK_INTERACTIVE(  0): [1,1,1,1,0,0,0,0,0,0,0]
  *  TASK_INTERACTIVE( 10): [1,1,0,0,0,0,0,0,0,0,0]
  *  TASK_INTERACTIVE( 19): [0,0,0,0,0,0,0,0,0,0,0]
  *
  * (the X axis represents the possible -5 ... 0 ... +5 dynamic
  *  priority range a task can explore, a value of '1' means the
  *  task is rated interactive.)

However, the current code does not scale it linearly and the result 
differs from the given examples. If the mathematical function "floor" is 
used when the nice value is negative instead of the truncation one gets 
when using integer division, the result conforms to the documentation.

I belive that this is a bug. Is this correct or have i misunderstood 
something?

/Martin Andersson

---

Output of TASK_INTERACTIVE when using the kernel code:
nice    dynamic priorities
-20     1     1     1     1     1     1     1     1     1     0     0
-19     1     1     1     1     1     1     1     1     0     0     0
-18     1     1     1     1     1     1     1     1     0     0     0
-17     1     1     1     1     1     1     1     1     0     0     0
-16     1     1     1     1     1     1     1     1     0     0     0
-15     1     1     1     1     1     1     1     0     0     0     0
-14     1     1     1     1     1     1     1     0     0     0     0
-13     1     1     1     1     1     1     1     0     0     0     0
-12     1     1     1     1     1     1     1     0     0     0     0
-11     1     1     1     1     1     1     0     0     0     0     0
-10     1     1     1     1     1     1     0     0     0     0     0
  -9     1     1     1     1     1     1     0     0     0     0     0
  -8     1     1     1     1     1     1     0     0     0     0     0
  -7     1     1     1     1     1     0     0     0     0     0     0
  -6     1     1     1     1     1     0     0     0     0     0     0
  -5     1     1     1     1     1     0     0     0     0     0     0
  -4     1     1     1     1     1     0     0     0     0     0     0
  -3     1     1     1     1     0     0     0     0     0     0     0
  -2     1     1     1     1     0     0     0     0     0     0     0
  -1     1     1     1     1     0     0     0     0     0     0     0
  0      1     1     1     1     0     0     0     0     0     0     0
  1      1     1     1     1     0     0     0     0     0     0     0
  2      1     1     1     1     0     0     0     0     0     0     0
  3      1     1     1     1     0     0     0     0     0     0     0
  4      1     1     1     0     0     0     0     0     0     0     0
  5      1     1     1     0     0     0     0     0     0     0     0
  6      1     1     1     0     0     0     0     0     0     0     0
  7      1     1     1     0     0     0     0     0     0     0     0
  8      1     1     0     0     0     0     0     0     0     0     0
  9      1     1     0     0     0     0     0     0     0     0     0
10      1     1     0     0     0     0     0     0     0     0     0
11      1     1     0     0     0     0     0     0     0     0     0
12      1     0     0     0     0     0     0     0     0     0     0
13      1     0     0     0     0     0     0     0     0     0     0
14      1     0     0     0     0     0     0     0     0     0     0
15      1     0     0     0     0     0     0     0     0     0     0
16      0     0     0     0     0     0     0     0     0     0     0
17      0     0     0     0     0     0     0     0     0     0     0
18      0     0     0     0     0     0     0     0     0     0     0
19      0     0     0     0     0     0     0     0     0     0     0


Output of TASK_INTERACTIVE when using "floor"
nice    dynamic priorities
-20     1     1     1     1     1     1     1     1     1     0     0
-19     1     1     1     1     1     1     1     1     1     0     0
-18     1     1     1     1     1     1     1     1     1     0     0
-17     1     1     1     1     1     1     1     1     1     0     0
-16     1     1     1     1     1     1     1     1     0     0     0
-15     1     1     1     1     1     1     1     1     0     0     0
-14     1     1     1     1     1     1     1     1     0     0     0
-13     1     1     1     1     1     1     1     1     0     0     0
-12     1     1     1     1     1     1     1     0     0     0     0
-11     1     1     1     1     1     1     1     0     0     0     0
-10     1     1     1     1     1     1     1     0     0     0     0
  -9     1     1     1     1     1     1     1     0     0     0     0
  -8     1     1     1     1     1     1     0     0     0     0     0
  -7     1     1     1     1     1     1     0     0     0     0     0
  -6     1     1     1     1     1     1     0     0     0     0     0
  -5     1     1     1     1     1     1     0     0     0     0     0
  -4     1     1     1     1     1     0     0     0     0     0     0
  -3     1     1     1     1     1     0     0     0     0     0     0
  -2     1     1     1     1     1     0     0     0     0     0     0
  -1     1     1     1     1     1     0     0     0     0     0     0
   0     1     1     1     1     0     0     0     0     0     0     0
   1     1     1     1     1     0     0     0     0     0     0     0
   2     1     1     1     1     0     0     0     0     0     0     0
   3     1     1     1     1     0     0     0     0     0     0     0
   4     1     1     1     0     0     0     0     0     0     0     0
   5     1     1     1     0     0     0     0     0     0     0     0
   6     1     1     1     0     0     0     0     0     0     0     0
   7     1     1     1     0     0     0     0     0     0     0     0
   8     1     1     0     0     0     0     0     0     0     0     0
   9     1     1     0     0     0     0     0     0     0     0     0
  10     1     1     0     0     0     0     0     0     0     0     0
  11     1     1     0     0     0     0     0     0     0     0     0
  12     1     0     0     0     0     0     0     0     0     0     0
  13     1     0     0     0     0     0     0     0     0     0     0
  14     1     0     0     0     0     0     0     0     0     0     0
  15     1     0     0     0     0     0     0     0     0     0     0
  16     0     0     0     0     0     0     0     0     0     0     0
  17     0     0     0     0     0     0     0     0     0     0     0
  18     0     0     0     0     0     0     0     0     0     0     0
  19     0     0     0     0     0     0     0     0     0     0     0
