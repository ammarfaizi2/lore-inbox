Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbTD3W7B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 18:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbTD3W7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 18:59:01 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:7814 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262520AbTD3W65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 18:58:57 -0400
Message-Id: <200304302311.h3UNB2H27134@owlet.beaverton.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org,
       frankeh@us.ibm.com
Subject: Re: must-fix list for 2.6.0 
In-reply-to: Your message of "Wed, 30 Apr 2003 12:11:05 PDT."
             <20030430121105.454daee1.akpm@digeo.com> 
Date: Wed, 30 Apr 2003 16:11:02 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    The below patch should fix that up, but we need to decide whether
    the (rather unclear) advantages of the sched_yield() change outweigh
    the breakage which it caused linuxthreads applications.

Exactly right; we've gone back and forth on this a few times.  What fixes
one seems to break the other.  Hubertus Franke (frankeh@us.ibm.com)
has been trying to reply with this succinct summary of
advantages/disadvantages but is having some sort of DNS issues right now so
I'll post it for him:

   This goes back to the semantics of sched_yield().

   OLD: when sched_yield() is called the task moves to expired,
	every other task in the active queue will run first before the
	yielding task will run again.

   NEW: move the yielding task to the end of its current priority level,
	but keeps it active not expired.

	Why is this good?
	(a) the task will not loose its timeslice length, because moving it to
	    expired effectively does that.
	(b) it keeps the task responsive

	Why is this bad?
	(a) if it does busy looping through sched_yield it will eat cycles which
	    might not have happened

	What else could be done?
	(a) drop the effective priority of the yielding task by a percentile,
	    but don't reduce the time slice!

   Hubertus Franke
   email: frankeh@us.ibm.com
   (w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003

