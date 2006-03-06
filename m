Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751874AbWCFUxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbWCFUxR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 15:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbWCFUxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 15:53:17 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:51951 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751874AbWCFUxQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 15:53:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=afgMsMuA5rXB1NJXy9ceIEvwX0ibc7MnfvTszbUc1NYVgnZqugVUxdJsRqm+15MwGGD8C4OzNdw7JyC2sIYtq603paOmhaBQOyXusM2OzNRVjg88fcKR+4zVAcEUcJByPbpMIX8qpydwD2HIhZhG3CcljHiJodxWNcCsz/Hs+I0=
Message-ID: <9a8748490603061253u5e4d7561vd4e566f5798a5f4@mail.gmail.com>
Date: Mon, 6 Mar 2006 21:53:14 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       "Andrea Arcangeli" <andrea@suse.de>,
       "Mike Christie" <michaelc@cs.wisc.edu>,
       "James Bottomley" <James.Bottomley@steeleye.com>,
       "Jens Axboe" <axboe@suse.de>
In-Reply-To: <200603062136.17098.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603060117.16484.jesper.juhl@gmail.com>
	 <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>
	 <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
	 <200603062136.17098.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On Monday 06 March 2006 21:06, Linus Torvalds wrote:
> >
<...snip...>
> > and the scary thing is that "len=64".
> >
> > The thing is, SCSI uses "SCSI_SENSE_BUFFERSIZE" to determine the maximum
> > sense size to copy, and what do we have, if not
> >
> >       include/scsi/scsi_cmnd.h:#define SCSI_SENSE_BUFFERSIZE  96
> >
> > ie a 64-byte buffer is simply TOO DAMN SMALL!
> >
> > Now, the thing is, the 64 comes from "sizeof(struct request_sense)", which
> > is what "struct packet_command *" uses. We can change that sizeof() to
> > just use SCSI_SENSE_BUFFERSIZE, but that still makes me worry about
>
> Building a kernel with that change on top of the other ones atm.
>
Changing the sizeof() to SCSI_SENSE_BUFFERSIZE doesn't fix it :

Slab corruption: start=f79da5a8, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02934db>](sr_do_ioctl+0x11b/0x270)
000: 70 00 02 00 00 00 00 0a 00 00 00 00 3a 01 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Prev obj: start=f79da55c, len=64
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c0158918>](__vmalloc_node+0x68/0x80)
000: d0 1e 1e c3 18 1f 1e c3 60 1f 1e c3 a8 1f 1e c3
010: f0 1f 1e c3 38 20 1e c3 80 20 1e c3 c8 20 1e c3
Next obj: start=f79da5f4, len=64
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c0173923>](real_lookup+0x93/0xe0)
000: 6c 69 62 62 6f 6f 73 74 5f 70 72 67 5f 65 78 65
010: 63 5f 6d 6f 6e 69 74 6f 72 2d 67 63 63 2d 6d 74
Slab corruption: start=f79da5a8, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02934db>](sr_do_ioctl+0x11b/0x270)
000: 70 00 05 00 00 00 00 0a 00 00 00 00 24 00 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Prev obj: start=f79da55c, len=64
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c0158918>](__vmalloc_node+0x68/0x80)
000: d0 1e 1e c3 18 1f 1e c3 60 1f 1e c3 a8 1f 1e c3
010: f0 1f 1e c3 38 20 1e c3 80 20 1e c3 c8 20 1e c3
Next obj: start=f79da5f4, len=64
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c0173923>](real_lookup+0x93/0xe0)
000: 6c 69 62 62 6f 6f 73 74 5f 70 72 67 5f 65 78 65
010: 63 5f 6d 6f 6e 69 74 6f 72 2d 67 63 63 2d 6d 74

I'll now go test the things Jens suggested.  Expect more feedback shortly.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
