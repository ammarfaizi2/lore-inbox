Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267277AbTAKP6u>; Sat, 11 Jan 2003 10:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267273AbTAKP6u>; Sat, 11 Jan 2003 10:58:50 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39381 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267277AbTAKP6c>; Sat, 11 Jan 2003 10:58:32 -0500
Date: Sat, 11 Jan 2003 17:07:14 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: [2.5 patch] small cleanups for drivers/char/ip2*
Message-ID: <20030111160714.GM10486@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following cleanups in drivers/char/ip2*:

drivers/char/ip2/i2os.h:
- removed kernel 2.0 code
- removed unused #define VERSION

drivers/char/ip2main.c:
- removed unused #define MIN/MAX
- removed kernel 2.0 code (including the expansion of no longer needed
                          #define's)
- MODULE_{AUTHOR,DESCRIPTION) don't need to be hidden behind an
  #ifdef MODULE

drivers/char/ip2/i2lib.c:
- expand a no longer needed #define

drivers/char/ip2.c:
- removed unused #define NULL
- removed kernel 2.0 and 2.2 code


I've tested the compilation with 2.5.56.


cu
Adrian


--- linux-2.5.56/drivers/char/ip2/i2os.h.old	2003-01-11 08:40:02.000000000 +0100
+++ linux-2.5.56/drivers/char/ip2/i2os.h	2003-01-11 08:42:13.000000000 +0100
@@ -19,8 +19,6 @@
 #ifndef I2OS_H    /* To prevent multiple includes */
 #define I2OS_H 1
 
-#define VERSION(ver,rel,seq) (((ver)<<16) | ((rel)<<8) | (seq))
-
 //-------------------------------------------------
 // Required Includes
 //-------------------------------------------------
@@ -46,19 +44,6 @@
 // Interrupt control
 //--------------------------------------------
 
-#if LINUX_VERSION_CODE < 0x00020100
-typedef int spinlock_t;
-#define spin_lock_init() 
-#define spin_lock(a)
-#define spin_unlock(a)
-#define spin_lock_irqsave(a,b)			{save_flags((b));cli();}
-#define spin_unlock_irqrestore(a,b)		{restore_flags((b));}
-#define write_lock_irqsave(a,b)			spin_lock_irqsave(a,b)
-#define write_unlock_irqrestore(a,b)	spin_unlock_irqrestore(a,b)
-#define read_lock_irqsave(a,b)			spin_lock_irqsave(a,b)
-#define read_unlock_irqrestore(a,b)		spin_unlock_irqrestore(a,b)
-#endif
-
 //#define SAVE_AND_DISABLE_INTS(a,b)	spin_lock_irqsave(a,b)
 //#define RESTORE_INTS(a,b)         	spin_unlock_irqrestore(a,b)
 
--- linux-2.5.56/drivers/char/ip2main.c.old	2003-01-11 08:43:07.000000000 +0100
+++ linux-2.5.56/drivers/char/ip2main.c	2003-01-11 09:56:11.000000000 +0100
@@ -122,83 +122,11 @@
 #include <asm/irq.h>
 #include <asm/bitops.h>
 
-#ifndef KERNEL_VERSION
-#define KERNEL_VERSION(ver,rel,seq) (((ver)<<16) | ((rel)<<8) | (seq))
-#endif
+#include <linux/vmalloc.h>
+#include <linux/init.h>
+#include <asm/serial.h>
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,0)
-#	include <linux/vmalloc.h>
-#	include <linux/init.h>
-#	include <asm/serial.h>
-#else
-#	include <linux/bios32.h>
-#endif
-
-// These VERSION switches maybe inexact because I simply don't know
-// when the various features appeared in the 2.1.XX kernels.
-// They are good enough for 2.0 vs 2.2 and if you are fooling with
-// the 2.1.XX stuff then it would be trivial for you to fix.
-// Most of these macros were stolen from some other drivers
-// so blame them.
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,4)
-#	define GET_USER(error,value,addr) error = get_user(value,addr)
-#	define COPY_FROM_USER(error,dest,src,size) error = copy_from_user(dest,src,size) ? -EFAULT : 0
-#	define PUT_USER(error,value,addr) error = put_user(value,addr)
-#	define COPY_TO_USER(error,dest,src,size) error = copy_to_user(dest,src,size) ? -EFAULT : 0
-
-#	if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,5)
-#		include <asm/uaccess.h>
-#		define		pcibios_strerror(status)	\
-					printk( KERN_ERR "IP2: PCI error 0x%x \n", status );
-#	endif
-
-#else  /* 2.0.x and 2.1.x before 2.1.4 */
-
-#	define		proc_register_dynamic(a,b) proc_register(a,b) 
-
-#	define GET_USER(error,value,addr)					  \
-	do {									  \
-		error = verify_area (VERIFY_READ, (void *) addr, sizeof (value)); \
-		if (error == 0)							  \
-			value = get_user(addr);					  \
-	} while (0)
-
-#	define COPY_FROM_USER(error,dest,src,size)				  \
-	do {									  \
-		error = verify_area (VERIFY_READ, (void *) src, size);		  \
-		if (error == 0)							  \
-			memcpy_fromfs (dest, src, size);			  \
-	} while (0)
-
-#	define PUT_USER(error,value,addr)					   \
-	do {									   \
-		error = verify_area (VERIFY_WRITE, (void *) addr, sizeof (value)); \
-		if (error == 0)							   \
-			put_user (value, addr);					   \
-	} while (0)
-
-#	define COPY_TO_USER(error,dest,src,size)				  \
-	do {									  \
-		error = verify_area (VERIFY_WRITE, (void *) dest, size);		  \
-		if (error == 0)							  \
-			memcpy_tofs (dest, src, size);				  \
-	} while (0)
-
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,0)
-#define __init
-#define __initfunc(a) a
-#define __initdata
-#define ioremap(a,b) vremap((a),(b))
-#define iounmap(a) vfree((a))
-#define SERIAL_TYPE_NORMAL	1
-#define SERIAL_TYPE_CALLOUT	2
-#define schedule_timeout(a){current->timeout = jiffies + (a); schedule();}
-#define signal_pending(a) ((a)->signal & ~(a)->blocked)
-#define in_interrupt()	intr_count
-#endif
+#include <asm/uaccess.h>
 
 #include "./ip2/ip2types.h"
 #include "./ip2/ip2trace.h"
