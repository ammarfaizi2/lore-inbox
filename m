Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266543AbUIIRlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUIIRlG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 13:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUIIRgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:36:25 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:20241 "EHLO
	cyclades.com.br") by vger.kernel.org with ESMTP id S266366AbUIIR2e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:28:34 -0400
Subject: Cyclades assynchronous driver - implementing sysfs and bug
	correction
From: Germano Barreiro <germano.barreiro@cyclades.com>
Reply-To: germano.barreiro@cyclades.com
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Content-Type: multipart/mixed; boundary="=-O12qk7fdC78EJgI+wuYA"
Organization: Cyclades do Brasil
Message-Id: <1094751011.3348.18.camel@germano.cyclades.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 09 Sep 2004 14:30:12 -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-O12qk7fdC78EJgI+wuYA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

This patch implements sysfs support and corrects a bug in the cyclades
assynchronous card driver and is intended for review.

Regards,
Germano




--=-O12qk7fdC78EJgI+wuYA
Content-Disposition: attachment; filename=cyc-boardsYZ.patch
Content-Type: text/x-patch; name=cyc-boardsYZ.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- a/drivers/char/cyclades.c	2004-08-20 11:19:20.000000000 -0300
+++ b/drivers/char/cyclades.c	2004-09-08 10:56:31.000000000 -0300
@@ -2,7 +2,7 @@
 #define	Z_WAKE
 #undef	Z_EXT_CHARS_IN_BUFFER
 static char rcsid[] =
