Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262009AbRFBWvk>; Sat, 2 Jun 2001 18:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262022AbRFBWvb>; Sat, 2 Jun 2001 18:51:31 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21009 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262009AbRFBWvO>; Sat, 2 Jun 2001 18:51:14 -0400
Subject: Re: Reading from /dev/fb0 very slow?
To: pavel@suse.cz (Pavel Machek)
Date: Sat, 2 Jun 2001 23:49:25 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20010603004655.E2434@atrey.karlin.mff.cuni.cz> from "Pavel Machek" at Jun 03, 2001 12:46:55 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156KCz-0002GO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately, at least X and few framebuffer modes can not survive
> that too well.

Actually most X servers are heavily optimised to avoid video->video copies and
use the accelerators. If you are using the frame buffer X server then yes
it can be a problem but look up 'shadowfb'.

> > Writes to a PCI device can be queued or posted. Reads from a PCI device for
> > obvious reasons have to stall the CPU until the data returns. 
> 
> But they can't be posted indifinitely, right? I'm copying whole
> framebuffer at a time, I do not believe PCI has enough buffers to
> cache *that*. [Or is it using some kind of burst mode it can not use
> for reading? That does not give a sense, you can cache reads, too....]

Your writes are running at bus speed. Assuming the video ram has an mtrr for
write combining you are doing full bursts. When you read the sequence instead
is

	issue read
	stall cpu
	pci cycle goes out for one longword
	pci cycle hits the video card
	video card replies a longword
	cpu gets it

So the entire pci bus latency is directly biting you for each fetch.

Alan