@@ -287,11 +215,7 @@
 static int get_serial_info(i2ChanStrPtr, struct serial_struct *);
 static int set_serial_info(i2ChanStrPtr, struct serial_struct *);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,0)
-static int     ip2_ipl_read(struct inode *, char *, size_t , loff_t *);
-#else
 static ssize_t ip2_ipl_read(struct file *, char *, size_t, loff_t *) ;
-#endif
 static ssize_t ip2_ipl_write(struct file *, const char *, size_t, loff_t *);
 static int ip2_ipl_ioctl(struct inode *, struct file *, UINT, ULONG);
 static int ip2_ipl_open(struct inode *, struct file *);
@@ -372,9 +296,6 @@
 #define DBG_CNT(s)
 #endif
 
-#define MIN(a,b)	( ( (a) < (b) ) ? (a) : (b) )
-#define MAX(a,b)	( ( (a) > (b) ) ? (a) : (b) )
-
 /********/
 /* Code */
 /********/
@@ -384,12 +305,8 @@
 #include "./ip2/i2lib.c"      /* High level interface services */
 
 /* Configuration area for modprobe */
-#ifdef MODULE
-#	if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,0)
-		MODULE_AUTHOR("Doug McNash");
-		MODULE_DESCRIPTION("Computone IntelliPort Plus Driver");
-#	endif	/* LINUX_VERSION */
-#endif	/* MODULE */
+MODULE_AUTHOR("Doug McNash");
+MODULE_DESCRIPTION("Computone IntelliPort Plus Driver");
 
 static int poll_only = 0;
 
@@ -662,90 +579,41 @@
 			break;
 		case PCI:
 #ifdef CONFIG_PCI
