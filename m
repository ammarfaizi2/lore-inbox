Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279832AbRKAWnQ>; Thu, 1 Nov 2001 17:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279833AbRKAWnM>; Thu, 1 Nov 2001 17:43:12 -0500
Received: from [63.231.122.81] ([63.231.122.81]:5425 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S279832AbRKAWmy>;
	Thu, 1 Nov 2001 17:42:54 -0500
Date: Thu, 1 Nov 2001 15:42:28 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Ken Ashcraft <kash@stanford.edu>
Cc: linux-kernel@vger.kernel.org, Doug McNash <dougm@computone.com>,
        Doug McNash <dougm@computone.com>, torvalds@transmeta.com
Subject: Re: [CHECKER] Is this a bug?
Message-ID: <20011101154227.H16554@lynx.no>
Mail-Followup-To: Ken Ashcraft <kash@stanford.edu>,
	linux-kernel@vger.kernel.org, Doug McNash <dougm@computone.com>,
	torvalds@transmeta.com
In-Reply-To: <Pine.GSO.4.33.0111011058500.10726-100000@saga5.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.GSO.4.33.0111011058500.10726-100000@saga5.Stanford.EDU>; from kash@stanford.edu on Thu, Nov 01, 2001 at 11:13:38AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 01, 2001  11:13 -0800, Ken Ashcraft wrote:
> I'm trying to figure out if the following is a bug, but I don't understand
> well enough how files work.  This type of bug would be a security hole.
> The user length "cmd" gets passed in to the sys_ioctl call. From there, if
> it does not match one of the case statements, it is passed to a function
> pointer.  Here is where I'm hung up: I think a potential function for that
> function pointer is ip2_ipl_ioctl--

> ip2_ipl_ioctl ( struct inode *pInode, struct file *pFile, UINT cmd, ULONG
> arg )
> {
> 	...
> 	switch ( iplminor ) {
> 	...
> 	case 13:
> 		switch ( cmd ) {
> 		...
> 		default:
> Error--->
> 			pCh = DevTable[cmd];
> 			if ( pCh )
> 			{
> 				COPY_TO_USER(rc, (char*)arg, (char*)pCh,
> sizeof(i2ChanStr) );
> 			}
> 		}
> 	}
> }

You are correct - the ioctl function called depends on the file it was
called on (and the file has the ioctl method set at open time).  So,
if you open the "ip2_ipl" char device (whatever it is called), and call
sys_ioctl() you will get the above function.  It looks like the above
command is poorly implemented.  In the code that I have (2.4.13) it
checks AFTERWARDS if cmd > 64 (presumably the size of DevTable) and
issues -EINVAL in that case, oops too late.  A patch to fix this follows.

Also (in a separate patch at the end) is the removal of a whole bunch of:

#ifdef IP2DEBUG_TRACE
	ip2trace(foo);
#endif

and replacing it with (the Linus-preferred, and far cleaner):

#ifdef IP2DEBUG_TRACE
void ip2trace(foo)
#else
#define ip2trace(foo) do {} while (0)
#endif

and then just using "iptrace" directly in the code (makes it 88 lines shorter).

Linus, please apply at least the first one (Computone folks are CC'd on this).

Cheers, Andreas
=============================================================================
--- linux.orig/drivers/char/ip2main.c	Thu Oct 25 03:04:30 2001
+++ linux/drivers/char/ip2main.c	Thu Nov  1 14:44:08 2001
@@ -3093,13 +3093,15 @@
 			break;
 
 		default:
-			pCh = DevTable[cmd];
-			if ( pCh )
-			{
-				COPY_TO_USER(rc, (char*)arg, (char*)pCh, sizeof(i2ChanStr) );
-			} else {
-				rc = cmd < 64 ? -ENODEV : -EINVAL;
-			}
+			if (cmd < IP2_MAX_PORTS) {
+				pCh = DevTable[cmd];
+				if ( pCh )
+					COPY_TO_USER(rc, (char*)arg, (char*)pCh,
+						     sizeof(i2ChanStr) );
+				else
+					rc = -ENODEV;
+			} else
+				rc = -EINVAL;
 		}
 		break;
 
=============================================================================
--- linux.orig/drivers/char/ip2main.c	Thu Oct 25 03:04:30 2001
+++ linux/drivers/char/ip2main.c	Thu Nov  1 15:20:23 2001
@@ -268,7 +268,6 @@
 static int ip2_ipl_ioctl(struct inode *, struct file *, UINT, ULONG);
 static int ip2_ipl_open(struct inode *, struct file *);
 
-void ip2trace(unsigned short,unsigned char,unsigned char,unsigned long,...);
 static int DumpTraceBuffer(char *, int);
 static int DumpFifoBuffer( char *, int);
 
@@ -588,9 +587,7 @@
 	i2eBordStrPtr pB = NULL;
 	int rc = -1;
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (ITRC_NO_PORT, ITRC_INIT, ITRC_ENTER, 0 );
-#endif
 
 	/* Announce our presence */
 	printk( KERN_INFO "%s version %s\n", pcName, pcVersion );
@@ -761,9 +758,7 @@
 		}
 	}
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (ITRC_NO_PORT, ITRC_INIT, 2, 0 );
-#endif
 
 	/* Zero out the normal tty device structure. */
 	memset ( &ip2_tty_driver, 0, sizeof ip2_tty_driver );
@@ -822,9 +817,7 @@
 	ip2_callout_driver.major   = IP2_CALLOUT_MAJOR;
 	ip2_callout_driver.subtype = SERIAL_TYPE_CALLOUT;
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (ITRC_NO_PORT, ITRC_INIT, 3, 0 );
-#endif
 
 	/* Register the tty devices. */
 	if ( ( err = tty_register_driver ( &ip2_tty_driver ) ) ) {
@@ -847,9 +840,7 @@
 		printk(KERN_ERR "IP2: failed to register read_procmem\n");
 	} else {
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (ITRC_NO_PORT, ITRC_INIT, 4, 0 );
-#endif
 		/* Register the interrupt handler or poll handler, depending upon the
 		 * specified interrupt.
 		 */
@@ -935,9 +926,7 @@
 			}
 		}
 	}
