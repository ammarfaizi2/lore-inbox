Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbUJ1UHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbUJ1UHA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 16:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbUJ1UFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 16:05:55 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:44293 "EHLO
	cyclades.com.br") by vger.kernel.org with ESMTP id S262214AbUJ1T7J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 15:59:09 -0400
Subject: patch for sysfs in the cyclades driver
From: Germano Barreiro <germano.barreiro@cyclades.com>
Reply-To: germano.barreiro@cyclades.com
To: torvalds@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Wanda Rosalino <wanda.rosalino@cyclades.com>
Content-Type: multipart/mixed; boundary="=-SPxQhi/QsxS4jyDQ+ATY"
Organization: Cyclades do Brasil
Message-Id: <1098989790.6605.3.camel@germano.cyclades.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 28 Oct 2004 16:56:30 -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SPxQhi/QsxS4jyDQ+ATY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

This patch implements the sysfs support in the cyclades async driver,
which is needed by the Cyclades' CyMonitor application. It is based in
the last one sent (see copied message below), but implements the changes
asked for that patch by Greg (the array of attributes was eliminated and
now there is only one file for each value to be exported).
I hope it is ok to be applied now, but if more changes are needed I
would be pleased to listen about them. By the way, I'm grateful to
Marcelo for taking time to examining many "middle" versions of this
patch, and also to Greg for his comments to the last patch.

Kind regards,
Germano

========================================================================
From: Greg KH <greg@kroah.com>
Date: Tue, 28 Sep 2004 07:12:43 -0700
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
        germano.barreiro@cyclades.com
In-Reply-To: <20040928120421.GB11779@logos.cnet>
Subject: Re: [PATCH] cyclades.c sysfs statistics support
X-MIMETrack: Itemize by SMTP Server on USMail/Cyclades(Release
6.5.1|January 21, 2004) at
 09/28/2004 07:12:51

On Tue, Sep 28, 2004 at 09:04:21AM -0300, Marcelo Tosatti wrote:
> +    device_create_file(&(cy_card[info->card].pdev->dev),
&_cydas[line]);            

Why the array of attributes?  As you only have one (which is wrong...)
you only need one attribute structure.

> +  show_sys_data - shows the data exported to sysfs/device, mostly the
signals status involved in the
> +  serial communication such as CTS,RTS,DTS,etc

NO!  sysfs is 1 value per file.  Not a whole bunch of values per one
file.  Please change this to create a whole bunch of little files, not
one big one.

thanks,

greg k-h

-- End forwarded message --
=================================================================================================








--=-SPxQhi/QsxS4jyDQ+ATY
Content-Disposition: attachment; filename=sysfs-2.6.10rc1.patch
Content-Type: text/x-patch; name=sysfs-2.6.10rc1.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.6.10rc1.orig/drivers/char/cyclades.c	2004-10-25 16:40:00.000000000 -0200
+++ linux-2.6.10rc1/drivers/char/cyclades.c	2004-10-26 17:13:20.000000000 -0200
@@ -646,6 +646,7 @@ static char rcsid[] =
 #include <linux/string.h>
 #include <linux/fcntl.h>
 #include <linux/ptrace.h>
+#include <linux/device.h>
 #include <linux/cyclades.h>
 #include <linux/mm.h>
 #include <linux/ioport.h>
