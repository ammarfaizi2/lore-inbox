Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270796AbUJUSZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270796AbUJUSZX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270785AbUJUSV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 14:21:56 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:8286 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S270746AbUJUSMm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:12:42 -0400
Subject: Re: Linux v2.6.9 (Strange tty problem?)
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul <set@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1098349651.17067.3.camel@localhost.localdomain>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>
	 <20041021024132.GB6504@squish.home.loc>
	 <1098349651.17067.3.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1098382360.3288.8.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 21 Oct 2004 13:12:41 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 04:07, Alan Cox wrote:
> introduced by the tty changes. I'll try and fix it ASAP if Paul doesn't
> beat me to it.

I reviewed, patched, and tested ppp_async.c to
implement ldisc->hangup(). This correctly terminates
the PPP connection on hangup.

Paul Mackerras already did an excellent job of
ensuring safe shutdown and I/O completion
in ldisc->close so the change is trivial:
just add the ldisc->hangup and call the
existing close routine.

One question to Alan: what is the return code
in ldisc->hangup for? The docs don't say.

-- 
Paul Fulghum
paulkf@microgate.com

--- linux-2.6.9-bk4/drivers/net/ppp_async.c	2004-10-18 16:54:40.000000000 -0500
+++ b/drivers/net/ppp_async.c	2004-10-21 12:50:50.000000000 -0500
@@ -238,6 +238,18 @@ ppp_asynctty_close(struct tty_struct *tt
 }
 
 /*
+ * Called on tty hangup in process context.
+ *
+ * Wait for I/O to driver to complete and unregister PPP channel.
+ * This is already done by the close routine, so just call that.
+ */
+static int ppp_asynctty_hangup(struct tty_struct *tty)
+{
+	ppp_asynctty_close(tty);
+	return 0;
+}
+
+/*
  * Read does nothing - no data is ever available this way.
  * Pppd reads and writes packets via /dev/ppp instead.
  */
@@ -380,6 +392,7 @@ static struct tty_ldisc ppp_ldisc = {
 	.name	= "ppp",
 	.open	= ppp_asynctty_open,
 	.close	= ppp_asynctty_close,
+	.hangup	= ppp_asynctty_hangup,
 	.read	= ppp_asynctty_read,
 	.write	= ppp_asynctty_write,
 	.ioctl	= ppp_asynctty_ioctl,


