Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbUC2NSp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 08:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbUC2NHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 08:07:39 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:11165
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262939AbUC2NEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 08:04:16 -0500
Date: Mon, 29 Mar 2004 15:04:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040329130410.GH3039@dualathlon.random>
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl> <406720A7.1050501@pobox.com> <20040329005502.GG3039@dualathlon.random> <40679FE3.3080007@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40679FE3.3080007@pobox.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2004 at 11:02:43PM -0500, Jeff Garzik wrote:
> My point is there are two maximums:
> 
> 1) the hardware limit
> 2) the limit that "makes sense", e.g. 512k or 1M for most
> 
> The driver should only care about #1, and should be "told" #2.
> 
> A very, very, very minimal implementation could be this:
> 
> --- 1.138/include/linux/blkdev.h        Fri Mar 12 04:33:07 2004
> +++ edited/include/linux/blkdev.h       Sun Mar 28 22:44:15 2004
> @@ -607,6 +607,24 @@
> 
>  extern void drive_stat_acct(struct request *, int, int);
> 
> +#define BLK_DISK_MAX_SECTORS   2048
> +#define BLK_FLOPPY_MAX_SECTORS 64
> 
> 
> Hardcoding such a maximum in the driver is inflexible and IMO incorrect.

you're complaining the current API and you're arguing long term the
selection of the dma size for bulk I/O should change and be more
dynamic, but this doesn't change your patch is still wrong today.

Once you change the API too, then you can set the hardwre limit in your
driver and relay on the highlevel blkdev code to find the optimal runtime
dma size for bulk I/O, but today it's your driver that is enforcing a
runtime bulk dma size, not the maximim limit of the controller, and so
you should code your patch accordingly.

Probably both VM and I/O scheduler will require an override if we're
going to set the dma size to 32M anytime in the future (though even that
isn't obvious, I mean a battery backed ram isn't going to take that a
long latency to read/write 32M). But that VM/IOscheduler stuff will be
an "override", the blkdev value you're playing with is a blkdev-only
thing indipdentent from VM and I/O scheduler, and it's the min dma size
required to reach bulk I/O performance with minimal cpu overhead and
that's just an hardware issue that you can measure with an OS w/o VM and
with an OS w/o I/O scheduler. If it's too big the VM and the I/O
scheduler may want to reduce it for various reasons, but the decision of
this value from a blkdev point of view is indipendent from VM and I/O
scheduler as far as I can tell. VM and I/O scheduler cares about this
bit only if it's too big because if it's too big it hurts on latency and
memory pressure.
