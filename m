Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266174AbUA1U3L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 15:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbUA1U3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 15:29:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:48586 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266170AbUA1U3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 15:29:01 -0500
Date: Wed, 28 Jan 2004 12:28:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: willy@debian.org, ishii.hironobu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [RFC/PATCH, 2/4] readX_check() performance evaluation
In-Reply-To: <20040128211554.0cc890fb.ak@suse.de>
Message-ID: <Pine.LNX.4.58.0401281221320.28145@home.osdl.org>
References: <00a301c3e541$c13a6350$2987110a@lsd.css.fujitsu.com>
 <Pine.LNX.4.58.0401271847440.10794@home.osdl.org>
 <20040128182003.GL11844@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0401281129570.28145@home.osdl.org> <20040128204049.627e6312.ak@suse.de>
 <Pine.LNX.4.58.0401281205250.28145@home.osdl.org> <20040128211554.0cc890fb.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Jan 2004, Andi Kleen wrote:
> 
> Where would you put the flag? 
> 
> Doing it global may give false errors for the wrong device with async MCEs
> and on SMP.

That entirely depends on what the hardware supports. How much information 
will you get about the error?

If the real error is on the bridge somewhere but you don't even know which
CPU did the access (and just "somebody" gets an MCE), just set a global
flag, and have "read_pcix_error()" check the bridge (since it doesn't need
to look anything up - it already knows the device).

And in that case then you need to take the proper locks (per-bridge, or
global, depending on just how much you care) in "clear_pcix_error()" and
release them in "read_pcix_error()".

Alternatively, if you get a lot of information at MCE time (CPU that did
the access + some device data), just queue up the information in a per-CPU
queue. You don't have to worry about overflow - you can just drop if if 
you get many errors (or maybe maintain a count), since the only thing that 
matters is "we got an error for this device" along with maybe some small 
amount of info on what kind(s) of error(s).

Basically: it all boils down to what the hardware offers.

		Linus
