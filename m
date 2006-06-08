Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbWFHHPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbWFHHPO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 03:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWFHHPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 03:15:13 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:39515 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932544AbWFHHPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 03:15:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=ZWCCe/rOGiv6NEE60kMDfP22s0uFqmuIQnWDuv2dE7b7lVYLbM3TjKF2qfXVZlSrlgB55wEkTykSFsttLh5np530fR4iWDdv0KtqnMvYEbI46R5uU3gMCF+CDFg+nL3xlm+emOTuyV9pgp3rU8pbJaONJOzRaXXff2Q7i73flIE=
Message-ID: <489ecd0c0606080015v4815d0f3wa3d28c564eaf6885@mail.gmail.com>
Date: Thu, 8 Jun 2006 15:15:11 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: samuel@sortiz.org, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Fix an inproper alignment accessing in irda protocol stack
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_18446_21065351.1149750911075"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_18446_21065351.1149750911075
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

 For "struct irda_device_info" in irda.h:
struct irda_device_info {
	__u32       saddr;    /* Address of local interface */
	__u32       daddr;    /* Address of remote device */
	char        info[22]; /* Description */
	__u8        charset;  /* Charset used for description */
	__u8        hints[2]; /* Hint bits */
};
   The "hints" member aligns at the third byte of a word, an odd
address. So if we visit "hints" as a short in irlmp.c:

    u16ho(irlmp->discovery_cmd.data.hints) = irlmp->hints.word;

  will cause alignment problem on some machines. Architectures with
strict alignment rules do not allow 16-bit read on an odd address.

Signed-off-by: Luke Yang <luke.adi@gmail.com>

 irlmp.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- net/irda/irlmp.c.old        2006-06-08 14:49:20.000000000 +0800
+++ net/irda/irlmp.c    2006-06-08 14:54:29.000000000 +0800
@@ -849,7 +849,8 @@
        }

        /* Construct new discovery info to be used by IrLAP, */
-       u16ho(irlmp->discovery_cmd.data.hints) = irlmp->hints.word;
+       irlmp->discovery_cmd.data.hints[0] = irlmp->hints.word & 0xff;
+       irlmp->discovery_cmd.data.hints[1] = (irlmp->hints.word & 0xff00) >> 8;

        /*
         *  Set character set for device name (we use ASCII), and

-- 
Best regards,
Luke Yang
luke.adi@gmail.com

------=_Part_18446_21065351.1149750911075
Content-Type: text/x-patch; name=irlmp_alignment_fixing.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eo6ru1m6
Content-Disposition: attachment; filename="irlmp_alignment_fixing.patch"

LS0tIG5ldC9pcmRhL2lybG1wLmMub2xkCTIwMDYtMDYtMDggMTQ6NDk6MjAuMDAwMDAwMDAwICsw
ODAwCisrKyBuZXQvaXJkYS9pcmxtcC5jCTIwMDYtMDYtMDggMTQ6NTQ6MjkuMDAwMDAwMDAwICsw
ODAwCkBAIC04NDksNyArODQ5LDggQEAKIAl9CiAKIAkvKiBDb25zdHJ1Y3QgbmV3IGRpc2NvdmVy
eSBpbmZvIHRvIGJlIHVzZWQgYnkgSXJMQVAsICovCi0JdTE2aG8oaXJsbXAtPmRpc2NvdmVyeV9j
bWQuZGF0YS5oaW50cykgPSBpcmxtcC0+aGludHMud29yZDsKKwlpcmxtcC0+ZGlzY292ZXJ5X2Nt
ZC5kYXRhLmhpbnRzWzBdID0gaXJsbXAtPmhpbnRzLndvcmQgJiAweGZmOworCWlybG1wLT5kaXNj
b3ZlcnlfY21kLmRhdGEuaGludHNbMV0gPSAoaXJsbXAtPmhpbnRzLndvcmQgJiAweGZmMDApID4+
IDg7CiAKIAkvKgogCSAqICBTZXQgY2hhcmFjdGVyIHNldCBmb3IgZGV2aWNlIG5hbWUgKHdlIHVz
ZSBBU0NJSSksIGFuZAo=
------=_Part_18446_21065351.1149750911075--
