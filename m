Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTEMHQr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 03:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263328AbTEMHQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 03:16:47 -0400
Received: from [193.98.9.7] ([193.98.9.7]:64193 "EHLO mail.provi.de")
	by vger.kernel.org with ESMTP id S263279AbTEMHQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 03:16:45 -0400
Subject: Re: 2.4.21-rc:  lost interrupt wgen usinf atapi cdrom-drive
From: Michael Reincke <reincke.m@stn-atlas.de>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E19FTA7-000Mgw-00.arvidjaar-mail-ru@f15.mail.ru>
References: <E19FTA7-000Mgw-00.arvidjaar-mail-ru@f15.mail.ru>
Content-Type: text/plain; charset=ISO-8859-15
Organization: STN ATLAS Elektronik GmbH
Message-Id: <1052810966.1602.4.camel@pcew80.atlas.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 May 2003 09:29:26 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-13 at 08:21, Andrey Borzenkov wrote:
> > i upgraded the linux kernel of my computer from 2.4.21-pre4 to
> > 2.4.21-rc2 and got the following messages in syslog when using my
> > atapi-cdrom drive:
> > May 12 09:42:52 pcew80 kernel: hdc: DMA interrupt recovery
> > May 12 09:42:52 pcew80 kernel: hdc: lost interrupt
> > May 12 09:42:52 pcew80 kernel: hdc: status timeout: status=0xd0 { Busy }
> > May 12 09:42:52 pcew80 kernel: hdc: status timeout: error=0x00
> > May 12 09:42:52 pcew80 kernel: hdc: DMA disabled
> > May 12 09:42:52 pcew80 kernel: hdc: drive not ready for command
> > May 12 09:42:52 pcew80 kernel: hdc: ATAPI reset complete
> 
> 
> It smells like ide_do_request forgets to enable interrupts when
> request queue is empty.
> 
> drivers/ide/ide-io.c:
> 
> void ide_do_request (ide_hwgroup_t *hwgroup, int masked_irq)
> {
>         ide_drive_t     *drive;
>         ide_hwif_t      *hwif;
>         struct request  *rq;
>         ide_startstop_t startstop;
> 
>         /* for atari only: POSSIBLY BROKEN HERE(?) */
>         ide_get_lock(&ide_intr_lock, ide_intr, hwgroup);
> 
>         /* necessary paranoia: ensure IRQs are masked on local CPU */
>         local_irq_disable();
>            ^^^^^^^^
>               [...]
>                 if (drive == NULL) {
>                               [...]
>                         if (sleep) {
>                               [...]
>                         } else {
>                                 /* Ugly, but how can we sleep for the lock
>                                  * otherwise? perhaps from tq_disk?
>                                  */
> 
>                                 /* for atari only */
>                                 ide_release_lock(&ide_intr_lock);
>                                 hwgroup->busy = 0;
>                         }
>                         /* no more work for this hwgroup (for now) */
>                         return;
>                    Oops. local_irq_disable remains in effect
>                      [...]
>                 spin_unlock(&io_request_lock);
>                 local_irq_enable();
>                 ^^^^^^^^^^^^^^^^^^^
>                         /* allow other IRQs while we start this request */
>                 startstop = start_request(drive, rq);
>                 spin_lock_irq(&io_request_lock);
>                 if (masked_irq && hwif->irq != masked_irq)
>                         enable_irq(hwif->irq);
>                 if (startstop == ide_stopped)
>                         hwgroup->busy = 0;
> 
> Ironically it does not release ide_intr_lock in this case but we
> are not on m68k so we do not care :)
> 
> Could you please try to add local_irq_enable() before ide_release_lock() above and see if it helps?
> It has been reported to have fixed fix problems for other people. OTOH
> I did have sevral hard lockups with this so there may be more subtle
> problems issues.
The hangs and timeouts and total blocking of the cdrom drive seems to be
away, but the lost interrupt messages are still there.
But have in mind I've only a quick test so far.

-- 
Michael Reincke, NUT Team 2 (Software Build Management)

STN ATLAS Elektronik GmbH, Bremen (Germany)
E-mail : reincke.m@stn-atlas.de |  mail: Sebaldsbrücker Heerstr 235    
phone  : +49-421-457-2302       |        28305 Bremen                  
fax    : +49-421-457-3913       |




