Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161507AbWAMJTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161507AbWAMJTX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 04:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161509AbWAMJTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 04:19:22 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:62882 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161506AbWAMJTV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 04:19:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nNRW6CyNjN7ggpX2YMtyAB+jvPX0PW8nGWTAtcCp5FKxFJ1iCXZLS5lfBLPw9FmsrvaecHTGc0+Zng4RZIQ9aBrBbEWnVNA21WzdIBjBoN+J0yaYvsVqURKWrhHTruw0uhc3NZ1umwwPBRvdAR6y85OBXwblc/y5GE9iXM7kHZ0=
Message-ID: <58cb370e0601130119g5c62b749r1bc5da59a0d4a56c@mail.gmail.com>
Date: Fri, 13 Jan 2006 10:19:17 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Volker Kuhlmann <list0570@paradise.net.nz>
Subject: Re: ide-cd turning off DMA when verifying DVD-R
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <20060113083009.GE12338@paradise.net.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5ujmU-1UQ-665@gated-at.bofh.it> <5uoqr-Qq-7@gated-at.bofh.it>
	 <43C72F41.5060207@shaw.ca> <20060113083009.GE12338@paradise.net.nz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/13/06, Volker Kuhlmann <list0570@paradise.net.nz> wrote:
> On Fri 13 Jan 2006 17:40:33 NZDT +1300, Robert Hancock wrote:
>
> > I'm thinking the IDE code is too aggressive in assuming that the failure
> >  is because of a DMA problem and disabling it.. Most likely all that's
> > happening is the drive is taking a long time to complete the current
> > command.

What actually happened is that normal command timed out
and because of that driver reset the device which caused
it to loose DMA:

->ide_atapi_error()
    ->ide_do_reset()
      ->pre_reset()
        ->check_dma_crc()
          ->__ide_dma_off()

Somebody needs to investigate why __ide_dma_off() is called
et all and if we need to restore DMA after reset (don't count ATM
on me, I'm buried by bugreports).  Ondrej, could you fill the bug at
http://bugzilla.kernel.org so we don't lose it?

> Yes! Each time when inserting a faulty CD/DVD, or whenever the drive
> gives read errors for whatever reason, the kernel decides to turn DMA
> off and try again, fail (again) and leave DMA off. And this after having
> successfully used DMA before - so it's not that the device is
> DMA-incapable.

This is a separate issue and is related to retrying failed DMA
commands.  Driver doesn't know what was the cause of the timeout
and it shouldn't disable DMA for the device (only the failed request
should be retried in PIO mode).

Any takers? :)

PS1 please don't trim cc: list
PS2 please use linux-ide@vger.kernel.org for ATA problem

Thanks,
Bartlomiej
