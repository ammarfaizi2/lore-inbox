Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTKKOA4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 09:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbTKKOA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 09:00:56 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:2220 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S263496AbTKKOAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 09:00:53 -0500
From: "Csaba Halasz" <Jester01@freemail.hu>
To: "'Jens Axboe'" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: ide-cd panic with faulty disk and DMA enabled (2.6.0-test9)
Date: Tue, 11 Nov 2003 14:57:19 +0100
Message-ID: <9B4E9DA25A3DD41189B000508B5C0CEE2142B0@BOMBA>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
In-Reply-To: <9B4E9DA25A3DD41189B000508B5C0CEE29370C@BOMBA>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I did some more experimenting last night, and I think
I have stumbled upon something. Don't know
what it means or how to fix it though :)

The request is indeed freed by cdrom_end_request.
The reason is that rq->nr_sectors is an insane value.
And that is because restore_request screwed up.

Just before the crash, in restore_request (ide-cd.c:1346 or so):

restore_request: rq = 0xde158f60, rq->buffer = 0x00000000, bio_data(rq->bio) = 0xc654b000, n=1889704
restore_request: dev hdd: flags = REQ_CMD REQ_STARTED 
sector 7043336, nr/cnr 240/8
bio de09e610, biotail de09e720, buffer 00000000, data 00000000, len 1515870810

The rq->nr_sectors value of 240 will be adjusted to 1889944!
The fix might be as simple as checking for a NULL rq->buffer, but
I don't really understand what is going on here.

Also, somebody else seems to mess with rq->nr_sectors as well,
because I have added a sanity check to cdrom_read_intr and
it catches another such bug, but this time with no preceding
restore_request call...

Hope this helps.

I have also tried ide-scsi, that crashes spectacularly as well.
But I'll start a new thread for that :-)

Greets,
	Csaba