@@ -700,8 +701,36 @@ static void cy_send_xchar (struct tty_st
 
 #define	JIFFIES_DIFF(n, j)	((j) - (n))
 
+static char _version[150];
 static struct tty_driver *cy_serial_driver;
 
+
+const static char sysufixes[18][10]={"stat","card","baud","flow","rxfl","txfl","dcd","dsr","cts",
+                                     "rts","dtr","rx","tx","bdrx","bdtx","par","stop","chlen"};
+
+ssize_t (*showfunctions[])(struct device *, char *)={
+	show_sys_stat,
+	show_sys_card,
+	show_sys_baud,
+	show_sys_flow,
+	show_sys_rxfl,
+	show_sys_txfl,
+	show_sys_dcd,
+	show_sys_dsr,
+	show_sys_cts,
+	show_sys_rts,
+	show_sys_dtr,
+	show_sys_rx,
+	show_sys_tx,
+	show_sys_bdrx,
+	show_sys_bdtx,
+	show_sys_par,
+	show_sys_stop,
+	show_sys_chlen
+};
+
+
+
 #ifdef CONFIG_ISA
 /* This is the address lookup table. The driver will probe for
    Cyclom-Y/ISA boards at all addresses in here. If you want the
@@ -2621,9 +2650,12 @@ cy_open(struct tty_struct *tty, struct f
     info->throttle = 0;
 
 #ifdef CY_DEBUG_OPEN
-    printk(" cyc:cy_open done\n");/**/
+    printk(" cyc:cy_open done\n");
 #endif
+    /*records line struct pointer for recovering when reading sysfs*/
+    cy_card[info->card].pdev->dev.driver_data=info; 
 
+    createsysfiles(info); //create the sys files associated with this channel
     return 0;
 } /* cy_open */
 
@@ -2837,6 +2869,7 @@ cy_close(struct tty_struct *tty, struct 
 #endif
 
     CY_UNLOCK(info, flags);
+    removesysfiles(info);
     return;
 } /* cy_close */
 
@@ -5154,18 +5187,18 @@ cy_detect_pci(void)
  * This routine prints out the appropriate serial driver version number
  * and identifies which options were configured into this driver.
  */
-static inline void
-show_version(void)
+static inline void show_version(void)
 {
-  char *rcsvers, *rcsdate, *tmp;
-    rcsvers = strchr(rcsid, ' '); rcsvers++;
-    tmp = strchr(rcsvers, ' '); *tmp++ = '\0';
-    rcsdate = strchr(tmp, ' '); rcsdate++;
-    tmp = strrchr(rcsdate, ' '); *tmp = '\0';
-    printk("Cyclades driver %s %s\n",
-        rcsvers, rcsdate);
-    printk("        built %s %s\n",
-	__DATE__, __TIME__);
+	char *rcsvers, *rcsdate, *tmp;
+	rcsvers = strchr(rcsid, ' '); rcsvers++;
+	tmp = strchr(rcsvers, ' '); *tmp++ = '\0';
+	rcsdate = strchr(tmp, ' '); rcsdate++;
+	tmp = strrchr(rcsdate, ' '); *tmp = '\0';
+	printk("Cyclades driver %s %s\n", rcsvers, rcsdate);
+	printk("        built %s %s\n", __DATE__, __TIME__);
+	/* _version is later used by show_sys_data */
+	snprintf(_version, sizeof(_version), "Cyclades driver %s %s\n         built %s %s\n", 
+			rcsvers, rcsdate, __DATE__, __TIME__);
 } /* show_version */
 
 static int 
@@ -5558,4 +5591,456 @@ cy_setup(char *str, int *ints)
 } /* cy_setup */
 #endif /* MODULE */
 
