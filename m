Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVB1Oml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVB1Oml (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 09:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVB1Omk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 09:42:40 -0500
Received: from smtp-out.hotpop.com ([38.113.3.71]:30661 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261389AbVB1OmO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 09:42:14 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net, Olaf Hering <olh@suse.de>,
       linux-nvidia@lists.surfsouth.com
Subject: Re: [Linux-fbdev-devel] Re: 2.6.11-rc5, rivafb i2c oops, bogus error handling
Date: Mon, 28 Feb 2005 22:41:54 +0800
User-Agent: KMail/1.5.4
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org> <20050227203214.GA15572@suse.de>
In-Reply-To: <20050227203214.GA15572@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502282241.55815.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 February 2005 04:32, Olaf Hering wrote:
>  On Wed, Feb 23, Linus Torvalds wrote:
> > This time it's really supposed to be a quickie, so people who can, please
> > check it out, and we'll make the real 2.6.11 asap.
>
> Here is another one, probably not new.
> Is riva_get_EDID_i2c a bit too optimistic by not having a $i2cadapter_ok
> member in riva_par->riva_i2c_chan? It calls riva_probe_i2c_connector
> even if riva_create_i2c_busses fails to register all 3 busses.
>

Thanks,

Can you try this?

Fixed error handling in rivafb-i2c.c if bus registration fails.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 rivafb-i2c.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff -Nru a/drivers/video/riva/rivafb-i2c.c b/drivers/video/riva/rivafb-i2c.c
--- a/drivers/video/riva/rivafb-i2c.c	2005-01-13 03:57:12 +08:00
+++ b/drivers/video/riva/rivafb-i2c.c	2005-02-28 08:22:06 +08:00
@@ -120,8 +120,12 @@
 	rc = i2c_bit_add_bus(&chan->adapter);
 	if (rc == 0)
 		dev_dbg(&chan->par->pdev->dev, "I2C bus %s registered.\n", name);
-	else
-		dev_warn(&chan->par->pdev->dev, "Failed to register I2C bus %s.\n", name);
+	else {
+		dev_warn(&chan->par->pdev->dev,
+			 "Failed to register I2C bus %s.\n", name);
+		chan->par = NULL;
+	}
+
 	return rc;
 }
 
@@ -171,6 +175,9 @@
 		},
 	};
 	u8 *buf;
+
+	if (!chan->par)
+		return NULL;
 
 	buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
 	if (!buf) {


