Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274749AbRJQGmv>; Wed, 17 Oct 2001 02:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274774AbRJQGmm>; Wed, 17 Oct 2001 02:42:42 -0400
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:48623 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S274766AbRJQGme>; Wed, 17 Oct 2001 02:42:34 -0400
Date: Wed, 17 Oct 2001 09:43:42 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: <makisara@kai.makisara.local>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: <linux-kernel@vger.kernel.org>, <jmerkey@timpanogas.org>
Subject: Re: SCSI tape load problem with Exabyte Drive
In-Reply-To: <20011016153623.A21324@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.33.0110170935300.2271-100000@kai.makisara.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2001, Jeff V. Merkey wrote:

>
>
> On 2.4.6 with st and AICXXXX driver, issuance of an MTLOAD command
> via st ioctl() calls results in a unit attention and failure of
> the drive while loading a tape from an EXB-480 robotics tape
> library.
>
> Code which generates this error is attached.  The error will not
> clear unless the code first closes the open handle to the device,
> then reopens the handle and retries the load command.  The failure
> scenario is always the same.  The first MTLOAD command triggers
> the tape drive to load the tape, then all subsequent commands
> fail until the handle is closed and the device is reopened and
> a second MTLOAD command gets issued, then the drive starts
> working.
>
This is a "feature" of the st driver: if you get UNIT ATTENTION anywhere
else than within open(), it is considered an error. In most cases this is
true but MTLOAD is an exception. I have not thought about this exception
and noone before you has reported it ;-)

As you say, the workaround is to close and reopen the device after MTLOAD.
You should not need the second MTLOAD.

I will think about a fix to this problem. The basic reason for not
allowing UNIT ATTENTION anywhere is that flushing the driver state
properly in any condition is complicated and there has been no legitimate
reason to allow this. However, here it should be sufficient to use a no-op
SCSI command after LOAD to get the UNIT ATTENTION.

	Kai


