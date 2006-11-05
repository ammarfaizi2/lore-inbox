Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161506AbWKESxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161506AbWKESxM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 13:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161507AbWKESxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 13:53:12 -0500
Received: from ns2.suse.de ([195.135.220.15]:43489 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161506AbWKESxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 13:53:11 -0500
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [rfc patch] i386: don't save eflags on task switch
Date: Sun, 5 Nov 2006 19:52:55 +0100
User-Agent: KMail/1.9.5
Cc: Zachary Amsden <zach@vmware.com>, Benjamin LaHaise <bcrl@kvack.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200611040200_MC3-1-D04D-6EA3@compuserve.com> <200611051801.18277.ak@suse.de> <Pine.LNX.4.64.0611050920220.25218@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611050920220.25218@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611051952.55655.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> So you get a test, a unpredictable conditional jump, and the sti - and 
> you'll end up with the cost being pretty much the same as the popf: only 
> bigger and more complex.
> 
> That's a win, right?

Previously we had a popf which for the CPU unpredictable
restoring of most of its state. I would assume the unpredicted jump
is cheaper than that.

I might be wrong. Benchmarks will tell when I try it.

But I think it might be worth a try at least.

> 
> > 99.9999% of all restore_flags just need STI.
> 
> Hell no. If you know it statically, you can already just do the 
> "spin_lock_irq()"->"spin_unlock_irq()", and then you have the 
> _unconditional_ sti.

I meant they don't care about any other flags. Of course you need
a test + conditional jump first to handle the nested lock case.

> Andi, one single bug is usually worth _months_ of peoples time and effort. 
> How many CPU cycles is that? 

I bet near all cases where restore_flags() are used to restore something
else than IF are actually bugs or performance issues of some sort

This doesn't include the context switch of course, but that one 
doesn't use restore_flags().

(I think I have a few legitimate cases of save_flags though. They probably
should be using a different macro for clarity.) 

-Andi
 