-#ifdef IP2DEBUG_TRACE
 	ip2trace (ITRC_NO_PORT, ITRC_INIT, ITRC_RETURN, 0 );
-#endif
 
 	return 0;
 }
@@ -1290,9 +1279,7 @@
 	int i;
 	i2eBordStrPtr  pB;
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (ITRC_NO_PORT, ITRC_INTR, 99, 1, irq );
-#endif
 
 #ifdef USE_IQI
 
@@ -1312,9 +1299,7 @@
 
 	++irq_counter;
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (ITRC_NO_PORT, ITRC_INTR, ITRC_RETURN, 0 );
-#endif
 }
 
 /******************************************************************************/
@@ -1330,9 +1315,7 @@
 static void
 ip2_poll(unsigned long arg)
 {
-#ifdef IP2DEBUG_TRACE
 	ip2trace (ITRC_NO_PORT, ITRC_INTR, 100, 0 );
-#endif
 	TimerOn = 0; // it's the truth but not checked in service
 
 	bh_counter++; 
@@ -1352,9 +1335,7 @@
 	add_timer( &PollTimer );
 	TimerOn = 1;
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (ITRC_NO_PORT, ITRC_INTR, ITRC_RETURN, 0 );
-#endif
 }
 
 static inline void 
@@ -1362,10 +1343,8 @@
 {
 	unsigned long flags;
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace(CHANN, ITRC_INPUT, 21, 0 );
-#endif
-	// Data input
+	/* Data input */
 	if ( pCh->pTTY != NULL ) {
 		READ_LOCK_IRQSAVE(&pCh->Ibuf_spinlock,flags)
 		if (!pCh->throttled && (pCh->Ibuf_stuff != pCh->Ibuf_strip)) {
@@ -1374,9 +1353,7 @@
 		} else
 			READ_UNLOCK_IRQRESTORE(&pCh->Ibuf_spinlock,flags)
 	} else {
-#ifdef IP2DEBUG_TRACE
 		ip2trace(CHANN, ITRC_INPUT, 22, 0 );
-#endif
 		i2InputFlush( pCh );
 	}
 }
@@ -1401,13 +1378,11 @@
 
 	status =  i2GetStatus( pCh, (I2_BRK|I2_PAR|I2_FRA|I2_OVR) );
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_STATUS, 21, 1, status );
-#endif
 
 	if (pCh->pTTY && (status & (I2_BRK|I2_PAR|I2_FRA|I2_OVR)) ) {
 		if ( (status & I2_BRK) ) {
-			// code duplicated from n_tty (ldisc)
+			/* code duplicated from n_tty (ldisc) */
 			if (I_IGNBRK(pCh->pTTY))
 				goto skip_this;
 			if (I_BRKINT(pCh->pTTY)) {
@@ -1463,9 +1438,7 @@
 		}
 	}
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_STATUS, 26, 0 );
-#endif
 }
 
 /******************************************************************************/
@@ -1519,9 +1492,7 @@
 	int do_clocal = 0;
 	i2ChanStrPtr  pCh = DevTable[MINOR(tty->device)];
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (MINOR(tty->device), ITRC_OPEN, ITRC_ENTER, 0 );
-#endif
 
 	if ( pCh == NULL ) {
 		return -ENODEV;
@@ -1631,10 +1602,8 @@
 			(pCh->flags & ASYNC_CLOSING)?"True":"False");
 		printk(KERN_DEBUG "OpenBlock: waiting for CD or signal\n");
 #endif
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_OPEN, 3, 2, (pCh->flags & ASYNC_CALLOUT_ACTIVE),
-								(pCh->flags & ASYNC_CLOSING) );
-#endif
+				  (pCh->flags & ASYNC_CLOSING) );
 		/* check for signal */
 		if (signal_pending(current)) {
 			rc = (( pCh->flags & ASYNC_HUP_NOTIFY ) ? -EAGAIN : -ERESTARTSYS);
@@ -1643,9 +1612,7 @@
 		interruptible_sleep_on(&pCh->open_wait);
 	}
 	--pCh->wopen; //why count?
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_OPEN, 4, 0 );
-#endif
 	if (rc != 0 ) {
 		return rc;
 	}
@@ -1682,9 +1649,7 @@
 #endif
 	serviceOutgoingFifo( pCh->pMyBord );
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_OPEN, ITRC_RETURN, 0 );
-#endif
 	return 0;
 }
 
@@ -1707,9 +1672,7 @@
 		return;
 	}
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_CLOSE, ITRC_ENTER, 0 );
-#endif
 
 #ifdef IP2DEBUG_OPEN
 	printk(KERN_DEBUG "IP2:close ttyF%02X:\n",MINOR(tty->device));
@@ -1718,16 +1681,12 @@
 	if ( tty_hung_up_p ( pFile ) ) {
 		MOD_DEC_USE_COUNT;
 
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_CLOSE, 2, 1, 2 );
-#endif
 		return;
 	}
 	if ( tty->count > 1 ) { /* not the last close */
 		MOD_DEC_USE_COUNT;
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_CLOSE, 2, 1, 3 );
-#endif
 		return;
 	}
 	pCh->flags |= ASYNC_CLOSING;	// last close actually
@@ -1794,9 +1753,7 @@
 
 	MOD_DEC_USE_COUNT;
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_CLOSE, ITRC_RETURN, 1, 1 );
-#endif
 	return;
 }
 
@@ -1814,9 +1771,7 @@
 {
 	i2ChanStrPtr  pCh = tty->driver_data;
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_HANGUP, ITRC_ENTER, 0 );
-#endif
 
 	ip2_flush_buffer(tty);
 
@@ -1839,9 +1794,7 @@
 	pCh->pTTY = NULL;
 	wake_up_interruptible ( &pCh->open_wait );
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_HANGUP, ITRC_RETURN, 0 );
-#endif
 }
 
 /******************************************************************************/
@@ -1869,9 +1822,7 @@
 	int bytesSent = 0;
 	unsigned long flags;
 
