Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292571AbSBVKOB>; Fri, 22 Feb 2002 05:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292656AbSBVKNx>; Fri, 22 Feb 2002 05:13:53 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:56488 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S292571AbSBVKNi>; Fri, 22 Feb 2002 05:13:38 -0500
Date: Fri, 22 Feb 2002 04:13:08 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Pozsar Balazs <pozsy@sch.bme.hu>
Cc: Rajasekhar Inguva <irajasek@in.ibm.com>, girouard@us.ibm.com,
        ctindel@ieee.org, willy@meta-x.org,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]:Ethernet Bonding Driver-2.4.17
Message-ID: <20020222041308.A12791@asooo.flowerfire.com>
In-Reply-To: <3C6E462D.39039598@in.ibm.com> <Pine.GSO.4.30.0202161326260.4511-100000@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.30.0202161326260.4511-100000@balu>; from pozsy@sch.bme.hu on Sat, Feb 16, 2002 at 01:28:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What about something like this?  MAX_BONDS appears to be the default
max_bonds value, so max_bonds>MAX_BONDS is fine as long as
max_bonds<=INT_MAX, AFAICT.

I'm thinking a bogus value should reset to the default rather than
<=0 --> 1 or >INT_MAX --> INT_MAX.  Compiled but not tested.

-- 
Ken.
brownfld@irridia.com

--- linux/drivers/net/bonding.c.orig	Fri Feb 22 00:49:57 2002
+++ linux/drivers/net/bonding.c	Fri Feb 22 01:19:36 2002
@@ -234,7 +234,7 @@
 static struct bonding *these_bonds =  NULL;
 static struct net_device *dev_bonds = NULL;
 
-MODULE_PARM(max_bonds, "1-" __MODULE_STRING(INT_MAX) "i");
+MODULE_PARM(max_bonds, "i");
 MODULE_PARM_DESC(max_bonds, "Max number of bonded devices");
 MODULE_PARM(miimon, "i");
 MODULE_PARM_DESC(miimon, "Link check interval in milliseconds");
@@ -2037,6 +2037,14 @@
 
 	/* Find a name for this unit */
 	static struct net_device *dev_bond = NULL;
+
+	if ( max_bonds < 1 || max_bonds > INT_MAX ) {
+		printk( KERN_WARNING
+			"binding_init(): max_bonds (%d) not in range %d-%d, "
+			"was reset to MAX_BONDS (%d)",
+			max_bonds, 1, INT_MAX, MAX_BONDS );
+		max_bonds = MAX_BONDS ;
+	}
 
 	dev_bond = dev_bonds = kmalloc(max_bonds*sizeof(struct net_device), 
 					GFP_KERNEL);

On Sat, Feb 16, 2002 at 01:28:03PM +0100, Pozsar Balazs wrote:
| 
| On Sat, 16 Feb 2002, Rajasekhar Inguva wrote:
| 
| > Hi all,
| >
| > The patch is WRT a problem with the Ethernet Bonding Driver when
| > compiled as a module. Tested on 2.4.17
| > and the patch is also against 2.4.17.
| >
| > # insmod bonding max_bonds=2
| > Using /lib/modules/2.4.17/kernel/drivers/net/bonding.o
| > Warning: /lib/modules/2.4.17/kernel/drivers/net/bonding.o parameter
| > max_bonds
| > has max < min!
| > /lib/modules/2.4.17/kernel/drivers/net/bonding.o: unknown parameter type
| > '(' for
| > max_bonds
| >
| > and the module fails to load.
| >
| > The problem seems to be with the way MODULE_PARM was written for
| > max_bonds.
| >
| > MODULE_PARM(max_bonds,"1-" __MODULE_STRING(INT_MAX) "i");
| >
| > INT_MAX is defined to be ((int)(~0U>>1)) and 'insmod' gets the string
| > "1-((int)(~0U>>1))i" which it is failing to understand.
| >
| > As max_bonds is an integer and not an array, i feel omitting the min-max
| > range would be a better option.
| >
| > And if a negative or zero value is supplied to max_bonds while loading,
| > it can be taken care of in bonding_init() by setting it back to
| > MAX_BONDS.
| >
| > Thx,
| > Rajasekhar Inguva
| >
| >
| > --- /usr/src/linux/drivers/net/bonding.c	Fri Dec 21 23:11:54 2001
| > +++ /usr/src/linux/drivers/fixed/bonding.c	Sat Feb 16 17:03:48 2002
| > @@ -226,7 +226,7 @@
| >  static struct bonding *these_bonds =  NULL;
| >  static struct net_device *dev_bonds = NULL;
| >
| > -MODULE_PARM(max_bonds, "1-" __MODULE_STRING(INT_MAX) "i");
| > +MODULE_PARM(max_bonds,"i");
| >  MODULE_PARM_DESC(max_bonds, "Max number of bonded devices");
| >  MODULE_PARM(miimon, "i");
| >  MODULE_PARM_DESC(miimon, "Link check interval in milliseconds");
| > @@ -1981,6 +1981,10 @@
| >
| >  	/* Find a name for this unit */
| >  	static struct net_device *dev_bond = NULL;
| > +
| > +	/* If max_bonds <=0, set it to MAX_BONDS */
| > +	if(max_bonds <=0)
| > +		max_bonds = MAX_BONDS;
| 
| 
| Imho you would need a check for the upper limit too. like:
| 	if(max_bonds > MAX_BONDS)
| 		max_bonds = MAX_BONDS;
| 
| 
| >
| >  	dev_bond = dev_bonds = kmalloc(max_bonds*sizeof(struct net_device),
| >  					GFP_KERNEL);
| 
| -- 
| pozsy
