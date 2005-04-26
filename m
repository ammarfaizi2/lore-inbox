Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVDZOTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVDZOTM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 10:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVDZOTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 10:19:12 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:39313 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261544AbVDZOTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 10:19:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=AqgCKOuAxX75H/Q42R8VyWRJ5G0hcrjQXJeTVzBZpQN0+2Gg3vlZrVN/5NnIeDTV3tP8uu9sVj1GkWCCZrK4PiFbwevbRTRbrBYP7029CAIAoZRAKyM/QvBn8iumYGXXRP8UcZNjxMn5qQz/xN3kUHrm/huuX7If12SfNrTiwiM=
Message-ID: <63f529680504260719283a6a96@mail.gmail.com>
Date: Tue, 26 Apr 2005 16:19:01 +0200
From: Marcello Maggioni <hayarms@gmail.com>
Reply-To: Marcello Maggioni <hayarms@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Timeout at bootTime with NEC3500A (and others) when inserted a CD in it.
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2332_22936759.1114525141510"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_2332_22936759.1114525141510
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,=20

I've attached a patch intended for solving boottime issues with this
and other drives when a CD/DVD is inserted .

Problem: Some drives (NEC 3500 , TDK 1616N , Mad-dog MD-16XDVD9, RICOH
MP5163DA , Memorex DVD9 drive and IO-DATA's too for sure) , if a
CD/DVD is inserted into the tray when the system is booted and if
before the OS bootup the BIOS checked for the presence of a bootable
CD/DVD into the drive , during the IDE probe phase the drive may
result busy and remain so for the next 25/30 seconds . This cause the
drive to be skipped during the booting phase and not begin usable
until the next reboot (if the reboot goes well and the drive doesn't
timeout again ).

Solution: Rising the timeout time from 10 seconds to 35 seconds
(during these 35 seconds  every drive should wake up for sure
according to the tests I've done) .


Here the simple patch :

--- drivers/ide/ide-probe.c.orig=092005-04-26 15:04:46.000000000 +0200
+++ drivers/ide/ide-probe.c=092005-04-26 15:04:14.000000000 +0200
@@ -638,13 +638,13 @@
 =09SELECT_DRIVE(&hwif->drives[0]);
 =09hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
 =09mdelay(2);
-=09rc =3D ide_wait_not_busy(hwif, 10000);
+=09rc =3D ide_wait_not_busy(hwif, 35000);
 =09if (rc)
 =09=09return rc;
 =09SELECT_DRIVE(&hwif->drives[1]);
 =09hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
 =09mdelay(2);
-=09rc =3D ide_wait_not_busy(hwif, 10000);
+=09rc =3D ide_wait_not_busy(hwif, 35000);
=20
 =09/* Exit function with master reselected (let's be sane) */
 =09SELECT_DRIVE(&hwif->drives[0]);


Greets,

Maggioni Marcello

------=_Part_2332_22936759.1114525141510
Content-Type: text/plain; name="ide-timeout-NEC3500.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ide-timeout-NEC3500.diff"

LS0tIGRyaXZlcnMvaWRlL2lkZS1wcm9iZS5jLm9yaWcJMjAwNS0wNC0yNiAxNTowNDo0Ni4wMDAw
MDAwMDAgKzAyMDAKKysrIGRyaXZlcnMvaWRlL2lkZS1wcm9iZS5jCTIwMDUtMDQtMjYgMTU6MDQ6
MTQuMDAwMDAwMDAwICswMjAwCkBAIC02MzgsMTMgKzYzOCwxMyBAQAogCVNFTEVDVF9EUklWRSgm
aHdpZi0+ZHJpdmVzWzBdKTsKIAlod2lmLT5PVVRCKDgsIGh3aWYtPmlvX3BvcnRzW0lERV9DT05U
Uk9MX09GRlNFVF0pOwogCW1kZWxheSgyKTsKLQlyYyA9IGlkZV93YWl0X25vdF9idXN5KGh3aWYs
IDEwMDAwKTsKKwlyYyA9IGlkZV93YWl0X25vdF9idXN5KGh3aWYsIDM1MDAwKTsKIAlpZiAocmMp
CiAJCXJldHVybiByYzsKIAlTRUxFQ1RfRFJJVkUoJmh3aWYtPmRyaXZlc1sxXSk7CiAJaHdpZi0+
T1VUQig4LCBod2lmLT5pb19wb3J0c1tJREVfQ09OVFJPTF9PRkZTRVRdKTsKIAltZGVsYXkoMik7
Ci0JcmMgPSBpZGVfd2FpdF9ub3RfYnVzeShod2lmLCAxMDAwMCk7CisJcmMgPSBpZGVfd2FpdF9u
b3RfYnVzeShod2lmLCAzNTAwMCk7CiAKIAkvKiBFeGl0IGZ1bmN0aW9uIHdpdGggbWFzdGVyIHJl
c2VsZWN0ZWQgKGxldCdzIGJlIHNhbmUpICovCiAJU0VMRUNUX0RSSVZFKCZod2lmLT5kcml2ZXNb
MF0pOwo=
------=_Part_2332_22936759.1114525141510--
