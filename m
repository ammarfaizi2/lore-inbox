Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129638AbQKJO2y>; Fri, 10 Nov 2000 09:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129483AbQKJO2o>; Fri, 10 Nov 2000 09:28:44 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:38661 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129638AbQKJO2c>;
	Fri, 10 Nov 2000 09:28:32 -0500
Message-ID: <3A0C05CB.158C0FF5@mandrakesoft.com>
Date: Fri, 10 Nov 2000 09:27:23 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Frank Davis <fdavis112@juno.com>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Re: [test11-pre2] rrunner.c compiler error
In-Reply-To: <Pine.LNX.4.21.0011101458350.5675-100000@tricky>
Content-Type: multipart/mixed;
 boundary="------------9ADA4B27C9E7C178B69D1C66"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9ADA4B27C9E7C178B69D1C66
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Blah.  Puke.  Ug.  Not your changes, Bart... which are ok, but
incomplete.

Here is the complete bugfix.  There are two places where error
conditions are not fully handled, and 'out_spin' can kfree(image),
saving some code.  The worst bug of the list... if the firmware
copy_from_user failed....  we still load firmware [ie. questionable
data] into EEPROM.

-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
--------------9ADA4B27C9E7C178B69D1C66
Content-Type: text/plain; charset=us-ascii;
 name="rrunner.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rrunner.patch"

Index: drivers/net/rrunner.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/rrunner.c,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 rrunner.c
--- drivers/net/rrunner.c	2000/11/10 02:09:10	1.1.1.4
+++ drivers/net/rrunner.c	2000/11/10 14:21:01
@@ -1550,36 +1550,29 @@
 
 	rrpriv = (struct rr_private *)dev->priv;
 
-
 	switch(cmd){
 	case SIOCRRGFW:
-		if (!capable(CAP_SYS_RAWIO)){
-			error = -EPERM;
-			goto out;
-		}
+		if (!capable(CAP_SYS_RAWIO))
+			return -EPERM;
 
 		image = kmalloc(EEPROM_WORDS * sizeof(u32), GFP_KERNEL);
 		if (!image){
 			printk(KERN_ERR "%s: Unable to allocate memory "
 			       "for EEPROM image\n", dev->name);
-			error = -ENOMEM;
-			goto out;
+			return -ENOMEM;
 		}
 		
 		spin_lock(&rrpriv->lock);
 		
 		if (rrpriv->fw_running){
 			printk("%s: Firmware already running\n", dev->name);
-			kfree(image);
 			error = -EPERM;
 			goto out_spin;
 		}
 
 		i = rr_read_eeprom(rrpriv, 0, image, EEPROM_BYTES);
 		if (i != EEPROM_BYTES){
-			kfree(image);
-			printk(KERN_ERR "%s: Error reading EEPROM\n",
-			       dev->name);
+			printk(KERN_ERR "%s: Error reading EEPROM\n", dev->name);
 			error = -EFAULT;
 			goto out_spin;
 		}
@@ -1591,9 +1584,8 @@
 		return error;
 		
 	case SIOCRRPFW:
-		if (!capable(CAP_SYS_RAWIO)){
+		if (!capable(CAP_SYS_RAWIO))
 			return -EPERM;
-		}
 
 		image = kmalloc(EEPROM_WORDS * sizeof(u32), GFP_KERNEL);
 		if (!image){
@@ -1604,18 +1596,21 @@
 
 		oldimage = kmalloc(EEPROM_WORDS * sizeof(u32), GFP_KERNEL);
 		if (!oldimage){
+			kfree(image);
 			printk(KERN_ERR "%s: Unable to allocate memory "
 			       "for old EEPROM image\n", dev->name);
 			return -ENOMEM;
 		}
 
 		error = copy_from_user(image, rq->ifr_data, EEPROM_BYTES);
-		if (error)
-			error = -EFAULT;
+		if (error) {
+			kfree(image);
+			kfree(oldimage);
+			return -EFAULT;
+		}
 
 		spin_lock(&rrpriv->lock);
 		if (rrpriv->fw_running){
-			kfree(image);
 			kfree(oldimage);
 			printk("%s: Firmware already running\n", dev->name);
 			error = -EPERM;
@@ -1652,6 +1647,7 @@
 	}
 
  out_spin:
+	kfree(image);
 	spin_unlock(&rrpriv->lock);
 	return error;
 }

--------------9ADA4B27C9E7C178B69D1C66--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
