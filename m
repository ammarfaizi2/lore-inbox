Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbTEMGIj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 02:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTEMGIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 02:08:39 -0400
Received: from f15.mail.ru ([194.67.57.45]:7690 "EHLO f15.mail.ru")
	by vger.kernel.org with ESMTP id S263084AbTEMGIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 02:08:37 -0400
From: "Andrey Borzenkov" <arvidjaar@mail.ru>
To: "Michael Reincke" <reincke.m@stn-atlas.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc:  lost interrupt wgen usinf atapi cdrom-drive
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Tue, 13 May 2003 10:21:19 +0400
Reply-To: "Andrey Borzenkov" <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19FTA7-000Mgw-00.arvidjaar-mail-ru@f15.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i upgraded the linux kernel of my computer from 2.4.21-pre4 to
> 2.4.21-rc2 and got the following messages in syslog when using my
> atapi-cdrom drive:
>
> May 12 09:42:42 pcew80 kernel: sr0: scsi3-mmc drive: 24x/24x writer
> cd/rw xa/form2 cdda tray
> May 12 09:42:42 pcew80 kernel: Uniform CD-ROM driver Revision: 3.12
> May 12 09:42:42 pcew80 kernel: sr1: scsi-1 drive
> May 12 09:42:42 pcew80 kernel: hdc: attached ide-cdrom driver.
> May 12 09:42:42 pcew80 kernel: hdc: ATAPI 48X CD-ROM drive, 120kB Cache,
> UDMA(33)
> May 12 09:42:42 pcew80 kernel: ISO 9660 Extensions: Microsoft Joliet
> Level 3
> May 12 09:42:52 pcew80 kernel: hdc: DMA interrupt recovery
> May 12 09:42:52 pcew80 kernel: hdc: lost interrupt
> May 12 09:42:52 pcew80 kernel: hdc: status timeout: status=0xd0 { Busy }
> May 12 09:42:52 pcew80 kernel: hdc: status timeout: error=0x00
> May 12 09:42:52 pcew80 kernel: hdc: DMA disabled
> May 12 09:42:52 pcew80 kernel: hdc: drive not ready for command
> May 12 09:42:52 pcew80 kernel: hdc: ATAPI reset complete


It smells like ide_do_request forgets to enable interrupts when
request queue is empty.

drivers/ide/ide-io.c:

void ide_do_request (ide_hwgroup_t *hwgroup, int masked_irq)
{
        ide_drive_t     *drive;
        ide_hwif_t      *hwif;
        struct request  *rq;
        ide_startstop_t startstop;

        /* for atari only: POSSIBLY BROKEN HERE(?) */
        ide_get_lock(&ide_intr_lock, ide_intr, hwgroup);

        /* necessary paranoia: ensure IRQs are masked on local CPU */
        local_irq_disable();
           ^^^^^^^^
              [...]
                if (drive == NULL) {
                              [...]
                        if (sleep) {
                              [...]
                        } else {
                                /* Ugly, but how can we sleep for the lock
                                 * otherwise? perhaps from tq_disk?
                                 */

                                /* for atari only */
                                ide_release_lock(&ide_intr_lock);
                                hwgroup->busy = 0;
                        }
                        /* no more work for this hwgroup (for now) */
                        return;
                   Oops. local_irq_disable remains in effect
                     [...]
                spin_unlock(&io_request_lock);
                local_irq_enable();
                ^^^^^^^^^^^^^^^^^^^
                        /* allow other IRQs while we start this request */
                startstop = start_request(drive, rq);
                spin_lock_irq(&io_request_lock);
                if (masked_irq && hwif->irq != masked_irq)
                        enable_irq(hwif->irq);
                if (startstop == ide_stopped)
                        hwgroup->busy = 0;

Ironically it does not release ide_intr_lock in this case but we
are not on m68k so we do not care :)

Could you please try to add local_irq_enable() before ide_release_lock() above and see if it helps?
It has been reported to have fixed fix problems for other people. OTOH
I did have sevral hard lockups with this so there may be more subtle
problems issues.

-andrey
