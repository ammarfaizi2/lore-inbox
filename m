Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265349AbUFSKF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265349AbUFSKF6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 06:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265360AbUFSKF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 06:05:58 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:45164 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265349AbUFSKF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 06:05:56 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.7] bug_smp_call_function 
In-reply-to: Your message of "Sat, 19 Jun 2004 02:59:10 MST."
             <20040619095910.GQ1863@holomorphy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 19 Jun 2004 20:05:13 +1000
Message-ID: <6245.1087639513@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2004 02:59:10 -0700, 
William Lee Irwin III <wli@holomorphy.com> wrote:
>Keith Owens <kaos@sgi.com> wrote:
>>>  sg.c has been fixed to no longer call vfree() with interrupts disabled.
>>>  Change smp_call_function() from WARN_ON to BUG_ON when interrupts are
>>>  disabled.  It was only set to WARN_ON because of sg.c.
>
>On Sat, Jun 19, 2004 at 02:44:16AM -0700, Andrew Morton wrote:
>> I prefer the WARN_ON.  It is exceedingly unlikely that the bug will cause
>> lockups or memory/data corruption or anything else, so why nuke the user's
>> box when we can trivially continue?
>> We'll be sent the bug report either way.
>
>Calls to smp_call_function() with interrupts off or spinlocks held
>typically causes deadlocks on SMP systems. ISTR debugging such an
>issue in the scheduler a while back, i.e. mmdrop() under rq->lock
>doing vfree() of an LDT. Basically smp_call_function() will spin
>waiting for the other cpus to answer the interrupt on multiple cpus.
>It also doesn't need to be the same function doing smp_call_function();
>generally TLB flushing deadlocks against anything doing this.

Agreed, that is exactly the class of problems that I spent days
debugging.  WARN_ON() lets developers add code that breaks the rules
and assumes that we will have to fix the bad code later.  BUG_ON()
prevents any bad code being added because it catches the developer as
soon as they add it.

