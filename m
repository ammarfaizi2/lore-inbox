Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265728AbUAKAKh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 19:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265729AbUAKAKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 19:10:37 -0500
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:6034 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S265728AbUAKAKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 19:10:30 -0500
Subject: USB hangs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-YqVT5L3wUCUGaDmszyxP"
Message-Id: <1073779636.17720.3.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 11 Jan 2004 00:07:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YqVT5L3wUCUGaDmszyxP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

With the various fixes people had been posting USB storage
writing was still hanging repeatedly when doing a 20Gb rsync
to usb-storage disks with a low memory system. Doing things
like while(true) sync() made it hang even more often.

After a bit of digging the following seems to fix it

Not sure if 2.6 needs this as well.

The failure path seems to be

	->scsi_done in the USB storage thread
	issues a new command
	causes USB to kmalloc GFP_KERNEL
	causes a page out
	queues a page out to the USB storage thread
	Deadlock.

Setting PF_MEMALLOC should stop the storage thread ever causing pageout
itself so deadlocking.


--=-YqVT5L3wUCUGaDmszyxP
Content-Disposition: attachment; filename=a1
Content-Type: text/plain; name=a1; charset=UTF-8
Content-Transfer-Encoding: base64

LS0tIGRyaXZlcnMvdXNiL3N0b3JhZ2UvdXNiLmN+CTIwMDQtMDEtMDkgMDI6MDY6MzUuMDAwMDAw
MDAwICswMDAwDQorKysgZHJpdmVycy91c2Ivc3RvcmFnZS91c2IuYwkyMDA0LTAxLTA5IDAyOjA2
OjM1LjAwMDAwMDAwMCArMDAwMA0KQEAgLTMzMiw2ICszMzIsOCBAQA0KIA0KIAkvKiBzZXQgb3Vy
IG5hbWUgZm9yIGlkZW50aWZpY2F0aW9uIHB1cnBvc2VzICovDQogCXNwcmludGYoY3VycmVudC0+
Y29tbSwgInVzYi1zdG9yYWdlLSVkIiwgdXMtPmhvc3RfbnVtYmVyKTsNCisJDQorCWN1cnJlbnQt
PmZsYWdzIHw9IFBGX01FTUFMTE9DOw0KIA0KIAl1bmxvY2tfa2VybmVsKCk7DQogDQo=

--=-YqVT5L3wUCUGaDmszyxP--
