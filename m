Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265292AbUAAAIY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 19:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265305AbUAAAIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 19:08:24 -0500
Received: from shawmail.shawcable.com ([64.59.128.220]:50559 "EHLO
	bpd2mo1no.prod.shawcable.com") by vger.kernel.org with ESMTP
	id S265292AbUAAAIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 19:08:22 -0500
Date: Wed, 31 Dec 2003 17:12:16 -0700
From: Matthew Mastracci <mmastrac@canada.com>
Subject: Removable USB device contents cached after removal?
To: linux-kernel@vger.kernel.org
Message-id: <3FF365E0.5090507@canada.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6a)
 Gecko/20031030
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been working on getting my USB Atech 9-in-1 card reader working 
with Linux.  Everything mounts, unmounts and reads fine, but I'm getting 
a strange situation where the contents of the card seem to be buffered 
after the media has been removed from the card reader.

The strange thing is that this only happens when the card itself has 
been mounted, but it does *not* happen if the card is inserted and 
removed without mounting.

I'm running kernel 2.6.0-1.107 from arjanv's RedHat builds.

Here are the steps I use to reproduce it:

Working case (never mounted)

1.  Insert card into reader.
2.  dd if=/dev/sdd1 count=1024 bs=1 | hexdump
	- results in correct filesystem dump
3.  Remove card from reader.
4.  cat /dev/sdd1 results in "No medium found"

Non-working case:

1.  Insert card into reader.
2.  Mount card as directory somewhere in root filesystem, list contents 
of card
3.  dd if=/dev/sdd1 count=1024 bs=1024 | hexdump
	- results in correct filesystem dump
4.  Remove card from reader.
5.  dd if=/dev/sdd1 count=1024 bs=1024 | hexdump
	- same filesystem dump as before!
6.  cd to mountpoint, contents are still available
7.  dd if=/dev/sdd1 of=/dev/null
         - approx 3MB of card data still available
8.  umount the mountpoint from before
9.  dd if=/dev/sdd1 of=/dev/null results in "No medium found"

I can provide more information as required.  It appears as if the reader 
is correctly determining that no medium is present, but the mountpoint's 
existence somehow prevents userspace code from seeing this.

Any ideas?

Here's some dumps that might assist:

[root@matt root]# lsmod | grep "usb"
usb_storage            56384  1
scsi_mod              107320  2 sd_mod,usb_storage
usbcore                93148  7 usb_storage,hid,ohci_hcd,uhci_hcd,ehci_hcd

"dd" on non-existant card (note that 8976 was the amount of data read 
when the card was inserted):

[root@matt root]# dd if=/dev/sdd1 of=/dev/null
dd: reading `/dev/sdd1': Input/output error
8976+0 records in
8976+0 records out

dmesg output after "dd" on non-existant card:

Device sdd not ready.
end_request: I/O error, dev sdd, sector 9001
Buffer I/O error on device sdd1, logical block 8976
Buffer I/O error on device sdd1, logical block 8977
Buffer I/O error on device sdd1, logical block 8978
Buffer I/O error on device sdd1, logical block 8979
Buffer I/O error on device sdd1, logical block 8980
Buffer I/O error on device sdd1, logical block 8981
Buffer I/O error on device sdd1, logical block 8982
Buffer I/O error on device sdd1, logical block 8983

Matt.
