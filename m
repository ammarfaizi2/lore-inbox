Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263057AbTDBQsz>; Wed, 2 Apr 2003 11:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263059AbTDBQsz>; Wed, 2 Apr 2003 11:48:55 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:15083 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S263057AbTDBQsx>; Wed, 2 Apr 2003 11:48:53 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 2 Apr 2003 19:06:52 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Kernel List <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Frank Davis <fdavis@si.rr.com>
Subject: [patch] add i2c_clients_command()
Message-ID: <20030402170652.GA24954@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch adds a function which loops over all i2c clients attached
to some i2c adapter and calls the ->command function of the driver.

Currently the bttv and saa7134 drivers have simliar functions, but
(currently) without sane locking and module handling.  Newer versions
will switch to this function.  Updates for the two drivers which are
actually using this new function are available from
http://bytesex.org/patches/wip/

  Gerd

diff -u linux-2.5.66/drivers/i2c/i2c-core.c linux/drivers/i2c/i2c-core.c
--- linux-2.5.66/drivers/i2c/i2c-core.c	2003-04-02 11:42:18.357220889 +0200
+++ linux/drivers/i2c/i2c-core.c	2003-04-02 16:17:47.127702160 +0200
@@ -494,6 +494,27 @@
 	return 0;
 }
 
+void i2c_clients_command(struct i2c_adapter *adap, unsigned int cmd, void *arg)
+{
+	int i;
+
+	down(&adap->list);
+	for (i = 0; i < I2C_CLIENT_MAX; i++) {
+		if (NULL == adap->clients[i])
+			continue;
+		if (!try_module_get(adap->clients[i]->driver->owner))
+			continue;
+		if (NULL == adap->clients[i]->driver->command)
+			continue;
+		
+		up(&adap->list);
+		adap->clients[i]->driver->command(adap->clients[i],cmd,arg);
+		module_put(adap->clients[i]->driver->owner);
+		down(&adap->list);
+	}
+	up(&adap->list);
+}
+
 #ifdef CONFIG_PROC_FS
 /* This function generates the output for /proc/bus/i2c-? */
 static ssize_t i2cproc_bus_read(struct file *file, char *buf,
@@ -1417,6 +1438,7 @@
 EXPORT_SYMBOL(i2c_use_client);
 EXPORT_SYMBOL(i2c_release_client);
 EXPORT_SYMBOL(i2c_check_addr);
+EXPORT_SYMBOL(i2c_clients_command);
 
 EXPORT_SYMBOL(i2c_master_send);
 EXPORT_SYMBOL(i2c_master_recv);
diff -u linux-2.5.66/include/linux/i2c.h linux/include/linux/i2c.h
--- linux-2.5.66/include/linux/i2c.h	2003-04-02 11:49:36.479533709 +0200
+++ linux/include/linux/i2c.h	2003-04-02 11:49:36.727492916 +0200
@@ -329,6 +329,11 @@
 extern int i2c_use_client(struct i2c_client *);
 extern int i2c_release_client(struct i2c_client *);
 
+/* call the i2c_client->command() of all attached clients with
+ * the given arguments */
+extern void i2c_clients_command(struct i2c_adapter *adap,
+				unsigned int cmd, void *arg);
+
 /* returns -EBUSY if address has been taken, 0 if not. Note that the only
    other place at which this is called is within i2c_attach_client; so
    you can cheat by simply not registering. Not recommended, of course! */

-- 
Michael Moore for president!
