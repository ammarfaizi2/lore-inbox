Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266205AbUA1VqH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 16:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266210AbUA1Vpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 16:45:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:48523 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266205AbUA1VoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 16:44:12 -0500
Date: Wed, 28 Jan 2004 13:43:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: willy@debian.org, ishii.hironobu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [RFC/PATCH, 2/4] readX_check() performance evaluation
In-Reply-To: <20040128220921.7ba0bb78.ak@suse.de>
Message-ID: <Pine.LNX.4.58.0401281340301.28145@home.osdl.org>
References: <00a301c3e541$c13a6350$2987110a@lsd.css.fujitsu.com>
 <Pine.LNX.4.58.0401271847440.10794@home.osdl.org>
 <20040128182003.GL11844@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0401281129570.28145@home.osdl.org> <20040128204049.627e6312.ak@suse.de>
 <Pine.LNX.4.58.0401281205250.28145@home.osdl.org> <20040128211554.0cc890fb.ak@suse.de>
 <Pine.LNX.4.58.0401281221320.28145@home.osdl.org> <20040128220921.7ba0bb78.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Jan 2004, Andi Kleen wrote:
>
> On Wed, 28 Jan 2004 12:28:56 -0800 (PST)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > 
> > Alternatively, if you get a lot of information at MCE time (CPU that did
> > the access + some device data), just queue up the information in a per-CPU
> > queue. You don't have to worry about overflow - you can just drop if if 
> 
> That assumes that the access happened with preempt off ?

Yes. I assume you want _some_ locking anyway, at least within that 
particular device driver (you don't want to have an irq handler touch the 
device at the same time you are doing this thing), so any such spinlock 
would have disabled preemption anyway.

> That's fine if it's guaranteed that the MCE still happened inside 
> readl/writel. But if it's delayed longer for some reason there is no guarantee 
> that you can find back to the CPU that caused the fault.

Again, this is all depending on hardware implementation issues. It is 
entirely possible that "read_pcix_error()" has to do some kind of 
synchronization to make sure that any async operations have finished and 
all errors have been accounted for.

Again, this is the whole reason for doing the separate "clear/read"  
phases in error handling - exactly because hardware implementation may
make error handling fairly heavy-weight, so you don't want to do it on a
per-IO basis, but rather on a "per transaction" basis.

		Linus