-#ifdef IP2DEBUG_TRACE
-   ip2trace (CHANN, ITRC_WRITE, ITRC_ENTER, 2, count, -1 );
-#endif
+	ip2trace (CHANN, ITRC_WRITE, ITRC_ENTER, 2, count, -1 );
 
 	/* Flush out any buffered data left over from ip2_putchar() calls. */
 	ip2_flush_chars( tty );
@@ -1881,9 +1832,7 @@
 	bytesSent = i2Output( pCh, pData, count, user );
 	WRITE_UNLOCK_IRQRESTORE(&pCh->Pbuf_spinlock,flags);
 
-#ifdef IP2DEBUG_TRACE
-   ip2trace (CHANN, ITRC_WRITE, ITRC_RETURN, 1, bytesSent );
-#endif
+	ip2trace (CHANN, ITRC_WRITE, ITRC_RETURN, 1, bytesSent );
 	return bytesSent > 0 ? bytesSent : 0;
 }
 
@@ -1903,9 +1852,7 @@
 	i2ChanStrPtr  pCh = tty->driver_data;
 	unsigned long flags;
 
-#ifdef IP2DEBUG_TRACE
 //	ip2trace (CHANN, ITRC_PUTC, ITRC_ENTER, 1, ch );
-#endif
 
 	WRITE_LOCK_IRQSAVE(&pCh->Pbuf_spinlock,flags);
 	pCh->Pbuf[pCh->Pbuf_stuff++] = ch;
@@ -1915,9 +1862,7 @@
 	} else
 		WRITE_UNLOCK_IRQRESTORE(&pCh->Pbuf_spinlock,flags);
 
-#ifdef IP2DEBUG_TRACE
 //	ip2trace (CHANN, ITRC_PUTC, ITRC_RETURN, 1, ch );
-#endif
 }
 
 /******************************************************************************/
@@ -1937,9 +1882,7 @@
 
 	WRITE_LOCK_IRQSAVE(&pCh->Pbuf_spinlock,flags);
 	if ( pCh->Pbuf_stuff ) {
-#ifdef IP2DEBUG_TRACE
-//	ip2trace (CHANN, ITRC_PUTC, 10, 1, strip );
-#endif
+//		ip2trace (CHANN, ITRC_PUTC, 10, 1, strip );
 		//
 		// We may need to restart i2Output if it does not fullfill this request
 		//
@@ -1971,9 +1915,7 @@
 	bytesFree = i2OutputFree( pCh ) - pCh->Pbuf_stuff;
 	READ_UNLOCK_IRQRESTORE(&pCh->Pbuf_spinlock,flags);
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_WRITE, 11, 1, bytesFree );
-#endif
 
 	return ((bytesFree > 0) ? bytesFree : 0);
 }
@@ -1993,9 +1935,7 @@
 	i2ChanStrPtr  pCh = tty->driver_data;
 	int rc;
 	unsigned long flags;
-#ifdef IP2DEBUG_TRACE
-	ip2trace (CHANN, ITRC_WRITE, 12, 1, pCh->Obuf_char_count + pCh->Pbuf_stuff );
-#endif
+	ip2trace(CHANN, ITRC_WRITE, 12, 1, pCh->Obuf_char_count + pCh->Pbuf_stuff);
 #ifdef IP2DEBUG_WRITE
 	printk (KERN_DEBUG "IP2: chars in buffer = %d (%d,%d)\n",
 				 pCh->Obuf_char_count + pCh->Pbuf_stuff,
@@ -2025,9 +1965,7 @@
 	i2ChanStrPtr  pCh = tty->driver_data;
 	unsigned long flags;
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_FLUSH, ITRC_ENTER, 0 );
-#endif
 #ifdef IP2DEBUG_WRITE
 	printk (KERN_DEBUG "IP2: flush buffer\n" );
 #endif
@@ -2036,9 +1974,7 @@
 	WRITE_UNLOCK_IRQRESTORE(&pCh->Pbuf_spinlock,flags);
 	i2FlushOutput( pCh );
 	ip2_owake(tty);
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_FLUSH, ITRC_RETURN, 0 );
-#endif
 }
 
 /******************************************************************************/
@@ -2183,9 +2119,7 @@
 		return -ENODEV;
 	}
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_IOCTL, ITRC_ENTER, 2, cmd, arg );
-#endif
 
 #ifdef IP2DEBUG_IOCTL
 	printk(KERN_DEBUG "IP2: ioctl cmd (%x), arg (%lx)\n", cmd, arg );
@@ -2193,18 +2127,14 @@
 
 	switch(cmd) {
 	case TIOCGSERIAL:
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_IOCTL, 2, 1, rc );
-#endif
 		rc = get_serial_info(pCh, (struct serial_struct *) arg);
 		if (rc)
 			return rc;
 		break;
 
 	case TIOCSSERIAL:
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_IOCTL, 3, 1, rc );
-#endif
 		rc = set_serial_info(pCh, (struct serial_struct *) arg);
 		if (rc)
 			return rc;