-#if (LINUX_VERSION_CODE < 0x020163) /* 2.1.99 */
-			if (pcibios_present()) {
-				unsigned char pci_bus, pci_devfn;
-				int Pci_index = 0;
-				status = pcibios_find_device(PCI_VENDOR_ID_COMPUTONE,
-							  PCI_DEVICE_ID_COMPUTONE_IP2EX, Pci_index,
-							  &pci_bus, &pci_devfn);
-				if (status == 0) {
-					unsigned int addr;
-					unsigned char pci_irq;
-
+		if (pci_present()) {
+			struct pci_dev *pci_dev_i = NULL;
+			pci_dev_i = pci_find_device(PCI_VENDOR_ID_COMPUTONE,
+						  PCI_DEVICE_ID_COMPUTONE_IP2EX, pci_dev_i);
+			if (pci_dev_i != NULL) {
+				unsigned int addr;
+				unsigned char pci_irq;
 					ip2config.type[i] = PCI;
-					/* 
-					 * Update Pci_index, so that the next time we go
-					 * searching for a PCI board we find a different
-					 * one.
-					 */
-					++Pci_index;
-
-					pcibios_read_config_dword(pci_bus, pci_devfn,
-								  PCI_BASE_ADDRESS_1, &addr);
-					if ( addr & 1 ) {
-						ip2config.addr[i]=(USHORT)(addr&0xfffe);
-					} else {
-						printk( KERN_ERR "IP2: PCI I/O address error\n");
-					}
-					pcibios_read_config_byte(pci_bus, pci_devfn,
-								  PCI_INTERRUPT_LINE, &pci_irq);
-
-//		If the PCI BIOS assigned it, lets try and use it.  If we
-//		can't acquire it or it screws up, deal with it then.
-
-//					if (!is_valid_irq(pci_irq)) {
-//						printk( KERN_ERR "IP2: Bad PCI BIOS IRQ(%d)\n",pci_irq);
-//						pci_irq = 0;
-//					}
-					ip2config.irq[i] = pci_irq;
-				} else {	// ann error
-					ip2config.addr[i] = 0;
-					if (status == PCIBIOS_DEVICE_NOT_FOUND) {
-						printk( KERN_ERR "IP2: PCI board %d not found\n", i );
-					} else {
-						pcibios_strerror(status);
-					}
-				} 
-			} 
-#else /* LINUX_VERSION_CODE > 2.1.99 */
-			if (pci_present()) {
-				struct pci_dev *pci_dev_i = NULL;
-				pci_dev_i = pci_find_device(PCI_VENDOR_ID_COMPUTONE,
-							  PCI_DEVICE_ID_COMPUTONE_IP2EX, pci_dev_i);
-				if (pci_dev_i != NULL) {
-					unsigned int addr;
-					unsigned char pci_irq;
-
-					ip2config.type[i] = PCI;
-					status =
-					pci_read_config_dword(pci_dev_i, PCI_BASE_ADDRESS_1, &addr);
-					if ( addr & 1 ) {
-						ip2config.addr[i]=(USHORT)(addr&0xfffe);
-					} else {
-						printk( KERN_ERR "IP2: PCI I/O address error\n");
-					}
-					status =
-					pci_read_config_byte(pci_dev_i, PCI_INTERRUPT_LINE, &pci_irq);
+				status =
+				pci_read_config_dword(pci_dev_i, PCI_BASE_ADDRESS_1, &addr);
+				if ( addr & 1 ) {
+					ip2config.addr[i]=(USHORT)(addr&0xfffe);
+				} else {
+					printk( KERN_ERR "IP2: PCI I/O address error\n");
+				}
+				status =
+				pci_read_config_byte(pci_dev_i, PCI_INTERRUPT_LINE, &pci_irq);
 
-//		If the PCI BIOS assigned it, lets try and use it.  If we
-//		can't acquire it or it screws up, deal with it then.
+//	If the PCI BIOS assigned it, lets try and use it.  If we
+//	can't acquire it or it screws up, deal with it then.
 
-//					if (!is_valid_irq(pci_irq)) {
-//						printk( KERN_ERR "IP2: Bad PCI BIOS IRQ(%d)\n",pci_irq);
-//						pci_irq = 0;
-//					}
-					ip2config.irq[i] = pci_irq;
-				} else {	// ann error
-					ip2config.addr[i] = 0;
-					if (status == PCIBIOS_DEVICE_NOT_FOUND) {
-						printk( KERN_ERR "IP2: PCI board %d not found\n", i );
-					} else {
-						pcibios_strerror(status);
-					}
-				} 
+//				if (!is_valid_irq(pci_irq)) {
+//					printk( KERN_ERR "IP2: Bad PCI BIOS IRQ(%d)\n",pci_irq);
+//					pci_irq = 0;
+//				}
+				ip2config.irq[i] = pci_irq;
+			} else {	// ann error
+				ip2config.addr[i] = 0;
+				if (status == PCIBIOS_DEVICE_NOT_FOUND) {
+					printk( KERN_ERR "IP2: PCI board %d not found\n", i );
+				} else {
+					printk(KERN_ERR "IP2: PCI error 0x%x \n", status);
+				}
 			} 
-#endif	/* ! 2_0_X */
+		} 
 #else
 			printk( KERN_ERR "IP2: PCI card specified but PCI support not\n");
 			printk( KERN_ERR "IP2: configured in this kernel.\n");
@@ -794,10 +662,8 @@
 	/* Initialise the relevant fields. */
 	ip2_tty_driver.magic                = TTY_DRIVER_MAGIC;
 	ip2_tty_driver.name                 = pcTty;
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,1,0)
 	ip2_tty_driver.driver_name          = pcDriver_name;
 	ip2_tty_driver.read_proc          	= ip2_read_proc;
