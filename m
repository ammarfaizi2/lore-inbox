Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315416AbSGQQps>; Wed, 17 Jul 2002 12:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315427AbSGQQps>; Wed, 17 Jul 2002 12:45:48 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:7871 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S315416AbSGQQpp>; Wed, 17 Jul 2002 12:45:45 -0400
Message-ID: <3D359FE3.E6314630@nortelnetworks.com>
Date: Wed, 17 Jul 2002 12:48:35 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] idt77252 driver enhancements: ioctl and VBR support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since there isn't really an ATM maintainer, I'm posting this to the list in the
hopes that someone picks it up to pass on to Marcello and Linus.

This patch adds VBR and ioctl support to the idt77252 driver.  It's based and
tested on 2.4.18, but it compiled on 2.5.20 (I haven't tried later ones).

The ioctl support allows access to the sonet diagnostics through the ioctl in
suni.c (so sonetdiag will now work with cards based on the idt77252) and is very
straightforward.

The VBR support was more interesting, but seems to be working fine. There was
one entry (TCT_MAX_IDLE_COUNT) which was arbitrarily set to its maximum value as
I am not sure what effect this will have on real-world traffic.  This parameter
controls how many idle cells are sent before the hardware considers the
connection to be idle and stops scheduling it.  Since we check for idle
connections while sending each message, this field should only have an effect
when attempting to schedule many connections simultaneously.  Since my
connections are few and semi-permanent, I don't have any way of really testing
the effect of this value.  As part of the VBR support, two fields were added to
the atm_trafprm struct. The two new fields are SCR (sustained cell rate) and MBS
(max burst size).  The maximum MBS for the idt77252 is 255 (0xff).

Chris



diff -ur linux-2.4.18-vanilla/drivers/atm/idt77252.c
linux-2.4.18/drivers/atm/idt77252.c
--- linux-2.4.18-vanilla/drivers/atm/idt77252.c	Fri Dec 21 12:41:53 2001
+++ linux-2.4.18/drivers/atm/idt77252.c	Wed Jul 17 11:22:21 2002
@@ -137,6 +137,7 @@
 static void idt77252_interrupt(int irq, void *dev_id,
 			       struct pt_regs *regs);
 static void idt77252_softint(void *dev_id);
+static int idt77252_ioctl(struct atm_dev *dev, unsigned int cmd, void *arg);
 
 
 static struct atmdev_ops idt77252_ops =
@@ -144,6 +145,7 @@
 	dev_close:	idt77252_dev_close,
 	open:		idt77252_open,
 	close:		idt77252_close,
+	ioctl:		idt77252_ioctl,
 	send:		idt77252_send,
 	send_oam:	idt77252_send_oam,
 	phy_put:	idt77252_phy_put,
@@ -155,6 +157,8 @@
 static struct idt77252_dev *idt77252_chain = NULL;
 static unsigned int idt77252_sram_write_errors = 0;
 
+
+
 /*****************************************************************************/
 /*                                                                           */
 /* I/O and Utility Bus                                                       */
@@ -1468,7 +1472,7 @@
 				break;
 			}
 
-			printk("%s: Connection %d IDLE.\n",
+			TXPRINTK("%s: Connection %d IDLE.\n",
 			       card->name, vc->index);
 
 			set_bit(VCF_IDLE, &vc->flags);
@@ -1744,11 +1748,38 @@
 	return res;
 }
 
+/* this procedure calculates the 16-bit binary fractional value of the division
+ * of two 32-bit integers.  It shifts the numerator left until the leftmost
+ * bit is a one, and shifts the denominator right until the rightmost bit is a
one,
+ * then does the division and shifts the result as approprate to give a 16-bit
+ * fractional result.  Note that only the fractional portion of the result is
returned,
+ * the integer portion is ignored.
+ */
+static u16 fixed_div_16(u32 num, u32 denom)
+{
+   int t = -sizeof(u16)*8;
+   
+   while (!(num & (1 << (sizeof(u32)*8 - 1))))
+   {
+      num <<= 1;
+      t++;
+   }
+   
+   while (!(denom & 1))
+   {
+      denom >>= 1;
+      t++;
+   }
+   
+   return (num/denom)>>t;
+}
+
 
 static int
