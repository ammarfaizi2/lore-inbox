Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161096AbWBPNd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161096AbWBPNd0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 08:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161099AbWBPNd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 08:33:26 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:41490 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161096AbWBPNdZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 08:33:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qGkji2m4y6uglYGGKcomc/aJa4sTo+NbbRnD6+zIPBhT3N7ghhw2R8PkocVnei1Tpzr6l/YnOjPj1Kx4GnGbkuGSlfnxCH05kVjHoZDdtSlknuQZsKKJJ/sGs/wLO8Kap1ClMRtMTBYT/03lT1HBOSWd6zwS7zO+SR2vU7EFGQw=
Message-ID: <58cb370e0602160533n3325ba03yfedaf4e55278521d@mail.gmail.com>
Date: Thu, 16 Feb 2006 14:33:22 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] kernel 2.6.15.4: soft lockup detected on CPU#0!
Cc: Charles-Edouard Ruault <ce@ruault.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060215185120.6c35eca2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43EF8388.10202@ruault.com> <20060215185120.6c35eca2.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/06, Andrew Morton <akpm@osdl.org> wrote:
> Charles-Edouard Ruault <ce@ruault.com> wrote:
> >
> > i was trying to rip a CD when the whole machine started to freeze
> >  periodicaly, i then looked at the logs and found the following :
> >
> >  Feb 12 19:23:39 ruault kernel: hdc: irq timeout: status=0x80 { Busy }
> >  Feb 12 19:23:39 ruault kernel: ide: failed opcode was: unknown
> >  Feb 12 19:23:39 ruault kernel: hdd: status timeout: status=0x80 { Busy }
> >  Feb 12 19:23:39 ruault kernel: ide: failed opcode was: unknown
> >  Feb 12 19:23:39 ruault kernel: hdd: drive not ready for command
>
> No idea what caused that.
>
> >  Feb 12 19:23:39 ruault kernel: BUG: soft lockup detected on CPU#0!
>
> The following was merged today.  Hopefully it suppresses this false
> positive.

Unfortunately it won't.  Charles' problem is different (and the BUG
output is different!) - soft lockup got triggered for PIO handling in
ide-cd driver.  This patch fixes the problem only for generic ATA PIO
routines (disks and [P]IDENTIFY), ATAPI PIO still needs fixing
(ide-cd/floppy/tape/scsi drivers).

Andrew, there is no "high level" function for ATAPI PIO as
ide_pio_datablock() for ATA PIO so fixing soft lockup false positives
would require going through all drivers and adding bunch of
touch_softlockup_watchdog() or using sledge-hammer approach
and touching watchdog in ide-iops.c:atapi_[input,output]_bytes().

BTW Charles' OOPS is for tainted (P) kernel (fglrx loaded)

Bartlomiej