-"$Revision: 2.3.2.20 $$Date: 2004/02/25 18:14:16 $";
+"$Revision: 1.7 $$Date: 2004/09/03 22:55:55 $";
 
 /*
  *  linux/drivers/char/cyclades.c
@@ -25,6 +25,27 @@
  * This version supports shared IRQ's (only for PCI boards).
  *
  * $Log: cyclades.c,v $
+ * Revision 1.7  2004/09/03 22:55:55  germano
+ * made the module read the correct number of boards from the firmware when using a Z board
+ *
+ * Revision 1.6  2004/09/02 13:10:51  germano
+ * gave a more correct name to the function that exports information under /sys/device
+ *
+ * Revision 1.5  2004/09/01 21:38:23  germano
+ * old procfs code ported to new sysfs
+ *
+ * Revision 1.4  2004/08/30 18:46:05  germano
+ * new try to implement sysfs for async
+ *
+ * Revision 1.1  2004/08/27 20:55:55  germano
+ * sysfs work on async
+ *
+ * Revision 1.2  2004/08/26 20:30:11  germano
+ * daily global commit
+ *
+ * Revision 1.1  2004/08/20 20:13:19  germano
+ * started sysfs support coding
+ *
  * Prevent users from opening non-existing Z ports.
  *
  * Revision 2.3.2.8   2000/07/06 18:14:16 ivan
@@ -646,13 +667,13 @@
 #include <linux/string.h>
 #include <linux/fcntl.h>
 #include <linux/ptrace.h>
-#include <linux/cyclades.h>
 #include <linux/mm.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 
+
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -676,6 +697,7 @@
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
 
+#include <linux/cyclades.h>
 static void cy_throttle (struct tty_struct *tty);
 static void cy_send_xchar (struct tty_struct *tty, char ch);
 
@@ -700,6 +722,7 @@
 
 #define	JIFFIES_DIFF(n, j)	((j) - (n))
 
+static char _version[80];
 static struct tty_driver *cy_serial_driver;
 
 #ifdef CONFIG_ISA
@@ -850,6 +873,9 @@
 			};
 #endif
 
+
+
+
 static void cy_start(struct tty_struct *);
 static void set_line_char(struct cyclades_port *);
 static int cyz_issue_cmd(struct cyclades_card *, uclong, ucchar, uclong);
@@ -2528,6 +2554,13 @@
   int retval, line;
   unsigned long page;
 
+  uclong numberports=0;
+
+  /* these were included to make the necessary code for this
+     module to report the correct number of ports when using a Z-board */
+  struct ZFW_CTRL *zfw_ctrl;
+  struct BOARD_CTRL *board_ctrl;
+  
     line = tty->index;
     if ((line < 0) || (NR_PORTS <= line)){
         return -ENODEV;
@@ -2546,6 +2579,14 @@
 	struct FIRM_ID *firm_id = (struct FIRM_ID *)
         	(cinfo->base_addr + ID_ADDRESS);
 
+        /* find out the number of ports registered by the firmware*/
+   	zfw_ctrl = (struct ZFW_CTRL *)(cy_card[info->card].base_addr + (cy_readl(&firm_id->zfwctrl_addr) & 0xfffff));
+        board_ctrl = &(zfw_ctrl->board_ctrl);
+        numberports = cy_readl(&board_ctrl->n_channel); 
+        
+	/* prints the port opened together with the number of ports for that board */
+	printk(KERN_INFO "Opening port %d of %lu in this board\n",line,numberports);
+
         if (!ISZLOADED(*cinfo)) {
 	    if (((ZE_V1 ==cy_readl(&((struct RUNTIME_9060 *)
 		(cinfo->ctl_addr))->mail_box_0)) &&
@@ -2647,9 +2688,12 @@
     info->throttle = 0;
 
 #ifdef CY_DEBUG_OPEN
-    printk(" cyc:cy_open done\n");/**/
+    printk(" cyc:cy_open done\n");
 #endif
-
+    /*records line struct pointer for recovering when reading sysfs*/
+    cy_card[info->card].pdev->dev.driver_data=info; 
+   
+    device_create_file(&(cy_card[info->card].pdev->dev), &_cydas[line]);            
     return 0;
 } /* cy_open */
 
@@ -2874,6 +2918,7 @@
 #endif
 
     CY_UNLOCK(info, flags);
+    device_remove_file(&cy_card[info->card].pdev->dev, &_cydas[info->line]);
     return;
 } /* cy_close */
 
@@ -4831,6 +4876,13 @@
   uclong		Ze_phys0[NR_CARDS], Ze_phys2[NR_CARDS];
   unsigned char		Ze_irq[NR_CARDS];
   struct pci_dev	*Ze_pdev[NR_CARDS];
+  uclong numberports=0;
+
+  /* these were included to make the necessary code for this
+     module to report the correct number of ports when using a Z-board */
+  struct FIRM_ID *firm_id;
+  struct ZFW_CTRL *zfw_ctrl;
+  struct BOARD_CTRL *board_ctrl;
 
         for (i = 0; i < NR_CARDS; i++) {
                 /* look for a Cyclades card by vendor and device id */
@@ -5152,6 +5204,7 @@
 
                 printk("%d channels starting from port %d.\n",
 		    cy_pci_nchan,cy_next_channel);
+
                 cy_next_channel += cy_pci_nchan;
 	    }
         }
@@ -5225,10 +5278,16 @@
                 cy_card[j].ctl_addr = cy_pci_addr0;
                 cy_card[j].irq = (int) cy_pci_irq;
                 cy_card[j].bus_index = 1;
-                cy_card[j].first_line = cy_next_channel;
+		cy_card[j].first_line = cy_next_channel;
                 cy_card[j].num_chips = -1;
 		cy_card[j].pdev = pdev;
 
+                /* find out the number of ports registered by the firmware*/
+                firm_id = (struct FIRM_ID *)(cy_pci_addr2 + ID_ADDRESS);
+   		zfw_ctrl = (struct ZFW_CTRL *)(cy_pci_addr2 + (cy_readl(&firm_id->zfwctrl_addr) & 0xfffff));
+                board_ctrl = &(zfw_ctrl->board_ctrl);
+                numberports = cy_readl(&board_ctrl->n_channel); 
+
                 /* print message */
 #ifdef CONFIG_CYZ_INTR
 		/* don't report IRQ if board is no IRQ */
@@ -5243,8 +5302,6 @@
 			j+1,(ulong)cy_pci_phys2,
 			(ulong)(cy_pci_phys2 + CyPCI_Ze_win - 1));
 
-                printk("%d channels starting from port %d.\n",
-		    cy_pci_nchan,cy_next_channel);
                 cy_next_channel += cy_pci_nchan;
         }
 	if (ZeIndex != 0) {
@@ -5276,6 +5333,8 @@
         rcsvers, rcsdate);
     printk("        built %s %s\n",
 	__DATE__, __TIME__);
+    /* _version is later used by show_sys_data */
+    sprintf(_version,"Cyclades driver %s %s\n         built %s %s\n", rcsvers, rcsdate, __DATE__, __TIME__);
 } /* show_version */
 
 static int 
@@ -5386,8 +5445,9 @@
   unsigned long mailbox;
   unsigned short chip_number;
   int nports;
-
+ 
     cy_serial_driver = alloc_tty_driver(NR_PORTS);
+    
     if (!cy_serial_driver)
 	return -ENOMEM;
     show_version();
