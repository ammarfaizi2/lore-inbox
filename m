Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131573AbRCXEpf>; Fri, 23 Mar 2001 23:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131577AbRCXEpZ>; Fri, 23 Mar 2001 23:45:25 -0500
Received: from blount.mail.mindspring.net ([207.69.200.226]:34859 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S131573AbRCXEpS>; Fri, 23 Mar 2001 23:45:18 -0500
Message-ID: <001e01c0b41d$1665de80$1601a8c0@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: "Alessandro Suardi" <alessandro.suardi@oracle.com>
Cc: <linux-kernel@vger.kernel.org>, "Jeff Garzik" <jgarzik@mandrakesoft.com>
In-Reply-To: <012301c0b357$3d29cc50$1601a8c0@zeusinc.com> <3ABBD639.12BE1035@oracle.com>
Subject: [PATCH] Fix for serial.c to work with Xircom Cardbus Ethernet+Modem
Date: Fri, 23 Mar 2001 23:44:17 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tom Sightler wrote:
> >
> > Hi all,
> >
> > I saw a discussion on this list about this problem earlier, but could
not
> > find that it had actually been resolved.
>
> That was me :) and no, it doesn't work. Jeff Garzik asked me to enable
>  a couple debug #defines in serial.c, apply patches to serial.c and
>  finally disable i82365 support but as of now it doesn't work.
>
> It looks like we have the same card with modem @ 0x1880.

Yep, almost certainly the same, or at least very similar Xircom card.

> > Any ideas?  I may look at it more tomorrow.  For now I'm back to using
> > serial_cb which still works fine (even though that apparently suprises
many
> > people).
>
> :) this is -pre4 with serial_cb which works fine, and always has...

OK, can you try this patch?  It's very simple, and is probably not the
correct fix (the correct fix is probably to add the Xircom card to the
supported PCI table), but it works for me.  I'm not sure why the generic pci
serial code counts the number of iomem regions and only uses it if it has
exactly 0 or 1, but the Xircom has 2 iomem regions so the generic code fails
to use it.  The following change relaxes the generic code to allow for up to
2 iomem regions on a PCI serial device.  I have no idea what the side
effects would be to this change, but it makes my Xircom work again and that
was my goal.  If I can help someone fix this correctly let me know what you
need.

Later,
Tom

--- serial.c.old        Fri Mar 23 23:23:17 2001
+++ serial.c    Fri Mar 23 23:24:17 2001
@@ -4616,10 +4616,10 @@
        }

        /*
-        * If there is 1 or 0 iomem regions, and exactly one port, use
+        * If there is <= 2 iomem regions, and exactly one port, use
         * it.
         */
-       if (num_iomem <= 1 && num_port == 1) {
+       if (num_iomem <= 2 && num_port == 1) {
                board->flags = first_port;
                return 0;
        }


