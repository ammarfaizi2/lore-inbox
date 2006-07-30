Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWG3U67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWG3U67 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 16:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWG3U67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 16:58:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32157 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932170AbWG3U66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 16:58:58 -0400
Date: Sun, 30 Jul 2006 13:55:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: johnstul@us.ibm.com, smurf@smurf.noris.de, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, bunk@stusta.de, lethal@linux-sh.org,
       hirofumi@mail.parknet.co.jp, asit.k.mallick@intel.com
Subject: Re: REGRESSION: the new i386 timer code fails to sync CPUs
Message-Id: <20060730135518.f16c0399.akpm@osdl.org>
In-Reply-To: <20060730201005.GA85093@muc.de>
References: <20060722173649.952f909f.akpm@osdl.org>
	<20060723081604.GD27566@kiste.smurf.noris.de>
	<20060723044637.3857d428.akpm@osdl.org>
	<20060723120829.GA7776@kiste.smurf.noris.de>
	<20060723053755.0aaf9ce0.akpm@osdl.org>
	<1153756738.9440.14.camel@localhost>
	<20060724171711.GA3662@kiste.smurf.noris.de>
	<20060724175150.GD50320@muc.de>
	<1153774443.12836.6.camel@localhost>
	<20060730020346.5d301bb5.akpm@osdl.org>
	<20060730201005.GA85093@muc.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Jul 2006 22:10:05 +0200
Andi Kleen <ak@muc.de> wrote:

> > I guess Matthias didn't test this patch.  Can we get some obviously-correct
> > fix in place for 2.6.18?
> 
> So far we don't have any idea what the problem is on that system.

I believe we do know what the problem is: a) write_tsc() doesn't work, b)
the TSC's are unsynced (or have an offset), c) we removed a check which
would have caused pmtmr/rtc fallback.

> > It is a "CPU0: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03".
> 
> Was that on that system?

yes.

> I guess it could be checked for and TSC 
> be forced off.

There's no need for that, I think.  synchronize_tsc_bp() knows for-sure
that the synchronization failed, in a way which works on all CPUs.

So all we need to do is to set some flag in synchronize_tsc_bp() if `buggy'
is set, telling the clocksource code to give up on the TSC.

> It sounds like a real CPU bug however.

I was hoping the Intel guys could help out with that.