@@ -5668,4 +5728,275 @@
 } /* cy_setup */
 #endif /* MODULE */
 
+/*****************************************************************************************************
+ SYSFS SUPPORT FUNCTIONS
+ Germano Barreiro - 2/09/2004
+ ****************************************************************************************************/
+
+ /***************************************************************************************************
+  show_sys_data - shows the data exported to sysfs/device, mostly the signals status involved in the
+  serial communication such as CTS,RTS,DTS,etc
+  This function is called by the kernel whenever any user mode process tries to read a file created
+  in the virtual filesystem /sys/device/.../ttyC?
+  The code internal to this function, with few changes, was extracted from the original procfs 
+  implementation in the cyclades async serial driver, made by Ivan. 
+
+  p - points to the struct device associated with this channel. Besides some other potentially useful
+      information for future debugging tasks, cy_open() saves there a pointer to the cyclades_port
+      associated with this channel, which in recovered in this function.
+  buf - points to the buffer where the data to be available in the file mentioned above must be written
+
+  Returns the number of bytes written to user space 
+  ***************************************************************************************************/
+ static ssize_t show_sys_data(struct device *p, char *buf)
+ {  
+     
+	int len, z;
+	int	flow; // 0:none, 1:soft ctr, 2: hard ctr
+	int chip;
+        //cy_open recorded the cyclades_port pointer here
+	struct cyclades_port *info = p->driver_data;
+        //ind will be an index to the cyclades_port struct associated to this device in the array cy_port[]
+        int ind = info - cy_port; 
+	struct tty_struct * tty = info->tty;
+	unsigned char *base_addr = (unsigned char *) cy_card[info->card].base_addr;
+	struct FIRM_ID *firm_id = (struct FIRM_ID *) (base_addr + ID_ADDRESS);
+	struct ZFW_CTRL *zfw_ctrl = (struct ZFW_CTRL *) (base_addr + (cy_readl(&firm_id->zfwctrl_addr) & 0xfffff));
+	struct CH_CTRL *ch_ctrl = zfw_ctrl->ch_ctrl;
+	struct BUF_CTRL *buf_ctrl = &(zfw_ctrl->buf_ctrl[ind - cy_card[info->card].first_line]);
+	int card = info->card;
+	int channel = (info->line) - (cy_card[card].first_line);
+	int index = cy_card[card].bus_index;
+	uclong control;
+
+        //refer to cyclades.h to many of the symbols below	
+	if ( tty == 0 ) {
+		len = sprintf(buf, "%s:%s\n", cysys_state, cysys_close);
+		return len;
+	} 
+	len = sprintf(buf, "%s:%s\n", cysys_state, cysys_open);
+	
+	//Printing tty and board type
+	if (IS_CYC_Z(cy_card[card])) {
+		z = 1;
+		len += sprintf(buf+len, "%s:%s\n", cysys_ct, cysys_z);
+	} else {
+		z = 0;
+		len += sprintf(buf+len, "%s:%s\n", cysys_ct, cysys_y);
+	}
+		
+	//Printing the baud rate	
+	len += sprintf(buf+len, "%s:%d\n", cysys_baud, tty_get_baud_rate(tty) );
+	
+	//Printing the flow control type
+	if (I_IXOFF(tty)) { 
+		flow = 1;	
+		len += sprintf(buf+len, "%s:%s\n", cysys_fc, cysys_fc_soft);
+	} else if ( C_CRTSCTS(tty) ) {
+		flow = 2;	
+		len += sprintf(buf+len, "%s:%s\n", cysys_fc, cysys_fc_hard);
+	} else {
+		flow = 0;	
+		len += sprintf(buf+len, "%s:%s\n", cysys_fc, cysys_fc_none);
+	}
+		
+	//printing the flow status
+	if (z == 1) { 					// Cyclades-Z board
+		if ( flow == 2 ) { 			//hard flow control
+			uclong control = cy_readl(&ch_ctrl[channel].rs_status);
+			if (control & C_RS_RTS) {
+				len += sprintf(buf+len, "%s:%s\n", cysys_rxfcs, cysys_on);
+			} else {
+				len += sprintf(buf+len, "%s:%s\n", cysys_rxfcs, cysys_off);
+			}	
+			
+			if (control & C_RS_CTS) {
+				len += sprintf(buf+len, "%s:%s\n", cysys_txfcs, cysys_on);
+			} else {
+				len += sprintf(buf+len, "%s:%s\n", cysys_txfcs, cysys_off);
+			}
+		} else if (flow == 1) { 	//soft flow control
+			// Fix me. Find how to discover the software flow control state
+		}
+	} else {						// Cyclades-Y board
+		uclong aux;
+		chip = channel >> 2;
+		channel &= 0x03;
+		base_addr = (unsigned char *)(cy_card[card].base_addr
+					 + (cy_chip_offset[chip] << index));
+		
+		if ( flow == 1 ) {			// Software flow control
+			/*			
+			int ccsr;	
+ 			unsigned long flags;
+			CY_LOCK(info, flags);
+			cy_writeb((u_long) base_addr + (CyCAR << index), (u_char) channel);
+			ccsr = cy_readb((u_long) base_addr + (CyCCSR << index));
+			CY_UNLOCK(info, flags);
+			len += sprintf(buf+len, "ccsr:%x\n", ccsr);
+			*/
+			// Fix me. It seems the CCSR register is not responding properly
+		}
+
+		if ( flow == 2 ) {			// Hardware flow control
+			uclong control = cy_readb((u_long) base_addr + (CyMSVR1 << index));
+
+			if (info->rtsdtr_inv) {
+				aux = CyDTR;
+			} else {
+				aux = CyRTS;
+			}
+			
+			if (control & aux) {
+				len += sprintf(buf+len, "%s:%s\n", cysys_rxfcs, cysys_on);
+			} else {
+				len += sprintf(buf+len, "%s:%s\n", cysys_rxfcs, cysys_off);
+			}	
+		}
+	}
+
+	//Printing status of the signals: DCD, DSR, CTS, RTS, DTR
+	if (z == 1) {					// Cyclades-Z board
+		control = cy_readl(&ch_ctrl[channel].rs_status);
+	} else {
+		control = cy_readb((u_long) base_addr + (CyMSVR1 << index));
+	}
+	
+	// DCD status
+	len += sprintf(buf+len, "%s:%s\n", cysys_dcd, 
+			   (control & (z ? C_RS_DCD:CyDCD) ) ? cysys_on : cysys_off);
+
+	// DSR Status
+	len += sprintf(buf+len, "%s:%s\n", cysys_dsr, 
+			   (control & (z ? C_RS_DSR:CyDSR) ) ? cysys_on : cysys_off);
+
+	// CTS status
+	len += sprintf(buf+len, "%s:%s\n", cysys_cts, 
+			   (control & (z ? C_RS_CTS:CyCTS) ) ? cysys_on : cysys_off);
+				
+	// RTS status
+	len += sprintf(buf+len, "%s:%s\n", cysys_rts, 
+			   (control & (z ? C_RS_RTS:CyRTS) ) ? cysys_on : cysys_off);
+
+	// DTR status
+	len += sprintf(buf+len, "%s:%s\n", cysys_dtr,
+                           (control & (z ? C_RS_DTR:(info->rtsdtr_inv ? CyRTS : CyDTR)) ) ? cysys_on : cysys_off);
+	
+	
+	//Printing status of tty buffer
+	len += sprintf(buf+len,"%s:%d/%d\n", cysys_ttyrxbuf, 
+					tty->read_cnt,N_TTY_BUF_SIZE);
+	len += sprintf(buf+len, "%s:%d/%ld\n", cysys_ttytxbuf, 
+					info->xmit_cnt, SERIAL_XMIT_SIZE);
+
+	//Printing the status of onboard buffer (for cyclades z only)
+	if ( z == 1) {
+		volatile uclong put, get, bufsize;
+		volatile int char_count;
+		//rx
+		get = cy_readl(&buf_ctrl->rx_get);
+		put = cy_readl(&buf_ctrl->rx_put);
+		bufsize = cy_readl(&buf_ctrl->rx_bufsize);
+		if (put >= get) {
+			char_count = put - get;
+		} else {
+			char_count = put - get + bufsize;
+		}
+		len += sprintf(buf+len, "%s:%d/%ld\n", cysys_boardrxbuf,
+						char_count, bufsize);
+
+		//tx
+		get = cy_readl(&buf_ctrl->tx_get);
+		put = cy_readl(&buf_ctrl->tx_put);
+		bufsize = cy_readl(&buf_ctrl->tx_bufsize);
+		if (put >= get) {
+			char_count = put - get;
+		} else {
+			char_count = put - get + bufsize;
+		}
+		len += sprintf(buf+len, "%s:%d/%ld\n", cysys_boardtxbuf,
+						char_count, bufsize);
+	}
+
+	//Printing communication data len
+	if (z == 1){
+		uclong data_len, pari;
+		char par;
+		int nstop, char_len;
+		
+		data_len = cy_readl(&ch_ctrl[channel].comm_data_l);
+		pari = cy_readl(&ch_ctrl[channel].comm_parity);
+
+		switch (pari) {
+			case C_PR_NONE:
+				par = 'n';
+				break;
+			case C_PR_ODD:
+				par = 'o';
+				break;
+			case C_PR_EVEN:
+				par = 'e';
+				break;
+			default:
+				par = 'n';
+				break;
+		}
+	
+		if ( data_len & C_DL_2STOP) {
+			nstop = 2;
+		} else {
+			nstop = 1;
+		}
+			
+		switch (data_len & 0x0f) {
+			case 1:
+				char_len = 5;
+				break;
+			case 2:
+				char_len = 6;
+				break;
+			case 4:
+				char_len = 7;
+				break;
+			case 8:
+				char_len = 8;
+				break;
+			default:
+				char_len = 8;
+				break;
+		}
+				
+		len += sprintf(buf+len, "%s:%d%c%d\n", cysys_charlen, 
+						char_len, par, nstop); 
+	} else {
+		int nstop;
+		char par;
+
+		switch ( info->cor1 & 0xc0) {
+			case CyPARITY_NONE:
+				par = 'n';
+				break;
+			case CyPARITY_O:
+				par = 'o';
+				break;
+			case CyPARITY_E:
+				par = 'e';
+				break;
+			default:
+				par = 'n';
+				break;
+		}
+
+		if ( info->cor1 & Cy_2_STOP) {
+			nstop = 2;
+		} else {
+			nstop = 1;
+		}
+		
+		len += sprintf(buf+len, "%s:%d%c%d\n", cysys_charlen, 
+						(info->cor1 & 0x03) + 5, par, nstop);
+	}	
+	return len;
+ }
+
 MODULE_LICENSE("GPL");
