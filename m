Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262619AbVEMWxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbVEMWxk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 18:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbVEMWxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 18:53:32 -0400
Received: from science.horizon.com ([192.35.100.1]:49197 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S262608AbVEMWvi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 18:51:38 -0400
Date: 13 May 2005 22:51:35 -0000
Message-ID: <20050513225135.20005.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is with the *combination* of fine-grained multithreading,
a shared cache, *and* high-resolution timing via RDTSC.

A far easier fix would be to disable RDTSC.
(A third possibility would be to disable the cache, but I assume that's
too horrible to contemplate.)

When Intel implemented RDTSC, they were quite aware that it made a good
covert channel and provided an enable bit (bit 2 of CR4) to control
user-space access.

This attack is just showing that, with the tight coupling provided
by hyperthreading, it's possible to receive "interesting" data from a
process that is *not* deliberately transmitting.  (Whereas the classic
problem enfocing the Bell-Lapadula model comes from preventing
*deliberate* transmission.)


If you don't want to disable it universally, how about providing,
at the OS level, a way for a task to request that RDTSC be disabled
while it is running?  If another task tries to use it, it traps and one
of the two (doesn't matter which!) gets rescheduled later when the other
is not running.

If RDTSC is too annoying to disable, just interpret the same flag as a
"schedule me solo" flag that prevents scheduling anything else (at least,
not sharing the same ->mm) on the other virtual processor.  (Of course,
the time should count double for scheduler fairness purposes.)
