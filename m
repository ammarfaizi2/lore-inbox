Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUAYKD7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 05:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUAYKD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 05:03:59 -0500
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:22283 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S263850AbUAYKD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 05:03:57 -0500
Date: Sun, 25 Jan 2004 11:03:58 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH 2.4] Fix bus reset in i2c-philips-par
Message-Id: <20040125110358.770c41a1.khali@linux-fr.org>
In-Reply-To: <20040123213024.79b69112.khali@linux-fr.org>
References: <20040123213024.79b69112.khali@linux-fr.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

This patch fixes the bus reset in i2c-philips-par when it is loaded with
type!=0. For now, the reset is always made as if type==0. This patch was
built and tested on 2.4.25-pre7.

I've committed a similar fix to our i2c CVS repository, and have sent
a patch to Greg KH for 2.6 too, which he already accepted.

This is a bug fix, however:
* I think that the i2c-philips-par driver isn't much used.
* I think that the i2c-philips-par driver with type!=0 is even less
  used.
* The bus reset is more or less optional. Skipping it doesn't hurt much.
* The wrong reset doesn't hurt either.
So this is in no way critical (and explains why the bug wasn't
discovered earlier).

On the other hand the fix is easy and clear. Anyway I leave it to you to
decide if it should be applied to 2.4 or not.

Thanks.

--- linux-2.4.25-pre7/drivers/i2c/i2c-philips-par.c.orig	Sun Jan 25 09:57:06 2004
+++ linux-2.4.25-pre7/drivers/i2c/i2c-philips-par.c	Sun Jan 25 09:59:36 2004
@@ -212,8 +212,8 @@
 
 	/* reset hardware to sane state */
 	parport_claim_or_block(adapter->pdev);
-	bit_lp_setsda(port, 1);
-	bit_lp_setscl(port, 1);
+	adapter->bit_lp_data.setsda(port, 1);
+	adapter->bit_lp_data.setscl(port, 1);
 	parport_release(adapter->pdev);
 
 	if (i2c_bit_add_bus(&adapter->adapter) < 0)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