@@ -2240,9 +2170,7 @@
 
 	case TCSBRK:   /* SVID version: non-zero arg --> no break */
 		rc = tty_check_change(tty);
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_IOCTL, 4, 1, rc );
-#endif
 		if (!rc) {
 			ip2_wait_until_sent(tty,0);
 			if (!arg) {
@@ -2254,9 +2182,7 @@
 
 	case TCSBRKP:  /* support for POSIX tcsendbreak() */
 		rc = tty_check_change(tty);
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_IOCTL, 5, 1, rc );
-#endif
 		if (!rc) {
 			ip2_wait_until_sent(tty,0);
 			i2QueueCommands(PTYPE_INLINE, pCh, 100, 1,
@@ -2266,18 +2192,14 @@
 		break;
 
 	case TIOCGSOFTCAR:
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_IOCTL, 6, 1, rc );
-#endif
 			PUT_USER(rc,C_CLOCAL(tty) ? 1 : 0, (unsigned long *) arg);
 		if (rc)	
 			return rc;
 	break;
 
 	case TIOCSSOFTCAR:
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_IOCTL, 7, 1, rc );
-#endif
 		GET_USER(rc,arg,(unsigned long *) arg);
 		if (rc) 
 			return rc;
@@ -2287,9 +2209,7 @@
 		break;
 
 	case TIOCMGET:
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_IOCTL, 8, 1, rc );
-#endif
 /*
 	FIXME - the following code is causing a NULL pointer dereference in
 	2.3.51 in an interrupt handler.  It's suppose to prompt the board
@@ -2317,9 +2237,7 @@
 	case TIOCMBIS:
 	case TIOCMBIC:
 	case TIOCMSET:
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_IOCTL, 9, 0 );
-#endif
 		rc = set_modem_info(pCh, cmd, (unsigned int *) arg);
 		break;
 
@@ -2336,13 +2254,9 @@
 						CMD_DCD_REP, CMD_CTS_REP, CMD_DSR_REP, CMD_RI_REP);
 		serviceOutgoingFifo( pCh->pMyBord );
 		for(;;) {
-#ifdef IP2DEBUG_TRACE
 			ip2trace (CHANN, ITRC_IOCTL, 10, 0 );
-#endif
 			interruptible_sleep_on(&pCh->delta_msr_wait);
-#ifdef IP2DEBUG_TRACE
 			ip2trace (CHANN, ITRC_IOCTL, 11, 0 );
-#endif
 			/* see if a signal did it */
 			if (signal_pending(current)) {
 				rc = -ERESTARTSYS;
@@ -2383,9 +2297,7 @@
 	 * serial driver.
 	 */
 	case TIOCGICOUNT:
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_IOCTL, 11, 1, rc );
-#endif
 		save_flags(flags);cli();
 		cnow = pCh->icount;
 		restore_flags(flags);
@@ -2416,15 +2328,11 @@
 	case TIOCSERSETMULTI:
 
 	default:
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_IOCTL, 12, 0 );
-#endif
 		rc =  -ENOIOCTLCMD;
 		break;
 	}
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_IOCTL, ITRC_RETURN, 0 );
-#endif
 	return rc;
 }
 
@@ -2635,9 +2543,7 @@
 #ifdef IP2DEBUG_IOCTL
 	printk (KERN_DEBUG "IP2: set line discipline\n" );
 #endif
-#ifdef IP2DEBUG_TRACE
-	ip2trace (((i2ChanStrPtr)tty->driver_data)->port_index, ITRC_IOCTL, 16, 0 );
-#endif
+	ip2trace(((i2ChanStrPtr)tty->driver_data)->port_index, ITRC_IOCTL, 16, 0);
 }
 
 /******************************************************************************/
@@ -3411,10 +3318,10 @@
 /*                                                                            */
 /*                                                                            */
 /******************************************************************************/
+#ifdef IP2DEBUG_TRACE
 void
 ip2trace (unsigned short pn, unsigned char cat, unsigned char label, unsigned long codes, ...)
 {
-#ifdef IP2DEBUG_TRACE
 	long flags;
 	unsigned long *pCode = &codes;
 	union ip2breadcrumb bc;
@@ -3454,8 +3361,8 @@
 
 		tracebuf[tracestuff++] = *++pCode;
 	}
-#endif
 }
+#endif
 
 
 MODULE_LICENSE("GPL");
--- linux.orig/drivers/char/ip2/i2lib.h	Tue Apr 10 16:42:42 2001
+++ linux/drivers/char/ip2/i2lib.h	Thu Nov  1 15:14:56 2001
@@ -341,6 +341,12 @@
 static int  i2ServiceBoard(i2eBordStrPtr);
 static void i2DrainOutput(i2ChanStrPtr, int);
 
+#ifdef IP2DEBUG_TRACE
+void ip2trace(unsigned short,unsigned char,unsigned char,unsigned long,...);
+#else
+#define ip2trace(a,b,c,d...) do {} while (0)
+#endif
+
 // Argument to i2QueueCommands
 //
 #define C_IN_LINE 1
--- linux.orig/drivers/char/ip2/i2lib.c	Wed Jul  5 12:00:22 2000
+++ linux/drivers/char/ip2/i2lib.c	Thu Nov  1 15:12:08 2001
@@ -319,7 +319,9 @@
 		pCh->tqueue_status.data = pCh;
 #endif
 
+#ifdef IP2DEBUG_TRACE
 		pCh->trace = ip2trace;
+#endif
 
 		++pCh;
      	--nChannels;
@@ -535,9 +537,7 @@
 	if ( !i2Validate ( pCh ) ) {
 		return -1;
 	}
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_QUEUE, ITRC_ENTER, 0 );
-#endif
 	pB = pCh->pMyBord;
 
 	// Board must also exist, and THE INTERRUPT COMMAND ALREADY SENT
@@ -615,9 +615,7 @@
 			if (--bufroom < 0) {
 				bufroom += maxBuff;
 			}
-#ifdef IP2DEBUG_TRACE
 			ip2trace (CHANN, ITRC_QUEUE, 2, 1, bufroom );
-#endif
 			// Check for overflow
 			if (totalsize <= bufroom) {
 				// Normal Expected path - We still hold LOCK
@@ -625,9 +623,7 @@
 			}
 		}
 
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_QUEUE, 3, 1, totalsize );
-#endif
 		// Prepare to wait for buffers to empty
 		WRITE_UNLOCK_IRQRESTORE(lock_var_p,flags); 
 		serviceOutgoingFifo(pB);	// Dump what we got
@@ -649,9 +645,7 @@
 			return 0;   // Wake up! Time to die!!!
 		}
 
-#ifdef IP2DEBUG_TRACE
-	ip2trace (CHANN, ITRC_QUEUE, 4, 0 );
-#endif
+		ip2trace (CHANN, ITRC_QUEUE, 4, 0 );
 	}	// end of for(;;)
 
 	// At this point we have room and the lock - stick them in.
@@ -673,9 +667,7 @@
 		// pCs->cmd[0].
 		if (pCs == CMD_BMARK_REQ) {
 			pCh->bookMarks++;
-#ifdef IP2DEBUG_TRACE
 			ip2trace (CHANN, ITRC_DRAIN, 30, 1, pCh->bookMarks );
-#endif
 		}
 		cnt = pCs->length;
 
