Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVAMQoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVAMQoX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 11:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVAMQnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:43:40 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:25060 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261220AbVAMQkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:40:52 -0500
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: brking@us.ibm.com
Cc: Andi Kleen <ak@muc.de>, paulus@samba.org, benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41E45089.4010006@us.ibm.com>
References: <200501101449.j0AEnWYF020850@d03av01.boulder.ibm.com>
	 <m14qhpxo2j.fsf@muc.de> <41E2AC74.9090904@us.ibm.com>
	 <20050110162950.GB14039@muc.de> <41E3086D.90506@us.ibm.com>
	 <1105454259.15794.7.camel@localhost.localdomain>
	 <20050111173332.GA17077@muc.de>  <41E45089.4010006@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105626729.4644.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 15:36:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-11 at 22:17, Brian King wrote:
> Andi Kleen wrote:
> We can certainly go either way. I decided to go the way I did simply 
> because that was what was suggested.

The error case breaks X11. The cached approach of Ben's would probably
hide that nicely although it might cause some random crashes during
powerdown. Its hard to fix in user space because X has no idea how to
tell what is going on portably in the 'it broke' case other than spin
trying to for a while. The kernel knows what is up and can make an
intelligent decision - if the device doesn't come back from bist or we
need to mark devices as "very gone away" then maybe a second flag so we
have two user checked flags

	In BIST - wait
	Dead - error

> cycles and may even deadlock the system. This usage would require the 
> ability to block userspace for an indefinite period of time and also 
> make use of the config space caching code that is in my patch.

What if the user space you block holds a resource that is preventing
power down completing ? I can see how the kernel side stuff needs to be
more robust (bad news btw.. over 99% of pci config calls in the kernel
don't check the return according to a quick grep count. Good news is
they are almost all reads so caching ought to work for the main config
space stuff at least)

Caching doesn't however work for the cases like IRQ handlers but that
seems not to be problematic as the only "other device" stuff people
should be sticking their noses in except for bridge fixup stuff is
things like the BAR registers.

Alan

