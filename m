Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268075AbTAJAiV>; Thu, 9 Jan 2003 19:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268076AbTAJAiU>; Thu, 9 Jan 2003 19:38:20 -0500
Received: from holomorphy.com ([66.224.33.161]:47509 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268075AbTAJAiS>;
	Thu, 9 Jan 2003 19:38:18 -0500
Date: Thu, 9 Jan 2003 16:46:34 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Dieter N?tzel <Dieter.Nuetzel@hamburg.de>
Cc: Brian Tinsley <btinsley@emageon.com>, Russell Coker <russell@coker.com.au>,
       ReiserFS <reiserfs-list@namesys.com>, Rik van Riel <riel@nl.linux.org>,
       Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: kswapd CPU usage and heavy disk IO
Message-ID: <20030110004634.GB1147@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
	Brian Tinsley <btinsley@emageon.com>,
	Russell Coker <russell@coker.com.au>,
	ReiserFS <reiserfs-list@namesys.com>,
	Rik van Riel <riel@nl.linux.org>, Andrea Arcangeli <andrea@suse.de>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <200301091431.54451.russell@coker.com.au> <3E1D9D10.40700@emageon.com> <200301091742.51101.Dieter.Nuetzel@hamburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <200301091742.51101.Dieter.Nuetzel@hamburg.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline

Am Donnerstag, 9. Januar 2003 17:02 schrieb Brian Tinsley:
>> I've been seeing the exact same thing on the same type of system in the
>> same situations. This has been causing all kinds of problems on our
>> clusters: the system live-locks for a minute or two, causes cluster
>> heartbeats to not be received, and falsely fails over when the system
>> recovers from the live-lock. The only thing I can find after the
>> live-lock is that the runtime for kswapd is abnormally high.
>> We started running sar (60 second collection interval) and were able to
>> capture some stats during this live-lock period. I've snipped some I
>> believe may be of interest. Note the missing stats between 03:59:43 and
>> 04:02:03
>> Oh BTW, this is on a stock 2.4.20 kernel (dual P3, 4GB), but I have seen
>> the same behavior on 2.4.19 and 2.4.17.

On Thu, Jan 09, 2003 at 05:42:51PM +0100, Dieter N?tzel wrote:
> I think you should have cc'ed Andrea Arcangeli <andrea@suse.de>,
> LKM and try 2.4.20-aa1. Are you sure it is a ReiserFS and not a
> kernel thing?

There simply aren't enough scenarios for this to be a mystery. Both
-aa and 2.5.x should have something in there for it: memclass-related
buffer_head stuff in -aa, and bh-stripping + "bh-less" operation (for
ext2) in 2.5.x + fewer (if any) bh's outside of actual dirty data.

Bloat monitoring scripts attached, which might provide somewhat more
useful output to capture, though they certainly don't eliminate the
need for /proc/meminfo logging. I'll also see if some of the accounting
patches can be backported and send those to Marcelo and Andrea.


Bill

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Description: bloatmon
Content-Disposition: attachment; filename=bloatmon

#!/usr/bin/awk -f
BEGIN {
	printf "%18s    %8s %8s %8s\n", "cache", "active", "alloc", "%util";
}

{
	if ($3 != 0.0) {
		pct  = 100.0 * $2 / $3;
		frac = (10000.0 * $2 / $3) % 100;
	} else {
		pct  = 100.0;
		frac = 0.0;
	}
	active = ($2 * $4)/1024;
	alloc  = ($3 * $4)/1024;
	if ((alloc - active) < 1.0) {
		pct  = 100.0;
		frac = 0.0;
	}
	printf "%18s: %8dKB %8dKB  %3d.%-2d\n", $1, active, alloc, pct, frac;
}

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Description: bloatmeter
Content-Disposition: attachment; filename=bloatmeter

#!/bin/sh
while : ; do
	grep -v '^slabinfo' /proc/slabinfo	\
		| bloatmon			\
		| sort -n -k 4,4		\
		| head -22
	sleep 5
	echo
done

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Description: bloatmost
Content-Disposition: attachment; filename=bloatmost

#!/bin/sh

while true
do
	bloatmon < /proc/slabinfo \
		| sort -rn -k 3,3 \
		| head -22
	sleep 60
	echo
done

--vkogqOf2sHV7VnPd--