@@ -683,9 +675,7 @@
 		// if the last command had to be at the end of a block, we end
 		// the existing block here and start a new one.
 		if ((blocksize + cnt > maxBlock) || lastended) {
-#ifdef IP2DEBUG_TRACE
 			ip2trace (CHANN, ITRC_QUEUE, 5, 0 );
-#endif
 			PTYPE_OF(pInsert) = type;
 			CHANNEL_OF(pInsert) = channel;
 			// count here does not include the header
@@ -747,9 +737,7 @@
 		i2QueueNeeds(pB, pCh, NEED_BYPASS);
 		break;
 	}
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_QUEUE, ITRC_RETURN, 1, nCommands );
-#endif
 	return nCommands; // Good status: number of commands sent
 }
 
@@ -772,9 +760,7 @@
 	unsigned short status;
 	i2eBordStrPtr pB;
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_STATUS, ITRC_ENTER, 2, pCh->dataSetIn, resetBits );
-#endif
 
 	// Make sure the channel exists, otherwise do nothing */
 	if ( !i2Validate ( pCh ) )
@@ -792,9 +778,7 @@
 		pCh->dataSetIn &= ~(I2_DDCD | I2_DCTS | I2_DDSR | I2_DRI);
 	}
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_STATUS, ITRC_RETURN, 1, pCh->dataSetIn );
-#endif
 
 	return status;
 }
@@ -819,9 +803,7 @@
 	int count;
 	unsigned long flags = 0;
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_INPUT, ITRC_ENTER, 0);
-#endif
 
 	// Ensure channel structure seems real
 	if ( !i2Validate( pCh ) ) {
@@ -887,9 +869,7 @@
 
 i2Input_exit:
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_INPUT, ITRC_RETURN, 1, count);
-#endif
 	return count;
 }
 
@@ -913,9 +893,7 @@
 	if ( !i2Validate ( pCh ) )
 		return -1;
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_INPUT, 10, 0);
-#endif
 
 	WRITE_LOCK_IRQSAVE(&pCh->Ibuf_spinlock,flags);
 	count = pCh->Ibuf_stuff - pCh->Ibuf_strip;
@@ -943,9 +921,7 @@
 	} else {
 		WRITE_UNLOCK_IRQRESTORE(&pCh->Ibuf_spinlock,flags);
 	}
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_INPUT, 19, 1, count);
-#endif
 	return count;
 }
 
@@ -1015,9 +991,7 @@
 
 	int bailout = 10;
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_OUTPUT, ITRC_ENTER, 2, count, user );
-#endif
 
 	// Ensure channel structure seems real
 	if ( !i2Validate ( pCh ) ) 
@@ -1064,10 +1038,8 @@
 // Small WINDOW here with no LOCK but I can't call Flush with LOCK
 // We would be flushing (or ending flush) anyway
 
-#ifdef IP2DEBUG_TRACE
-			ip2trace (CHANN, ITRC_OUTPUT, 10, 1, amountToMove );
-#endif
-		if ( !(pCh->flush_flags && i2RetryFlushOutput(pCh) ) 
+		ip2trace (CHANN, ITRC_OUTPUT, 10, 1, amountToMove );
+		if ( !(pCh->flush_flags && i2RetryFlushOutput(pCh) )
 				&& amountToMove > 0 )
 		{
 			WRITE_LOCK_IRQSAVE(&pCh->Obuf_spinlock,flags);
@@ -1104,35 +1076,27 @@
 
 			WRITE_UNLOCK_IRQRESTORE(&pCh->Obuf_spinlock,flags);
 
-#ifdef IP2DEBUG_TRACE
 			ip2trace (CHANN, ITRC_OUTPUT, 13, 1, stuffIndex );
-#endif
-
 		} else {
 
 			// Cannot move data
 			// becuz we need to stuff a flush 
 			// or amount to move is <= 0
-
-#ifdef IP2DEBUG_TRACE
 			ip2trace(CHANN, ITRC_OUTPUT, 14, 3,
-				amountToMove,  pB->i2eFifoRemains, pB->i2eWaitingForEmptyFifo );
-#endif
+				 amountToMove,  pB->i2eFifoRemains,
+				 pB->i2eWaitingForEmptyFifo );
+
 			// Put this channel back on queue
 			// this ultimatly gets more data or wakes write output
 			i2QueueNeeds(pB, pCh, NEED_INLINE);
 
 			if ( pB->i2eWaitingForEmptyFifo ) {
 
-#ifdef IP2DEBUG_TRACE
 				ip2trace (CHANN, ITRC_OUTPUT, 16, 0 );
-#endif
 				// or schedule
 				if (!in_interrupt()) {
 
-#ifdef IP2DEBUG_TRACE
-	ip2trace (CHANN, ITRC_OUTPUT, 61, 0 );
-#endif
+					ip2trace (CHANN, ITRC_OUTPUT, 61, 0 );
 					current->state = TASK_INTERRUPTIBLE;
 					schedule_timeout(2);
 					if (signal_pending(current)) {
@@ -1140,9 +1104,7 @@
 					}
 					continue;
 				} else {
-#ifdef IP2DEBUG_TRACE
-	ip2trace (CHANN, ITRC_OUTPUT, 62, 0 );
-#endif
+					ip2trace (CHANN, ITRC_OUTPUT, 62, 0 );
 					// let interrupt in = WAS restore_flags()
 					// We hold no lock nor is irq off anymore???
 					
@@ -1152,31 +1114,25 @@
 			}
 			else if ( pB->i2eFifoRemains < 32 && !pB->i2eTxMailEmpty ( pB ) )
 			{
-#ifdef IP2DEBUG_TRACE
-				ip2trace (CHANN, ITRC_OUTPUT, 19, 2, pB->i2eFifoRemains,
-									pB->i2eTxMailEmpty );
-#endif
+				ip2trace (CHANN, ITRC_OUTPUT, 19, 2,
+					  pB->i2eFifoRemains,
+					  pB->i2eTxMailEmpty );
 				break;   // from while(count)
 			} else if ( pCh->channelNeeds & NEED_CREDIT ) {
-#ifdef IP2DEBUG_TRACE
 				ip2trace (CHANN, ITRC_OUTPUT, 22, 0 );
-#endif
 				break;   // from while(count)
 			} else if ( --bailout) {
 
 				// Try to throw more things (maybe not us) in the fifo if we're
 				// not already waiting for it.
-	
-#ifdef IP2DEBUG_TRACE
 				ip2trace (CHANN, ITRC_OUTPUT, 20, 0 );
-#endif
 				serviceOutgoingFifo(pB);
 				//break;  CONTINUE;
 			} else {
-#ifdef IP2DEBUG_TRACE
-				ip2trace (CHANN, ITRC_OUTPUT, 21, 3, pB->i2eFifoRemains,
-							pB->i2eOutMailWaiting, pB->i2eWaitingForEmptyFifo );
-#endif
+				ip2trace (CHANN, ITRC_OUTPUT, 21, 3,
+					  pB->i2eFifoRemains,
+					  pB->i2eOutMailWaiting,
+					  pB->i2eWaitingForEmptyFifo );
 				break;   // from while(count)
 			}
 		}
@@ -1187,14 +1143,10 @@
 	// We drop through either when the count expires, or when there is some
 	// count left, but there was a non-blocking write.
 	if (countOriginal > count) {
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_OUTPUT, 17, 2, countOriginal, count );
-#endif
 		serviceOutgoingFifo( pB );
 	}
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_OUTPUT, ITRC_RETURN, 2, countOriginal, count );
-#endif
 
 	return countOriginal - count;
 }
