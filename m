Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbTAEM7Y>; Sun, 5 Jan 2003 07:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264716AbTAEM7Y>; Sun, 5 Jan 2003 07:59:24 -0500
Received: from hera.cwi.nl ([192.16.191.8]:6342 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264715AbTAEM7W>;
	Sun, 5 Jan 2003 07:59:22 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 5 Jan 2003 14:07:39 +0100 (MET)
Message-Id: <UTC200301051307.h05D7da08203.aeb@smtp.cwi.nl>
To: mdharm-kernel@one-eyed-alien.net
Subject: Re: inquiry in scsi_scan.c
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dharm writes:

> Instead of fixing this in usb-storage, I think I would rather make
> scsi_scan.c just assume a minimum of 36.

No, because (for SCSI-1) the minimum is 5.

> Or, put another way, if the first request indicates less than 36, why
> should we do a second request?  We already have all the data...

We don't do a second request.

> Actually, we ask for 36 and get 36, but the field in the response which is
> supposed to tell us how much there is total is zeroed out, instead of
> having a real value.

Right.

> All we need to do is recognize when that field indicates less than 36
> bytes, and then stop asking for anything else.  Either (a) the device is
> lying, in which case our original INQUIRY is fine, or (b) the device really
> has less than 36 bytes, which means that we already have all the data.

I think you misunderstand the problems. We do not ask for anything else.
There are two problems: a SCSI and a USB problem.

In the SCSI code a length of 5 is legal. Now the code
allocates space for these 5 bytes but subsequently uses
pointers to vendor etc that point past the end of the allocated area.
If ever anything is written via these pointers random memory is corrupted.
And "cat /proc/scsi/scsi" shows randow junk.
A bug that has to be fixed, independently of USB.

The SCSI code has no means of knowing the actual length transferred,
so has no choice but to believe the length byte in the reply.
But the USB code does the transferring itself, and knows precisely
how many bytes were transferred. If 36 bytes were transferred and
the additional length byte is 0, indicating a length of 5, then the
USB code can fix the response and change the additional length byte
to 31, indicating a length of 36. That way the SCSI code knows that
not 5 but 36 bytes are valid, and it gets actual vendor and model strings.

Andries


[the code I showed does the right things; will submit actual diffs
sooner or later]
