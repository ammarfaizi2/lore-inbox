Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290827AbSAaCC2>; Wed, 30 Jan 2002 21:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290830AbSAaCCS>; Wed, 30 Jan 2002 21:02:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7954 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290827AbSAaCCH>;
	Wed, 30 Jan 2002 21:02:07 -0500
Message-ID: <3C58A3F3.7F1002D9@zip.com.au>
Date: Wed, 30 Jan 2002 17:54:59 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ryan Mack <rmack@mackman.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] dmesg: "invalidate: busy buffer"
In-Reply-To: <Pine.LNX.4.44.0201301717340.9601-100000@mackman.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Mack wrote:
> 
> The last two days my dmesg buffer has be filled with "invalidate: busy
> buffer" messages.  I tried rebooting (and forcing a fsck), but after about
> 12 hours they came back.
> 
> I'm running 2.4.17 on a dual P3, Intel 440BX chipset.  Both filesystems
> are raid mirrored, ext3, ordered-data mode.  One mirrored pair is on a
> Adaptec AHA-2940U2/W controller (actually, this is running in degraded
> mode, damn defective IBM UltraStar failed on me).  The other mirrored pair
> is on two Intel PIIX4 IDE controllers.
> 
> Since one of the raid pairs is down to a single drive, I've been backing
> it up to the other mirrored pair nightly using dump 0.4b22 and, more
> recently, dump 0.4b26.

This is due to some userspace application calling
ioctl(BLKFLSBUF);  The kernel calls invalidate_buffers()
against a live device so it can of course sometimes
encounter a locked buffer, and it spits this message.

> Any thoughts what's causing this?  Am I at risk for data loss?

No, there's no risk.  I think the invalidate_buffers()
call should only be made within the ioctl if the device's
usage count is one, but various kernel luminaries didn't
like the idea, for reasons which I failed to understand :)

-
