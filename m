Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291021AbSBGBAL>; Wed, 6 Feb 2002 20:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291019AbSBGA7z>; Wed, 6 Feb 2002 19:59:55 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:60821 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S291013AbSBGA70>; Wed, 6 Feb 2002 19:59:26 -0500
Date: Wed, 6 Feb 2002 16:59:11 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Ralf Oehler <R.Oehler@GDAmbH.com>
Cc: Scsi <linux-scsi@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <andrea@suse.de>, Jens Axboe <axboe@kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: one-line-patch against SCSI-Read-Error-BUG()
Message-ID: <20020206165911.A27458@eng2.beaverton.ibm.com>
In-Reply-To: <XFMail.20020205153210.R.Oehler@GDAmbH.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <XFMail.20020205153210.R.Oehler@GDAmbH.com>; from R.Oehler@GDAmbH.com on Tue, Feb 05, 2002 at 03:32:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2002 at 03:32:10PM +0100, Ralf Oehler wrote:
> Hi, List
> 
> I think, I found a very simple solution for this annoying BUG().
> 
> Since at least kernel 2.4.16 there is a BUG() in pci.h,
> that crashes the kernel on any attempt to read a SCSI-Sector
> from an erased MO-Medium and on any attempt to read
> a sector from a SCSI-disk, which returns "Read-Error".
> 
> There seems to be a thinko in the corresponding code, which 
> does not take into account the case where a SCSI-READ
> does not return any data because of a "sense code: read error"
> or a "sense code: blank sector".

> Regards,
>         Ralf

Ralf -

A retried IO for a host busy (queuecommand returns 1) or SCSI queue full
case calls scsi_mlqueue_insert; it eventually calls __scsi_insert_special,
where we then set:

    rq->cmd = SPECIAL

The IO is then resent, and if it completes, it looks like everything will
complete OK.

But, if we then get a check condition for the same command, sd.c will call
scsi_io_completion - it nulls out some buffers, including request_buffer,
and then it requeues the command without modifying rq->cmd.

scsi_request_fn() sees that we now have cmd == SPECIAL, and a valid
SCpnt, and does not re-init the IO - this means request_buffer is still
NULL.

I can't tell from your earlier oops stack where exactly you are in the aic
code, but it could be a dereference of request_buffer (stored in cur_seg),
but I would think you would have seen a NULL pointer dereference rather
than hitting the BUG().

I don't know what conditions on your system might lead to a host busy or
queue full, but, it seems possible that we could have a queue full or host
busy immediately followed by a check condition.

In 2.4, I don't know how this can be fixed without adding another field
in Scsi_Cmnd, we could just try setting cmd back to not be SPECIAL, but
the original value is not saved - you could try such a hack and see if
it still oopses. You could also add a check to pci_map_sg to print
out the value of sg when the BUG() is hit.

In 2.5, we might be able to clear REQ_CMD, then set REQ_SPECIAL (in
__scsi_insert_special), and then clear REQ_SPECIAL and set REQ_CMD
in scsi_queue_next_request (when SCpnt != NULL).

You can see if you are hitting the busy cases by turning on SCSI mlcomplete
(to see queue full retries) and mlqueue logging (to see the host busy retries),
and looking for log messages. (Turning on scsi logging with syslogd and/or
klogd? running can flood your system with log messages.)

It also looks the race condition checked for in scsi_mlqueue_insert
is faulty (device_busy or host_busy == 0, but we are just about to
decrement them, so they can't ever be 0, it should compare them to 1),
but that would just hang your IO's (on queue full no matter what the
comparison it could hang IO for clustered systems sharing SCSI devices).

-- Patrick Mansfield
