Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWFIDpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWFIDpJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 23:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWFIDpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 23:45:09 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:5003 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932147AbWFIDpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 23:45:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=pX+8C/fQyuIw9lSxgRFm76vaPSbToahbTg1yrwJx5znFs0UzrW3oHhZ4fTpcfrZjaQX+/zBSrAk82AzEw3AAFUOzGZnmXTdg+tZMQanaf+M2fq2cHxOAcE/VEkn/4yTEWzRShr31yOI5WPHZbiOb2m0Gf0F9VMpmzbWEFdr5ims=
Message-ID: <489ecd0c0606082045w7456a90et586a3954f1a2fca0@mail.gmail.com>
Date: Fri, 9 Jun 2006 11:45:06 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] Fix an inproper alignment accessing in irda protocol stack
Cc: samuel@sortiz.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060608003015.52fe1b8e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_7813_22026591.1149824706389"
References: <489ecd0c0606080015v4815d0f3wa3d28c564eaf6885@mail.gmail.com>
	 <20060608003015.52fe1b8e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_7813_22026591.1149824706389
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Andrew,

   Thanks. I modified the patch (don't know if there is any way better
to solve this).

Signed-off-by: Luke Yang <luke.adi@gmail.com>

 irlmp.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)

--- net/irda/irlmp.c.old        2006-06-08 14:49:20.000000000 +0800
+++ net/irda/irlmp.c    2006-06-09 19:43:58.000000000 +0800
@@ -849,7 +849,13 @@
        }

        /* Construct new discovery info to be used by IrLAP, */
-       u16ho(irlmp->discovery_cmd.data.hints) = irlmp->hints.word;
+#ifdef __LITTLE_ENDIAN
+       irlmp->discovery_cmd.data.hints[0] = irlmp->hints.word & 0xff;
+       irlmp->discovery_cmd.data.hints[1] = (irlmp->hints.word & 0xff00) >> 8;
+#else /* ifdef __BIG_ENDIAN */
+       irlmp->discovery_cmd.data.hints[0] = (irlmp->hints.word & 0xff00) >> 8;
+       irlmp->discovery_cmd.data.hints[1] = irlmp->hints.word & 0xff;
+#endif

        /*
         *  Set character set for device name (we use ASCII), and

On 6/8/06, Andrew Morton <akpm@osdl.org> wrote:
> On Thu, 8 Jun 2006 15:15:11 +0800
> "Luke Yang" <luke.adi@gmail.com> wrote:
>
> > Hi all,
> >
> >  For "struct irda_device_info" in irda.h:
> > struct irda_device_info {
> >       __u32       saddr;    /* Address of local interface */
> >       __u32       daddr;    /* Address of remote device */
> >       char        info[22]; /* Description */
> >       __u8        charset;  /* Charset used for description */
> >       __u8        hints[2]; /* Hint bits */
> > };
> >    The "hints" member aligns at the third byte of a word, an odd
> > address. So if we visit "hints" as a short in irlmp.c:
> >
> >     u16ho(irlmp->discovery_cmd.data.hints) = irlmp->hints.word;
> >
> >   will cause alignment problem on some machines. Architectures with
> > strict alignment rules do not allow 16-bit read on an odd address.
> >
> > Signed-off-by: Luke Yang <luke.adi@gmail.com>
> >
> >  irlmp.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletion(-)
> >
> > --- net/irda/irlmp.c.old        2006-06-08 14:49:20.000000000 +0800
> > +++ net/irda/irlmp.c    2006-06-08 14:54:29.000000000 +0800
> > @@ -849,7 +849,8 @@
> >         }
> >
> >         /* Construct new discovery info to be used by IrLAP, */
> > -       u16ho(irlmp->discovery_cmd.data.hints) = irlmp->hints.word;
> > +       irlmp->discovery_cmd.data.hints[0] = irlmp->hints.word & 0xff;
> > +       irlmp->discovery_cmd.data.hints[1] = (irlmp->hints.word & 0xff00) >> 8;
>
> This change will have the effect of swapping those two bytes on big-endian
> machines.
>
>


-- 
Best regards,
Luke Yang
luke.adi@gmail.com

------=_Part_7813_22026591.1149824706389
Content-Type: text/x-patch; name="irlmp_alignment_fixing.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="irlmp_alignment_fixing.patch"
X-Attachment-Id: f_eo8h8l5m

LS0tIG5ldC9pcmRhL2lybG1wLmMub2xkCTIwMDYtMDYtMDggMTQ6NDk6MjAuMDAwMDAwMDAwICsw
ODAwCisrKyBuZXQvaXJkYS9pcmxtcC5jCTIwMDYtMDYtMDkgMTk6NDM6NTguMDAwMDAwMDAwICsw
ODAwCkBAIC04NDksNyArODQ5LDEzIEBACiAJfQogCiAJLyogQ29uc3RydWN0IG5ldyBkaXNjb3Zl
cnkgaW5mbyB0byBiZSB1c2VkIGJ5IElyTEFQLCAqLwotCXUxNmhvKGlybG1wLT5kaXNjb3Zlcnlf
Y21kLmRhdGEuaGludHMpID0gaXJsbXAtPmhpbnRzLndvcmQ7CisjaWZkZWYgX19MSVRUTEVfRU5E
SUFOCisJaXJsbXAtPmRpc2NvdmVyeV9jbWQuZGF0YS5oaW50c1swXSA9IGlybG1wLT5oaW50cy53
b3JkICYgMHhmZjsKKwlpcmxtcC0+ZGlzY292ZXJ5X2NtZC5kYXRhLmhpbnRzWzFdID0gKGlybG1w
LT5oaW50cy53b3JkICYgMHhmZjAwKSA+PiA4OworI2Vsc2UgLyogaWZkZWYgX19CSUdfRU5ESUFO
ICovCisJaXJsbXAtPmRpc2NvdmVyeV9jbWQuZGF0YS5oaW50c1swXSA9IChpcmxtcC0+aGludHMu
d29yZCAmIDB4ZmYwMCkgPj4gODsKKwlpcmxtcC0+ZGlzY292ZXJ5X2NtZC5kYXRhLmhpbnRzWzFd
ID0gaXJsbXAtPmhpbnRzLndvcmQgJiAweGZmOworI2VuZGlmCiAKIAkvKgogCSAqICBTZXQgY2hh
cmFjdGVyIHNldCBmb3IgZGV2aWNlIG5hbWUgKHdlIHVzZSBBU0NJSSksIGFuZAo=
------=_Part_7813_22026591.1149824706389--
