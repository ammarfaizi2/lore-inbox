Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265503AbRFVT7g>; Fri, 22 Jun 2001 15:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265505AbRFVT70>; Fri, 22 Jun 2001 15:59:26 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:26155
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S265504AbRFVT7T>; Fri, 22 Jun 2001 15:59:19 -0400
Date: Fri, 22 Jun 2001 21:59:11 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: dougm@computone.com
Cc: linux-computone@lazuli.wittsend.com, linux-kernel@vger.kernel.org
Subject: [PATCH] cleanup of drivers/char/ip2main.c (245ac16)
Message-ID: <20010622215911.A842@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch #ifdefs a function to be in its preprocessor
scope and eliminates the use of check_region, adds '\n' to printk's,
adds checks for kmalloc and does error path resource releasing
in ip2_init_board. All in drivers/char/ip2main.c and against
245ac16.

(The kmalloc part of this was reported by the Stanford team
a while back.)


--- linux-245-ac16-clean/drivers/char/ip2main.c	Sat May 19 20:58:17 2001
+++ linux-245-ac16/drivers/char/ip2main.c	Fri Jun 22 21:49:08 2001
@@ -418,6 +418,7 @@
 	rirqs[iindx++] = irq;
 }
 
+#ifdef MODULE
 static int __init
 clear_requested_irq( char irq )
 {
@@ -430,6 +431,7 @@
 	}
 	return 0;
 }
+#endif /* MODULE */
 
 static int __init
 have_requested_irq( char irq )
@@ -953,7 +955,7 @@
 static void __init
 ip2_init_board( int boardnum )
 {
-	int i,rc;
+	int i;
 	int nports = 0, nboxes = 0;
 	i2ChanStrPtr pCh;
 	i2eBordStrPtr pB = i2BoardPtrTable[boardnum];
@@ -961,24 +963,21 @@
 	if ( !iiInitialize ( pB ) ) {
 		printk ( KERN_ERR "IP2: Failed to initialize board at 0x%x, error %d\n",
 			 pB->i2eBase, pB->i2eError );
-		kfree ( pB );
-		i2BoardPtrTable[boardnum] = NULL;
-		return;
+		goto err_initialize;
 	}
-	printk(KERN_INFO "Board %d: addr=0x%x irq=%d ", boardnum + 1,
+	printk(KERN_INFO "Board %d: addr=0x%x irq=%d\n", boardnum + 1,
 	       ip2config.addr[boardnum], ip2config.irq[boardnum] );
 
-	if (0 != ( rc = check_region( ip2config.addr[boardnum], 8))) {
-		i2BoardPtrTable[boardnum] = NULL;
-		printk(KERN_ERR "bad addr=0x%x rc = %d\n",
-				ip2config.addr[boardnum], rc );
-		return;
+	if (!request_region( ip2config.addr[boardnum], 8, pcName )) {
+		printk(KERN_ERR "bad addr=0x%x\n",
+				ip2config.addr[boardnum] );
+		goto err_initialize;
 	}
-	request_region( ip2config.addr[boardnum], 8, pcName );
 
 	if ( iiDownloadAll ( pB, (loadHdrStrPtr)Fip_firmware, 1, Fip_firmware_size )
 	    != II_DOWN_GOOD ) {
-		printk ( KERN_ERR "IP2:failed to download loadware " );
+		printk ( KERN_ERR "IP2:failed to download loadware\n" );
+		goto err_release_region;
 	} else {
 		printk ( KERN_INFO "fv=%d.%d.%d lv=%d.%d.%d\n",
 			 pB->i2ePom.e.porVersion,
@@ -993,7 +992,7 @@
 		printk( KERN_ERR "IP2: Unknown board type, ID = %x",
 				pB->i2ePom.e.porID );
 		nports = 0;
-		goto ex_exit;
+		goto err_release_region;
 		break;
 
 	case POR_ID_II_4: /* IntelliPort-II, ISA-4 (4xRJ45) */
@@ -1028,8 +1027,13 @@
 		}
 		DevTableMem[boardnum] = pCh =
 			kmalloc( sizeof(i2ChanStr) * nports, GFP_KERNEL );
+		if ( !pCh ) {
+			printk ( KERN_ERR "(i2_init_channel:) Out of memory.\n");
+			goto err_release_region;
+		}
 		if ( !i2InitChannels( pB, nports, pCh ) ) {
 			printk(KERN_ERR "i2InitChannels failed: %d\n",pB->i2eError);
+			goto err_kmalloc;
 		}
 		pB->i2eChannelPtr = &DevTable[portnum];
 		pB->i2eChannelCnt = ABS_MOST_PORTS;
@@ -1051,6 +1055,10 @@
 	}
 	DevTableMem[boardnum] = pCh =
 		kmalloc ( sizeof (i2ChanStr) * nports, GFP_KERNEL );
+	if ( !pCh ) {
+		printk ( KERN_ERR "(i2_init_channel:) Out of memory.\n");
+		goto err_kmalloc;
+	}
 	pB->i2eChannelPtr = pCh;
 	pB->i2eChannelCnt = nports;
 	i2InitChannels ( pB, pB->i2eChannelCnt, pCh );
@@ -1062,7 +1070,17 @@
 		pCh++;
 	}
 ex_exit:
-	printk ( KERN_INFO "\n" );
+	printk ( "\n" );
+	return;
+
+err_kmalloc:
+	kfree ( pCh );
+err_release_region:
+	release_region(ip2config.addr[boardnum], 8);
+err_initialize:
+	kfree ( pB );
+	i2BoardPtrTable[boardnum] = NULL;
+	return;
 }
 
 /******************************************************************************/
-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"The obvious mathematical breakthrough would be development of an easy way
to factor large prime numbers." 
  -- Bill Gates, The Road Ahead, Viking Penguin (1995)
