Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbTIMXLe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 19:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbTIMXLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 19:11:34 -0400
Received: from email-out1.iomega.com ([147.178.1.82]:60124 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S262248AbTIMXLa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 19:11:30 -0400
Subject: Re: console lost to Ctrl+Alt+F$n in 2.6.0-test5
From: Pat LaVarre <p.lavarre@ieee.org>
To: mhf@linuxmail.org
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org
In-Reply-To: <200309132347.37831.mhf@linuxmail.org>
References: <1063378664.5059.19.camel@patehci2>
	 <1063460312.2905.13.camel@patehci2> <200309132249.40283.mhf@linuxmail.org>
	 <200309132347.37831.mhf@linuxmail.org>
Content-Type: text/plain
Organization: 
Message-Id: <1063494749.2855.7.camel@patehci2>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 13 Sep 2003 17:12:30 -0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2003 23:11:29.0816 (UTC) FILETIME=[5D506980:01C37A4C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> script ... switches every $wait (5) seconds between VT
> $vt (1) and X @vt$x (7) ...

Yes, logging in via ssh to run this script does reliably crash my
2.6.0-test5, I think because of `chvt $x`, while I am not touching the
console keyboard or mouse.

Cycles required varies.  Counting cycles completed before crashing, I
saw: 1 18 20 20 ... 4 16 ...

The script as was posted creates a small ./X and produces logs such as:

Cycle 1 switching to VT 1
Cycle 1 switching to X
...
Cycle 20 switching to VT 1
Cycle 20 switching to X
Cycle 21 switching to VT 1

This log could have been produced by crashing in `chvt $vt`, but I think
I saw it was produced by crashing in the `sleep $wait` that follows
`chvt $x`.  That is, I think the $vt was the last non-blank display, not
the $x.

To increase my confidence, I ran with every command echoed, and indeed
via ssh I saw the last command echoed was `sleep 5`.

I ended by running the third variant script quoted below.  Now my logs
comfortingly end with 'switching to X'.  I presume I'm catching the
crash in the last sleep $wait.

Pat LaVarre

#!/bin/bash
cycle=1
log=/tmp/_vt.log
vt=1
x=7
wait=3
rm -f $log
echo 'Starting VT <> X test'
while ((1)); do
	echo Cycle $cycle switching to VT $vt | tee -a $log
	sync
	sleep $wait
	chvt $vt
	sleep $wait
	echo Cycle $cycle switching to X | tee -a $log
	sync
	sleep $wait
	chvt $x
	sleep $wait
	((cycle += 1))
done
;;



