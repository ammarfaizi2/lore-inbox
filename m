Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268401AbUHYHDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268401AbUHYHDH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 03:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268464AbUHYHDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 03:03:06 -0400
Received: from gate.crashing.org ([63.228.1.57]:20661 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268463AbUHYHCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 03:02:50 -0400
Subject: Re: [RFC&PATCH 1/2] PCI Error Recovery (readX_check)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0408232231070.17766@ppc970.osdl.org>
References: <412AD123.8050605@jp.fujitsu.com>
	 <Pine.LNX.4.58.0408232231070.17766@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1093417267.2170.47.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 25 Aug 2004 17:01:08 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 15:41, Linus Torvalds wrote:

> Just make "clear_pci_errors()" take a spinlock on the bridge, and 
> "read_pci_errors()" unlock it. We need to make sure that if multiple 
> devices on the same bridge try to be careful, they can do so without 
> seeing each others errors.
> 
> readX_check() itself would do no locking at all, since it is already 
> called with the assumption that the bridge has been locked.
> 
> I'd also suggest that you make "clear_pci_errors()" return a cookie for 
> read_pci_errors() to use. 

Well, I'm not sure about all this... part of the problem is that drivers
commonly need to also do IOs from interrupts. And another driver may
"pollute" us too, depending on how the HW & bridge are designed. So we
really also want to disable interrupts, we may need a "flags" around (could
be burried into the cookie stuff though as an arch specific thing)

Most drivers already have such a low level lock though, so we may end
up replacing it with a bridge-based lock... but depending on the architecture,
that would end up sync'ing lots of drivers on the same lock, which may not
be good especially if we have no checking to do... 

I don't know what is the best thing to do here... The arch is the one to
know what is the granularity of the error management (per slot ? per segment
or per domain ?) and so to know what kind of lock is needed...

Ben.