+/*****************************************************************************************************
+ SYSFS SUPPORT FUNCTIONS
+ Germano Barreiro - 2/09/2004
+ ****************************************************************************************************/
+
+static ssize_t show_sys_stat(struct device *p, char *buf) //exports status of the port
+{ 
+ 	return get_sys_data(p, buf, STAT);
+}
+
+static ssize_t show_sys_card(struct device *p, char *buf) //exports card type information
+{
+ 	return get_sys_data(p, buf, CARD);
+}
+
+static ssize_t show_sys_baud(struct device *p, char *buf) //exports baud rate configuration
+{
+ 	return get_sys_data(p, buf, BAUD);
+}
+
+static ssize_t show_sys_flow(struct device *p, char *buf) //exports flow control type
+{
+ 	return get_sys_data(p, buf, FLOW);
+}
+
+static ssize_t show_sys_rxfl(struct device *p, char *buf) //exports rx flow control status
+{
+ 	return get_sys_data(p, buf, RXFL);
+}
+
+static ssize_t show_sys_txfl(struct device *p, char *buf) //exports tx flow control status
+{
+ 	return get_sys_data(p, buf, TXFL);
+}
+
+static ssize_t show_sys_dcd(struct device *p, char *buf) //exports dcd signal
+{
+ 	return get_sys_data(p, buf, DCD);
+}
+
+static ssize_t show_sys_dsr(struct device *p, char *buf) //exports dsr signal
+{
+ 	return get_sys_data(p, buf, DSR);
+}
+
+static ssize_t show_sys_cts(struct device *p, char *buf) //exports cts signal
+{
+ 	return get_sys_data(p, buf, CTS);
+}
+
+static ssize_t show_sys_rts(struct device *p, char *buf) //exports rts signal
+{
+ 	return get_sys_data(p, buf, RTS);
+}
+
+static ssize_t show_sys_dtr(struct device *p, char *buf) //exports dtr signal
+{
+ 	return get_sys_data(p, buf, DTR);
+}
+
+static ssize_t show_sys_rx(struct device *p, char *buf) //exports rx buffer size
+{
+ 	return get_sys_data(p, buf, RX);
+}
+
+static ssize_t show_sys_tx(struct device *p, char *buf) //exports tx buffer size
+{
+ 	return get_sys_data(p, buf, TX);
+}
+
+static ssize_t show_sys_bdrx(struct device *p, char *buf) //exports board rx buffer size (z board only)
+{
+ 	return get_sys_data(p, buf, BDRX);
+}
+
+static ssize_t show_sys_bdtx(struct device *p, char *buf) //exports board tx buffer size (z board only)
+{
+ 	return get_sys_data(p, buf, BDTX);
+}
+
+static ssize_t show_sys_par(struct device *p, char *buf) //exports parity configuration
+{
+ 	return get_sys_data(p, buf, PAR);
+}
+
+static ssize_t show_sys_stop(struct device *p, char *buf) //exports stop bits configuration
+{
+ 	return get_sys_data(p, buf, STOP);
+}
+
+static ssize_t show_sys_chlen(struct device *p, char *buf) //exports word size configuration
+{
+ 	return get_sys_data(p, buf, CHLEN);
+}
+
+
+/* this function creates the sys files that will export each signal status to sysfs 
+   each value will be put in a separate filename */
+static void createsysfiles(struct cyclades_port *port)
+{
+	enum tserinfo index;
+	for(index=STAT; index<=CHLEN; index++){
+		sprintf(port->sysdata.sysnames[index],"cycser%d_%s",port->line,sysufixes[index]); 
+		port->sysdata.cydas[index].attr.name = port->sysdata.sysnames[index];
+		port->sysdata.cydas[index].attr.mode = S_IRUGO;
+		port->sysdata.cydas[index].attr.owner = THIS_MODULE;
+		port->sysdata.cydas[index].show  =  showfunctions[index];
+		port->sysdata.cydas[index].store = NULL;
+		device_create_file(&(cy_card[port->card].pdev->dev), &port->sysdata.cydas[index]);            
+	}
+}
+ 
+/* removes all the sys files created for that port */
+static void removesysfiles(struct cyclades_port *port){
+	enum tserinfo index;
+	for(index=STAT; index <= CHLEN; index++)
+		device_remove_file(&cy_card[port->card].pdev->dev, &port->sysdata.cydas[index]);
+}
+
+/*******************************************************************************************************
+  get_sys_data - get the data to be exported to sysfs/device, mostly the signals status involved in the
+  serial communication such as CTS,RTS,DTS,etc as well as some config info.
+  This funcion is called by each specific function that exports to the sys virtual filesystem
+  values about signals and states related to each serial port of the card.
+  The code internal to this function, with few changes, was extracted from the original procfs 
+  implementation in the cyclades async serial driver, made by Ivan. 
+
+  p - points to the struct device associated with this channel. Besides some other potentially useful
+      information for future debugging tasks, cy_open() saves there a pointer to the cyclades_port
+      associated with this channel, which in recovered in this function.
+  buf - points to the buffer where the data to be available in the file mentioned above must be written
+  whatinfo - the information asked. To see all possible values, look at cyclades.h where the definition
+             of this enum is.
+
+  Returns the number of bytes written to buf 
+********************************************************************************************************/
+static ssize_t get_sys_data(struct device *p, char *buf, enum tserinfo whatinfo)
+{  
+	int len=0, z=0;
+	int	flow=0; // 0:none, 1:soft ctr, 2: hard ctr
+	int chip;
+	//cy_open recorded the cyclades_port pointer here
+	struct cyclades_port *info = p->driver_data;
+	//ind will be an index to the cyclades_port struct associated to this device in the array cy_port[]
+	int ind = info - cy_port; 
+
+	struct tty_struct * tty = info->tty;
+	unsigned char *base_addr = (unsigned char *) cy_card[info->card].base_addr;
+	struct FIRM_ID *firm_id = (struct FIRM_ID *) (base_addr + ID_ADDRESS);
+	struct ZFW_CTRL *zfw_ctrl = (struct ZFW_CTRL *) \
+					(base_addr + (cy_readl(&firm_id->zfwctrl_addr) & 0xfffff));
+
+	struct CH_CTRL *ch_ctrl = zfw_ctrl->ch_ctrl;
+	struct BUF_CTRL *buf_ctrl = &(zfw_ctrl->buf_ctrl[ind - cy_card[info->card].first_line]);
+	int card = info->card;
+	int channel = (info->line) - (cy_card[card].first_line);
+	int index = cy_card[card].bus_index;
+	uclong control;
+	char par;
+	int nstop; //number of stop bits
+	int char_len; //size of the word
+
+	//verifies if it is a z board
+	if (IS_CYC_Z(cy_card[card])) z = 1;
+
+	//checks if it is being used soft or hardware flow control
+	if (I_IXOFF(tty))  flow = 1;	
+	else if ( C_CRTSCTS(tty) ) flow = 2;	
+	else flow = 0;	
+   
+	//necessary for printing status of the signals: DCD, DSR, CTS, RTS, DTR
+	if (z == 1) {// Cyclades-Z board
+		control = cy_readl(&ch_ctrl[channel].rs_status);
+	} else {
+		control = cy_readb((u_long) base_addr + (CyMSVR1 << index));
+	}
+	
+        switch(whatinfo){
+
+		case STAT: //open/closed
+			if ( tty == 0 ) 
+				len = sprintf(buf, "%s:%s\n", cysys_state, cysys_close);
+			else
+				len = sprintf(buf, "%s:%s\n", cysys_state, cysys_open);
+		break;
+
+		case CARD: //card type
+			if (z) //it's a z-card 
+				len += sprintf(buf, "%s:%s\n", cysys_ct, cysys_z);
+			else 
+				len += sprintf(buf, "%s:%s\n", cysys_ct, cysys_y);
+		break;
+
+		case BAUD: //baud rate
+			len += sprintf(buf, "%s:%d\n", cysys_baud, tty_get_baud_rate(tty) );
+		break;
+
+		case FLOW: //flow control type
+			if (flow==1)  
+				len += sprintf(buf, "%s:%s\n", cysys_fc, cysys_fc_soft);
+			else if (flow==2)
+				len += sprintf(buf, "%s:%s\n", cysys_fc, cysys_fc_hard);
+			else 
+				len += sprintf(buf, "%s:%s\n", cysys_fc, cysys_fc_none);
+		break;
+
+		case RXFL: //rx hardware flow control status
+
+			if (z == 1) {// Cyclades-Z board
+				if (control & C_RS_RTS) {
+					len += sprintf(buf, "%s:%s\n", cysys_rxfcs, cysys_on);
+				} else {
+					len += sprintf(buf, "%s:%s\n", cysys_rxfcs, cysys_off);
+				}	
+			
+			} else {// Cyclades-Y board
+				len += get_rxfl_y(buf,info);
+			}
+		break;
+
+ 		case TXFL: //hardware tx flow control
+
+			if (z == 1){// Cyclades-Z board
+				uclong control = cy_readl(&ch_ctrl[channel].rs_status);
+			
+				if (control & C_RS_CTS) {
+					len += sprintf(buf, "%s:%s\n", cysys_txfcs, cysys_on);
+				} else {
+					len += sprintf(buf, "%s:%s\n", cysys_txfcs, cysys_off);
+				}
+			} else {// Cyclades-Y board
+				uclong aux;
+				chip = channel >> 2;
+				channel &= 0x03;
+				base_addr = (unsigned char *)(cy_card[card].base_addr
+							 + (cy_chip_offset[chip] << index));
+				uclong control = cy_readb((u_long) base_addr + (CyMSVR1 << index));
+				if (info->rtsdtr_inv) {
+					aux = CyDTR;
+				} else {
+					aux = CyRTS;
+				}
+				if (control & aux) {
+					len += sprintf(buf, "%s:%s\n", cysys_rxfcs, cysys_on);
+				} else {
+					len += sprintf(buf, "%s:%s\n", cysys_rxfcs, cysys_off);
+				}	
+			}
+		break;
+
+
+        	case DCD: //DCD status
+			len += sprintf(buf, "%s:%s\n", cysys_dcd,
+		                 (control & (z ? C_RS_DCD:CyDCD) ) ? cysys_on : cysys_off);
+		break;				   
+		
+		case DSR: //DSR status
+	        	len += sprintf(buf, "%s:%s\n", cysys_dsr,
+		                 (control & (z ? C_RS_DSR:CyDSR) ) ? cysys_on : cysys_off);
+	        break;
+
+		case CTS: //CTS status
+	        	len += sprintf(buf, "%s:%s\n", cysys_cts,
+		                 (control & (z ? C_RS_CTS:CyCTS) ) ? cysys_on : cysys_off);
+		break;
+	
+		case RTS: //RTS status
+	        	len += sprintf(buf, "%s:%s\n", cysys_rts,
+		                 (control & (z ? C_RS_RTS:CyRTS) ) ? cysys_on : cysys_off);
+		break;
+	
+		case DTR: //DTR status
+			len += sprintf(buf, "%s:%s\n", cysys_dtr,
+		      		(control & (z ? C_RS_DTR:(info->rtsdtr_inv ? CyRTS : CyDTR)) ) \
+				? cysys_on : cysys_off); 
+		break;
+
+		case RX: //rx buffer
+	        	len += sprintf(buf,"%s:%d/%d\n", cysys_ttyrxbuf,tty->read_cnt,N_TTY_BUF_SIZE);
+		break;
+	
+		case TX: //tx buffer
+	        	len += sprintf(buf, "%s:%d/%ld\n", cysys_ttytxbuf,info->xmit_cnt, SERIAL_XMIT_SIZE);
+		break;
+
+		case BDRX: //board buffer, apply only to z-boards
+	
+			if ( z == 1) {
+				volatile uclong put, get, bufsize;
+				volatile int char_count;
+				//rx
+				get = cy_readl(&buf_ctrl->rx_get);
+				put = cy_readl(&buf_ctrl->rx_put);
+				bufsize = cy_readl(&buf_ctrl->rx_bufsize);
+				if (put >= get) {
+					char_count = put - get;
+				} else {
+					char_count = put - get + bufsize;
+				}
+				len += sprintf(buf, "%s:%d/%ld\n", cysys_boardrxbuf,
+							char_count, bufsize);
+			}
+			else len += sprintf(buf, "board rx buffer is specific for Z-boards\n");
+        	break;	
+	
+		case BDTX: //board buffer, apply only to z-boards
+	
+			if ( z == 1) {
+				volatile uclong put, get, bufsize;
+				volatile int char_count;
+
+				//tx
+				get = cy_readl(&buf_ctrl->tx_get);
+				put = cy_readl(&buf_ctrl->tx_put);
+				bufsize = cy_readl(&buf_ctrl->tx_bufsize);
+				if (put >= get) {
+					char_count = put - get;
+				} else {
+					char_count = put - get + bufsize;
+				}
+				len += sprintf(buf, "%s:%d/%ld\n", cysys_boardtxbuf,
+								char_count, bufsize);
+			}
+			else len += sprintf(buf, "board tx buffer is specific for Z-boards\n");
+        	break;	
+	
+		case PAR://parity configuration info
+			if(z == 1){
+				uclong pari;
+				pari = cy_readl(&ch_ctrl[channel].comm_parity);
+				switch (pari) {
+					case C_PR_NONE:
+						par = 'n';
+					break;
+					case C_PR_ODD:
+						par = 'o';
+					break;
+					case C_PR_EVEN:
+						par = 'e';
+					break;
+					default:
+						par = 'n';
+					break;
+				}
+		       	len += sprintf(buf, "%s:%c\n", cysys_parity, par); 
+			}
+			else{
+				switch ( info->cor1 & 0xc0) {
+					case CyPARITY_NONE:
+						par = 'n';
+					break;
+					case CyPARITY_O:
+						par = 'o';
+					break;
+					case CyPARITY_E:
+						par = 'e';
+					break;
+					default:
+						par = 'n';
+					break;
+				}
+				len += sprintf(buf, "%s:%c\n", cysys_parity, par);
+			}
+
+		break;
+
+		case STOP: //number of stop bits info
+			if(z == 1){
+				uclong data_len;
+				data_len = cy_readl(&ch_ctrl[channel].comm_data_l);
+				if ( data_len & C_DL_2STOP) {
+					nstop = 2;
+		   		} else {
+					nstop = 1;
+		   		}
+			}
+			else{
+				if ( info->cor1 & Cy_2_STOP) {
+					nstop = 2;
+				} else {
+					nstop = 1;
+				}
+
+			}
+			len += sprintf(buf, "%s:%d\n",cysys_stopbits, nstop);
+		break;
+	
+		case CHLEN:
+
+		//Printing communication data len
+		if (z == 1){
+			uclong data_len;
+			data_len = cy_readl(&ch_ctrl[channel].comm_data_l);
+
+			switch (data_len & 0x0f) {
+				case 1:
+					char_len = 5;
+				break;
+				case 2:
+					char_len = 6;
+				break;
+				case 4:
+					char_len = 7;
+				break;
+				case 8:
+					char_len = 8;
+				break;
+			default:
+				char_len = 8;
+				break;
+		}
+				
+		} else {
+			char_len = (info->cor1 & 0x03) + 5;
+		}	
+		len += sprintf(buf, "%s:%d\n", cysys_charlen, char_len); 
+        	break;
+	
+	}/*switch(whatinfo)*/	
+
+	return len;
+}
+
+/* get the hardware rx flow control status for y board*/
+inline ssize_t get_rxfl_y(char *buf, struct cyclades_port *info)
+{
+	ssize_t len=0;
+	int card = info->card;
+	int index = cy_card[card].bus_index;
+	int channel = (info->line) - (cy_card[card].first_line);
+	int chip = channel >> 2;
+	unsigned char *base_addr = (unsigned char *)(cy_card[card].base_addr
+					+ (cy_chip_offset[chip] << index));
+
+	uclong control = cy_readb((u_long) base_addr + (CyMSVR1 << index));
+	uclong aux;
+
+	if (info->rtsdtr_inv) {
+		aux = CyDTR;
+	} else {
+		aux = CyRTS;
+	}
+
+	if (control & aux) {
+		len += sprintf(buf, "%s:%s\n", cysys_rxfcs, cysys_on);
+	} else {
+		len += sprintf(buf, "%s:%s\n", cysys_rxfcs, cysys_off);
+	}
+	return len;
+}
+
+
 MODULE_LICENSE("GPL");
