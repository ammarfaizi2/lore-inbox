Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbUCPPfS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbUCPPcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 10:32:41 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:2183 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263092AbUCPPcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 10:32:14 -0500
Date: Tue, 16 Mar 2004 15:30:19 +0000
From: Dave Jones <davej@redhat.com>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       jgarzik@pobox.com
Subject: Re: [3C509] Fix sysfs leak.
Message-ID: <20040316153018.GB17958@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marc Zyngier <mzyngier@freesurf.fr>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org, akpm@osdl.org, jgarzik@pobox.com
References: <200403152147.i2FLl09s002942@delerium.codemonkey.org.uk> <wrpad2hf4be.fsf@panther.wild-wind.fr.eu.org> <20040316134613.GA15600@redhat.com> <wrp3c88g9xu.fsf@panther.wild-wind.fr.eu.org> <20040316142951.GA17958@redhat.com> <wrpwu5kessd.fsf@panther.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrpwu5kessd.fsf@panther.wild-wind.fr.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 04:05:38PM +0100, Marc Zyngier wrote:
 > >>>>> "Dave" == Dave Jones <davej@redhat.com> writes:
 > 
 > Dave,
 > 
 > Dave> The damned bus doesn't even exist. If this is a case that couldn't be
 > Dave> detected, I'd not be complaining, but this is just nonsense having
 > Dave> a driver claim that its found an EISA device, when there aren't even
 > Dave> any EISA slots on the board.
 > 
 > The driver doesn't claim to have found any device. It just registered
 > to the EISA framework, which you compiled in for a reason.

which is valid for a single kernel image that supports boxes both with
and without eisa (ie, vendor kernels).

 > Unload the driver and the directory will go.

no it doesn't, which is the whole purpose of the patch I sent.
try it..

modprobe 3c509
lsmod | grep 3c509     # module didnt stay around
find /sys | grep 3c509 # oh look, it left crap in sysfs


 > Dave> This happens long after bus initialisation should have already figured
 > Dave> out that the bus doesn't exist. Even if it was left this late, the
 > Dave> eisa registration code should be doing a 'oh, I've not even checked
 > Dave> if I have a bus yet, I'll do it now' before it starts doing completely
 > Dave> bogus things like checking for devices.
 > 
 > Sure. When EISA bus is hanging off the PCI bus, which haven't been
 > probed yet ?

We have multiple levels of initcalls for a reason. Whilst they suck in a lot
of ways, they can be used to enforce dependancies like this.

 > When the driver registers, the EISA framework may not
 > have a f*cking clue about where the EISA bus sits, or if it even
 > exists.

Why is this even an issue so late on? Bus probing should have been done as
part of bootup. By the time I get to modprobing device drivers, it should have
been determined already.

Your argument seems to be "probing is hard, so we don't do it", which is
just *wrong*.

		Dave