-#endif
 	ip2_tty_driver.major                = IP2_TTY_MAJOR;
 	ip2_tty_driver.minor_start          = 0;
 	ip2_tty_driver.num                  = IP2_MAX_PORTS;
@@ -838,10 +704,8 @@
 	 */
 	ip2_callout_driver         = ip2_tty_driver;
 	ip2_callout_driver.name    = pcCallout;
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,1,0)
 	ip2_callout_driver.driver_name = pcDriver_name;
 	ip2_callout_driver.read_proc  = NULL;
-#endif
 	ip2_callout_driver.major   = IP2_CALLOUT_MAJOR;
 	ip2_callout_driver.subtype = SERIAL_TYPE_CALLOUT;
 
@@ -2315,7 +2179,7 @@
 
 		ip2trace (CHANN, ITRC_IOCTL, 6, 1, rc );
 
-			PUT_USER(rc,C_CLOCAL(tty) ? 1 : 0, (unsigned long *) arg);
+			rc = put_user(C_CLOCAL(tty) ? 1 : 0, (unsigned long *) arg);
 		if (rc)	
 			return rc;
 	break;
@@ -2324,7 +2188,7 @@
 
 		ip2trace (CHANN, ITRC_IOCTL, 7, 1, rc );
 
-		GET_USER(rc,arg,(unsigned long *) arg);
+		rc = get_user(arg,(unsigned long *) arg);
 		if (rc) 
 			return rc;
 		tty->termios->c_cflag = ((tty->termios->c_cflag & ~CLOCAL)
@@ -2365,13 +2229,12 @@
 			return -EINTR;
 		}
 #endif