--- linux-2.6.10rc1.orig/include/linux/cyclades.h	2004-10-18 19:55:35.000000000 -0200
+++ linux-2.6.10rc1/include/linux/cyclades.h	2004-10-26 13:04:04.000000000 -0200
@@ -401,6 +401,45 @@ struct	FIRM_ID {
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
+char cysys_parity[]  =  "Parity:               ";
+char cysys_stopbits[] = "Stop bits:            ";
+
 /*
  *	CH_CTRL - This per port structure contains all parameters
  *	that control an specific port. It can be seen as the
@@ -556,6 +595,11 @@ struct cyclades_icount {
 	__u32	buf_overrun;
 };
 
+struct cycsysinfo{
+  char sysnames[18][20]; /* this buffer will keep the sys filenames for each channel*/
+  struct device_attribute cydas[18];   
+};
+
 /*
  * This is our internal structure for each serial port's state.
  * 
@@ -609,6 +653,8 @@ struct cyclades_port {
 	wait_queue_head_t       shutdown_wait;
 	wait_queue_head_t       delta_msr_wait;
 	int throttle;
+	struct cycsysinfo sysdata;
+        /*struct device_attribute cydas[18];*/
 };
 
 /*
@@ -823,5 +869,39 @@ struct cyclades_port {
 
 /***************************************************************************/
 
