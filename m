Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVBNXIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVBNXIf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 18:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVBNXIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 18:08:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:54765 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261278AbVBNXId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 18:08:33 -0500
Subject: Re: Radeon FB troubles with recent kernels
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, adaplas@pol.net
In-Reply-To: <1108420723.12740.17.camel@gaston>
References: <20050214203902.GH15058@waste.org>
	 <1108420723.12740.17.camel@gaston>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 10:08:11 +1100
Message-Id: <1108422492.12653.30.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Appeared ? hah... that's strange. X is known to fuck up the chip when
> quit, but I wouldn't have expected any change due to the new version of
> radeonfb. From what you describe, it looks like an offset register is
> changed by X, or the surface control.
> 
> My patch did not change any of radeonfb accel code though...
> 
> I'll catch up with you on IRC ...

Ok, from our discussions, it's not related to the power management code,
and an engine reset triggered by fbset fixes it. So at this point, I can
see no change in the driver explaining it...

We did some changes to the VT layer to force a mode setting (and thus an
engine reset) when going away from X, so I can't see why that wouldn't
work, while using fbset later on works ... this goes through the same
code path in the driver... unless we are facing a timing issue...

X is known to play funny tricks, like touching the engine when it's in
the background (not frontmost VT) and quit, or possibly other bad things
on console switch. Maybe I changed enough delays (speeded up) the mode
switch so that we fall into a case where X has not finished mucking up
with us...

Can you try adding some msleep(200) or so at the beginning at
radeonfb_set_par() or radeon_write_mode() to see if that makes any
difference ?

Some printk's in there would help to... I expect calls to
radeon_engine_init() to fix it and such a call is present in the mode
restore unless accel is disabled...

Can you check what's happening ?

Ben.


