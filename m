Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423419AbWBBJhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423419AbWBBJhO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 04:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423424AbWBBJhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 04:37:14 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50441 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1423419AbWBBJhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 04:37:13 -0500
Date: Thu, 2 Feb 2006 09:36:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Purpose of MMC_DATA_MULTI?
Message-ID: <20060202093656.GA5034@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <43E057DA.7000909@drzeus.cx> <20060201092934.GB27735@flint.arm.linux.org.uk> <43E08148.3060003@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E08148.3060003@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 10:37:12AM +0100, Pierre Ossman wrote:
> Russell King wrote:
> > On Wed, Feb 01, 2006 at 07:40:26AM +0100, Pierre Ossman wrote:
> >> I noticed that a new transfer flag was recently added to the MMC layer
> >> without any immediate users, the MMC_DATA_MULTI flag. I'm guessing the
> >> purpose of the flag is to indicate the difference between
> >> MMC_READ_SINGLE_BLOCK and MMC_READ_MULTIPLE_BLOCKS with just one block.
> >> If so, then that should probably be mentioned in a comment somewhere.
> >>     
> >
> > There are hosts out there (Atmel AT91-based) which need to know if the
> > transfer is going to be multiple block.  Rather than have them test
> > the op-code (which is what they're already doing), we provide a flag
> > instead.
> 
> As far as the hardware is concerned there are two "multi-block" transfers:
> 
>  * Multiple, back-to-back blocks.
>  * One or more blocks that need to be terminated by some form of stop
> command.
> 
> The first can be identified by checking the number of blocks in the
> request, the latter is harder to identify since it's a protocol semantic
> (it could be just one block, but still need a stop). Does MMC_DATA_MULTI
> indicate the latter, former or both?

In short, it's defined to be whatever AT91_MCI_TRTYP_MULTIPLE means in
the AT91RM9200 MMC host driver, which appears to be set for any of the
multiple block commands.  They currently are doing:

+static const u32 commands[64] = {
+       /* Class 1  (0) */
+       MMC_GO_IDLE_STATE,
+       MMC_SEND_OP_COND        | AT91_MCI_RSPTYP_48,
+       MMC_ALL_SEND_CID        | AT91_MCI_RSPTYP_136,
+       MMC_SET_RELATIVE_ADDR   | AT91_MCI_RSPTYP_48    | AT91_MCI_MAXLAT,
+       MMC_SET_DSR             | AT91_MCI_MAXLAT,
...
+       MMC_READ_SINGLE_BLOCK   | AT91_MCI_RSPTYP_48    | AT91_MCI_MAXLAT | AT91_MCI_TRDIR | AT91_MCI_TRCMD_START | AT91_MCI_TRTYP_BLOCK,
+       MMC_READ_MULTIPLE_BLOCK | AT91_MCI_RSPTYP_48    | AT91_MCI_MAXLAT | AT91_MCI_TRDIR | AT91_MCI_TRCMD_START | AT91_MCI_TRTYP_MULTIPLE,
...
+       MMC_WRITE_BLOCK         | AT91_MCI_RSPTYP_48    | AT91_MCI_MAXLAT | AT91_MCI_TRCMD_START | AT91_MCI_TRTYP_BLOCK,
+       MMC_WRITE_MULTIPLE_BLOCK| AT91_MCI_RSPTYP_48    | AT91_MCI_MAXLAT | AT91_MCI_TRCMD_START | AT91_MCI_TRTYP_MULTIPLE,

and using that as a lookup table by command for the value to put into
the command register.  I want to eliminate that, and not passing the
MULTI flag prevents elimination of this table.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
