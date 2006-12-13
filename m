Return-Path: <linux-kernel-owner+w=401wt.eu-S1751744AbWLMX3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbWLMX3A (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 18:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbWLMX3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 18:29:00 -0500
Received: from smtp.osdl.org ([65.172.181.25]:56511 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743AbWLMX27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 18:28:59 -0500
Date: Wed, 13 Dec 2006 15:28:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
In-Reply-To: <Pine.LNX.4.61.0612132219480.32433@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0612131522310.5718@woody.osdl.org>
References: <20061213195226.GA6736@kroah.com>  <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
 <1166044471.11914.195.camel@localhost.localdomain>
 <Pine.LNX.4.61.0612132219480.32433@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2006, Jan Engelhardt wrote:
> 
> For the sharing case, some sort of softirq should be created. That is, when a
> hard interrupt is generated and the irq handler is executed, set a flag that at
> some other point in time, the irq is delivered to userspace. Like you do with
> signals in userspace:

NO.

The whole point is, YOU CANNOT DO THIS.

You need to shut the device up. Otherwise it keeps screaming.

Please, people, don't confuse the issue any further. A hardware driver

	ABSOLUTELY POSITIVELY HAS TO

have an in-kernel irq handler that knows how to turn the irq off.

End of story. No ifs, buts, maybes about it.

You cannot have a generic kernel driver that doesn't know about the 
low-level hardware (not with current hardware - you could make the "shut 
the f*ck up" a generic thing if you designed hardware properly, but that 
simply does not exist in general right now).

In short: a user-space device driver has exactly TWO choices:

 - don't use interrupts at all, just polling

 - have an in-kernel irq handler that at a minimum knows how to test 
   whether the irq came from that device and knows how to shut it up.

This means NOT A GENERIC DRIVER. That simply isn't an option on the 
table, no matter how much people would like it to be.

			Linus