-set_tct(struct idt77252_dev *card, struct vc_map *vc)
+set_tct(struct idt77252_dev *card, struct vc_map *vc, struct atm_qos *qos)
 {
 	unsigned long tct;
+	unsigned short pcr_token;
 
 	tct = (unsigned long) (card->tct_base + vc->index * SAR_SRAM_TCT_SIZE);
 
@@ -1782,8 +1813,42 @@
 		break;
 
 	case SCHED_VBR:
+		if (qos->txtp.mbs < 0 || qos->txtp.mbs > TCT_MAX_MBS)
+		{
+			printk("%s: error, outgoing MBS must be between 1 and %d\n",
+			       card->name, TCT_MAX_MBS);
+			return -EINVAL;
+		}
+		
+		if (qos->txtp.scr > qos->txtp.pcr)
+		{
+			printk("%s: error, PCR must be greater than SCR\n", card->name);
+			return -EINVAL;
+		}
+		
+		pcr_token = fixed_div_16(qos->txtp.scr, qos->txtp.pcr);
+		
+		//if there is roundoff error, better too slow than too fast
+		if (pcr_token == 0)
+			pcr_token++;
+	
+		OPRINTK("%s: writing TCT at 0x%lx, SCD 0x%lx.\n",
+		        card->name, tct, vc->scq->scd);
+
+		write_sram(card, tct + 0, TCT_VBR | vc->scq->scd);
+		write_sram(card, tct + 1, 0);
+		write_sram(card, tct + 2, TCT_TSIF);
+		write_sram(card, tct + 3, TCT_HALT | TCT_IDLE);
+		write_sram(card, tct + 4, TCT_MAX_IDLE_COUNT); //rationale for value not well
understood
+		                                               //lacr updated later
+		write_sram(card, tct + 5, TCT_TOKEN_INIT); //init_er updated later
+		write_sram(card, tct + 6, (qos->txtp.mbs << 16) | pcr_token);
+		write_sram(card, tct + 7, 0);
+		break;
+
 	case SCHED_ABR:
 	default:
+		printk("%s: class %d not supported.\n", card->name, qos->txtp.traffic_class);
 		return -ENOSYS;
 	}
 
@@ -1943,6 +2008,26 @@
 /*                                                                           */
 /*****************************************************************************/
 
+static int
+idt77252_ioctl(struct atm_dev *dev, unsigned int cmd, void *arg)
+{
+	struct idt77252_dev *card;
+
+	card = dev->dev_data;
+	switch (cmd)
+	{
+		default:
+			if (dev->phy && dev->phy->ioctl) {
+				return dev->phy->ioctl(dev, cmd, arg);
+			}
+			else {
+				printk("idt77252 itf:%d: %s == NULL \n", card->index,
+				        dev->phy ? "dev->phy->ioctl" : "dev->phy");
+				return -ENOIOCTLCMD;
+			}
+	}
+}
+
 static void
 idt77252_phy_put(struct atm_dev *dev, unsigned char value, unsigned long addr)
 {
@@ -2261,6 +2346,26 @@
 }
 
 static int