@@ -1213,23 +1165,17 @@
 i2FlushOutput(i2ChanStrPtr pCh)
 {
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_FLUSH, 1, 1, pCh->flush_flags );
-#endif
 
 	if (pCh->flush_flags)
 		return;
 
 	if ( 1 != i2QueueCommands(PTYPE_BYPASS, pCh, 0, 1, CMD_STARTFL) ) {
 		pCh->flush_flags = STARTFL_FLAG;		// Failed - flag for later
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_FLUSH, 2, 0 );
-#endif
 	} else if ( 1 != i2QueueCommands(PTYPE_INLINE, pCh, 0, 1, CMD_STOPFL) ) {
 		pCh->flush_flags = STOPFL_FLAG;		// Failed - flag for later
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_FLUSH, 3, 0 );
-#endif
 	}
 }
 
@@ -1238,9 +1184,7 @@
 {
 	int old_flags = pCh->flush_flags;
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_FLUSH, 14, 1, old_flags );
-#endif
 
 	pCh->flush_flags = 0;	// Clear flag so we can avoid recursion
 									// and queue the commands
@@ -1251,23 +1195,17 @@
 		} else {
 			old_flags = STARTFL_FLAG;	//Failure - Flag for retry later
 		}
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_FLUSH, 15, 1, old_flags );
-#endif
 	}
 	if ( old_flags & STOPFL_FLAG ) {
 		if ( 1 == i2QueueCommands(PTYPE_INLINE, pCh, 0, 1, CMD_STOPFL) > 0 ) {
 			old_flags = 0;	// Success - clear flags
 		}
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_FLUSH, 16, 1, old_flags );
-#endif
 	}
-   pCh->flush_flags = old_flags;
+	pCh->flush_flags = old_flags;
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_FLUSH, 17, 1, old_flags );
-#endif
 	return old_flags;
 }
 
@@ -1284,9 +1222,7 @@
 static void
 i2DrainWakeup(i2ChanStrPtr pCh)
 {
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_DRAIN, 10, 1, pCh->BookmarkTimer.expires );
-#endif
 	pCh->BookmarkTimer.expires = 0;
 	wake_up_interruptible( &pCh->pBookmarkWait );
 }
@@ -1296,9 +1232,7 @@
 {
 	i2eBordStrPtr pB;
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (CHANN, ITRC_DRAIN, ITRC_ENTER, 1, pCh->BookmarkTimer.expires);
-#endif
 	pB = pCh->pMyBord;
 	// If the board has gone fatal, return bad, 
 	// and also hit the trap routine if it exists.
@@ -1315,9 +1249,7 @@
 		pCh->BookmarkTimer.function = (void*)(unsigned long)i2DrainWakeup;
 		pCh->BookmarkTimer.data     = (unsigned long)pCh;
 
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_DRAIN, 1, 1, pCh->BookmarkTimer.expires );
-#endif
 
 		add_timer( &(pCh->BookmarkTimer) );
 	}
@@ -1332,14 +1264,9 @@
 				(pCh->BookmarkTimer.expires > jiffies)) {
 		del_timer( &(pCh->BookmarkTimer) );
 		pCh->BookmarkTimer.expires = 0;
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_DRAIN, 3, 1, pCh->BookmarkTimer.expires );
-#endif
-
 	}
-#ifdef IP2DEBUG_TRACE
-	ip2trace (CHANN, ITRC_DRAIN, ITRC_RETURN, 1, pCh->BookmarkTimer.expires );
-#endif
+	ip2trace (CHANN,ITRC_DRAIN,ITRC_RETURN, 1, pCh->BookmarkTimer.expires );
 	return;
 }
 
@@ -1384,17 +1311,13 @@
 
 	pCh = tp->driver_data;
 
-#ifdef IP2DEBUG_TRACE
-	ip2trace (CHANN, ITRC_SICMD, 10, 2, tp->flags, (1 << TTY_DO_WRITE_WAKEUP) );
-#endif
+	ip2trace (CHANN, ITRC_SICMD, 10, 2, tp->flags,(1<<TTY_DO_WRITE_WAKEUP));
 	wake_up_interruptible ( &tp->write_wait );
 	if ( ( tp->flags & (1 << TTY_DO_WRITE_WAKEUP) ) 
 	  && tp->ldisc.write_wakeup )
 	{
 		(tp->ldisc.write_wakeup) ( tp );
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_SICMD, 11, 0 );
-#endif
 	}
 }
 
@@ -1480,14 +1403,10 @@
 	unsigned char dss_change;
 	unsigned long bflags,cflags;
 
