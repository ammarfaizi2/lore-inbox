Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUCYO6a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 09:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbUCYO6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 09:58:30 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:24709 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263185AbUCYO62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 09:58:28 -0500
Date: Thu, 25 Mar 2004 09:26:43 -0500
From: Ben Collins <bcollins@debian.org>
To: linux-kernel@vger.kernel.org
Subject: 2.0.x kernels and stack leak under high interrupt load
Message-ID: <20040325142643.GP2255@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on a problem I'm having in 2.0 kernels (embedded product, no
chance of upgrading to 2.2/2.4/whatever, so that's not a good
suggestion :)

The problem is that under heavy interrupt load, tasks that are in the
middle of a syscall will get constantly rescheduled. Eventually one of
these stacks will eat up all the kernel stack associated with it, and
crash. I've put checks in do_bottom_half() to catch this and do a
backtrace. The backtrace is full of nothing but ret_from_sys_call and
do_bottom_half's (like 10 ret_from_sys_call's then a do_bottom_half).

All of this rescheduling (because the interrupts come in so fast that
the ret_from_sys_call cannot complete) eventually eats up the stack.
When we first noticed this it just ended up being a gross backtrace that
meant nothing (corrupted). The check in do_bottom_half allowed me to
test the stack size and oops before it got corrupted.

The high interrupt load in this case is caused by a constant high load
of 64-byte UDP packets. This may not be normal load, but it's possible
to generate this in some sort of DoS attempt. It is also unrelated to
the ethernet driver. I've been able to reproduce this on several
machines using different NIC's and drivers.

Anyone seen this issue before or can suggest a fix?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
