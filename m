Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266534AbUITRU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266534AbUITRU1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 13:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266864AbUITRU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 13:20:27 -0400
Received: from mail.convergence.de ([212.227.36.84]:48589 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S266534AbUITRUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 13:20:21 -0400
Message-ID: <414F111C.9030809@linuxtv.org>
Date: Mon, 20 Sep 2004 19:19:24 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][2.6] Add command function to struct i2c_adapter
Content-Type: multipart/mixed;
 boundary="------------090604020904090407050003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090604020904090407050003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi there,

the attached patch adds a command function to struct i2c_adapter, 
similar to the command function that is already there for struct i2c_client.

The reason behind this is as follows:
In the DVB subsystem, the tuners are accessed via normal kernel i2c 
drivers. One big problem is, that tuners can be wired very differently 
depending on the surrounding hardware. Currently, we need to keep 
specific settings which are unique to a hardware design in the 
independent i2c tuner driver. This is both very ugly and makes it 
impossible to support DVB drivers which are not in the official Linux 
kernel tree, but could otherwise use in-kernel frontend driver.

If the struct i2c_adapter has a command function, it would be possible 
to get additional informations from the adapter in the i2c client's 
attach_adapter() function *before* probing the device and guessing 
things like i2c addresses or other hardware settings.

This patch is non-intrusive. It doesn't affect any current drivers, but 
only future developments.

Are there any objections against this patch?

Regards
Michael.

--------------090604020904090407050003
Content-Type: text/plain;
 name="i2c-add-command.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c-add-command.diff"

diff -ura linux-2.6.9-rc2-mm1/include/linux/i2c.h b/include/linux/i2c.h
--- linux-2.6.9-rc2-mm1/include/linux/i2c.h	2004-09-20 12:38:24.000000000 +0200
+++ b/include/linux/i2c.h	2004-09-20 18:53:32.000000000 +0200
@@ -231,6 +231,11 @@
 	struct i2c_algorithm *algo;/* the algorithm to access the bus	*/
 	void *algo_data;
 
+	/* a ioctl like command that can be used to perform specific functions
+	 * with the adapter.
+	 */
+	int (*command)(struct i2c_adapter *adapter, unsigned int cmd, void *arg);
+
 	/* --- administration stuff. */
 	int (*client_register)(struct i2c_client *);
 	int (*client_unregister)(struct i2c_client *);

--------------090604020904090407050003--
