Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbULVMEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbULVMEo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 07:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbULVMEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 07:04:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:24508 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261974AbULVMAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 07:00:16 -0500
Subject: Re: [PATCH] USB: fix Scheduling while atomic warning when resuming.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <41C905C0.9000705@pobox.com>
References: <200412220103.iBM13wS0002158@hera.kernel.org>
	 <200412212022.52316.david-b@pacbell.net> <41C8FC25.2060304@pobox.com>
	 <200412212059.15426.david-b@pacbell.net>  <41C905C0.9000705@pobox.com>
Content-Type: text/plain
Date: Wed, 22 Dec 2004 12:59:28 +0100
Message-Id: <1103716768.28670.61.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If the PCI layer is calling the resume method for a PCI device while 
> simultaneously calling the suspend method, that's a PCI layer problem. 
> Similarly, If the USB layer is calling into your driver while you are 
> resuming, something is broken and it ain't your locking.

Actually, the later isn't broken, something may well call into the
higher level USB drivers while resuming, but indeed, those shouldn't
send any URB down the stack when the bus is suspended, and the EHCI
driver should drop incoming URBs as well until fully resumed.

I think the lock here is only needed to protect the HCD state
transitions David, no ? All we need is make sure that we don't let
things get queued (or call into EHCI code path that will end up
touch the HW) while suspended.

Ben.


