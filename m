Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbTGIJUO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 05:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265882AbTGIJUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 05:20:14 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:34003 "EHLO gaston")
	by vger.kernel.org with ESMTP id S265879AbTGIJUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 05:20:10 -0400
Subject: Re: 2.4.21 IDE and IEEE1394+SBP2 regressions, orinoco_pci progress
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zygo Blaxell <uixjjji1@umail.furryterror.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <pan.2003.07.08.22.25.12.249185.15455@umail.hungrycats.org>
References: <pan.2003.07.08.22.25.12.249185.15455@umail.hungrycats.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1057743274.506.4.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 09 Jul 2003 11:34:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-09 at 04:49, Zygo Blaxell wrote:
> Previously on kernels up to 2.4.20, an IDE disk I/O request that was in
> progress at suspend time would trigger a DMA reset upon resume, after a
> short delay while waiting for the timeout.  2.4.20 looked like this:
> 
>         ide_dmaproc: chipset supported ide_dma_lostirq func only: 13 hda:
>         lost interrupt
> 
> After this, the machine happily resumes whatever it was doing.  There is a
> delay of a few seconds while this happens.
> 
> Now in 2.4.21, the kernel prints the following message:
> 
>         hda: dma_timer_expiry: dma status == 0x04
> 
> and that's the last thing it ever does--the kernel locks up hard.

Whatever happens, you shouldn't let the machine suspend while ongoing
disk IOs are in progress. A lot of bad things could result from that.

Actually, the proper fix is to implement some working suspend/resume
handlers in the IDE layer like we did in 2.5, though the problem here
is that 2.4 lacks proper infrastructure for doing that in a properly
ordered way.

> Note that in order to see this you need to be doing a lot of I/O at
> suspend time, e.g. 'cp -a /usr /tmp' or some such thing.
> 
> Also in 2.4.21, a filesystem mounted from a CD-ROM via ide-scsi will start
> to get I/O errors if it is accessed during the suspend/resume sequence. 
> In 2.4.20, there were no ill effects when this happens.

Same thing. You need the driver to block requests during that sequence,
and to complete any pending one before suspend is entered.


