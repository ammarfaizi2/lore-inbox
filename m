Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264507AbUBIAt1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 19:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbUBIAt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 19:49:27 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:8168 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264507AbUBIAtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 19:49:24 -0500
Date: Mon, 9 Feb 2004 01:48:12 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Murilo Pontes <murilo_pontes@yahoo.com.br>
Cc: linux-kernel@vger.kernel.org, wnelsonjr@comcast.net, ctpm@rnl.ist.utl.pt,
       clay@exavio.com.cn, mbuesch@freenet.de, johann.lombardi@bull.net,
       mikeserv@bmts.com, gillb4@telusplanet.net, aeriksson@fastmail.fm
Subject: [patch] Re: psmouse.c, throwing 3 bytes away
Message-ID: <20040209004812.GA18512@ucw.cz>
References: <200402041820.39742.wnelsonjr@comcast.net> <200402060006.32732.wnelsonjr@comcast.net> <20040207004700.0dd5e626.mikeserv@bmts.com> <200402070911.42569.murilo_pontes@yahoo.com.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <200402070911.42569.murilo_pontes@yahoo.com.br>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 07, 2004 at 09:11:42AM +0000, Murilo Pontes wrote:

> Problem still occurs :-(

And here is a fix. Damn stupid mistake I made.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lost-sync-fix

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1587, 2004-02-09 01:47:16+01:00, vojtech@suse.cz
  input: Fix "psmouse: Lost sync" problem. It was really losing sync.


 i8042.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Mon Feb  9 01:47:46 2004
+++ b/drivers/input/serio/i8042.c	Mon Feb  9 01:47:46 2004
@@ -379,9 +379,12 @@
 	unsigned int dfl;
 	int ret;
 
+	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
+
 	spin_lock_irqsave(&i8042_lock, flags);
 	str = i8042_read_status();
-	data = i8042_read_data();
+	if (str & I8042_STR_OBF)
+		data = i8042_read_data();
 	spin_unlock_irqrestore(&i8042_lock, flags);
 
 	if (~str & I8042_STR_OBF) {
@@ -432,7 +435,6 @@
 irq_ret:
 	ret = 1;
 out:
-	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
 	return IRQ_RETVAL(ret);
 }
 

--OXfL5xGRrasGEqWY--
