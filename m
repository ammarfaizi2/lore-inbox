Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbTAICtL>; Wed, 8 Jan 2003 21:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbTAICtL>; Wed, 8 Jan 2003 21:49:11 -0500
Received: from holomorphy.com ([66.224.33.161]:10638 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261495AbTAICs6>;
	Wed, 8 Jan 2003 21:48:58 -0500
Date: Wed, 8 Jan 2003 18:57:36 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Chris Wood <cwood@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440)
Message-ID: <20030109025736.GF23814@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Chris Wood <cwood@xmission.com>, linux-kernel@vger.kernel.org
References: <3E1A12B5.4020505@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <3E1A12B5.4020505@xmission.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline

On Mon, Jan 06, 2003 at 04:35:17PM -0700, Chris Wood wrote:
> With some tips from James Cleverdon (IBM), I turned on some kernel 
> debugging and got the following from readprofile when the server was 
> having problems (truncated to the first 22 lines):
> 16480 total                                      0.0138

Here are some monitoring tools that might help detect the cause of
the situation.

bloatmon is the "back end"; there's no reason to run it directly.

bloatmeter shows the "least utilized" slabs.

bloatmost shows the largest slabs.

These sort of make for a top(1) for "lowmem pressure". Not everything
is accounted there, though. The missing pieces are largely

(1) simultaneous temporary poll table allocations
(2) pmd's
(3) kernel stacks

Bill

--fUYQa+Pmc3FrFX/N
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

--fUYQa+Pmc3FrFX/N
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

--fUYQa+Pmc3FrFX/N
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

--fUYQa+Pmc3FrFX/N--
