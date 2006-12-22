Return-Path: <linux-kernel-owner+w=401wt.eu-S1752313AbWLVLdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbWLVLdN (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 06:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752877AbWLVLdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 06:33:12 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:61875 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbWLVLdM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 06:33:12 -0500
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 06:33:11 EST
From: Martin Williges <kernel@zut.de>
To: gregkh@suse.de, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 1/1] usblp.c - add Kyocera Mita FS 820 to list of "quirky" printers
Date: Fri, 22 Dec 2006 12:27:18 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, dsd@gentoo.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612221227.18870.kernel@zut.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:0e8a1abe8b7b166fb6ca785a477f557f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from: Martin Williges <kernel@zut.de>

this patch gets the Kyocera FS 820 working with cups 1.2 via usb again. It
adds the printer to the list of "quirky" printers. Patch is based on
linux-2.6.19.

Signed-off-by: Martin Williges <kernel@zut.de>

---

Background:
I have little knowledge of usb, the following is based on my observations and
assumptions. With cups 1.2.6 going stable in gentoo, the usb backend does not
find the printer and thus users are not able to add the printer if it´s
connected via usb. In cups 1.1.x, the backend just reported a default bunch
of devices a printer might be connected to.
As far as I could see, cups detects the printer (/dev/usb/lp0) and sends an
ioctl which times out. I traced the timeout:
usblp.c calls usb_control_msg() (in message.c)
->usb_internal_control_msg()
->usb_start_wait_urb()
this function times out, the printer does not answer (0/1023 chars read).

Funny thing is, reading the identification works directly after plugging the
printer in, but not some seconds after. The patch lets the cups usb backend
find the printer again. So maybe the patch is a little crude. If someone has
a better idea, I may be able provide straces, syslog with DEBUG on,...

--- usblp.c.orig        2006-11-29 22:57:37.000000000 +0100
+++ usblp.c     2006-12-22 12:08:00.000000000 +0100
@@ -217,6 +217,7 @@ static const struct quirk_printer_struct
        { 0x0409, 0xbef4, USBLP_QUIRK_BIDIR }, /* NEC Picty760 (HP OEM) */
        { 0x0409, 0xf0be, USBLP_QUIRK_BIDIR }, /* NEC Picty920 (HP OEM) */
        { 0x0409, 0xf1be, USBLP_QUIRK_BIDIR }, /* NEC Picty800 (HP OEM) */
+       { 0x0482, 0x0010, USBLP_QUIRK_BIDIR }, /* Kyocera Mita FS 820, by zut <kernel@zut.de> */
        { 0, 0 }
 };
