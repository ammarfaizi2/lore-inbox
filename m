Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbUEEB0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUEEB0V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 21:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbUEEB0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 21:26:21 -0400
Received: from tantale.fifi.org ([216.27.190.146]:18317 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S261479AbUEEB0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 21:26:09 -0400
Cc: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: iRiver H100 series and usb-storage issues
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 04 May 2004 18:26:06 -0700
Message-ID: <87llk77jgx.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lads,

I've had a discussion with Matthew Dharm
<mdharm-usb@one-eyed-alien.net> on the Linux-usb mailing list
<linux-usb-users@lists.sourceforge.net> and I'm taking the topic
here...

Mailing list threads:

 http://marc.theaimsgroup.com/?l=linux-usb-users&m=108329645220736&w=2
 http://marc.theaimsgroup.com/?l=linux-usb-users&m=108332081125990&w=2
 http://marc.theaimsgroup.com/?l=linux-usb-users&m=108370356206121&w=2

Here's the problem:

 The iRiver H100 series MP3 players work with linux, but quite
 unreliably. By unreliable, I mean that repetitively md5sum'ing the
 files on the device yield different results:

   find <mountpoint> -type f -print0 | sort -z | xargs -r0 md5sum > sums.1
   find <mountpoint> -type f -print0 | sort -z | xargs -r0 md5sum > sums.2
   diff sums.1 sums.2

 will dump a bunch of diffs. Bad, bad, bad...

With vanilla 2.4.26, these kernel messages are issued and an I/O error
is returned to user space:

  USB Mass Storage device found at 18
  SCSI disk error : host 1 channel 0 id 0 lun 0 return code = 8000000
  Current sd08:21: sense key None
   I/O error: dev 08:21, sector 2225382

The sector numbers change all the time... Retrying a faulty sector
will give a good result.

After recompiling with debug message, here are the messages before and
during the error (2.4.26 too):

  usb-storage: queuecommand() called
  usb-storage: *** thread awakened.
  usb-storage: Command READ_10 (10 bytes)
  usb-storage: 28 00 01 e5 1f 5c 00 00 01 00 00 00
  usb-storage: Bulk command S 0x43425355 T 0x944 Trg 0 LUN 0 L 512 F 128 CL 10
  usb-storage: Bulk command transfer result=0
  usb-storage: usb_stor_transfer_partial(): xfer 512 bytes
  usb-storage: usb_stor_bulk_msg() returned 0 xferred 512/512
  usb-storage: usb_stor_transfer_partial(): transfer complete
  usb-storage: Bulk data transfer result 0x0
  usb-storage: Attempting to get CSW...
  usb-storage: Bulk status result = 0
  usb-storage: Bulk status Sig 0x53425355 T 0x944 R 0 Stat 0x0
  usb-storage: scsi cmd done, result=0x0
  usb-storage: *** thread sleeping.
  usb-storage: queuecommand() called
  usb-storage: *** thread awakened.
  usb-storage: Command READ_10 (10 bytes)
  usb-storage: 28 00 00 a3 e9 21 00 00 01 00 00 00
  usb-storage: Bulk command S 0x43425355 T 0x945 Trg 0 LUN 0 L 512 F 128 CL 10
  usb-storage: Bulk command transfer result=0
  usb-storage: usb_stor_transfer_partial(): xfer 512 bytes
  usb-storage: usb_stor_bulk_msg() returned 0 xferred 0/512
  usb-storage: Bulk data transfer result 0x1
  usb-storage: Attempting to get CSW...
  usb-storage: clearing endpoint halt for pipe 0xc0011e80
  usb-storage: usb_stor_clear_halt: result=0
  usb-storage: Attempting to get CSW (2nd try)...
  usb-storage: Bulk status result = 0
  usb-storage: Bulk status Sig 0x53425355 T 0x945 R 512 Stat 0x0
  usb-storage: -- unexpectedly short transfer
  usb-storage: Issuing auto-REQUEST_SENSE
  usb-storage: Bulk command S 0x43425355 T 0x946 Trg 0 LUN 0 L 18 F 128 CL 6
  usb-storage: Bulk command transfer result=0
  usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
  usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
  usb-storage: usb_stor_transfer_partial(): transfer complete
  usb-storage: Bulk data transfer result 0x0
  usb-storage: Attempting to get CSW...
  usb-storage: Bulk status result = 0
  usb-storage: Bulk status Sig 0x53425355 T 0x946 R 0 Stat 0x0
  usb-storage: -- Result from auto-sense is 0
  usb-storage: -- code: 0x70, key: 0x0, ASC: 0x0, ASCQ: 0x0
  usb-storage: No Sense: no additional sense information
  usb-storage: scsi cmd done, result=0x0
  usb-storage: *** thread sleeping.
  SCSI disk error : host 1 channel 0 id 0 lun 0 return code = 8000000
  Current sd08:21: sense key None
   I/O error: dev 08:21, sector 10741986

When using vanilla 2.6.5, I get no I/O errors, but the md5 diffs are
still generated, so there is still something wrong...

Apparently, the problem is that the device posts an empty reply to a
valid query (save an bug in linux, which I could not pinpoint (yet?)).

I have tried running the device on different computers with different
USB chipsets, and I could reproduce the problem every time.

I am posting here to see if anyone can provide any debugging help or
other clues before I call it quit.

Thanks,
Phil.
