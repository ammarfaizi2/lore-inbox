Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263794AbSKDIKO>; Mon, 4 Nov 2002 03:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265978AbSKDIKN>; Mon, 4 Nov 2002 03:10:13 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:15283 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263794AbSKDIKN>; Mon, 4 Nov 2002 03:10:13 -0500
From: <benh@kernel.crashing.org>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Pavel Machek" <pavel@ucw.cz>
Cc: "Linus Torvalds" <torvalds@transmeta.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
Date: Mon, 4 Nov 2002 09:16:24 +0100
Message-Id: <20021104081624.27128@smtp.wanadoo.fr>
In-Reply-To: <1036367813.30679.40.camel@irongate.swansea.linux.org.uk>
References: <1036367813.30679.40.camel@irongate.swansea.linux.org.uk>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>S4 the bios has spun the disks back up, S3 we may need to let the disks
>perform the IDE power on and diskware load. Ben has some possible code
>for that

On pmac, I just hard reset them as I have GPIOs to control
the disk reset line, then wait for BSY to go away. We need something
smarter for the generic case, typically a mix of ATA/ATAPI reset,
and eventually execute diagnostics. I need to talk to Andre a bit
about it.

Also, I know at least of one nasty device here that won't play
nice unless it gets the identify command after reset (special
hacked device that lies about it's device type, a ZIP that
masquerades as an IDE-CD, to workaround firmware bugs in some
older laptops, ugh !)

For now, I suspect sending an ATA reset or ATAPI reset depending
on the device type, and making sure BSY is gone should cover
most cases though.

For disks, you may also need to redo the LBA setting (never played
with that, I only own sane enough disks...) and  the SET_FEATURE for
PIO & DMA modes (provided your host controller chipset driver
saves & restore them).
But with the current design we have, this should probably be done
by the host chipset driver too. In 2.4, I just re-do a dma_check()
at the end of the resume phase, but that's incomplete in theory.

Ben.


