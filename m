Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292357AbSBPLpu>; Sat, 16 Feb 2002 06:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292356AbSBPLpl>; Sat, 16 Feb 2002 06:45:41 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:40125 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S292355AbSBPLp0>; Sat, 16 Feb 2002 06:45:26 -0500
Message-ID: <3C6E462D.39039598@in.ibm.com>
Date: Sat, 16 Feb 2002 17:14:45 +0530
From: Rajasekhar Inguva <irajasek@in.ibm.com>
X-Mailer: Mozilla 4.5 [en] (Win95; I)
X-Accept-Language: en
MIME-Version: 1.0
To: girouard@us.ibm.com
CC: ctindel@ieee.org, willy@meta-x.org,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]:Ethernet Bonding Driver-2.4.17
Content-Type: multipart/mixed;
 boundary="------------2DF5B0BE26821A7CA897A995"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2DF5B0BE26821A7CA897A995
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi all,

The patch is WRT a problem with the Ethernet Bonding Driver when
compiled as a module. Tested on 2.4.17
and the patch is also against 2.4.17.

# insmod bonding max_bonds=2
Using /lib/modules/2.4.17/kernel/drivers/net/bonding.o
Warning: /lib/modules/2.4.17/kernel/drivers/net/bonding.o parameter
max_bonds
has max < min!
/lib/modules/2.4.17/kernel/drivers/net/bonding.o: unknown parameter type
'(' for
max_bonds

and the module fails to load.

The problem seems to be with the way MODULE_PARM was written for
max_bonds. 

MODULE_PARM(max_bonds,"1-" __MODULE_STRING(INT_MAX) "i"); 

INT_MAX is defined to be ((int)(~0U>>1)) and 'insmod' gets the string
"1-((int)(~0U>>1))i" which it is failing to understand.

As max_bonds is an integer and not an array, i feel omitting the min-max
range would be a better option.

And if a negative or zero value is supplied to max_bonds while loading,
it can be taken care of in bonding_init() by setting it back to
MAX_BONDS.

Thx,
Rajasekhar Inguva


--- /usr/src/linux/drivers/net/bonding.c	Fri Dec 21 23:11:54 2001
+++ /usr/src/linux/drivers/fixed/bonding.c	Sat Feb 16 17:03:48 2002
@@ -226,7 +226,7 @@
 static struct bonding *these_bonds =  NULL;
 static struct net_device *dev_bonds = NULL;
 
-MODULE_PARM(max_bonds, "1-" __MODULE_STRING(INT_MAX) "i");
+MODULE_PARM(max_bonds,"i");
 MODULE_PARM_DESC(max_bonds, "Max number of bonded devices");
 MODULE_PARM(miimon, "i");
 MODULE_PARM_DESC(miimon, "Link check interval in milliseconds");
@@ -1981,6 +1981,10 @@
 
 	/* Find a name for this unit */
 	static struct net_device *dev_bond = NULL;
+
+	/* If max_bonds <=0, set it to MAX_BONDS */
+	if(max_bonds <=0)
+		max_bonds = MAX_BONDS;
 
 	dev_bond = dev_bonds = kmalloc(max_bonds*sizeof(struct net_device), 
 					GFP_KERNEL);
--------------2DF5B0BE26821A7CA897A995
Content-Type: text/plain; charset=us-ascii;
 name="bonding.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bonding.patch"

--- /usr/src/linux/drivers/net/bonding.c	Fri Dec 21 23:11:54 2001
+++ /usr/src/linux/drivers/fixed/bonding.c	Sat Feb 16 17:03:48 2002
@@ -226,7 +226,7 @@
 static struct bonding *these_bonds =  NULL;
 static struct net_device *dev_bonds = NULL;
 
-MODULE_PARM(max_bonds, "1-" __MODULE_STRING(INT_MAX) "i");
+MODULE_PARM(max_bonds,"i");
 MODULE_PARM_DESC(max_bonds, "Max number of bonded devices");
 MODULE_PARM(miimon, "i");
 MODULE_PARM_DESC(miimon, "Link check interval in milliseconds");
@@ -1981,6 +1981,10 @@
 
 	/* Find a name for this unit */
 	static struct net_device *dev_bond = NULL;
+
+	/* If max_bonds <=0, set it to MAX_BONDS */
+	if(max_bonds <=0)
+		max_bonds = MAX_BONDS;
 
 	dev_bond = dev_bonds = kmalloc(max_bonds*sizeof(struct net_device), 
 					GFP_KERNEL);

--------------2DF5B0BE26821A7CA897A995--

