Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129604AbRAUVYP>; Sun, 21 Jan 2001 16:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129944AbRAUVYG>; Sun, 21 Jan 2001 16:24:06 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:9798 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129604AbRAUVXs>; Sun, 21 Jan 2001 16:23:48 -0500
From: "LA Walsh" <law@sgi.com>
To: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: RE: Is sendfile all that sexy?
Date: Sun, 21 Jan 2001 13:22:02 -0800
Message-ID: <NBBBJGOOMDFADJDGDCPHCECKCKAA.law@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20010117213459.A14450@zalem.puupuu.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI -
	Another use sendfile(2) might be used for.  Suppose you were to generate
large amounts of data -- maybe kernel profiling data, audit data, whatever,
in the kernel.

	You want to pull that data out as fast as possible and write it to
a disk or network socket.  Normally, I think you'd do a "read/write" that
would xfer the data into user space, then write it back to the target
in system space.  With sendfile, it seems, one could write a dump-daemon
that used sendfile to dump the data directly out to a target file descriptor
w/o it going through user space.

	Just make sure the internal 'raw' data is massaged into the format
of a block device and voila!  A side benefit would be that data in the
kernel that is written to the block device would be 'queued' in the
block buffers and them being marked 'dirty' and needing to be written out.
The device driver marks the buffers as clean once they are pushed out
of a fd by doing a 'seek' to a new (later) position in the file -- whole
buffers
before that point are marked 'clean' and freed.

	Seems like this would have the benefit of reusing an existing
buffer management system for buffering while also using a single-copy
to get data to the target.

???
-l
--
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice/Vmail: (650) 933-5338


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