-		PUT_USER(rc,
-				    ((pCh->dataSetOut & I2_RTS) ? TIOCM_RTS : 0)
-				  | ((pCh->dataSetOut & I2_DTR) ? TIOCM_DTR : 0)
-				  | ((pCh->dataSetIn  & I2_DCD) ? TIOCM_CAR : 0)
-				  | ((pCh->dataSetIn  & I2_RI)  ? TIOCM_RNG : 0)
-				  | ((pCh->dataSetIn  & I2_DSR) ? TIOCM_DSR : 0)
-				  | ((pCh->dataSetIn  & I2_CTS) ? TIOCM_CTS : 0),
+		rc = put_user(((pCh->dataSetOut & I2_RTS) ? TIOCM_RTS : 0)
+			    | ((pCh->dataSetOut & I2_DTR) ? TIOCM_DTR : 0)
+			    | ((pCh->dataSetIn  & I2_DCD) ? TIOCM_CAR : 0)
+			    | ((pCh->dataSetIn  & I2_RI)  ? TIOCM_RNG : 0)
+			    | ((pCh->dataSetIn  & I2_DSR) ? TIOCM_DSR : 0)
+			    | ((pCh->dataSetIn  & I2_CTS) ? TIOCM_CTS : 0),
 				(unsigned int *) arg);
 		break;
 
@@ -2455,17 +2318,17 @@
 		cnow = pCh->icount;
 		restore_flags(flags);
 		p_cuser = (struct serial_icounter_struct *) arg;
-		PUT_USER(rc,cnow.cts, &p_cuser->cts);
-		PUT_USER(rc,cnow.dsr, &p_cuser->dsr);
-		PUT_USER(rc,cnow.rng, &p_cuser->rng);
-		PUT_USER(rc,cnow.dcd, &p_cuser->dcd);
-		PUT_USER(rc,cnow.rx, &p_cuser->rx);
-		PUT_USER(rc,cnow.tx, &p_cuser->tx);
-		PUT_USER(rc,cnow.frame, &p_cuser->frame);
-		PUT_USER(rc,cnow.overrun, &p_cuser->overrun);
-		PUT_USER(rc,cnow.parity, &p_cuser->parity);
-		PUT_USER(rc,cnow.brk, &p_cuser->brk);
-		PUT_USER(rc,cnow.buf_overrun, &p_cuser->buf_overrun);
+		rc = put_user(cnow.cts, &p_cuser->cts);
+		rc = put_user(cnow.dsr, &p_cuser->dsr);
+		rc = put_user(cnow.rng, &p_cuser->rng);
+		rc = put_user(cnow.dcd, &p_cuser->dcd);
+		rc = put_user(cnow.rx, &p_cuser->rx);
+		rc = put_user(cnow.tx, &p_cuser->tx);
+		rc = put_user(cnow.frame, &p_cuser->frame);
+		rc = put_user(cnow.overrun, &p_cuser->overrun);
+		rc = put_user(cnow.parity, &p_cuser->parity);
+		rc = put_user(cnow.brk, &p_cuser->brk);
+		rc = put_user(cnow.buf_overrun, &p_cuser->buf_overrun);
 		break;
 
 	/*
@@ -2509,7 +2372,7 @@
 	int rc;
 	unsigned int arg;
 
-	GET_USER(rc,arg,value);
+	rc = get_user(arg,value);
 	if (rc)
 		return rc;
 	switch(cmd) {
@@ -2591,7 +2454,7 @@
 	tmp.close_delay = pCh->ClosingDelay;
 	tmp.closing_wait = pCh->ClosingWaitTime;
 	tmp.custom_divisor = pCh->BaudDivisor;
-   	COPY_TO_USER(rc,retinfo,&tmp,sizeof(*retinfo));
+   	rc = copy_to_user(retinfo,&tmp,sizeof(*retinfo)) ? -EFAULT : 0;
    return rc;
 }
 
@@ -2616,7 +2479,7 @@
 	if ( !new_info ) {
 		return -EFAULT;
 	}
-	COPY_FROM_USER(rc, &ns, new_info, sizeof (ns) );
+	rc = copy_from_user(&ns, new_info, sizeof (ns) ) ? -EFAULT : 0;
 	if (rc) {
 		return rc;
 	}
@@ -2981,17 +2844,10 @@
 /*                                                                            */
 /******************************************************************************/
 
-static 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,0)
-int
-ip2_ipl_read(struct inode *pInode, char *pData, size_t count, loff_t *off )
-	unsigned int minor = minor( pInode->i_rdev );
-#else
-ssize_t
+static ssize_t
 ip2_ipl_read(struct file *pFile, char *pData, size_t count, loff_t *off )
 {
 	unsigned int minor = minor( pFile->f_dentry->d_inode->i_rdev );
-#endif
 	int rc = 0;
 
 #ifdef IP2DEBUG_IPL
@@ -3026,7 +2882,7 @@
 {
 #ifdef DEBUG_FIFO
 	int rc;
-	COPY_TO_USER(rc, pData, DBGBuf, count);
+	rc = copy_to_user(pData, DBGBuf, count) ? -EFAULT : 0;
 
 	printk(KERN_DEBUG "Last index %d\n", I );
 
@@ -3047,10 +2903,10 @@
 	if ( count < (sizeof(int) * 6) ) {
 		return -EIO;
 	}
-	PUT_USER(rc, tracewrap, pIndex );
-	PUT_USER(rc, TRACEMAX, ++pIndex );
-	PUT_USER(rc, tracestrip, ++pIndex );
-	PUT_USER(rc, tracestuff, ++pIndex );
+	rc = put_user(tracewrap, pIndex );
+	rc = put_user(TRACEMAX, ++pIndex );
+	rc = put_user(tracestrip, ++pIndex );
+	rc, tracestuff, ++pIndex );
 	pData += sizeof(int) * 6;
 	count -= sizeof(int) * 6;
 
@@ -3063,21 +2919,21 @@
 	}
 	chunk = TRACEMAX - tracestrip;
 	if ( dumpcount > chunk ) {
-		COPY_TO_USER(rc, pData, &tracebuf[tracestrip],
-			      chunk * sizeof(tracebuf[0]) );
+		rc = copy_to_user(pData, &tracebuf[tracestrip],
+			          chunk * sizeof(tracebuf[0]) ) ? -EFAULT : 0;
 		pData += chunk * sizeof(tracebuf[0]);
 		tracestrip = 0;
 		chunk = dumpcount - chunk;
 	} else {
 		chunk = dumpcount;
 	}
