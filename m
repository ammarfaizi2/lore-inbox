Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264731AbTFBQ6B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 12:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264789AbTFBQ6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 12:58:00 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:21724 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP id S264731AbTFBQ57
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 12:57:59 -0400
Date: Mon, 02 Jun 2003 10:13:25 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: USB 2.0 with 250Gb disk and insane loads
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
Message-id: <3EDB85B5.5040209@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <3EDA0E5D.8080404@pacbell.net>
 <200306011653.47958.oliver@neukum.org> <87k7c5g738.fsf@lapper.ihatent.com>
 <200306012021.41147.oliver@neukum.org> <87llwkpoex.fsf@lapper.ihatent.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Hoogerhuis wrote:
> 
> I had a private reply form a guy that had three of these running
> reliably on 2.4.21-pre6, and he noted he'd never done cd->disk
> transfers, but across the net. So I did the same.
> 
> Results are that it survived a lot longer, I managed to get about
> 700Mb across at about 8Mb/s (line speed 100mbit half duplex) before it
> fell over with this:
> 
> ...
> usb-storage: Command WRITE_10 (10 bytes)
> usb-storage:  2a 00 18 f0 34 47 00 04 00 00
> usb-storage: Bulk command S 0x43425355 T 0xc43 Trg 0 LUN 0 L 524288 F 0 CL 10
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=0


> usb-storage: usb_stor_bulk_transfer_sglist: xfer 524288 bytes, 128 entries
> usb-storage: Status code 0; transferred 524288/524288
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0

That's two successive operations on the OUT endpoint
(two IRQs:  request, then 128 pages) both of which
worked fine, followed by one on the IN endpoint:


> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: usb_storage_command_abort called
> usb-storage: usb_stor_stop_transport called
> usb-storage: -- cancelling URB
> usb-storage: Status code -104; transferred 0/13
> usb-storage: -- transfer cancelled
> usb-storage: Bulk status result = 3
> usb-storage: -- command was aborted
> ...

Interesting.  So basically, the failure mode you saw
was that after all the data was (evidently) transferred
OK, usb-storage aborted (for some reason) its fetch
for the transfer status ... and then trouble.

Why did usb-storage abort that IN transfer?  If we
knew that, we'd have a good clue as to what's going
wrong.


> Load only got up to about 3-4 before it fell over.
> 
> Apart from that, it seems the speed at which it falls over is depening
> on two factors: with/without debugging and speed at which data arrives
> for the drive.

Not unrelated.  Turning on usb-storage debug slows down the
rate at which data is handed to the drive.

- Dave


