Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264412AbTCXTJH>; Mon, 24 Mar 2003 14:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264413AbTCXTJH>; Mon, 24 Mar 2003 14:09:07 -0500
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:22015 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S264412AbTCXTJF>; Mon, 24 Mar 2003 14:09:05 -0500
Date: Mon, 24 Mar 2003 21:20:14 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Frans Pop <aragorn@tiscali.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Tape operation: missing filemark
In-Reply-To: <20030324144916.B7A214553A4@rebecca.tiscali.nl>
Message-ID: <Pine.LNX.4.52.0303242103260.3138@kai.makisara.local>
References: <20030324144916.B7A214553A4@rebecca.tiscali.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Mar 2003, Frans Pop wrote:

> I have been working on a bug in a 'tar cf /dev/tape --verify' operation.
> This results in an error 'Unexpected EOF in archive' during the verify
> stage of the operation and any subsequent attempts to read the archive from
> tape.
>
> The cause of this error is that no filemark is written between writing the
> tape and the start of the verification.
>
> My question.
> Which should be responsible for writing a filemark in this situation: the
> tape driver or tar?
>
For SCSI tapes in Linux, tar is responsible. Quoting from
linux/drivers/scsi/README.st:

"By default the driver writes one filemark when the device is closed after
writing and the last operation has been a write. Two filemarks can be
optionally written. ..."

It seems that the ide-tape driver behaves in the same way (all tape
drivers in Linux try to use the same semantics).

In other Unices there are different behaviours. Tru64 works in the same
way as Linux. Solaris (at least v.7) does write filemark after writes if
the next command is a file positioning ioctl.

There are two basic behaviours of tape devices: the BSD and the SYS V
semantics. There are minor difference between these and this writing of
the filemark may or may not be one of those (I don't have any definitions
except what I have deduced from implementations). It is difficult for a
generic program to know what to do. The safe way in this case is to close
the tape after writes to write the filemark and reopen it for
verification.

> When a 'normal' backup using tar (without verify option) is made, the tape
> driver writes the filemark when a release request is received while the
> driver is in write mode.
> So my thinking is that the driver should also write a filemark when an
> ioctl request is received while the driver is in write mode. Is this
> correct?
> Any pointers to documentation?
>
> tar sends (roughly) the following sequence of requests to the driver:
> - open device
> - write data
> - ioctl MTFSB 1 (space backwards 1 filemark)

MTBSF moves over one filemark. Next read returns always zero (unless MTBSF
has failed at BOT ;-).

> - read data
> - release device
>
...

-- 
Kai