-	COPY_TO_USER(rc, pData, &tracebuf[tracestrip],
-		      chunk * sizeof(tracebuf[0]) );
+	rc = copy_to_user(pData, &tracebuf[tracestrip],
+		          chunk * sizeof(tracebuf[0]) ) ? -EFAULT : 0;
 	tracestrip += chunk;
 	tracewrap = 0;
 
-	PUT_USER(rc, tracestrip, ++pIndex );
-	PUT_USER(rc, tracestuff, ++pIndex );
+	rc = put_user(tracestrip, ++pIndex );
+	rc = put_user(tracestuff, ++pIndex );
 
 	return dumpcount;
 #else
@@ -3141,16 +2997,16 @@
 	case 13:
 		switch ( cmd ) {
 		case 64:	/* Driver - ip2stat */
-			PUT_USER(rc, ref_count, pIndex++ );
-			PUT_USER(rc, irq_counter, pIndex++  );
-			PUT_USER(rc, bh_counter, pIndex++  );
+			rc = put_user(ref_count, pIndex++ );
+			rc = put_user(irq_counter, pIndex++  );
+			rc = put_user(bh_counter, pIndex++  );
 			break;
 
 		case 65:	/* Board  - ip2stat */
 			if ( pB ) {
-				COPY_TO_USER(rc, (char*)arg, (char*)pB, sizeof(i2eBordStr) );
-				PUT_USER(rc, INB(pB->i2eStatus),
-					(ULONG*)(arg + (ULONG)(&pB->i2eStatus) - (ULONG)pB ) );
+				rc = copy_to_user((char*)arg, (char*)pB, sizeof(i2eBordStr) ) ? -EFAULT : 0;
+				rc = put_user(INB(pB->i2eStatus),
+					      (ULONG*)(arg + (ULONG)(&pB->i2eStatus) - (ULONG)pB ) );
 			} else {
 				rc = -ENODEV;
 			}
@@ -3161,7 +3017,7 @@
 				pCh = DevTable[cmd];
 				if ( pCh )
 				{
-					COPY_TO_USER(rc, (char*)arg, (char*)pCh, sizeof(i2ChanStr) );
+					rc = copy_to_user((char*)arg, (char*)pCh, sizeof(i2ChanStr) ) ? -EFAULT : 0;
 				} else {
 					rc = -ENODEV;
 				}
@@ -3176,60 +3032,60 @@
 		break;
 	case 3:	    // Trace device
 		if ( cmd == 1 ) {
-			PUT_USER(rc, iiSendPendingMail, pIndex++ );
-			PUT_USER(rc, i2InitChannels, pIndex++ );
-			PUT_USER(rc, i2QueueNeeds, pIndex++ );
-			PUT_USER(rc, i2QueueCommands, pIndex++ );
-			PUT_USER(rc, i2GetStatus, pIndex++ );
-			PUT_USER(rc, i2Input, pIndex++ );
-			PUT_USER(rc, i2InputFlush, pIndex++ );
-			PUT_USER(rc, i2Output, pIndex++ );
-			PUT_USER(rc, i2FlushOutput, pIndex++ );
-			PUT_USER(rc, i2DrainWakeup, pIndex++ );
-			PUT_USER(rc, i2DrainOutput, pIndex++ );
-			PUT_USER(rc, i2OutputFree, pIndex++ );
-			PUT_USER(rc, i2StripFifo, pIndex++ );
-			PUT_USER(rc, i2StuffFifoBypass, pIndex++ );
-			PUT_USER(rc, i2StuffFifoFlow, pIndex++ );
-			PUT_USER(rc, i2StuffFifoInline, pIndex++ );
-			PUT_USER(rc, i2ServiceBoard, pIndex++ );
-			PUT_USER(rc, serviceOutgoingFifo, pIndex++ );
-			// PUT_USER(rc, ip2_init, pIndex++ );
-			PUT_USER(rc, ip2_init_board, pIndex++ );
-			PUT_USER(rc, find_eisa_board, pIndex++ );
-			PUT_USER(rc, set_irq, pIndex++ );
-			PUT_USER(rc, ip2_interrupt, pIndex++ );
-			PUT_USER(rc, ip2_poll, pIndex++ );
-			PUT_USER(rc, service_all_boards, pIndex++ );
-			PUT_USER(rc, do_input, pIndex++ );
-			PUT_USER(rc, do_status, pIndex++ );
+			rc = put_user(iiSendPendingMail, pIndex++ );
+			rc = put_user(i2InitChannels, pIndex++ );
+			rc = put_user(i2QueueNeeds, pIndex++ );
+			rc = put_user(i2QueueCommands, pIndex++ );
+			rc = put_user(i2GetStatus, pIndex++ );
+			rc = put_user(i2Input, pIndex++ );
+			rc = put_user(i2InputFlush, pIndex++ );
+			rc = put_user(i2Output, pIndex++ );
+			rc = put_user(i2FlushOutput, pIndex++ );
+			rc = put_user(i2DrainWakeup, pIndex++ );
+			rc = put_user(i2DrainOutput, pIndex++ );
+			rc = put_user(i2OutputFree, pIndex++ );
+			rc = put_user(i2StripFifo, pIndex++ );
+			rc = put_user(i2StuffFifoBypass, pIndex++ );
+			rc = put_user(i2StuffFifoFlow, pIndex++ );
+			rc = put_user(i2StuffFifoInline, pIndex++ );
+			rc = put_user(i2ServiceBoard, pIndex++ );
+			rc = put_user(serviceOutgoingFifo, pIndex++ );
+			// rc = put_user(ip2_init, pIndex++ );
+			rc = put_user(ip2_init_board, pIndex++ );
+			rc = put_user(find_eisa_board, pIndex++ );
+			rc = put_user(set_irq, pIndex++ );
+			rc = put_user(ip2_interrupt, pIndex++ );
+			rc = put_user(ip2_poll, pIndex++ );
+			rc = put_user(service_all_boards, pIndex++ );
+			rc = put_user(do_input, pIndex++ );
+			rc = put_user(do_status, pIndex++ );
 #ifndef IP2DEBUG_OPEN
-			PUT_USER(rc, 0, pIndex++ );
+			rc = put_user(0, pIndex++ );
 #else
-			PUT_USER(rc, open_sanity_check, pIndex++ );
+			rc = put_user(open_sanity_check, pIndex++ );
 #endif
-			PUT_USER(rc, ip2_open, pIndex++ );
-			PUT_USER(rc, ip2_close, pIndex++ );
-			PUT_USER(rc, ip2_hangup, pIndex++ );
-			PUT_USER(rc, ip2_write, pIndex++ );
-			PUT_USER(rc, ip2_putchar, pIndex++ );
-			PUT_USER(rc, ip2_flush_chars, pIndex++ );
-			PUT_USER(rc, ip2_write_room, pIndex++ );
-			PUT_USER(rc, ip2_chars_in_buf, pIndex++ );
-			PUT_USER(rc, ip2_flush_buffer, pIndex++ );
-
-			//PUT_USER(rc, ip2_wait_until_sent, pIndex++ );
-			PUT_USER(rc, 0, pIndex++ );
-
-			PUT_USER(rc, ip2_throttle, pIndex++ );
-			PUT_USER(rc, ip2_unthrottle, pIndex++ );
-			PUT_USER(rc, ip2_ioctl, pIndex++ );
-			PUT_USER(rc, set_modem_info, pIndex++ );
-			PUT_USER(rc, get_serial_info, pIndex++ );
-			PUT_USER(rc, set_serial_info, pIndex++ );
-			PUT_USER(rc, ip2_set_termios, pIndex++ );
-			PUT_USER(rc, ip2_set_line_discipline, pIndex++ );
-			PUT_USER(rc, set_params, pIndex++ );
+			rc = put_user(ip2_open, pIndex++ );
+			rc = put_user(ip2_close, pIndex++ );
+			rc = put_user(ip2_hangup, pIndex++ );
+			rc = put_user(ip2_write, pIndex++ );
+			rc = put_user(ip2_putchar, pIndex++ );
+			rc = put_user(ip2_flush_chars, pIndex++ );
+			rc = put_user(ip2_write_room, pIndex++ );
+			rc = put_user(ip2_chars_in_buf, pIndex++ );
+			rc = put_user(ip2_flush_buffer, pIndex++ );
+
+			//rc = put_user(ip2_wait_until_sent, pIndex++ );
+			rc = put_user(0, pIndex++ );
+
+			rc = put_user(ip2_throttle, pIndex++ );
+			rc = put_user(ip2_unthrottle, pIndex++ );
+			rc = put_user(ip2_ioctl, pIndex++ );
+			rc = put_user(set_modem_info, pIndex++ );
+			rc = put_user(get_serial_info, pIndex++ );
+			rc = put_user(set_serial_info, pIndex++ );
+			rc = put_user(ip2_set_termios, pIndex++ );
+			rc = put_user(ip2_set_line_discipline, pIndex++ );
+			rc = put_user(set_params, pIndex++ );
 		} else {
 			rc = -EINVAL;
 		}
--- linux-2.5.56/drivers/char/ip2.c.old	2003-01-11 09:09:16.000000000 +0100
+++ linux-2.5.56/drivers/char/ip2.c	2003-01-11 09:12:21.000000000 +0100
@@ -11,16 +11,6 @@
 #include <linux/init.h>
 #include <linux/wait.h>
 
-#ifndef __init
-#define __init
-#endif
-#ifndef __initfunc
-#define __initfunc(a) a
-#endif
-#ifndef __initdata
-#define __initdata
-#endif
-
 #include "./ip2/ip2types.h"		
 #include "./ip2/fip_firm.h"		// the meat
 
@@ -38,16 +28,14 @@
 
 static int poll_only = 0;
 
-#	if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,0)
-		MODULE_AUTHOR("Doug McNash");
-		MODULE_DESCRIPTION("Computone IntelliPort Plus Driver");
-		MODULE_PARM(irq,"1-"__MODULE_STRING(IP2_MAX_BOARDS) "i");
-		MODULE_PARM_DESC(irq,"Interrupts for IntelliPort Cards");
-		MODULE_PARM(io,"1-"__MODULE_STRING(IP2_MAX_BOARDS) "i");
-		MODULE_PARM_DESC(io,"I/O ports for IntelliPort Cards");
-		MODULE_PARM(poll_only,"1i");
-		MODULE_PARM_DESC(poll_only,"Do not use card interrupts");
-#	endif	/* LINUX_VERSION */
+MODULE_AUTHOR("Doug McNash");
+MODULE_DESCRIPTION("Computone IntelliPort Plus Driver");
+MODULE_PARM(irq,"1-"__MODULE_STRING(IP2_MAX_BOARDS) "i");
+MODULE_PARM_DESC(irq,"Interrupts for IntelliPort Cards");
+MODULE_PARM(io,"1-"__MODULE_STRING(IP2_MAX_BOARDS) "i");
+MODULE_PARM_DESC(io,"I/O ports for IntelliPort Cards");
+MODULE_PARM(poll_only,"1i");
+MODULE_PARM_DESC(poll_only,"Do not use card interrupts");
 
 
 //======================================================================
@@ -88,9 +76,6 @@
 
 #else	// !MODULE 
 
-#ifndef NULL
-# define NULL		((void *) 0)
-#endif
 
 /******************************************************************************
  *	ip2_setup:
@@ -144,9 +129,7 @@
 	return ip2_loadmain(io,irq,(unsigned char *)fip_firm,sizeof(fip_firm));
 }
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,13))
 __setup("ip2=", ip2_setup);
 __initcall(ip2_init);
-#endif
 
 #endif /* !MODULE */
--- linux-2.5.56/drivers/char/ip2/i2lib.c.old	2003-01-11 09:53:11.000000000 +0100
+++ linux-2.5.56/drivers/char/ip2/i2lib.c	2003-01-11 09:54:59.000000000 +0100
@@ -1091,8 +1091,8 @@
 
 			// Move the data
 			if ( user ) {
-				COPY_FROM_USER(rc, (char*)(DATA_OF(pInsert)), pSource,
-						amountToMove );
+				rc = copy_from_user( (char*)(DATA_OF(pInsert)), pSource,
+						     amountToMove ) ? -EFAULT : 0;
 			} else {
 				memcpy( (char*)(DATA_OF(pInsert)), pSource, amountToMove );
 			}


