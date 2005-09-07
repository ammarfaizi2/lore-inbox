Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVIGR74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVIGR74 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbVIGR74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:59:56 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:33722 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932092AbVIGR7z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:59:55 -0400
Subject: Re: [patch 4/4] ide: Break ide_lock -- remove ide_lock  from piix
	driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>
In-Reply-To: <20050907175019.GA3769@localhost.localdomain>
References: <20050906233322.GA3642@localhost.localdomain>
	 <20050906234429.GE3642@localhost.localdomain>
	 <1126112783.8928.14.camel@localhost.localdomain>
	 <20050907175019.GA3769@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 07 Sep 2005 19:24:29 +0100
Message-Id: <1126117469.8928.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-09-07 at 10:50 -0700, Ravikiran G Thirumalai wrote:
> Then the change to piix controller in my patchset is bad, How about changing
> the ide_lock to per-driver lock in this case?  Locking for rest of the
> controllers in the system is left equivalent to what ide_lock did earlier..

Thats what we did in Fedora Core. Its neccessary because the state of
ide_lock is undefined when the tuning functions get called and the base
kernel didn't handle this well - we had various reports from users of
hangs as a result.

Its not a full fix, really PIIX needs to wrap the entire command issue
with a semaphore or similar to avoid the error handling (CRC error)
breaking the driver. Unfortunately we do the CRC error handling and
speed change in an IRQ handler polled so I've never seen how we could
fix that without rewriting the entire error recovery code to work like
the scsi layer (in a thread).

> > fixing the IDE layer locking properly (or forward porting my patches and
> > then fixing them for all the refcounting changes and other stuff done
> > since).
> 
> Can you please point me to the patchset...

2.6.11-ac kernels. I will send you (off list) the last full version of
the fixes. Part of what it fixes (especially the proc file locking
changes) are mostly handled now by the reworking of the IDE code to use
refcounts that Bartlomiej did, and which is definitely the better way to
fix it.

Alan