+idt77252_init_vbr(struct idt77252_dev *card, struct vc_map *vc,
+		  struct atm_vcc *vcc, struct atm_qos *qos)
+{
+	if (qos->txtp.scr == 0) {
+		printk("%s: trying to open a VBR VC with avg cell rate = 0\n",
+		       card->name);
+		return -EINVAL;
+	}
+
+	vc->class = SCHED_VBR;
+	vc->lacr = idt77252_rate_logindex(card, qos->txtp.scr);
+	vc->init_er = idt77252_rate_logindex(card, qos->txtp.pcr);
+	
+	//set the init_er since we didn't know it back in set_tct()
+	writel(TCMDQ_INIT_ER | (vc->init_er << 16)| vc->index, SAR_REG_TCMDQ);	
+
+	return 0;
+}
+
+static int
 idt77252_init_tx(struct idt77252_dev *card, struct vc_map *vc,
 		 struct atm_vcc *vcc, struct atm_qos *qos)
 {
@@ -2279,6 +2384,9 @@
 			break;
 
 		case ATM_VBR:
+			vc->class = SCHED_VBR;
+			break;
+
 		case ATM_ABR:
 		default:
 			return -EPROTONOSUPPORT;
@@ -2299,9 +2407,7 @@
 
 	fill_scd(card, vc->scq, vc->class);
 
-	if (set_tct(card, vc)) {
-		printk("%s: class %d not supported.\n",
-		       card->name, qos->txtp.traffic_class);
+	if (set_tct(card, vc, qos)) {
 
 		card->scd2vc[vc->scd_index] = NULL;
 		free_scq(card, vc->scq);
@@ -2331,6 +2437,17 @@
 
 			set_bit(VCF_IDLE, &vc->flags);
 			break;
+			
+		case SCHED_VBR:
+			error = idt77252_init_vbr(card, vc, vcc, qos);
+			if (error) {
+				card->scd2vc[vc->scd_index] = NULL;
+				free_scq(card, vc->scq);
+				return error;
+			}
+
+			set_bit(VCF_IDLE, &vc->flags);
+			break;
 	}
 
 	vc->tx_vcc = vcc;
@@ -2663,6 +2780,11 @@
 				break;
 
 			case ATM_VBR:
+				/* only problem with vbr is that we would need to tear
+				 * down and rebuild the tct since a change to the scr/pcr
+				 * ratio requires updating the pcr token in the tct
+				 */
+
 			case ATM_ABR:
 				error = -EOPNOTSUPP;
 				goto out;
@@ -3775,6 +3897,10 @@
 	}
 	dev->dev_data = card;
 	card->atmdev = dev;
+   
+   if (dev->ops->ioctl)
+      printk("idt77252 have ioctl support\n");
+   
 
 #ifdef	CONFIG_ATM_IDT77252_USE_SUNI
 	suni_init(dev);
diff -ur linux-2.4.18-vanilla/drivers/atm/idt77252.h
linux-2.4.18/drivers/atm/idt77252.h
--- linux-2.4.18-vanilla/drivers/atm/idt77252.h	Tue Nov 13 12:19:41 2001
+++ linux-2.4.18/drivers/atm/idt77252.h	Wed Jul 17 11:22:21 2002
@@ -142,6 +142,10 @@
 #define TCT_IDLE		0x40000000
 #define TCT_FLAG_UBR		0x80000000
 
+#define TCT_MAX_IDLE_COUNT      0xff000000
+#define TCT_TOKEN_INIT          0x01000000
+#define TCT_MAX_MBS		0xff
+
 /*****************************************************************************/
 /*                                                                           */
 /*   Structure describing an IDT77252                                        */

diff -ur linux-2.4.18-vanilla/include/linux/atm.h
linux-2.4.18/include/linux/atm.h
--- linux-2.4.18-vanilla/include/linux/atm.h	Thu Nov 22 14:48:41 2001
+++ linux-2.4.18/include/linux/atm.h	Wed Jul 17 11:22:21 2002
@@ -138,6 +138,9 @@
 	int		min_pcr;	/* minimum PCR in cells per second */
 	int		max_cdv;	/* maximum CDV in microseconds */
 	int		max_sdu;	/* maximum SDU in bytes */
+	/* extra params for VBR */
+	int		scr;		/* sustained rate in cells per second */
+	int		mbs;		/* maximum burst size (MBS) in cells */
         /* extra params for ABR */
         unsigned int 	icr;         	/* Initial Cell Rate (24-bit) */
         unsigned int	tbe;		/* Transient Buffer Exposure (24-bit) */ 









-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