+/* one of the values of this enum is passed to get_sys_data in order to determine 
+   the information asked. DCD to DTR are the corresponding serial line signals.
+   RX and TX are the buffers
+   CHLEN is the size of the data
+   PAR is the parity configuration for the port
+   BBUF onboard buffer, apply only to z boards
+*/
+
+enum tserinfo {STAT,CARD,BAUD,FLOW,RXFL,TXFL,DCD,DSR,CTS,RTS,DTR,RX,TX,BDRX,BDTX,PAR,STOP,CHLEN};
+
+/*used for sysfs register purposes */
+static ssize_t show_sys_stat(struct device *p, char *buf); //exports status of the port
+static ssize_t show_sys_card(struct device *p, char *buf); //exports card type information
+static ssize_t show_sys_baud(struct device *p, char *buf); //exports baud rate configuration
+static ssize_t show_sys_flow(struct device *p, char *buf); //exports flow control type
+static ssize_t show_sys_rxfl(struct device *p, char *buf); //exports rx flow control status
+static ssize_t show_sys_txfl(struct device *p, char *buf); //exports tx flow control status
+static ssize_t show_sys_dcd(struct device *p, char *buf); //exports dcd signal
+static ssize_t show_sys_dsr(struct device *p, char *buf); //exports dsr signal
+static ssize_t show_sys_cts(struct device *p, char *buf); //exports cts signal
+static ssize_t show_sys_rts(struct device *p, char *buf); //exports rts signal
+static ssize_t show_sys_dtr(struct device *p, char *buf); //exports dtr signal
+static ssize_t show_sys_rx(struct device *p, char *buf); //exports rx buffer size
+static ssize_t show_sys_tx(struct device *p, char *buf); //exports tx buffer size
+static ssize_t show_sys_bdrx(struct device *p, char *buf); //exports board rx buffer size (z board only)
+static ssize_t show_sys_bdtx(struct device *p, char *buf); //exports board tx buffer size (z board only)
+static ssize_t show_sys_par(struct device *p, char *buf); //exports parity configuration
+static ssize_t show_sys_stop(struct device *p, char *buf); //exports stop bits configuration
+static ssize_t show_sys_chlen(struct device *p, char *buf); //exports word size configuration
+static ssize_t get_sys_data(struct device *p, char *buf, enum tserinfo whatinfo);
+inline ssize_t get_rxfl_y(char *buf, struct cyclades_port *info);//get rx hard flow for y board 
+static void createsysfiles(struct cyclades_port *port); //create sys files for a channel
+static void removesysfiles(struct cyclades_port *port); //remove sys files for a channel
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_CYCLADES_H */

--=-SPxQhi/QsxS4jyDQ+ATY--

