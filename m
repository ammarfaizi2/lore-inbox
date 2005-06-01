Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVFADih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVFADih (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 23:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVFADih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 23:38:37 -0400
Received: from adsl-69-149-197-17.dsl.austtx.swbell.net ([69.149.197.17]:15777
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S261217AbVFADi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 23:38:29 -0400
Subject: Re: [PATCH 1/2] Introduce tty_unregister_ldisc()
From: Paul Fulghum <paulkf@microgate.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1117578491.4627.14.camel@at2.pipehead.org>
References: <200505312356.00853.adobriyan@gmail.com>
	 <1117578491.4627.14.camel@at2.pipehead.org>
Content-Type: text/plain
Date: Tue, 31 May 2005 22:38:08 -0500
Message-Id: <1117597088.5888.18.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-31 at 17:28 -0500, Paul Fulghum wrote:
> An unmodified ldisc driver (externally maintained) will continue to call
> tty_register_ldisc with NULL, but the new behavior will be to set the
> ldisc pointer to NULL but have LDISC_FLAG_DEFINED set.

I was partially wrong.
After Alexey's patch, a NULL new_ldisc is accessed 
(not assigned) causing an oops. This is still not
good behavior.

As for the refcount bug, this patch should fix it.
Comments?

--
Paul Fulghum
paulkf@microgate.com

--- linux-2.6.11/drivers/char/tty_io.c	2005-03-02 01:38:10.000000000 -0600
+++ b/drivers/char/tty_io.c	2005-05-31 22:10:41.000000000 -0500
@@ -262,16 +262,16 @@ int tty_register_ldisc(int disc, struct 
 		return -EINVAL;
 	
 	spin_lock_irqsave(&tty_ldisc_lock, flags);
-	if (new_ldisc) {
+	if ((tty_ldiscs[disc].flags & LDISC_FLAG_DEFINED) &&
+	    tty_ldiscs[disc].refcount)
+		ret = -EBUSY;
+	else if (new_ldisc) {
 		tty_ldiscs[disc] = *new_ldisc;
 		tty_ldiscs[disc].num = disc;
 		tty_ldiscs[disc].flags |= LDISC_FLAG_DEFINED;
 		tty_ldiscs[disc].refcount = 0;
 	} else {
-		if(tty_ldiscs[disc].refcount)
-			ret = -EBUSY;
-		else
-			tty_ldiscs[disc].flags &= ~LDISC_FLAG_DEFINED;
+		tty_ldiscs[disc].flags &= ~LDISC_FLAG_DEFINED;
 	}
 	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 	


