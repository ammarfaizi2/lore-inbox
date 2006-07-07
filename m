Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWGGXL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWGGXL2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWGGXL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:11:28 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:24964 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932129AbWGGXL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:11:27 -0400
Subject: Hang and Soft Lockup problems with generic time code
From: James Bottomley <James.Bottomley@SteelEye.com>
To: john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 18:11:19 -0500
Message-Id: <1152313879.3866.53.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ever since the 2.6.17 kernel pulled in the generic timer code, I've been
experiencing hangs and softlockups with the aic94xx driver (which I
thought were driver related).  Finally, after a lot of debugging I've
isolated the culprit to linux/time.h:timespec_add_ns()

What is happening is that a->tv_nsec is coming in here negative and
looping for huge amounts of time.

Why tv_nsec is negative appears to be related to massive cycle
adjustments in kernel/timer.c:update_wall_time().  With the TSC as my
clocksource I've seen the clocksource_read() return increments of in the
200s range.  No idea why this is happening.  The same strange
discontinuous jumps in cycle count also occurs with pm_acpi as the clock
source.

I can't get a good enough handle on all the generic time code changes to
reverse them.  However, this machine is a P4, so I was able to boot it
with an x86_64 kernel (which doesn't yet use the generic time code) and
confirm that all the hangs and softlockups go away.

The machine in question is an IBM x206m dual core P4.

James


