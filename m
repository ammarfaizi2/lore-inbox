Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265361AbUFSKAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265361AbUFSKAf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 06:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265366AbUFSKAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 06:00:35 -0400
Received: from holomorphy.com ([207.189.100.168]:62860 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265361AbUFSKAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 06:00:34 -0400
Date: Sat, 19 Jun 2004 02:59:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Keith Owens <kaos@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.7] bug_smp_call_function
Message-ID: <20040619095910.GQ1863@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Keith Owens <kaos@sgi.com>,
	linux-kernel@vger.kernel.org
References: <5328.1087637808@kao2.melbourne.sgi.com> <20040619024416.065f4026.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040619024416.065f4026.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@sgi.com> wrote:
>>  sg.c has been fixed to no longer call vfree() with interrupts disabled.
>>  Change smp_call_function() from WARN_ON to BUG_ON when interrupts are
>>  disabled.  It was only set to WARN_ON because of sg.c.

On Sat, Jun 19, 2004 at 02:44:16AM -0700, Andrew Morton wrote:
> I prefer the WARN_ON.  It is exceedingly unlikely that the bug will cause
> lockups or memory/data corruption or anything else, so why nuke the user's
> box when we can trivially continue?
> We'll be sent the bug report either way.

Calls to smp_call_function() with interrupts off or spinlocks held
typically causes deadlocks on SMP systems. ISTR debugging such an
issue in the scheduler a while back, i.e. mmdrop() under rq->lock
doing vfree() of an LDT. Basically smp_call_function() will spin
waiting for the other cpus to answer the interrupt on multiple cpus.
It also doesn't need to be the same function doing smp_call_function();
generally TLB flushing deadlocks against anything doing this.


-- wli
