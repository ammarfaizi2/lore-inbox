Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbWFNC3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbWFNC3V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 22:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWFNC3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 22:29:21 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:41465 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964939AbWFNC3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 22:29:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=fKJIGKWJOFZFxHDTpam4qicfd+wNLtg2WFArJccBhA8SeMVLkfK1evZFCeAzus0OZmzCMrHn2yuktKmNzIOx1YT2wC4T75YsZiCGZ5ux4EXBfHY6Bw0Nh2fqqNwuQXDeIbIlNdwGBz8ZKwKprjHNvTK0qW/C7CCmSjNDJdcJxVg=
Message-ID: <489ecd0c0606131929l5311bdb9g1e903904f0d8fb2b@mail.gmail.com>
Date: Wed, 14 Jun 2006 10:29:19 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: samuel@sortiz.org, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix an inproper alignment accessing in irda protocol stack
In-Reply-To: <489ecd0c0606080015v4815d0f3wa3d28c564eaf6885@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_10551_1989831.1150252159131"
References: <489ecd0c0606080015v4815d0f3wa3d28c564eaf6885@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_10551_1989831.1150252159131
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
strict alignment rules do not allow 16-bit read on an odd address. I
use le16_to_cpu to do the converting.

Signed-off-by: Luke Yang <luke.adi@gmail.com>

 irlmp.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

--- net/irda/irlmp.c.old        2006-06-08 14:49:20.000000000 +0800
+++ net/irda/irlmp.c    2006-06-14 10:00:22.000000000 +0800
@@ -849,7 +849,10 @@
        }

        /* Construct new discovery info to be used by IrLAP, */
-       u16ho(irlmp->discovery_cmd.data.hints) = irlmp->hints.word;
+       irlmp->discovery_cmd.data.hints[0] = \
+               le16_to_cpu(irlmp->hints.word) & 0xff;
+       irlmp->discovery_cmd.data.hints[1] = \
+               (le16_to_cpu(irlmp->hints.word) & 0xff00) >> 8;

        /*
         *  Set character set for device name (we use ASCII), and

-- 
Best regards,
Luke Yang
luke.adi@gmail.com

------=_Part_10551_1989831.1150252159131
Content-Type: text/x-patch; name=irlmp_alignment_fixing.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eof2d5ec
Content-Disposition: attachment; filename="irlmp_alignment_fixing.patch"

LS0tIG5ldC9pcmRhL2lybG1wLmMub2xkCTIwMDYtMDYtMDggMTQ6NDk6MjAuMDAwMDAwMDAwICsw
ODAwCisrKyBuZXQvaXJkYS9pcmxtcC5jCTIwMDYtMDYtMTQgMTA6MDA6MjIuMDAwMDAwMDAwICsw
ODAwCkBAIC04NDksNyArODQ5LDEwIEBACiAJfQogCiAJLyogQ29uc3RydWN0IG5ldyBkaXNjb3Zl
cnkgaW5mbyB0byBiZSB1c2VkIGJ5IElyTEFQLCAqLwotCXUxNmhvKGlybG1wLT5kaXNjb3Zlcnlf
Y21kLmRhdGEuaGludHMpID0gaXJsbXAtPmhpbnRzLndvcmQ7CisJaXJsbXAtPmRpc2NvdmVyeV9j
bWQuZGF0YS5oaW50c1swXSA9IFwKKwkJbGUxNl90b19jcHUoaXJsbXAtPmhpbnRzLndvcmQpICYg
MHhmZjsKKwlpcmxtcC0+ZGlzY292ZXJ5X2NtZC5kYXRhLmhpbnRzWzFdID0gXAorCQkobGUxNl90
b19jcHUoaXJsbXAtPmhpbnRzLndvcmQpICYgMHhmZjAwKSA+PiA4OwogCiAJLyoKIAkgKiAgU2V0
IGNoYXJhY3RlciBzZXQgZm9yIGRldmljZSBuYW1lICh3ZSB1c2UgQVNDSUkpLCBhbmQK
------=_Part_10551_1989831.1150252159131--
