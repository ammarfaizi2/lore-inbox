Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271210AbTHCRXH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 13:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271222AbTHCRXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 13:23:07 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:55821 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S271210AbTHCRXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 13:23:03 -0400
Date: Sun, 3 Aug 2003 19:23:12 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>,
       "Greg KH" <greg@kroah.com>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: 2.4.22-pre7 drivers/i2c/i2c-dev.c user/kernel bug and
 mem leak
Message-Id: <20030803192312.68762d3c.khali@linux-fr.org>
Reply-To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Ten days ago, Robert T. Johnson repported two bugs in 2.4's
drivers/i2c/i2c-dev.c. It also applies to i2c CVS (out of kernel), which
is intended to become 2.4's soon. Being a member of the LM Sensors dev
team, I took a look at the repport. My knowledge is somewhat limited but
I'll do my best to help (unless Greg wants to handle it alone? ;-)).

For the user/kernel bug, I'm not sure I understand how copy_from_user is
supposed to work. If I understand what the proposed patch does, it
simply allocates a second buffer, copy_from_user to that buffer instead
of to the original one, and then copies from that second buffer to the
original one (kernel to kernel). I just don't see how different it is
from what the current code does, as far as user/kernel issues are
concerned. I must be missing something obvious, can someone please bring
me some light?

For the mem leak bug, it's clearly there. I admit the proposed patch
fixes it, but I think there is a better way to fix it. Compare what the
proposed patch does:

--- i2c-dev.c	Sun Aug  3 18:24:33 2003
+++ i2c-dev.c.proposed	Sun Aug  3 19:13:58 2003
@@ -226,6 +226,7 @@
 		res = 0;
 		for( i=0; i<rdwr_arg.nmsgs; i++ )
 		{
+			rdwr_pa[i].buf = NULL;
 		    	if(copy_from_user(&(rdwr_pa[i]),
 					&(rdwr_arg.msgs[i]),
 					sizeof(rdwr_pa[i])))
@@ -254,8 +255,9 @@
 		}
 		if (res < 0) {
 			int j;
-			for (j = 0; j < i; ++j)
-				kfree(rdwr_pa[j].buf);
+			for (j = 0; j <= i; ++j)
+				if (rdwr_pa[j].buf)
+					kfree(rdwr_pa[j].buf);
 			kfree(rdwr_pa);
 			return res;
 		}

with what I suggest:

--- i2c-dev.c	Sun Aug  3 18:24:33 2003
+++ i2c-dev.c.khali	Sun Aug  3 19:15:04 2003
@@ -247,8 +247,9 @@
 			if(copy_from_user(rdwr_pa[i].buf,
 				rdwr_arg.msgs[i].buf,
 				rdwr_pa[i].len))
 			{
+				kfree(rdwr_pa[i].buf);
 			    	res = -EFAULT;
 				break;
 			}
 		}

Contrary to the proposed fix, my fix does not slow down the non-faulty
cases. I also believe it will increase the code size by fewer bytes than
the proposed fix (not verified though).

So, what about it?



PS: I really would like to see Frodo Looijaard's address replaced with
the LM Sensors mailing list address <sensors@stimpy.netroedge.com> as
the main I2C contact in MAINTAINERS. Simon Vogl and Frodo Looijaard's
have been doing a really great job, but they do not work actively on I2C
anymore, so they end up forwarding every repport to the list anyway.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
