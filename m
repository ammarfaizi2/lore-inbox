Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265995AbTAFEh5>; Sun, 5 Jan 2003 23:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265998AbTAFEh4>; Sun, 5 Jan 2003 23:37:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58636 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265995AbTAFEh4>; Sun, 5 Jan 2003 23:37:56 -0500
Date: Sun, 5 Jan 2003 20:14:53 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, <davidm@hpl.hp.com>,
       <grundler@cup.hp.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs
In-Reply-To: <20030105153735.A8532@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.44.0301052009050.3087-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 5 Jan 2003, Ivan Kokshaysky wrote:
>
> Hopefully this patch should solve most problems with probing the BARs.
> The changes are quite minimal as everything still is done in one pass.

Can you do the same with a multi-pass thing? 

I really think the single-pass approach is broken, because it means that
we _cannot_ have a fixup for device that runs _before_ the fixup for the 
bridge that bridges to the device.

As such, the "PCI_FIXUP_EARLY" is not _nearly_ early enough, since it's
way too late for the actual problem that started this whole thread (ie in
order to turn off a bridge, we have to make sure that everything behind
the bridge is turned off _first_).

In other words, we really should be able to do all the bus number setup
_first_. That isn't dependent ont eh BAR's or anything else. The actual 
_sizing_ of the bus is clearly somethign we cannot do early, but we can 
(and should) enumerate the devices first in phase #1.

Alternatively, we could even have a very limited phase #1 that only 
enumerates _reachable_ devices (ie it doesn't even try to create bus 
numbers, it only enumerates devices and buses that have already been set 
up by the firmware, and ignores bridges that aren't set up yet). A pure 
discovery phase, without any configuration at all.

Hmm?

		Linus

