Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315691AbSECUgZ>; Fri, 3 May 2002 16:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315692AbSECUgY>; Fri, 3 May 2002 16:36:24 -0400
Received: from web21503.mail.yahoo.com ([66.163.169.14]:34977 "HELO
	web21503.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315691AbSECUgX>; Fri, 3 May 2002 16:36:23 -0400
Message-ID: <20020503203623.25862.qmail@web21503.mail.yahoo.com>
Date: Fri, 3 May 2002 21:36:23 +0100 (BST)
From: =?iso-8859-1?q?Neil=20Conway?= <nconway_kernel@yahoo.co.uk>
Subject: PATCH, IDE corruption, 2.4.18
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-679248808-1020458183=:24708"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-679248808-1020458183=:24708
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Well, I say patch, but it's really a band-aid.

[Caveats: before reading further, understand that I'm
not by any means an IDE expert; I have just figured
out how to prevent disk corruption on my PC.  I may
have completely missed the point.]

While debugging some "0x58" status errors (which I
believed to have lead to disk corruption) I discovered
that ide_config_drive_speed() uses SELECT_DRIVE
without checking to see if there are disk transfers in
progress (by definition these have to be DMA
transfers).  Unless I've misread the ATA specs, this
is a Very Bad Thing.

This means that when modules which call
ide_register_subdriver() are loaded (so far I think
it's just ide-cd and ide-scsi) any disk transfers in
progress on the other half of the cable are stuffed.

This is very easy to reproduce: just do a "dd
if=/dev/hda of=/dev/null" and a few of "rmmod
ide-cd;modprobe ide-cd" (where there must be a CD on
hdb, or hdc and hdd but you get the idea).  On my box,
this is about 80% successful each module-load at
causing the "0x58" status error.  Repeated usage
trashes inodes (don't know why) and even causes
lockups (don't know why either).  This suggests that
the error-recovery doesn't work very well...

Anyway, here's the band aid as promised.  A timeout,
or a queued request would be better, but I'm not sure
of how best to do either, so at least now the real
experts can fix it properly...

cheers
Neil
PS: don't know (but doubt it) if this is what caused
the 0x58 problems in 2.2 etc.
PPS: I'm off-list at present, so please CC me if you
want me to notice responses.


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
--0-679248808-1020458183=:24708
Content-Type: application/x-unknown; name=ide_patch030502
Content-Transfer-Encoding: base64
Content-Description: ide_patch030502
Content-Disposition: attachment; filename=ide_patch030502

LS0tIGlkZS1mZWF0dXJlcy5jLm9yaWcJRnJpIEZlYiAgOSAxOTo0MDowMiAy
MDAxCisrKyBpZGUtZmVhdHVyZXMuYwlGcmkgTWF5ICAzIDIwOjIxOjU4IDIw
MDIKQEAgLTI4MSwxMiArMjgxLDE4IEBACiAgKi8KIGludCBpZGVfY29uZmln
X2RyaXZlX3NwZWVkIChpZGVfZHJpdmVfdCAqZHJpdmUsIGJ5dGUgc3BlZWQp
CiB7CisJaWRlX2h3Z3JvdXBfdCAqaHdncm91cCA9IEhXR1JPVVAoZHJpdmUp
OwogCWlkZV9od2lmX3QgKmh3aWYgPSBIV0lGKGRyaXZlKTsKIAlpbnQJaSwg
ZXJyb3IgPSAxOwotCWJ5dGUgc3RhdDsKKwlieXRlIHN0YXQsdW5pdDsKKwor
CWlmIChod2dyb3VwLT5idXN5KSB7CisJCXByaW50aygiQXJnaDogaHdncm91
cCBpcyBidXN5IGluIGlkZV9jb25maWdfZHJpdmVfc3BlZWRcbiIpOworCQly
ZXR1cm4gZXJyb3I7CisJfQogCiAjaWYgZGVmaW5lZChDT05GSUdfQkxLX0RF
Vl9JREVETUEpICYmICFkZWZpbmVkKENPTkZJR19ETUFfTk9OUENJKQotCWJ5
dGUgdW5pdCA9IChkcml2ZS0+c2VsZWN0LmIudW5pdCAmIDB4MDEpOworCXVu
aXQgPSAoZHJpdmUtPnNlbGVjdC5iLnVuaXQgJiAweDAxKTsKIAlvdXRiKGlu
Yihod2lmLT5kbWFfYmFzZSsyKSAmIH4oMTw8KDUrdW5pdCkpLCBod2lmLT5k
bWFfYmFzZSsyKTsKICNlbmRpZiAvKiAoQ09ORklHX0JMS19ERVZfSURFRE1B
KSAmJiAhKENPTkZJR19ETUFfTk9OUENJKSAqLwogCg==

--0-679248808-1020458183=:24708--