-#ifdef IP2DEBUG_TRACE
 	//ip2trace (ITRC_NO_PORT, ITRC_SFIFO, ITRC_ENTER, 0 );
-#endif
 
 	while (HAS_INPUT(pB)) {
-#ifdef IP2DEBUG_TRACE
 		//ip2trace (ITRC_NO_PORT, ITRC_SFIFO, 2, 0 );
-#endif
 		// Process packet from fifo a one atomic unit
 		WRITE_LOCK_IRQSAVE(&pB->read_fifo_spinlock,bflags);
    
@@ -1500,9 +1419,7 @@
 		case PTYPE_DATA:
 			pB->got_input = 1;
 
-#ifdef IP2DEBUG_TRACE
 			//ip2trace (ITRC_NO_PORT, ITRC_SFIFO, 3, 0 );
-#endif
 			channel = CHANNEL_OF(pB->i2eLeadoffWord); /* Store channel */
 			count = iiReadWord(pB);          /* Count is in the next word */
 
@@ -1602,10 +1519,8 @@
 			break;   // From switch: ready for next packet
 
 		case PTYPE_STATUS:
-#ifdef IP2DEBUG_TRACE
 			ip2trace (ITRC_NO_PORT, ITRC_SFIFO, 4, 0 );
-#endif
-      
+
 			count = CMD_COUNT_OF(pB->i2eLeadoffWord);
 
 			iiReadBuf(pB, cmdBuffer, count);
@@ -1617,9 +1532,7 @@
 
 			while (pc < pcLimit) {
 				channel = *pc++;
-#ifdef IP2DEBUG_TRACE
 				ip2trace (channel, ITRC_SFIFO, 7, 2, channel, *pc );
-#endif
 				/* check for valid channel */
 				if (channel < pB->i2eChannelCnt
 					 && 
@@ -1652,41 +1565,29 @@
 						break;
 
 					case STAT_DCD_UP:
-#ifdef IP2DEBUG_TRACE
 						ip2trace (channel, ITRC_MODEM, 1, 1, pCh->dataSetIn );
-#endif
 						if ( !(pCh->dataSetIn & I2_DCD) )
 						{
-#ifdef IP2DEBUG_TRACE
 							ip2trace (CHANN, ITRC_MODEM, 2, 0 );
-#endif
 							pCh->dataSetIn |= I2_DDCD;
 							pCh->icount.dcd++;
 							dss_change = 1;
 						}
 						pCh->dataSetIn |= I2_DCD;
-#ifdef IP2DEBUG_TRACE
 						ip2trace (channel, ITRC_MODEM, 3, 1, pCh->dataSetIn );
-#endif
 						break;
 
 					case STAT_DCD_DN:
-#ifdef IP2DEBUG_TRACE
 						ip2trace (channel, ITRC_MODEM, 4, 1, pCh->dataSetIn );
-#endif
 						if ( pCh->dataSetIn & I2_DCD )
 						{
-#ifdef IP2DEBUG_TRACE
 							ip2trace (channel, ITRC_MODEM, 5, 0 );
-#endif
 							pCh->dataSetIn |= I2_DDCD;
 							pCh->icount.dcd++;
 							dss_change = 1;
 						}
 						pCh->dataSetIn &= ~I2_DCD;
-#ifdef IP2DEBUG_TRACE
 						ip2trace (channel, ITRC_MODEM, 6, 1, pCh->dataSetIn );
-#endif
 						break;
 
 					case STAT_DSR_UP:
@@ -1742,9 +1643,8 @@
 						if (pCh->bookMarks <= 0 ) {
 							pCh->bookMarks = 0;
 							wake_up_interruptible( &pCh->pBookmarkWait );
-#ifdef IP2DEBUG_TRACE
-						ip2trace (channel, ITRC_DRAIN, 20, 1, pCh->BookmarkTimer.expires );
-#endif
+							ip2trace (channel, ITRC_DRAIN, 20, 1,
+									  pCh->BookmarkTimer.expires );
 						}
 						break;
 
@@ -1754,22 +1654,16 @@
 						pCh->outfl.room =
 							((flowStatPtr)pc)->room -
 							(pCh->outfl.asof - ((flowStatPtr)pc)->asof);
-#ifdef IP2DEBUG_TRACE
 						ip2trace (channel, ITRC_STFLW, 1, 1, pCh->outfl.room );
-#endif
 						if (pCh->channelNeeds & NEED_CREDIT)
 						{
-#ifdef IP2DEBUG_TRACE
-						ip2trace (channel, ITRC_STFLW, 2, 1, pCh->channelNeeds);
-#endif
+							ip2trace(channel,ITRC_STFLW,2,1,pCh->channelNeeds);
 							pCh->channelNeeds &= ~NEED_CREDIT;
 							i2QueueNeeds(pB, pCh, NEED_INLINE);
 							if ( pCh->pTTY )
 								ip2_owake(pCh->pTTY);
 						}
-#ifdef IP2DEBUG_TRACE
 						ip2trace (channel, ITRC_STFLW, 3, 1, pCh->channelNeeds);
-#endif
 						pc += sizeof(flowStat);
 						break;
 
@@ -1865,16 +1759,12 @@
 			break;
 
 		default: // Neither packet? should be impossible
-#ifdef IP2DEBUG_TRACE
 			ip2trace (ITRC_NO_PORT, ITRC_SFIFO, 5, 1,
 				PTYPE_OF(pB->i2eLeadoffWord) );
-#endif
 			break;
 		}  // End of switch on type of packets
 	}	//while(board HAS_INPUT)
-#ifdef IP2DEBUG_TRACE
 	ip2trace (ITRC_NO_PORT, ITRC_SFIFO, ITRC_RETURN, 0 );
-#endif
 	// Send acknowledgement to the board even if there was no data!
 	pB->i2eOutMailWaiting |= MB_IN_STRIPPED;
 	return;
@@ -1969,11 +1859,9 @@
 		WRITE_UNLOCK_IRQRESTORE(&pCh->Cbuf_spinlock,flags);
 	}  // Either clogged or finished all the work
 
