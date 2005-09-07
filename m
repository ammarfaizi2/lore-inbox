Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbVIGTHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVIGTHT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 15:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbVIGTHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 15:07:19 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:5893 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751261AbVIGTHR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 15:07:17 -0400
Date: Wed, 7 Sep 2005 21:07:53 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Request only really used I/O ports in w83627hf driver
Message-Id: <20050907210753.3dbad61b.khali@linux-fr.org>
In-Reply-To: <20050907181415.GA468@vana.vc.cvut.cz>
References: <20050907181415.GA468@vana.vc.cvut.cz>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

> my motherboard (Tyan S2885) reports range 295-296 in its PNP hardware
> descriptors, and due to this w83627hf driver fails to load, as it
> requests 290-297 range, which is not subrange of this PNP resource. 
> As hardware monitor chip responds to 295/296 addresses only, there is
> no reason to request full 8 byte I/O.

Another point of view would be: as the physical address of the chip is
0x290-0x297, there is no reason to even think of requesting a different
range. And there is a very valid reason to request the full 8 byte I/O
range: to let the user know that this range is not available for other
devices. Mapping another device to the unused I/O ports of the W83627HF
would not work, right? Also consider that future chips of this family
could use additional ports.

The cause of your trouble is, IMVHO, a buggy BIOS. Ask Tyan to fix their
BIOS to allocate the real I/O range to the W83627HF chip, and you're
done.

http://bugzilla.kernel.org/show_bug.cgi?id=4014

Your fix might come in handy for your own situation, but it looks wrong
in the long run. We are not going to shrink the requested I/O range of
every random driver each time a motherboard manufacturer releases a
buggy BIOS.

If getting the manufacturers to provide fixed BIOSes doesn't seem to be
feasable, then the PNPACPI code certainly needs to be extended to handle
this case transparently. This could be achived using quirks similar to
what we have for PCI, or PNPACPI could simply accept requests of I/O
ranges which include a single PNP range as defined by the BIOS. Note
that everything was working just fine for everyone before PNPACPI was
added to the kernel.

> While I was doing that, I also changed W83781D_*_REG_OFFSET definitions
> from 5/6 to 0/1.  Code is a bit smaller after doing that, and it looks
> better now since we do not allocate full 8 byte range.

I find this change rather confusing myself, and it makes the code
bigger, not smaller.

-- 
Jean Delvare
