Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288946AbSBINZe>; Sat, 9 Feb 2002 08:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288950AbSBINZO>; Sat, 9 Feb 2002 08:25:14 -0500
Received: from pak218.pakuni.net ([207.91.34.218]:57872 "EHLO linuxtr.net")
	by vger.kernel.org with ESMTP id <S288946AbSBINZF>;
	Sat, 9 Feb 2002 08:25:05 -0500
Date: Sat, 9 Feb 2002 09:09:55 -0600 (CST)
From: Mike Phillips <mikep@linuxtr.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH]IBMTR clean-up, removal of last isa_read/writes
Message-ID: <Pine.LNX.4.10.10202090907410.1572-100000@www.linuxtr.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A minor patch to remove the last isa_read/isa_write function in  the
driver. 

Patch is again 2.4.17

Thanks
Mike Phillips
Linux Token Ring Project
http://www.linuxtr.net

diff -urN -X /home/phillim/dontdiff linux-2.4.17-vanilla/drivers/net/tokenring/ibmtr.c linux-2.4.17-production/drivers/net/tokenring/ibmtr.c
--- linux-2.4.17-vanilla/drivers/net/tokenring/ibmtr.c	Fri Nov  9 17:02:24 2001
+++ linux-2.4.17-production/drivers/net/tokenring/ibmtr.c	Fri Feb  8 22:00:47 2002
@@ -236,6 +236,10 @@
 	printk("\n");
 }
 
+/* We have to ioremap every checked address, because isa_readb is 
+ * going away. 
+ */
+
 static void __devinit find_turbo_adapters(int *iolist) {
 	int ram_addr;
 	int index=0;
@@ -243,7 +247,8 @@
 	int found_turbo=0;
 	unsigned char *tchanid, ctemp;
 	int i,j;
-  
+	void *ram_mapped ;   
+
 	if (turbo_searched == 1) return;
 	turbo_searched=1;
 	for (ram_addr=0xC0000; ram_addr < 0xE0000; ram_addr+=0x2000) {
@@ -251,37 +256,40 @@
 		__u32 intf_tbl=0;
 
 		found_turbo=1;
-		chanid=(CHANNEL_ID + ram_addr);
+		ram_mapped = ioremap((u32)ram_addr,0x1fff) ; 
+		if (ram_mapped==NULL) 
+ 			continue ; 
+		chanid=(CHANNEL_ID + ram_mapped);
 		tchanid=pcchannelid;
-		ctemp=isa_readb(chanid) & 0x0f;
+		ctemp=readb(chanid) & 0x0f;
 		if (ctemp != *tchanid) continue;
 		for (i=2,j=1; i<=46; i=i+2,j++) {
-			if ((isa_readb(chanid+i) & 0x0f) != tchanid[j]){
+			if ((readb(chanid+i) & 0x0f) != tchanid[j]){
 				found_turbo=0;
 				break;
 			}
 		}
 		if (!found_turbo) continue;
 
-		isa_writeb(0x90, ram_addr+0x1E01);
+		writeb(0x90, ram_mapped+0x1E01);
 		for(i=2; i<0x0f; i++) {
-			isa_writeb(0x00, ram_addr+0x1E01+i);
+			writeb(0x00, ram_mapped+0x1E01+i);
 		}
-		isa_writeb(0x00, ram_addr+0x1E01);
+		writeb(0x00, ram_mapped+0x1E01);
 		for(i=jiffies+TR_BUSY_INTERVAL; time_before_eq(jiffies,i););
-		intf_tbl=ntohs(isa_readw(ram_addr+ACA_OFFSET+ACA_RW+WRBR_EVEN));
+		intf_tbl=ntohs(readw(ram_mapped+ACA_OFFSET+ACA_RW+WRBR_EVEN));
 		if (intf_tbl) {
 #if IBMTR_DEBUG_MESSAGES
 			printk("ibmtr::find_turbo_adapters, Turbo found at "
 				"ram_addr %x\n",ram_addr);
 			printk("ibmtr::find_turbo_adapters, interface_table ");
 			for(i=0; i<6; i++) {
-				printk("%x:",isa_readb(ram_addr+intf_tbl+i));
+				printk("%x:",readb(ram_addr+intf_tbl+i));
 			}
 			printk("\n");
 #endif
-			turbo_io[index]=ntohs(isa_readw(ram_addr+intf_tbl+4));
-			turbo_irq[index]=isa_readb(ram_addr+intf_tbl+3);
+			turbo_io[index]=ntohs(readw(ram_mapped+intf_tbl+4));
+			turbo_irq[index]=readb(ram_mapped+intf_tbl+3);
 			outb(0, turbo_io[index] + ADAPTRESET);
 			for(i=jiffies+TR_RST_TIME;time_before_eq(jiffies,i););
 			outb(0, turbo_io[index] + ADAPTRESETREL);
@@ -292,7 +300,8 @@
 		printk("ibmtr::find_turbo_adapters, ibmtr card found at"
 			" %x but not a Turbo model\n",ram_addr);
 #endif
-	}
+	iounmap(ram_addr) ; 	
+	} /* for */
 	for(i=0; i<IBMTR_MAX_ADAPTERS; i++) {
 		if(!turbo_io[i]) break;
 		for (j=0; j<IBMTR_MAX_ADAPTERS; j++) {

