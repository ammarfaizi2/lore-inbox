Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbVBJP0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVBJP0d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 10:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVBJP0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 10:26:33 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:28862 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262140AbVBJP0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 10:26:19 -0500
Message-ID: <420B7D10.6090503@acm.org>
Date: Thu, 10 Feb 2005 09:26:08 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Gerd Knorr <kraxel@bytesex.org>, Greg KH <greg@kroah.com>, jjluza@yahoo.fr,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Fw: [Bug 4171] New: bttv seems broken here
References: <20050205141803.5519be6c.akpm@osdl.org>
In-Reply-To: <20050205141803.5519be6c.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------090700060308030902050702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090700060308030902050702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

JJ Luza and I found the problem.  A patch to the I2C non-blocking 
changes is attached.  JJ was a tremendous help on this.

-Corey

Andrew Morton wrote:

>Not sure who to blame here ;)
>
>Corey made some i2c changes...
>
>Begin forwarded message:
>
>Date: Sat, 5 Feb 2005 13:36:53 -0800
>From: bugme-daemon@osdl.org
>To: akpm@digeo.com
>Subject: [Bug 4171] New: bttv seems broken here
>
>
>http://bugme.osdl.org/show_bug.cgi?id=4171
>
>           Summary: bttv seems broken here
>    Kernel Version: 2.6.11-rc3-mm1
>            Status: NEW
>          Severity: normal
>
>
>Distribution: Debian Sid    
>Hardware Environment: Nforce2 + gforce4 + leadtek winfast TV 2000 (Bt878)  
>Software Environment: kernel module is snd_bt87x (and tuner and bttv), and tv 
>app is xdtv. 
>Problem Description: I can't watch tv with this kernel (it worked with 
>2.6.10). There is no image or sound with xdtv, and I get these errors sent by 
>kernel when I try to access the bttv device : 
> 
>  
>


--------------090700060308030902050702
Content-Type: text/plain;
 name="i2c_nonblock_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c_nonblock_fix.diff"

The I2C non-blocking patch would incorrectly return success in some
cases because it wasn't updating the proper result variable.  This
patch fixes the problem.  The bttv driver now works properly with
the I2C non-blocking patch.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc3/drivers/i2c/i2c-core.c
===================================================================
--- linux-2.6.11-rc3.orig/drivers/i2c/i2c-core.c
+++ linux-2.6.11-rc3/drivers/i2c/i2c-core.c
@@ -899,9 +899,11 @@
 					      entry->i2c.num);
 		up(&adap->bus_lock);
 
+		entry->result = ret;
 		return ret;
 	} else {
 		dev_dbg(&adap->dev, "I2C level transfers not supported\n");
+		entry->result = -ENOSYS;
 		return -ENOSYS;
 	}
 }
@@ -1491,7 +1493,7 @@
 	msg[0].len = 1;
 	msg[1].addr = entry->smbus.addr;
 	msg[1].flags = entry->smbus.flags | I2C_M_RD;
-	msg[1].len = 1;
+	msg[1].len = 0;
 
 	msgbuf0[0] = entry->smbus.command;
 	switch(entry->smbus.size) {
@@ -1593,17 +1595,17 @@
 
 /* Simulate a SMBus command using the i2c protocol 
    No checking of parameters is done!  */
-static s32 i2c_smbus_xfer_emulated(struct i2c_adapter * adap,
-				   struct i2c_op_q_entry * entry)
+static void i2c_smbus_xfer_emulated(struct i2c_adapter * adap,
+				    struct i2c_op_q_entry * entry)
 
 {
-	if (i2c_smbus_emu_format(adap, entry))
-		return -EINVAL;
-
-	if (i2c_transfer_entry(adap, entry) < 0)
-		return -EINVAL;
+	if (i2c_smbus_emu_format(adap, entry)) {
+		entry->result = -EINVAL;
+		return;
+	}
 
-	return entry->result;
+	/* Return value will be put into entry->result. */
+	i2c_transfer_entry(adap, entry);
 }
 
 s32 i2c_smbus_xfer(struct i2c_adapter * adap, u16 addr, unsigned short flags,

--------------090700060308030902050702--
