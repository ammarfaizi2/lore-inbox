Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267748AbTBGJO0>; Fri, 7 Feb 2003 04:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267749AbTBGJO0>; Fri, 7 Feb 2003 04:14:26 -0500
Received: from angband.namesys.com ([212.16.7.85]:46468 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S267748AbTBGJOZ>; Fri, 7 Feb 2003 04:14:25 -0500
Date: Fri, 7 Feb 2003 12:23:57 +0300
From: Oleg Drokin <green@namesys.com>
To: niteowl@intrinsity.com
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       andre@linux-ide.org, axboe@suse.de
Subject: Re: 2.5.59 kernel bugs
Message-ID: <20030207122357.A30922@namesys.com>
References: <200302062043.h16KhHY05212@bletchley.vert.intrinsity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302062043.h16KhHY05212@bletchley.vert.intrinsity.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Feb 06, 2003 at 02:43:17PM -0600, niteowl@intrinsity.com wrote:

Also similar stuff in IDE code in 2.4.21-pre4 from bk tree:

> ===== misplaced/extra semicolon =====
drivers/ide/ide-taskfile.c:247		if (drive->using_dma && !(hwif->ide_dma_write(drive)));
drivers/ide/ide-taskfile.c:253		if (drive->using_dma && !(hwif->ide_dma_read(drive)));

At least looking at another similar code that is ifdefed out, it seems below patch is correct.
(and even if it's not, still that code should be changed not to confuse people ;) )

Also I took a look at drivers/ide/ide-taskfile.c in 2.5 hoping I can see what should
be in fact done and got even more confused ;)
Sounds like in 2.5 there should be "return ide_started" at the end, not stopped,
because otherwise when drive->using_dma is set, we always return ide_stopped for
WIN_WRITEDMA.*, WIN_IDENTIFY_DMA and WIN_READDMA, WIN_READDMA_ONCE, WIN_READDMA_EXT
taskfile->command and default case is the same (we check stuff, and then regardless
or the result of the check we always return ide_stopped).
Which looks somehow strange (and different from similar code in 2.4).
Can please somebody take a look at it?

Bye,
    Oleg

===== drivers/ide/ide-taskfile.c 1.2 vs edited =====
--- 1.2/drivers/ide/ide-taskfile.c	Thu Nov 14 20:38:17 2002
+++ edited/drivers/ide/ide-taskfile.c	Fri Feb  7 11:56:59 2003
@@ -244,13 +244,13 @@
 		case WIN_WRITEDMA_ONCE:
 		case WIN_WRITEDMA:
 		case WIN_WRITEDMA_EXT:
-			if (drive->using_dma && !(hwif->ide_dma_write(drive)));
+			if (drive->using_dma && !(hwif->ide_dma_write(drive)))
 				return ide_started;
 		case WIN_READDMA_ONCE:
 		case WIN_READDMA:
 		case WIN_READDMA_EXT:
 		case WIN_IDENTIFY_DMA:
-			if (drive->using_dma && !(hwif->ide_dma_read(drive)));
+			if (drive->using_dma && !(hwif->ide_dma_read(drive)))
 				return ide_started;
 		default:
 			break;
