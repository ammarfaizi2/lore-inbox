Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263891AbUASW4t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 17:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264454AbUASW4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 17:56:49 -0500
Received: from hera.cwi.nl ([192.16.191.8]:14542 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263891AbUASW4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 17:56:48 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 19 Jan 2004 23:56:40 +0100 (MET)
Message-Id: <UTC200401192256.i0JMueG18732.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, wrlk@riede.org
Subject: Re: [PATCH] fix for ide-scsi crash
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Willem Riede <wrlk@riede.org>

    > -    spin_unlock_irq(cmd->device->host->host_lock);
    > -    (void) ide_do_drive_cmd (drive, rq, ide_end);
    > -    spin_lock_irq(cmd->device->host->host_lock);
    > +    {
    > +        struct Scsi_Host *host = cmd->device->host;
    > +        spin_unlock_irq(host->host_lock);
    > +        (void) ide_do_drive_cmd(drive, rq, ide_end);
    > +        spin_lock_irq(host->host_lock);
    > +    }

    Interesting. So cmd->device->host changed after ide_do_drive_cmd?

It is a race.
ide_do_drive_cmd(..., ide_end) does not wait for I/O to finish,
but when I/O finishes cmd is freed. So, if the device is quick
and the kernel is slow - maybe a timer interrupt in between -
the command can have finished before the spin_lock_irq() is done.

    That may be a problem if the scsi error handler has to spring 
    into action for this command, as it uses that field extensively...

    > -    if (pc) kfree (pc);
    > -    if (rq) kfree (rq);
    > +    kfree (pc);
    > +    kfree (rq);

    So it is OK to rely on the NULL check in kfree?

Yes. Many years ago I regarded it as ugly to do so, but by now
it is common usage.

Andries


