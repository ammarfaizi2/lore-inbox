Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbVLGQDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVLGQDz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 11:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVLGQDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 11:03:54 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:29918 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750793AbVLGQDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 11:03:54 -0500
Subject: Re: [linux-usb-devel] Re: [PATCH 00/10] usb-serial: Switches from
	spin lock to atomic_t.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oliver Neukum <oliver@neukum.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net,
       Eduardo Pereira Habkost <ehabkost@mandriva.com>,
       Greg KH <gregkh@suse.de>,
       Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200512071650.01439.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0512071000120.21143-100000@iolanthe.rowland.org>
	 <200512071637.40018.oliver@neukum.org>
	 <1133970015.2869.31.camel@laptopd505.fenrus.org>
	 <200512071650.01439.oliver@neukum.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 07 Dec 2005 16:02:07 +0000
Message-Id: <1133971327.544.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-12-07 at 16:50 +0100, Oliver Neukum wrote:
> But the atomic variant has to guard against interrupts, at least on
> architectures that do load/store only, hasn't it?

Yes. And you will see at least four different approaches 

1. ll/sc where if the sequence was interrupted and may be stale it gets
retried

2. locked operations where the IRQ cannot split the sequence and use of 

3. spin locks to provide atomic operations where there are architecture
limits

4. Use of instructions acting on memory where the CPU in question has
them and (as is usual in processors) does not permit an IRQ mid
instruction.

Thus on x86

	*foo++

might be atomic, might not on uniprocessor v interrupt solely because
the compiler chooses the operations. Atomic_inc however merely has to
use asm to force an inc of a memory location target. That instruction
cannot be split part way by an interrupt so is sufficient.

Relative efficiency of spin_lock versus atomic_foo is very platform
dependant.

