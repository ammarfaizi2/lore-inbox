Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967781AbWK3BNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967781AbWK3BNP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 20:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967784AbWK3BNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 20:13:15 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49610
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S967781AbWK3BNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 20:13:14 -0500
Date: Wed, 29 Nov 2006 17:13:16 -0800 (PST)
Message-Id: <20061129.171316.70216831.davem@davemloft.net>
To: akpm@osdl.org
Cc: wenji@fnal.gov, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061129170835.72bd40b3.akpm@osdl.org>
References: <HNEBLGGMEGLPMPPDOPMGGEAKCGAA.wenji@fnal.gov>
	<20061129.165311.45739865.davem@davemloft.net>
	<20061129170835.72bd40b3.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Wed, 29 Nov 2006 17:08:35 -0800

> On Wed, 29 Nov 2006 16:53:11 -0800 (PST)
> David Miller <davem@davemloft.net> wrote:
> 
> > 
> > Please, it is very difficult to review your work the way you have
> > submitted this patch as a set of 4 patches.  These patches have not
> > been split up "logically", but rather they have been split up "per
> > file" with the same exact changelog message in each patch posting.
> > This is very clumsy, and impossible to review, and wastes a lot of
> > mailing list bandwith.
> > 
> > We have an excellent file, called Documentation/SubmittingPatches, in
> > the kernel source tree, which explains exactly how to do this
> > correctly.
> > 
> > By splitting your patch into 4 patches, one for each file touched,
> > it is impossible to review your patch as a logical whole.
> > 
> > Please also provide your patch inline so people can just hit reply
> > in their mail reader client to quote your patch and comment on it.
> > This is impossible with the attachments you've used.
> > 
> 
> Here you go - joined up, cleaned up, ported to mainline and test-compiled.
> 
> That yield() will need to be removed - yield()'s behaviour is truly awful
> if the system is otherwise busy.  What is it there for?

What about simply turning off CONFIG_PREEMPT to fix this "problem"?

We always properly run the backlog (by doing a release_sock()) before
going to sleep otherwise except for the specific case of taking a page
fault during the copy to userspace.  It is only CONFIG_PREEMPT that
can cause this situation to occur in other circumstances as far as I
can see.

We could also pepper tcp_recvmsg() with some very carefully placed
preemption disable/enable calls to deal with this even with
CONFIG_PREEMPT enabled.
