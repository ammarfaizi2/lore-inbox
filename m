Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266994AbTAFPjp>; Mon, 6 Jan 2003 10:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266995AbTAFPjp>; Mon, 6 Jan 2003 10:39:45 -0500
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:17326
	"HELO ghanima.endorphin.org") by vger.kernel.org with SMTP
	id <S266994AbTAFPjo>; Mon, 6 Jan 2003 10:39:44 -0500
Date: Mon, 6 Jan 2003 16:41:39 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.4.20aa1 ide-scsi crashes
Message-ID: <20030106154138.GA2588@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

under heavy I/O load for my scsi-emulated cdrom 2.4.20aa1 crashes at

drivers/scsi/scsi_dma:155 with 
panic("scsi_free:Trying to free unused memory")

panic(..) somehow refuses to print the call trace because "IEEE in interrupt
handler - no sync".

The only scsi module I'm using is ide-scsi. As I browsed the aa patch I
recognized that a few &io_request_lock have been exchanged for
"q->queue_lock". But ide-scsi is still locking on io_request_lock. This is
probably the source of the race condition. However I'm not sure because I
think q->queue_lock is being initialized to &io_request_lock, so it should
still be the same lock.

See drivers/scsi/ide-scsi:295 or 
    drivers/scsi/ide-scsi:850 (Why isn't there a lock in that case?)

(done) referrs to sr.c:rw_intr which calls scsi_io_completion which calls
the panic(..)-ing scsi_free)

Any guesses?

Regards, Clemens
Please CC answers, /me not on list.
