Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbTLWCHd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 21:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264921AbTLWCHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 21:07:32 -0500
Received: from 12-211-66-152.client.attbi.com ([12.211.66.152]:60043 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S264919AbTLWCHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 21:07:30 -0500
Message-ID: <3FE7A35E.9090507@comcast.net>
Date: Mon, 22 Dec 2003 18:07:26 -0800
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031121
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nicklas Bondesson <nikomail@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error mounting root fs on 72:01 using Promise FastTrak TX2000
 (PDC20271)
References: <BAY8-DAV18eeADZVX6Q0000db55@hotmail.com>
In-Reply-To: <BAY8-DAV18eeADZVX6Q0000db55@hotmail.com>
Content-Type: multipart/mixed;
 boundary="------------080609060607080308080607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080609060607080308080607
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Nicklas Bondesson wrote:
> Actually the 2.4.18 seems to be the only one working. I'm sure someone out
> there have the proper fix for this. Who should I talk to in order to get
> this fixed? I'm willing to help out in any way I can.
> 
> /Nicke 

Well, not really sure. I thought Alan Cox did the original pdcraid.c for linux
some time back, but it really hasn't seen many changes. There were two general
Linux changes that took place back around 2.4.22 that might affect you. The
first, was the addition of the new Promise IDE driver, which you've got
configured. The second,  has to do with how Linux reports the geometry of a
drive. This change affected my setup which is why I wrote the patch for the
pdcraid driver. If your system makes it all the way through kernel booting
(which it seems to do), but can't mount the filesystem on the raid, it seems to
indicate the latter change affecting you also. The only other thing I can think
of, is to use my patch (attached) with patch -p1 < pdcraid.patch from your
/usr/src/linux and make sure that you've got both Promise drivers compiled in
your kernel. Recompile and see what happens. Outside of that, I'm stuck. Good luck,

-Walt

--------------080609060607080308080607
Content-Type: text/plain;
 name="pdcraid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pdcraid.patch"

--- /usr/src/temp/linux-2.4.21-xfs/linux/drivers/ide/raid/pdcraid.c	2003-12-22 17:59:09.653139067 -0800
+++ linux/drivers/ide/raid/pdcraid.c	2003-07-21 20:47:14.000000000 -0700
@@ -361,7 +361,11 @@
 	if (ideinfo->sect==0)
 		return 0;
-	lba = (ideinfo->capacity / (ideinfo->head*ideinfo->sect));
-	lba = lba * (ideinfo->head*ideinfo->sect);
-	lba = lba - ideinfo->sect;
+	if (ideinfo->head!=255) {
+		lba = (ideinfo->capacity / (ideinfo->head*ideinfo->sect));
+		lba = lba * (ideinfo->head*ideinfo->sect);
+		lba = lba - ideinfo->sect; }
+	else {
+		lba = ideinfo->capacity - ideinfo->sect;
+	}
 
 	return lba;

--------------080609060607080308080607--