--- a/include/linux/cyclades.h	2004-08-20 11:19:26.000000000 -0300
+++ b/include/linux/cyclades.h	2004-09-02 17:18:41.000000000 -0300
@@ -1,4 +1,4 @@
-/* $Revision: 3.0 $$Date: 1998/11/02 14:20:59 $
+/* $Revision: 1.5 $$Date: 2004/09/02 20:18:41 $
  * linux/include/linux/cyclades.h
  *
  * This file was initially written by
@@ -7,6 +7,21 @@
  *
  * This file contains the general definitions for the cyclades.c driver
  *$Log: cyclades.h,v $
+ *Revision 1.5  2004/09/02 20:18:41  germano
+ *Changed CyMonitor and drivers to export the atributes names under /sys as cycser[0-255]. Corrected installation scripts to run propertly under 2.6 kernel.
+ *
+ *Revision 1.4  2004/09/02 13:10:51  germano
+ *gave a more correct name to the function that exports information under /sys/device
+ *
+ *Revision 1.3  2004/09/01 21:38:23  germano
+ *old procfs code ported to new sysfs
+ *
+ *Revision 1.2  2004/08/30 18:46:06  germano
+ *new try to implement sysfs for async
+ *
+ *Revision 1.1  2004/08/20 20:13:19  germano
+ *started sysfs support coding
+ *
  *Revision 3.1  2002/01/29 11:36:16  henrique
  *added throttle field on struct cyclades_port to indicate whether the
  *port is throttled or not
@@ -401,6 +416,43 @@
 #define	C_CM_FATAL	0x91		/* fatal error */
 #define	C_CM_HW_RESET	0x92		/* reset board */
 