-#ifdef IP2DEBUG_TRACE
 	if ( !bailout ) {
 		ip2trace (ITRC_NO_PORT, ITRC_ERROR, 1, 0 );
 	}
-#endif
 }
 
 //******************************************************************************
@@ -1992,9 +1880,8 @@
 	i2ChanStrPtr pCh;
 	unsigned short paddedSize		= ROUNDUP(sizeof(flowIn));
 
-#ifdef IP2DEBUG_TRACE
-ip2trace (ITRC_NO_PORT, ITRC_SFLOW, ITRC_ENTER, 2, pB->i2eFifoRemains, paddedSize );
-#endif
+	ip2trace (ITRC_NO_PORT, ITRC_SFLOW, ITRC_ENTER, 2, pB->i2eFifoRemains,
+			  paddedSize );
 
 	// Continue processing so long as there are entries, or there is room in the
 	// fifo. Each entry represents a channel with something to do.
@@ -2006,14 +1893,12 @@
 			break;
 		}
 #ifdef DEBUG_FIFO
-WriteDBGBuf("FLOW",(unsigned char *) &(pCh->infl), paddedSize);
+		WriteDBGBuf("FLOW",(unsigned char *) &(pCh->infl), paddedSize);
 #endif /* DEBUG_FIFO */
 
 	}  // Either clogged or finished all the work
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (ITRC_NO_PORT, ITRC_SFLOW, ITRC_RETURN, 0 );
-#endif
 }
 
 //******************************************************************************
@@ -2041,10 +1926,8 @@
 	int bailout  = 1000;
 	int bailout2;
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (ITRC_NO_PORT, ITRC_SICMD, ITRC_ENTER, 3, pB->i2eFifoRemains, 
 			pB->i2Dbuf_strip, pB->i2Dbuf_stuff );
-#endif
 
 	// Continue processing so long as there are entries, or there is room in the
 	// fifo. Each entry represents a channel with something to do.
@@ -2054,9 +1937,7 @@
 		WRITE_LOCK_IRQSAVE(&pCh->Obuf_spinlock,flags);
 		stripIndex = pCh->Obuf_strip;
 
-#ifdef IP2DEBUG_TRACE
 		ip2trace (CHANN, ITRC_SICMD, 3, 2, stripIndex, pCh->Obuf_stuff );
-#endif 
 		// as long as there are packets for this channel...
 		bailout2 = 1000;
 		while ( --bailout2 && stripIndex != pCh->Obuf_stuff) {
@@ -2075,16 +1956,12 @@
 			flowsize = CREDIT_USAGE(flowsize);
 			paddedSize = ROUNDUP(packetSize);
 
-#ifdef IP2DEBUG_TRACE
 			ip2trace (CHANN, ITRC_SICMD, 4, 2, pB->i2eFifoRemains, paddedSize );
-#endif 
 			// If we don't have enough credits from the board to send the data,
 			// flag the channel that we are waiting for flow control credit, and
 			// break out. This will clean up this channel and remove us from the
 			// queue of hot things to do.
-#ifdef IP2DEBUG_TRACE
-				ip2trace (CHANN, ITRC_SICMD, 5, 2, pCh->outfl.room, flowsize );
-#endif 
+			ip2trace (CHANN, ITRC_SICMD, 5, 2, pCh->outfl.room, flowsize );
 			if (pCh->outfl.room <= flowsize)	{
 				// Do Not have the credits to send this packet.
 				i2QueueNeeds(pB, pCh, NEED_CREDIT);
@@ -2112,15 +1989,11 @@
 			}
 			pRemove += packetSize;
 			stripIndex += packetSize;
-#ifdef IP2DEBUG_TRACE
 			ip2trace (CHANN, ITRC_SICMD, 6, 2, stripIndex, pCh->Obuf_strip);
-#endif 
 			if (stripIndex >= OBUF_SIZE) {
 				stripIndex = 0;
 				pRemove = pCh->Obuf;
-#ifdef IP2DEBUG_TRACE
 				ip2trace (CHANN, ITRC_SICMD, 7, 1, stripIndex );
-#endif 
 			}
 		}	/* while */
 		if ( !bailout2 ) {
@@ -2132,23 +2005,17 @@
 		WRITE_UNLOCK_IRQRESTORE(&pCh->Obuf_spinlock,flags);
 		if ( notClogged )
 		{
-#ifdef IP2DEBUG_TRACE
 			ip2trace (CHANN, ITRC_SICMD, 8, 0 );
-#endif
 			if ( pCh->pTTY ) {
 				ip2_owake(pCh->pTTY);
 			}
 		}
 	}  // Either clogged or finished all the work
-#ifdef IP2DEBUG_TRACE
 	if ( !bailout ) {
 		ip2trace (ITRC_NO_PORT, ITRC_ERROR, 4, 0 );
 	}
-#endif
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (ITRC_NO_PORT, ITRC_SICMD, ITRC_RETURN, 1,pB->i2Dbuf_strip);
-#endif
 }
 
 //******************************************************************************
@@ -2214,9 +2081,7 @@
 
 	inmail = iiGetMail(pB);
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (ITRC_NO_PORT, ITRC_INTR, 2, 1, inmail );
-#endif
 
 	if (inmail != NO_MAIL_HERE) {
 		// If the board has gone fatal, nothing to do but hit a bit that will
@@ -2238,16 +2103,12 @@
 			pB->i2eFifoRemains = pB->i2eFifoSize;
 			pB->i2eWaitingForEmptyFifo = 0;
 			WRITE_UNLOCK_IRQRESTORE(&pB->write_fifo_spinlock,flags);
-#ifdef IP2DEBUG_TRACE
-		ip2trace (ITRC_NO_PORT, ITRC_INTR, 30, 1, pB->i2eFifoRemains );
-#endif
+			ip2trace (ITRC_NO_PORT, ITRC_INTR, 30, 1, pB->i2eFifoRemains );
 		}
 		serviceOutgoingFifo(pB);
 	}
 
-#ifdef IP2DEBUG_TRACE
 	ip2trace (ITRC_NO_PORT, ITRC_INTR, 8, 0 );
-#endif
 
 exit_i2ServiceBoard:
 
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

