Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbVHRSrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVHRSrg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 14:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbVHRSrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 14:47:35 -0400
Received: from fmr14.intel.com ([192.55.52.68]:23274 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S932389AbVHRSrf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 14:47:35 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: CONFIG_PRINTK_TIME woes
Date: Thu, 18 Aug 2005 11:47:32 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F042C7DA7@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CONFIG_PRINTK_TIME woes
Thread-Index: AcWkJUqnqkXjVIhyRFqxCnpJUuwr/w==
From: "Luck, Tony" <tony.luck@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Jason Uhlenkott" <jasonuhl@sgi.com>
X-OriginalArrivalTime: 18 Aug 2005 18:47:33.0363 (UTC) FILETIME=[4B473430:01C5A425]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It has been pointed out to me that ia64 doesn't boot
with CONFIG_PRINTK_TIME=y.  The issue is the call to
sched_clock() ... which on ia64 accesses some per-cpu
data to adjust for possible variations in processor
speed between different cpus.  Since the per-cpu page
is not set up for the first few printk() calls, we die.

Is this an issue on any other architecture?  Most versions
of sched_clock() seem to just scale jiffies into nanoseconds,
so I guess they don't.  s390, sparc64, x86 and x86_64 all
have more sophisticated versions but they don't appear to me
to have limitations on how early they might be called.

Possible solutions:

1) Fix ia64 version of sched_clock() to check whether
the per-cpu page hase been initialized before using it.

I don't like this solution as it will make sched_clock()
slower for its primary uses in kernel/sched.c ... none of
which can be called before the per-cpu area is initialized.


2) Add some test to the printk() path along the lines of:

  t = (can_call_sched_clock) ? sched_clock() : 0;

This is somewhat ugly ... perhaps too unpleasant for words in
that can_call_sched_clock is a per-cpu concept!

3) Make the printk() code get the time in some other way.

Using sched_clock() here seems wrong.  The ia64 version
has a big fat comment about not comparing the results of
two calls from different cpus ... but since printk() calls
can come from any cpu ... it seems likely that a user who
turns on PRINTK_TIME might subtract timestamps from two
lines to see how long it was between the messages.  This
could have significant error on a system that has been up
for a long time.

But I don't have a better suggestion from existing code.  I
assume that sched_clock() was picked as it is both fast and
lockless.

-Tony