+
+//strings
+char cysys_state[] = 		"State                 ";
+char cysys_open[] = "Open";
+char cysys_close[] = "Close";
+
+char cysys_ct[] = 			"Card Type             ";
+char cysys_z[] = "Cyclades Z";
+char cysys_y[] = "Cyclades Y";
+
+char cysys_baud[] = 		"Baud Rate             ";
+
+char cysys_fc[] = 			"Flow Control          ";
+char cysys_fc_soft[] = "software";
+char cysys_fc_hard[] = "hardware";
+char cysys_fc_none[] = "none";
+
+char cysys_rxfcs[] = 		"RX Flow Control Status";
+char cysys_txfcs[] = 		"TX Flow Control Status";
+
+char cysys_on[] = "on";
+char cysys_off[] = "off";
+
+char cysys_dcd[] = 		"DCD                   ";
+char cysys_dsr[] = 		"DSR                   ";
+char cysys_cts[] = 		"CTS                   ";
+char cysys_rts[] = 		"RTS                   ";
+char cysys_dtr[] = 		"DTR                   ";
+
+char cysys_ttyrxbuf[] = 	"TTY Rx Buffer         ";
+char cysys_ttytxbuf[] = 	"TTY Tx Buffer         ";
+
+char cysys_boardrxbuf[] = 	"On Board Rx Buffer    ";
+char cysys_boardtxbuf[] = 	"On Board Tx Buffer    ";
+
+char cysys_charlen[] = 	"Character Len         ";
+
 /*
  *	CH_CTRL - This per port structure contains all parameters
  *	that control an specific port. It can be seen as the
@@ -823,5 +875,267 @@
 
 /***************************************************************************/
 
