Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbUKFDpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbUKFDpP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 22:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbUKFDpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 22:45:15 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:53013 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261301AbUKFDpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 22:45:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=YrP8UXGtcJMHe7cd9Y8d5wwVowtCLmXQRVIW7ovR63L/0zBJbY66Gc12tt4QVFtQhvMBAbStkbpuIkiWy5X24tL/TEEAmKrwuPUQQjvsbWtjKJgHlV2XnvR5+v0JynneuJAV5CZmo4b6GSn/C2jDlEHayUv9lJQUdwQCtuzoDyM=
Message-ID: <8783be660411051945252097c3@mail.gmail.com>
Date: Fri, 5 Nov 2004 22:45:04 -0500
From: Ross Biro <ross.biro@gmail.com>
Reply-To: Ross Biro <ross.biro@gmail.com>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: [PATCH 2/3] WIN_* -> ATA_CMD_* conversion: update WIN_* users to use ATA_CMD_*
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041106032314.GC6060@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041103091101.GC22469@taniwha.stupidest.org>
	 <418AE8C0.3040205@pobox.com>
	 <58cb370e041105051635c15281@mail.gmail.com>
	 <20041106032314.GC6060@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2004 19:23:14 -0800, Chris Wedgwood <cw@f00f.org> wrote:
> @@ -434,7 +434,7 @@
>                 try_to_flush_leftover_data(drive);
>         if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT)) {
>                 /* force an abort */
> -               hwif->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
> +               hwif->OUTB(ATA_CMD_IDLEIMMEDIATE,IDE_COMMAND_REG);
>         }
>         if (rq->errors >= ERROR_MAX || blk_noretry_request(rq))
>                 DRIVER(drive)->end_request(drive, 0, 0);

Just a reminder, this error recovery doesn't work on many modern hard
drives, and is a violation of all ATA specs after ATA-2*.  In
particular, most Maxtor and Western Digital Drives will not recover
from errors with this command sequence.  The preferred error recovery
is to do a reset followed by a set features, because that is what
Windows does (as told to me by a drive vendor).  I've tested the
reset/set features method of error recovery and it works on all the
drives I've tried.  I have not tried it on any older drives, or any
other types of ATAPI devices.

    Ross

*Most drives set the ATA-2 support flag, so technically they are in
violation of the ATA spec if they don't support this error recovery,
but the drive vendors don't care, they just make sure it works with
windows.
