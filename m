Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbUCVLdl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 06:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbUCVLdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 06:33:41 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:2258 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261884AbUCVLdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 06:33:39 -0500
From: "Naresh Kumar Inna" <knaresh@india.hp.com>
To: <linux-kernel@vger.kernel.org>
Cc: <knaresh@india.hp.com>, <souravs@india.hp.com>
Subject: kiobuf I/O.
Date: Mon, 22 Mar 2004 17:02:42 +0530
Message-ID: <043c01c41001$6534b020$38624c0f@eb9856>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is about a problem I am facing on an IA64 box with Linux 2.4.18. I have
a program that opens a device file in raw mode. It  reads 8K bytes of data
from this raw device in consecutive attempts until it reaches the end of
device or encounters EIO. The device is an IDE ATAPI CDROM drive with media
in it. If I insert a CDROM with bad sectors, I see that my program takes a
very long time to complete. I figured that when 'read( )' encounters bad
sectors within the 8K of data it has requested, it gets blocked for very
long periods. At the end of this period, I can  see either EIO or less than
8K of data being returned by the read call.
My 'dmesg' is filled with these messages:

hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hda: cdrom_decode_status: error=0x34
hda: ATAPI reset complete
end_request: I/O error, dev 03:00 (hda), sector 2688

On seeing some of the raw driver code paths, I could see why this was
happening. The cause of the problem is of course, bad media in the drive.
The IDE drivers take a very long time to recover from errors. They retry
upto 8 times, performing a couple of resets. My read of 8K is being broken
into 16 buffers of 512 bytes each ( I guess this is the max sector size  for
this drive) by the raw interface. This request is handed over to
'brw_kiovec()'. One 'kiobuf' having 16 'buffer head' pointers is what I
could see being handed over to  'brw_kiovec()'. This function despatches
these 16 buffers to the low level driver for I/O and waits in
'kiobuf_wait_for_io( )' until completion.
On my system, all 16 buffer heads come back with errors ( EIO ) because of
bad sectors. However, because we synchronously wait for all the 16 buffers
to complete in 'kiobuf_wait_for_io( )', we are delayed by the time it takes
for one IDE driver sector read failure multiplied by 16.

I could see that the 16 buffers are serviced by the low-level driver in
ascending order of sector number ( though I guess this may not always be
true). So would it make sense for a read/write to be blocked for the
duration of I/O on 16 sectors when the first sector itself is bad? Is there
a possibility of making 'end_kio_request( )' wake up a request blocked on
'kiobuf->wait_queue' by zeroing out 'kiobuf->io_count' if the buffer head is
'kiobuf->bh[0]'? If this is too specific, then end_kio_request( )' could
wake up the blocked request once it has encountered an I/O error on the
lowest numbered sector. I know that this change would involve protecting the
mapping of the pages mapped by kiobuf until all I/O on these pages are over.
Some I/O may still be happening on these pages we may end up calling '
unmap_kiobuf( )' & 'free_kiovec()' and the results may be bad. Instead, is
it possible to notify the user of an EIO ( or the number of successful
bytes ) and do the cleaning-up out-of-band?

Thanks,
Naresh.



