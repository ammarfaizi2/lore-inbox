Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271836AbRIMQrJ>; Thu, 13 Sep 2001 12:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271834AbRIMQrC>; Thu, 13 Sep 2001 12:47:02 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:16645 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S271845AbRIMQqu>; Thu, 13 Sep 2001 12:46:50 -0400
Date: Thu, 13 Sep 2001 18:35:04 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com
Subject: [x86-64 patch 4/11] Fix the Granch driver
Message-ID: <20010913183504.A2572@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch constraints __asm__ usage in the Granch SBNI driver only to
i386, which is what the assembly parts are for. It also first casts a
pointer to long, to make sure it fits and avoid a warning. It also fixes
a wrongly typed __setup() function.


diff -urN linux-x86_64/drivers/net/wan/sbni.c linux/drivers/net/wan/sbni.c
--- linux-x86_64/drivers/net/wan/sbni.c	Thu Aug 23 18:14:52 2001
+++ linux/drivers/net/wan/sbni.c	Thu Sep 13 11:39:45 2001
@@ -155,7 +155,9 @@
 static int  emancipate( struct net_device * );
 #endif
 
+#ifdef __i386__
 #define ASM_CRC 1
+#endif
 
 static const char  version[] =
 	"Granch SBNI12 driver ver 5.0.1  Jun 22 2001  Denis I.Timofeev.\n";
@@ -361,7 +363,7 @@
 	/* store MAC address (generate if that isn't known) */
 	*(u16 *)dev->dev_addr = htons( 0x00ff );
 	*(u32 *)(dev->dev_addr + 2) = htonl( 0x01000000 |
-		( (mac[num]  ?  mac[num]  :  (u32)dev->priv) & 0x00ffffff) );
+		( (mac[num]  ?  mac[num]  :  (u32)((long)dev->priv)) & 0x00ffffff) );
 
 	/* store link settings (speed, receive level ) */
 	nl->maxframe  = DEFAULT_FRAME_LEN;
@@ -1517,7 +1519,7 @@
 
 #else	/* MODULE */
 
-void __init
+static int __init
 sbni_setup( char  *p )
 {
 	int  n, parm;
@@ -1528,7 +1530,7 @@
 	for( n = 0, parm = 0;  *p  &&  n < 8; ) {
 		(*dest[ parm ])[ n ] = simple_strtol( p, &p, 0 );
 		if( !*p  ||  *p == ')' )
-			return;
+			return 1;
 		if( *p == ';' )
 			++p, ++n, parm = 0;
 		else if( *p++ != ',' )
@@ -1539,6 +1541,7 @@
 	}
 bad_param:
 	printk( KERN_ERR "Error in sbni kernel parameter!\n" );
+	return 0;
 }
 
 __setup( "sbni=", sbni_setup );

-- 
Vojtech Pavlik
SuSE Labs