+
+
+/*used for sysfs register purposes */
+static ssize_t show_sys_data(struct device *p, char *buf);
+
+struct device_attribute _cydas[]={\
+__ATTR(cycser0, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser1, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser2, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser3, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser4, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser5, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser6, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser7, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser8, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser9, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser10, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser11, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser12, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser13, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser14, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser15, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser16, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser17, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser18, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser19, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser20, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser21, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser22, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser23, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser24, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser25, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser26, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser27, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser28, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser29, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser30, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser31, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser32, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser33, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser34, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser35, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser36, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser37, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser38, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser39, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser40, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser41, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser42, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser43, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser44, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser45, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser46, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser47, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser48, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser49, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser50, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser51, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser52, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser53, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser54, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser55, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser56, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser57, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser58, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser59, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser60, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser61, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser62, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser63, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser64, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser65, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser66, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser67, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser68, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser69, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser70, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser71, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser72, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser73, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser74, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser75, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser76, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser77, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser78, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser79, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser80, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser81, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser82, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser83, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser84, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser85, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser86, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser87, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser88, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser89, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser90, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser91, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser92, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser93, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser94, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser95, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser96, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser97, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser98, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser99, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser100, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser101, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser102, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser103, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser104, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser105, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser106, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser107, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser108, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser109, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser110, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser111, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser112, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser113, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser114, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser115, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser116, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser117, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser118, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser119, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser120, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser121, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser122, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser123, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser124, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser125, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser126, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser127, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser128, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser129, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser130, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser131, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser132, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser133, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser134, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser135, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser136, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser137, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser138, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser139, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser140, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser141, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser142, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser143, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser144, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser145, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser146, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser147, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser148, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser149, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser150, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser151, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser152, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser153, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser154, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser155, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser156, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser157, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser158, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser159, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser160, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser161, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser162, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser163, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser164, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser165, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser166, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser167, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser168, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser169, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser170, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser171, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser172, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser173, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser174, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser175, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser176, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser177, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser178, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser179, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser180, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser181, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser182, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser183, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser184, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser185, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser186, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser187, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser188, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser189, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser190, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser191, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser192, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser193, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser194, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser195, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser196, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser197, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser198, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser199, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser200, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser201, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser202, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser203, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser204, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser205, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser206, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser207, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser208, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser209, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser210, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser211, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser212, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser213, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser214, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser215, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser216, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser217, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser218, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser219, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser220, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser221, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser222, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser223, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser224, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser225, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser226, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser227, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser228, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser229, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser230, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser231, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser232, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser233, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser234, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser235, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser236, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser237, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser238, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser239, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser240, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser241, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser242, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser243, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser244, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser245, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser246, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser247, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser248, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser249, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser250, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser251, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser252, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser253, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser254, S_IRUGO, show_sys_data, NULL),
+__ATTR(cycser255, S_IRUGO, show_sys_data, NULL)};
 #endif /* __KERNEL__ */
 #endif /* _LINUX_CYCLADES_H */

--=-O12qk7fdC78EJgI+wuYA--

