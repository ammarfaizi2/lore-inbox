Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314975AbSEHTmO>; Wed, 8 May 2002 15:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314981AbSEHTmN>; Wed, 8 May 2002 15:42:13 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:61337 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S314975AbSEHTmN>; Wed, 8 May 2002 15:42:13 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Andre Hedrick <andre@linux-ide.org>
Cc: Bjorn Wesen <bjorn.wesen@axis.com>, Paul Mackerras <paulus@samba.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE 58
Date: Wed, 8 May 2002 21:10:54 +0200
Message-Id: <20020508191054.6282@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.44.0205081200340.5406-100000@home.transmeta.com>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>And done properly with per-controller (or drive - you may want to
>virtualize at the drive level just because you could separate out
>different kinds of drive accesses that way too) function pointers you can
>then _mix_ access methods, without getting completely idiotic run-time
>checks inside "ide_out()".

Which ends up basically into having function pointers in the
ata_channel (or ata_drive, but I doubt that would be really
necessary) a set of 4 access functions: taskfile_in/out for
access to taskfile registers (8 bits), and data_in/out for
steaming datas in/out of the data reg (16 bits).

That would cleanly solve my problem of mixing MMIO and PIO
controllers in the same machine, that would solve the crazy
byteswapping needed by some controllers for PIO at least,
etc...

I would even suggest not caring about the taskfile register
address at all (that is kill the array of port addresses) but
just pass the taskfile_in/out functions the register number
(cyl_hi, cyl_lo, select, ....) as a nice symbolic constant,
and let the channel specific implementation figure it out.
I haven't checked if you already killed all of the request/release
region crap done by the common ide code, that is matter is completely
internal to the host controller driver, etc...

Now, andre may tell us we need one more set for "slow IO"
versions for some HW, I don't know the details for these so
I'll let the old man speak up here.

Ben.


