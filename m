Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbUAMMF5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 07:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264141AbUAMMF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 07:05:57 -0500
Received: from colino.net ([62.212.100.143]:25331 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S264127AbUAMMFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 07:05:54 -0500
Date: Tue, 13 Jan 2004 13:05:29 +0100
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: cdc-acm problems
Message-Id: <20040113130529.03f5dbac.colin@colino.net>
Organization: 
X-Mailer: Sylpheed version 0.9.5claws (GTK+ 2.2.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__13_Jan_2004_13_05_29_+0100_=.y5ViVQ+GxKF(fC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Tue__13_Jan_2004_13_05_29_+0100_=.y5ViVQ+GxKF(fC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

I have problems with cdc-acm killing ohci. I tried to narrow down the problem, 
but didn't get far. 
Basically `killall -HUP pppd` gives (in dmesg):

drivers/usb/class/cdc-acm.c: acm_ctrl_irq - urb shutting down with status: -2
ohci_hcd 0001:01:1b.1: OHCI Unrecoverable Error, disabled
ohci_hcd 0001:01:1b.1: HC died; cleaning up
usb 4-1: USB disconnect, address 2
bus usb: remove device 4-1:1.0
bus usb: remove device 4-1:1.1
bus usb: remove device 4-1

I modified cdc-acm.c according to the attached patch, and noticed there may be
a buffer overflow: after applying this patch, `dmesg|grep high` gives:
drivers/usb/class/cdc-acm.c: databits index too high: 48
drivers/usb/class/cdc-acm.c: databits index too high: 48
drivers/usb/class/cdc-acm.c: databits index too high: 48
drivers/usb/class/cdc-acm.c: databits index too high: 48
drivers/usb/class/cdc-acm.c: databits index too high: 48

I'm on a Mac (big-endian). Maybe an endianness issue ?
My patch doesn't solve any problem, but maybe exposes one.

By the way, what's the difference between cpu_to_le32p() and cpu_to_le32() ? 
I'm wondering because of the newline.speed = cpu_to_le32p(...) line (537).

Thanks,
-- 
Colin

--Multipart_Tue__13_Jan_2004_13_05_29_+0100_=.y5ViVQ+GxKF(fC
Content-Type: application/octet-stream;
 name="cdc-acm.patch"
Content-Disposition: attachment;
 filename="cdc-acm.patch"
Content-Transfer-Encoding: base64

SW5kZXg6IGRyaXZlcnMvdXNiL2NsYXNzL2NkYy1hY20uYwo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiAv
aG9tZS9jdnNyb290L2xpbnV4cHBjL2RyaXZlcnMvdXNiL2NsYXNzL2NkYy1hY20uYyx2CnJldHJp
ZXZpbmcgcmV2aXNpb24gMS4xLjEuMQpkaWZmIC11IC11IC1yMS4xLjEuMSBjZGMtYWNtLmMKLS0t
IGRyaXZlcnMvdXNiL2NsYXNzL2NkYy1hY20uYwk4IEphbiAyMDA0IDExOjI1OjUxIC0wMDAwCTEu
MS4xLjEKKysrIGRyaXZlcnMvdXNiL2NsYXNzL2NkYy1hY20uYwkxMyBKYW4gMjAwNCAxMTo1OToy
OCAtMDAwMApAQCAtNDUsNyArNDUsNyBAQAogICogRm91bmRhdGlvbiwgSW5jLiwgNTkgVGVtcGxl
IFBsYWNlLCBTdWl0ZSAzMzAsIEJvc3RvbiwgTUEgMDIxMTEtMTMwNyBVU0EKICAqLwogCi0jdW5k
ZWYgREVCVUcKKyNkZWZpbmUgREVCVUcKIAogI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgogI2lu
Y2x1ZGUgPGxpbnV4L2Vycm5vLmg+CkBAIC01MzAsNyArNTMwLDcgQEAKIAlzdHJ1Y3QgdGVybWlv
cyAqdGVybWlvcyA9IHR0eS0+dGVybWlvczsKIAlzdHJ1Y3QgYWNtX2xpbmUgbmV3bGluZTsKIAlp
bnQgbmV3Y3RybCA9IGFjbS0+Y3RybG91dDsKLQorCWludCBvZmZzZXQgPSAwOwogCWlmICghQUNN
X1JFQURZKGFjbSkpCiAJCXJldHVybjsKIApAQCAtNTM5LDcgKzUzOSwxMyBAQAogCW5ld2xpbmUu
c3RvcGJpdHMgPSB0ZXJtaW9zLT5jX2NmbGFnICYgQ1NUT1BCID8gMiA6IDA7CiAJbmV3bGluZS5w
YXJpdHkgPSB0ZXJtaW9zLT5jX2NmbGFnICYgUEFSRU5CID8KIAkJKHRlcm1pb3MtPmNfY2ZsYWcg
JiBQQVJPREQgPyAxIDogMikgKyAodGVybWlvcy0+Y19jZmxhZyAmIENNU1BBUiA/IDIgOiAwKSA6
IDA7Ci0JbmV3bGluZS5kYXRhYml0cyA9IGFjbV90dHlfc2l6ZVsodGVybWlvcy0+Y19jZmxhZyAm
IENTSVpFKSA+PiA0XTsKKwkKKwlvZmZzZXQgPSAodGVybWlvcy0+Y19jZmxhZyAmIENTSVpFKSA+
PiA0OworCWlmIChvZmZzZXQgPj0gc2l6ZW9mKGFjbV90dHlfc2l6ZSkpIHsKKwkJZGJnKCJkYXRh
Yml0cyBpbmRleCB0b28gaGlnaDogJWRcbiIsIG9mZnNldCk7CisJCW9mZnNldCA9IDM7CisJfQor
CW5ld2xpbmUuZGF0YWJpdHMgPSBhY21fdHR5X3NpemVbb2Zmc2V0XTsKIAogCWFjbS0+Y2xvY2Fs
ID0gKCh0ZXJtaW9zLT5jX2NmbGFnICYgQ0xPQ0FMKSAhPSAwKTsKIAo=

--Multipart_Tue__13_Jan_2004_13_05_29_+0100_=.y5ViVQ+GxKF(fC--
