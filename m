Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266056AbUA1Tdm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 14:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266037AbUA1Tdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 14:33:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:9128 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266044AbUA1Tdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 14:33:38 -0500
Date: Wed, 28 Jan 2004 11:33:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthew Wilcox <willy@debian.org>
cc: Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>
Subject: Re: [RFC/PATCH, 2/4] readX_check() performance evaluation
In-Reply-To: <20040128182003.GL11844@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0401281129570.28145@home.osdl.org>
References: <00a301c3e541$c13a6350$2987110a@lsd.css.fujitsu.com>
 <Pine.LNX.4.58.0401271847440.10794@home.osdl.org>
 <20040128182003.GL11844@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Jan 2004, Matthew Wilcox wrote:
> 
> If there are, Linus' interface is probably the best one.  If not, we could
> simply have readX_check() / writeX_check() call dev->driver->unregister()
> if they notice an error has occurred and then the driver doesn't even
> need to call read_pcix_errors().

What worries me is that not only can the errors be asynchronous, they may 
well be relatively expensive to check for.

For example, if checking for an error involves actually reading a value 
from a bridge register, then that implies some _serious_ amount of 
serialization and external CPU stuff.

The advantage of having the "check for errors" be done later and
independently of the actual IO access itself is not only that I think it
makes the code look nicer - it also allows you to do the IO independently
of the check. Which potentially means that the CPU can burst out the
writes as a burst write, rather than doing them one at a time and then
doing a read of a bridge register in between that serializes everything.

		Linus
