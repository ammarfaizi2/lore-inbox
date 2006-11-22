Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755589AbWKVJuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755589AbWKVJuV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 04:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755604AbWKVJuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 04:50:21 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:43356 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1755575AbWKVJuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 04:50:20 -0500
Message-ID: <45641BEE.8060603@openvz.org>
Date: Wed, 22 Nov 2006 12:44:14 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Morton Andrew Morton <akpm@osdl.org>,
       mingo@redhat.com
CC: Vivek Goyal <vgoyal@in.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>, dev@sw.ru
Subject: Re: 2.6.19-rc6: known regressions (v4)
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org> <20061121212424.GQ5200@stusta.de> <20061121213335.GB30010@in.ibm.com> <Pine.LNX.4.64.0611211410460.3338@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611211410460.3338@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I really think this is wrong.
> 
> The original patch was wrong, and the _real_ problem is in __do_IRQ() that 
> got the desc->lock too early.
> 
> I _think_ the correct fix is to simply revert the broken commit, and fix 
> the _one_ place that called "misnote_interrupt()" with the lock held.
> 
> Something like this..
> 
> I also think that the real fix will be to move the whole
> 
> 	if (!noirqdebug)
> 		note_interrupt(irq, desc, action_ret);
> 
> 
> into handle_IRQ_event itself, since every caller (except for 
> "misrouted_irq()" itself, and that should probably be done separately) 
> should always do it. Right now we have a lot of people that just do
> 
> 	action_ret = handle_IRQ_event(irq, action);
> 	if (!noirqdebug)
> 		note_interrupt(irq, desc, action_ret);
> 
> explicitly.
> 
> The only thing that keeps us from doing that is that we don't pass in 
> "desc", but we should just do that.
> 
> But in the meantime, this appears to be the minimal fix. Can people please 
> test and verify?

This works for me, but is this normal that desc's fields are
modified non-atomically in note_interrupt()?

And one more thing - report_bad_irq() traverses desc->action
list without any locking either.
