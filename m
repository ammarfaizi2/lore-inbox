Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbTFPUUj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 16:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264242AbTFPUUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 16:20:39 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:62206 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264262AbTFPUTh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 16:19:37 -0400
Message-ID: <3EEE28DE.6040808@us.ibm.com>
Date: Mon, 16 Jun 2003 15:30:22 -0500
From: Janice M Girouard <janiceg@us.ibm.com>
Organization: IBM Linux Technology Center - Network Device Drivers
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
CC: stekloff@us.ibm.com, girouard@us.ibm.com, lkessler@us.ibm.com,
       kenistonj@us.ibm.com, Jeff Garzik <jgarzik@pobox.com>, davem@redhat.com
Subject: patch for common networking error messages
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Below is a patch that demonstrates standard messages for ethernet device 
drivers.  I would like your feedback on the concept of standard network 
messages, and any suggestions for messages to include.  

The intent of the standard message change is to:
1) Ensure key events are communicated to user space in a predictable 
way, enabling automated diagnostic systems or error log analysis,
2) Reduce the number of puzzling messages that are logged -- in this 
case, by replacing them with standard messages, and/or
3) Identify the device (or driver name) that is responsible for the error.

The patch includes changes for two drivers, the e1000 and tg3, to 
provide a concrete example of the concept.  Below is a snapshot of an 
error log, with the new messages:

Jun  4 14:54:06 dyn95394175 kernel: e1000: Intel(R) PRO/1000 Network 
Driver - version 5.0.43-k3
Jun  4 14:54:06 dyn95394175 kernel:        Copyright (c) 1999-2003 Intel 
Corporation.
Jun  4 14:54:06 dyn95394175 kernel: eth2: Intel(R) PRO/1000 Network 
Connection
Jun  4 14:54:06 dyn95394175 kernel: eth2: scatter/gather I/O enabled
Jun  4 14:54:06 dyn95394175 kernel: eth2: all IP checksums on transmit 
enabled
Jun  4 14:54:06 dyn95394175 kernel: eth3: Intel(R) PRO/1000 Network 
Connection
Jun  4 14:54:06 dyn95394175 kernel: eth3: scatter/gather I/O enabled
Jun  4 14:54:06 dyn95394175 kernel: eth3: all IP checksums on transmit 
enabled
...
Jun  4 14:54:06 dyn95394175 kernel: tg3: Broadcom Tigon3 ethernet driver 
- version 1.5
...

Below is the text for the most basic standard messages:

EMSG_NET_LINK_FAIL   "%s: transient problem: link error detected - MII 
status %x\n"
EMSG_NET_LINK_UP     "%s: state change: link up, %d Mbps, %s-duplex\n"
EMSG_NET_HUNG        "%s: software failure: ethernet controller hung\n"
EMSG_NET_RX_ERR      "%s: transient problem: packet receive error, 
rx_errors = %ld\n"
EMSG_NET_TX_ERR      "%s: transient problem: packet transmit error, 
tx_errors = %ld\n"
EMSG_NET_START_QUEUE "%s: performance event: (re)starting netdev queue\n"
EMSG_NET_STOP_QUEUE  "%s: performance event: stopping netdev queue\n"
EMSG_NET_SGATHER     "%s: scatter/gather I/O enabled\n"
EMSG_NET_NO_SGATHER  "%s: performance event: scatter/gather I/O 
disabled\n"   
EMSG_NET_HW_CSUMS    "%s: all IP checksums on transmit enabled\n"   
EMSG_NET_CSUMS       "%s: TCP/UDP over IPv6 checksums on transmit 
enabled\n"   
EMSG_NET_NO_CSUMS    "%s: performance event: IP checksums on transmit 
disabled\n"

Janice Girouard
janiceg@us.ibm.com
===================================================

diff -Naur linux-2.5.69.orig/drivers/net/e1000/e1000_hw.c 
linux-2.5.69.newMsgs/drivers/net/e1000/e1000_hw.c
--- linux-2.5.69.orig/drivers/net/e1000/e1000_hw.c    2003-06-04 
13:24:46.000000000 -0500
+++ linux-2.5.69.newMsgs/drivers/net/e1000/e1000_hw.c    2003-06-04 
13:14:58.000000000 -0500
@@ -31,6 +31,7 @@
  */
 
 #include "e1000_hw.h"
+#include <linux/stdmsgs.h>
 
 static int32_t e1000_set_phy_type(struct e1000_hw *hw);
 static void e1000_phy_init_script(struct e1000_hw *hw);
@@ -468,7 +469,7 @@
      * be initialized based on a value in the EEPROM.
      */
     if(e1000_read_eeprom(hw, EEPROM_INIT_CONTROL2_REG, 1, &eeprom_data) 
< 0) {
-        DEBUGOUT("EEPROM Read Error\n");
+        DEBUGOUT1(EMSG_DEV_EEPROM_READ, hw->back->adapter->netdev->name);
         return -E1000_ERR_EEPROM;
     }
 
@@ -666,7 +667,11 @@
             hw->autoneg_failed = 1;
             ret_val = e1000_check_for_link(hw);
             if(ret_val < 0) {
+        uint16_t mii_status_reg;
                 DEBUGOUT("Error while checking for link\n");
+                e1000_read_phy_reg( hw, PHY_STATUS, &mii_status_reg);
+            DEBUGOUT1(EMSG_NET_LINK_FAIL, hw->back->adapter->netdev->name,
+                mii_status_reg);
                 return ret_val;
             }
             hw->autoneg_failed = 0;
@@ -730,7 +735,7 @@
         msec_delay(15);
 
         if(e1000_write_phy_reg(hw, IGP01E1000_PHY_PAGE_SELECT, 0x0000) 
< 0) {
-            DEBUGOUT("PHY Write Error\n");
+               DEBUGOUT1(EMSG_DEV_PHY_WRITE, 
hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
 
@@ -746,29 +751,29 @@
             /* Disable SmartSpeed */
             if(e1000_read_phy_reg(hw, IGP01E1000_PHY_PORT_CONFIG,
                                   &phy_data) < 0) {
-                DEBUGOUT("PHY Read Error\n");
+            DEBUGOUT1(EMSG_DEV_PHY_READ, hw->back->adapter->netdev->name);
                 return -E1000_ERR_PHY;
             }
             phy_data &= ~IGP01E1000_PSCFR_SMART_SPEED;
             if(e1000_write_phy_reg(hw, IGP01E1000_PHY_PORT_CONFIG,
                                    phy_data) < 0) {
-                DEBUGOUT("PHY Write Error\n");
+                   DEBUGOUT1(EMSG_DEV_PHY_WRITE, 
hw->back->adapter->netdev->name);
                 return -E1000_ERR_PHY;
             }
             /* Set auto Master/Slave resolution process */
             if(e1000_read_phy_reg(hw, PHY_1000T_CTRL, &phy_data) < 0) {
-                DEBUGOUT("PHY Read Error\n");
+            DEBUGOUT1(EMSG_DEV_PHY_READ, hw->back->adapter->netdev->name);
                 return -E1000_ERR_PHY;
             }
             phy_data &= ~CR_1000T_MS_ENABLE;
             if(e1000_write_phy_reg(hw, PHY_1000T_CTRL, phy_data) < 0) {
-                DEBUGOUT("PHY Write Error\n");
+                   DEBUGOUT1(EMSG_DEV_PHY_WRITE, 
hw->back->adapter->netdev->name);
                 return -E1000_ERR_PHY;
             }
         }
 
         if(e1000_read_phy_reg(hw, IGP01E1000_PHY_PORT_CTRL, &phy_data) 
< 0) {
-            DEBUGOUT("PHY Read Error\n");
+               DEBUGOUT1(EMSG_DEV_PHY_READ, 
hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
 
@@ -779,14 +784,14 @@
         hw->mdix = 1;
 
         if(e1000_write_phy_reg(hw, IGP01E1000_PHY_PORT_CTRL, phy_data) 
< 0) {
-            DEBUGOUT("PHY Write Error\n");
+               DEBUGOUT1(EMSG_DEV_PHY_WRITE, 
hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
 
     } else {
         /* Enable CRS on TX. This must be set for half-duplex operation. */
         if(e1000_read_phy_reg(hw, M88E1000_PHY_SPEC_CTRL, &phy_data) < 0) {
-            DEBUGOUT("PHY Read Error\n");
+            DEBUGOUT1(EMSG_DEV_PHY_READ, hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
         phy_data |= M88E1000_PSCR_ASSERT_CRS_ON_TX;
@@ -826,7 +831,7 @@
         if(hw->disable_polarity_correction == 1)
             phy_data |= M88E1000_PSCR_POLARITY_REVERSAL;
         if(e1000_write_phy_reg(hw, M88E1000_PHY_SPEC_CTRL, phy_data) < 0) {
-            DEBUGOUT("PHY Write Error\n");
+               DEBUGOUT1(EMSG_DEV_PHY_WRITE, 
hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
 
@@ -834,7 +839,7 @@
          * to 25MHz clock.
          */
         if(e1000_read_phy_reg(hw, M88E1000_EXT_PHY_SPEC_CTRL, 
&phy_data) < 0) {
-            DEBUGOUT("PHY Read Error\n");
+            DEBUGOUT1(EMSG_DEV_PHY_READ, hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
         phy_data |= M88E1000_EPSCR_TX_CLK_25;
@@ -847,7 +852,7 @@
                          M88E1000_EPSCR_SLAVE_DOWNSHIFT_1X);
             if(e1000_write_phy_reg(hw, M88E1000_EXT_PHY_SPEC_CTRL,
                                    phy_data) < 0) {
-                DEBUGOUT("PHY Write Error\n");
+                   DEBUGOUT1(EMSG_DEV_PHY_WRITE, 
hw->back->adapter->netdev->name);
                 return -E1000_ERR_PHY;
             }
         }
@@ -855,7 +860,7 @@
         /* SW Reset the PHY so all changes take effect */
         ret_val = e1000_phy_reset(hw);
         if(ret_val < 0) {
-            DEBUGOUT("Error Resetting the PHY\n");
+            DEBUGOUT1(EMSG_DEV_SW_RESET, hw->back->adapter->netdev->name);
             return ret_val;
         }
     }
@@ -899,12 +904,12 @@
          * the Auto Neg Restart bit in the PHY control register.
          */
         if(e1000_read_phy_reg(hw, PHY_CTRL, &phy_data) < 0) {
-            DEBUGOUT("PHY Read Error\n");
+            DEBUGOUT1(EMSG_DEV_PHY_READ, hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
         phy_data |= (MII_CR_AUTO_NEG_EN | MII_CR_RESTART_AUTO_NEG);
         if(e1000_write_phy_reg(hw, PHY_CTRL, phy_data) < 0) {
-            DEBUGOUT("PHY Write Error\n");
+               DEBUGOUT1(EMSG_DEV_PHY_WRITE, 
hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
 
@@ -933,11 +938,11 @@
      */
     for(i = 0; i < 10; i++) {
         if(e1000_read_phy_reg(hw, PHY_STATUS, &phy_data) < 0) {
-            DEBUGOUT("PHY Read Error\n");
+            DEBUGOUT1(EMSG_DEV_PHY_READ, hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
         if(e1000_read_phy_reg(hw, PHY_STATUS, &phy_data) < 0) {
-            DEBUGOUT("PHY Read Error\n");
+            DEBUGOUT1(EMSG_DEV_PHY_READ, hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
         if(phy_data & MII_SR_LINK_STATUS) {
@@ -988,13 +993,13 @@
 
     /* Read the MII Auto-Neg Advertisement Register (Address 4). */
     if(e1000_read_phy_reg(hw, PHY_AUTONEG_ADV, &mii_autoneg_adv_reg) < 0) {
-        DEBUGOUT("PHY Read Error\n");
+        DEBUGOUT1(EMSG_DEV_PHY_READ, hw->back->adapter->netdev->name);
         return -E1000_ERR_PHY;
     }
 
     /* Read the MII 1000Base-T Control Register (Address 9). */
     if(e1000_read_phy_reg(hw, PHY_1000T_CTRL, &mii_1000t_ctrl_reg) < 0) {
-        DEBUGOUT("PHY Read Error\n");
+        DEBUGOUT1(EMSG_DEV_PHY_READ, hw->back->adapter->netdev->name);
         return -E1000_ERR_PHY;
     }
 
@@ -1103,14 +1108,14 @@
     }
 
     if(e1000_write_phy_reg(hw, PHY_AUTONEG_ADV, mii_autoneg_adv_reg) < 0) {
-        DEBUGOUT("PHY Write Error\n");
+           DEBUGOUT1(EMSG_DEV_PHY_WRITE, hw->back->adapter->netdev->name);
         return -E1000_ERR_PHY;
     }
 
     DEBUGOUT1("Auto-Neg Advertising %x\n", mii_autoneg_adv_reg);
 
     if(e1000_write_phy_reg(hw, PHY_1000T_CTRL, mii_1000t_ctrl_reg) < 0) {
-        DEBUGOUT("PHY Write Error\n");
+           DEBUGOUT1(EMSG_DEV_PHY_WRITE, hw->back->adapter->netdev->name);
         return -E1000_ERR_PHY;
     }
     return 0;
@@ -1150,7 +1155,7 @@
 
     /* Read the MII Control Register. */
     if(e1000_read_phy_reg(hw, PHY_CTRL, &mii_ctrl_reg) < 0) {
-        DEBUGOUT("PHY Read Error\n");
+        DEBUGOUT1(EMSG_DEV_PHY_READ, hw->back->adapter->netdev->name);
         return -E1000_ERR_PHY;
     }
 
@@ -1199,7 +1204,7 @@
 
     if (hw->phy_type == e1000_phy_m88) {
         if(e1000_read_phy_reg(hw, M88E1000_PHY_SPEC_CTRL, &phy_data) < 0) {
-            DEBUGOUT("PHY Read Error\n");
+               DEBUGOUT1(EMSG_DEV_PHY_READ, 
hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
 
@@ -1208,7 +1213,7 @@
          */
         phy_data &= ~M88E1000_PSCR_AUTO_X_MODE;
         if(e1000_write_phy_reg(hw, M88E1000_PHY_SPEC_CTRL, phy_data) < 0) {
-            DEBUGOUT("PHY Write Error\n");
+               DEBUGOUT1(EMSG_DEV_PHY_WRITE, 
hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
         DEBUGOUT1("M88E1000 PSCR: %x \n", phy_data);
@@ -1220,7 +1225,7 @@
          * forced whenever speed or duplex are forced.
          */
         if(e1000_read_phy_reg(hw, IGP01E1000_PHY_PORT_CTRL, &phy_data) 
< 0) {
-            DEBUGOUT("PHY Read Error\n");
+               DEBUGOUT1(EMSG_DEV_PHY_READ, 
hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
 
@@ -1228,14 +1233,14 @@
         phy_data &= ~IGP01E1000_PSCR_FORCE_MDI_MDIX;
 
         if(e1000_write_phy_reg(hw, IGP01E1000_PHY_PORT_CTRL, phy_data) 
< 0) {
-            DEBUGOUT("PHY Write Error\n");
+               DEBUGOUT1(EMSG_DEV_PHY_WRITE, 
hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
     }
 
     /* Write back the modified PHY MII control register. */
     if(e1000_write_phy_reg(hw, PHY_CTRL, mii_ctrl_reg) < 0) {
-        DEBUGOUT("PHY Write Error\n");
+           DEBUGOUT1(EMSG_DEV_PHY_WRITE, hw->back->adapter->netdev->name);
         return -E1000_ERR_PHY;
     }
     udelay(1);
@@ -1258,11 +1263,11 @@
              * to be set.
              */
             if(e1000_read_phy_reg(hw, PHY_STATUS, &mii_status_reg) < 0) {
-                DEBUGOUT("PHY Read Error\n");
+                   DEBUGOUT1(EMSG_DEV_PHY_READ, 
hw->back->adapter->netdev->name);
                 return -E1000_ERR_PHY;
             }
             if(e1000_read_phy_reg(hw, PHY_STATUS, &mii_status_reg) < 0) {
-                DEBUGOUT("PHY Read Error\n");
+                   DEBUGOUT1(EMSG_DEV_PHY_READ, 
hw->back->adapter->netdev->name);
                 return -E1000_ERR_PHY;
             }
             if(mii_status_reg & MII_SR_LINK_STATUS) break;
@@ -1285,11 +1290,11 @@
              * to be set.
              */
             if(e1000_read_phy_reg(hw, PHY_STATUS, &mii_status_reg) < 0) {
-                DEBUGOUT("PHY Read Error\n");
+                   DEBUGOUT1(EMSG_DEV_PHY_READ, 
hw->back->adapter->netdev->name);
                 return -E1000_ERR_PHY;
             }
             if(e1000_read_phy_reg(hw, PHY_STATUS, &mii_status_reg) < 0) {
-                DEBUGOUT("PHY Read Error\n");
+                   DEBUGOUT1(EMSG_DEV_PHY_READ, 
hw->back->adapter->netdev->name);
                 return -E1000_ERR_PHY;
             }
         }
@@ -1301,12 +1306,12 @@
          * defaults back to a 2.5MHz clock when the PHY is reset.
          */
         if(e1000_read_phy_reg(hw, M88E1000_EXT_PHY_SPEC_CTRL, 
&phy_data) < 0) {
-            DEBUGOUT("PHY Read Error\n");
+               DEBUGOUT1(EMSG_DEV_PHY_READ, 
hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
         phy_data |= M88E1000_EPSCR_TX_CLK_25;
         if(e1000_write_phy_reg(hw, M88E1000_EXT_PHY_SPEC_CTRL, 
phy_data) < 0) {
-            DEBUGOUT("PHY Write Error\n");
+               DEBUGOUT1(EMSG_DEV_PHY_WRITE, 
hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
 
@@ -1314,12 +1319,12 @@
          * TX.  This must be set for both full and half duplex operation.
          */
         if(e1000_read_phy_reg(hw, M88E1000_PHY_SPEC_CTRL, &phy_data) < 0) {
-            DEBUGOUT("PHY Read Error\n");
+               DEBUGOUT1(EMSG_DEV_PHY_READ, 
hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
         phy_data |= M88E1000_PSCR_ASSERT_CRS_ON_TX;
         if(e1000_write_phy_reg(hw, M88E1000_PHY_SPEC_CTRL, phy_data) < 0) {
-            DEBUGOUT("PHY Write Error\n");
+               DEBUGOUT1(EMSG_DEV_PHY_WRITE, 
hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
     }
@@ -1379,7 +1384,7 @@
      */
     if (hw->phy_type == e1000_phy_igp) {
         if(e1000_read_phy_reg(hw, IGP01E1000_PHY_PORT_STATUS, 
&phy_data) < 0) {
-            DEBUGOUT("PHY Read Error\n");
+            DEBUGOUT1(EMSG_DEV_PHY_READ, hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
         if(phy_data & IGP01E1000_PSSR_FULL_DUPLEX) ctrl |= E1000_CTRL_FD;
@@ -1398,7 +1403,7 @@
             ctrl |= E1000_CTRL_SPD_100;
     } else {
         if(e1000_read_phy_reg(hw, M88E1000_PHY_SPEC_STATUS, &phy_data) 
< 0) {
-            DEBUGOUT("PHY Read Error\n");
+            DEBUGOUT1(EMSG_DEV_PHY_READ, hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
         if(phy_data & M88E1000_PSSR_DPLX) ctrl |= E1000_CTRL_FD;
@@ -1533,11 +1538,11 @@
          * some "sticky" (latched) bits.
          */
         if(e1000_read_phy_reg(hw, PHY_STATUS, &mii_status_reg) < 0) {
-            DEBUGOUT("PHY Read Error \n");
+               DEBUGOUT1(EMSG_DEV_PHY_READ, 
hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
         if(e1000_read_phy_reg(hw, PHY_STATUS, &mii_status_reg) < 0) {
-            DEBUGOUT("PHY Read Error \n");
+               DEBUGOUT1(EMSG_DEV_PHY_READ, 
hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
 
@@ -1549,11 +1554,11 @@
              * negotiated.
              */
             if(e1000_read_phy_reg(hw, PHY_AUTONEG_ADV, 
&mii_nway_adv_reg) < 0) {
-                DEBUGOUT("PHY Read Error\n");
+                   DEBUGOUT1(EMSG_DEV_PHY_READ, 
hw->back->adapter->netdev->name);
                 return -E1000_ERR_PHY;
             }
             if(e1000_read_phy_reg(hw, PHY_LP_ABILITY, 
&mii_nway_lp_ability_reg) < 0) {
-                DEBUGOUT("PHY Read Error\n");
+                   DEBUGOUT1(EMSG_DEV_PHY_READ, 
hw->back->adapter->netdev->name);
                 return -E1000_ERR_PHY;
             }
 
@@ -1735,11 +1740,11 @@
          * Read the register twice since the link bit is sticky.
          */
         if(e1000_read_phy_reg(hw, PHY_STATUS, &phy_data) < 0) {
-            DEBUGOUT("PHY Read Error\n");
+               DEBUGOUT1(EMSG_DEV_PHY_READ, 
hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
         if(e1000_read_phy_reg(hw, PHY_STATUS, &phy_data) < 0) {
-            DEBUGOUT("PHY Read Error\n");
+               DEBUGOUT1(EMSG_DEV_PHY_READ, 
hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
 
@@ -1798,7 +1803,7 @@
          */
         if(hw->tbi_compatibility_en) {
             if(e1000_read_phy_reg(hw, PHY_LP_ABILITY, &lp_capability) < 
0) {
-                DEBUGOUT("PHY Read Error\n");
+                   DEBUGOUT1(EMSG_DEV_PHY_READ, 
hw->back->adapter->netdev->name);
                 return -E1000_ERR_PHY;
             }
             if(lp_capability & (NWAY_LPAR_10T_HD_CAPS |
@@ -1941,11 +1946,11 @@
          * Complete bit to be set.
          */
         if(e1000_read_phy_reg(hw, PHY_STATUS, &phy_data) < 0) {
-            DEBUGOUT("PHY Read Error\n");
+            DEBUGOUT1(EMSG_DEV_PHY_READ, hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
         if(e1000_read_phy_reg(hw, PHY_STATUS, &phy_data) < 0) {
-            DEBUGOUT("PHY Read Error\n");
+            DEBUGOUT1(EMSG_DEV_PHY_READ, hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
         if(phy_data & MII_SR_AUTONEG_COMPLETE) {
@@ -2286,7 +2291,7 @@
 
     if((hw->mac_type == e1000_82541) || (hw->mac_type == e1000_82547)) {
         if(e1000_write_phy_reg(hw, IGP01E1000_PHY_PAGE_SELECT, 0x0000) 
< 0) {
-            DEBUGOUT("PHY Write Error\n");
+               DEBUGOUT1(EMSG_DEV_PHY_WRITE, 
hw->back->adapter->netdev->name);
             return;
         }
 
@@ -2315,12 +2320,12 @@
     DEBUGFUNC("e1000_phy_reset");
 
     if(e1000_read_phy_reg(hw, PHY_CTRL, &phy_data) < 0) {
-        DEBUGOUT("PHY Read Error\n");
+        DEBUGOUT1(EMSG_DEV_PHY_READ, hw->back->adapter->netdev->name);
         return -E1000_ERR_PHY;
     }
     phy_data |= MII_CR_RESET;
     if(e1000_write_phy_reg(hw, PHY_CTRL, phy_data) < 0) {
-        DEBUGOUT("PHY Write Error\n");
+           DEBUGOUT1(EMSG_DEV_PHY_WRITE, hw->back->adapter->netdev->name);
         return -E1000_ERR_PHY;
     }
     udelay(1);
@@ -2346,13 +2351,13 @@
 
     /* Read the PHY ID Registers to identify which PHY is onboard. */
     if(e1000_read_phy_reg(hw, PHY_ID1, &phy_id_high) < 0) {
-        DEBUGOUT("PHY Read Error\n");
+        DEBUGOUT1(EMSG_DEV_PHY_READ, hw->back->adapter->netdev->name);
         return -E1000_ERR_PHY;
     }
     hw->phy_id = (uint32_t) (phy_id_high << 16);
     udelay(20);
     if(e1000_read_phy_reg(hw, PHY_ID2, &phy_id_low) < 0) {
-        DEBUGOUT("PHY Read Error\n");
+        DEBUGOUT1(EMSG_DEV_PHY_READ, hw->back->adapter->netdev->name);
         return -E1000_ERR_PHY;
     }
     hw->phy_id |= (uint32_t) (phy_id_low & PHY_REVISION_MASK);
@@ -2406,7 +2411,7 @@
         ret_val = 0;
     } while(0);
 
-    if(ret_val < 0) DEBUGOUT("PHY Write Error\n");
+    if(ret_val < 0) DEBUGOUT1(EMSG_DEV_PHY_WRITE, 
hw->back->adapter->netdev->name);
     return ret_val;
 }
 
@@ -2566,11 +2571,11 @@
     }
 
     if(e1000_read_phy_reg(hw, PHY_STATUS, &phy_data) < 0) {
-        DEBUGOUT("PHY Read Error\n");
+        DEBUGOUT1(EMSG_DEV_PHY_READ, hw->back->adapter->netdev->name);
         return -E1000_ERR_PHY;
     }
     if(e1000_read_phy_reg(hw, PHY_STATUS, &phy_data) < 0) {
-        DEBUGOUT("PHY Read Error\n");
+        DEBUGOUT1(EMSG_DEV_PHY_READ, hw->back->adapter->netdev->name);
         return -E1000_ERR_PHY;
     }
     if((phy_data & MII_SR_LINK_STATUS) != MII_SR_LINK_STATUS) {
@@ -3121,7 +3126,7 @@
 
     for(i = 0; i < (EEPROM_CHECKSUM_REG + 1); i++) {
         if(e1000_read_eeprom(hw, i, 1, &eeprom_data) < 0) {
-            DEBUGOUT("EEPROM Read Error\n");
+            DEBUGOUT1(EMSG_DEV_EEPROM_READ, 
hw->back->adapter->netdev->name);
             return -E1000_ERR_EEPROM;
         }
         checksum += eeprom_data;
@@ -3153,14 +3158,14 @@
 
     for(i = 0; i < EEPROM_CHECKSUM_REG; i++) {
         if(e1000_read_eeprom(hw, i, 1, &eeprom_data) < 0) {
-            DEBUGOUT("EEPROM Read Error\n");
+            DEBUGOUT1(EMSG_DEV_EEPROM_READ, 
hw->back->adapter->netdev->name);
             return -E1000_ERR_EEPROM;
         }
         checksum += eeprom_data;
     }
     checksum = (uint16_t) EEPROM_SUM - checksum;
     if(e1000_write_eeprom(hw, EEPROM_CHECKSUM_REG, 1, &checksum) < 0) {
-        DEBUGOUT("EEPROM Write Error\n");
+        DEBUGOUT1(EMSG_DEV_EEPROM_WRITE, hw->back->adapter->netdev->name);
         return -E1000_ERR_EEPROM;
     }
     return 0;
@@ -3381,7 +3386,7 @@
 
     /* Get word 0 from EEPROM */
     if(e1000_read_eeprom(hw, offset, 1, &eeprom_data) < 0) {
-        DEBUGOUT("EEPROM Read Error\n");
+        DEBUGOUT1(EMSG_DEV_EEPROM_READ, hw->back->adapter->netdev->name);
         return -E1000_ERR_EEPROM;
     }
     /* Save word 0 in upper half of part_num */
@@ -3389,7 +3394,7 @@
 
     /* Get word 1 from EEPROM */
     if(e1000_read_eeprom(hw, ++offset, 1, &eeprom_data) < 0) {
-        DEBUGOUT("EEPROM Read Error\n");
+        DEBUGOUT1(EMSG_DEV_EEPROM_READ, hw->back->adapter->netdev->name);
         return -E1000_ERR_EEPROM;
     }
     /* Save word 1 in lower half of part_num */
@@ -3415,7 +3420,7 @@
     for(i = 0; i < NODE_ADDRESS_SIZE; i += 2) {
         offset = i >> 1;
         if(e1000_read_eeprom(hw, offset, 1, &eeprom_data) < 0) {
-            DEBUGOUT("EEPROM Read Error\n");
+            DEBUGOUT1(EMSG_DEV_EEPROM_READ, 
hw->back->adapter->netdev->name);
             return -E1000_ERR_EEPROM;
         }
         hw->perm_mac_addr[i] = (uint8_t) (eeprom_data & 0x00FF);
@@ -3715,7 +3720,7 @@
     hw->ledctl_mode2 = hw->ledctl_default;
 
     if(e1000_read_eeprom(hw, EEPROM_ID_LED_SETTINGS, 1, &eeprom_data) < 
0) {
-        DEBUGOUT("EEPROM Read Error\n");
+        DEBUGOUT1(EMSG_DEV_EEPROM_READ, hw->back->adapter->netdev->name);
         return -E1000_ERR_EEPROM;
     }
     if((eeprom_data== ID_LED_RESERVED_0000) ||
@@ -3807,7 +3812,7 @@
         E1000_WRITE_REG(hw, LEDCTL, hw->ledctl_mode1);
         break;
     default:
-        DEBUGOUT("Invalid device ID\n");
+        DEBUGOUT1(EMSG_PCI_BAD_ID, hw->back->adapter->netdev->name);
         return -E1000_ERR_CONFIG;
     }
     return 0;
@@ -3849,7 +3854,7 @@
         E1000_WRITE_REG(hw, LEDCTL, hw->ledctl_default);
         break;
     default:
-        DEBUGOUT("Invalid device ID\n");
+        DEBUGOUT1(EMSG_PCI_BAD_ID, hw->back->adapter->netdev->name);
         return -E1000_ERR_CONFIG;
     }
     return 0;
@@ -3902,7 +3907,7 @@
         E1000_WRITE_REG(hw, LEDCTL, hw->ledctl_mode2);
         break;
     default:
-        DEBUGOUT("Invalid device ID\n");
+        DEBUGOUT1(EMSG_PCI_BAD_ID, hw->back->adapter->netdev->name);
         return -E1000_ERR_CONFIG;
     }
     return 0;
@@ -3955,7 +3960,7 @@
         E1000_WRITE_REG(hw, LEDCTL, hw->ledctl_mode1);
         break;
     default:
-        DEBUGOUT("Invalid device ID\n");
+        DEBUGOUT1(EMSG_PCI_BAD_ID, hw->back->adapter->netdev->name);
         return -E1000_ERR_CONFIG;
     }
     return 0;
@@ -4468,14 +4473,14 @@
 
     if(hw->phy_type == e1000_phy_igp) {
         if(e1000_read_phy_reg(hw, IGP01E1000_PHY_LINK_HEALTH, 
&phy_data) < 0) {
-            DEBUGOUT("PHY Read Error\n");
+            DEBUGOUT1(EMSG_DEV_PHY_READ, hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
         hw->speed_downgraded = (phy_data & 
IGP01E1000_PLHR_SS_DOWNGRADE) ? 1 : 0;
     }
     else if(hw->phy_type == e1000_phy_m88) {
         if(e1000_read_phy_reg(hw, M88E1000_PHY_SPEC_STATUS, &phy_data) 
< 0) {
-            DEBUGOUT("PHY Read Error\n");
+            DEBUGOUT1(EMSG_DEV_PHY_READ, hw->back->adapter->netdev->name);
             return -E1000_ERR_PHY;
         }
         hw->speed_downgraded = (phy_data & M88E1000_PSSR_DOWNSHIFT) >>
diff -Naur linux-2.5.69.orig/drivers/net/e1000/e1000_main.c 
linux-2.5.69.newMsgs/drivers/net/e1000/e1000_main.c
--- linux-2.5.69.orig/drivers/net/e1000/e1000_main.c    2003-06-04 
13:24:46.000000000 -0500
+++ linux-2.5.69.newMsgs/drivers/net/e1000/e1000_main.c    2003-06-04 
13:14:58.000000000 -0500
@@ -27,6 +27,7 @@
 *******************************************************************************/
 
 #include "e1000.h"
+#include <linux/stdmsgs.h>
 
 /* Change Log
  *
@@ -228,10 +229,11 @@
 e1000_init_module(void)
 {
     int ret;
-    printk(KERN_INFO "%s - version %s\n",
-           e1000_driver_string, e1000_driver_version);
 
-    printk(KERN_INFO "%s\n", e1000_copyright);
+    printk(KERN_INFO EMSG_BASICS, e1000_driver_name ,
+            e1000_driver_string , e1000_driver_version);
+
+    printk(KERN_INFO "       %s\n", e1000_copyright);
 
     ret = pci_module_init(&e1000_driver);
     if(ret >= 0)
@@ -508,6 +510,22 @@
     netif_stop_queue(netdev);
 
     printk(KERN_INFO "%s: %s\n", netdev->name, adapter->id_string);
+
+    if (netdev->features & NETIF_F_SG)
+        printk(KERN_INFO EMSG_NET_SGATHER, netdev->name);
+    else
+        printk(KERN_INFO EMSG_NET_NO_SGATHER, netdev->name);
+
+    if (netdev->features & NETIF_F_HW_CSUM) {
+        printk(KERN_INFO EMSG_NET_HW_CSUMS, netdev->name);
+    } else {
+      if (netdev->features & NETIF_F_IP_CSUM)
+        printk(KERN_INFO EMSG_NET_CSUMS, netdev->name);
+      else
+        printk(KERN_INFO EMSG_NET_NO_CSUMS, netdev->name);
+    }
+
+
     e1000_check_options(adapter);
 
     /* Initial Wake on LAN setting
@@ -597,9 +615,11 @@
     hw->subsystem_vendor_id = pdev->subsystem_vendor;
     hw->subsystem_id = pdev->subsystem_device;
 
-    pci_read_config_byte(pdev, PCI_REVISION_ID, &hw->revision_id);
+    if (pci_read_config_byte(pdev, PCI_REVISION_ID, &hw->revision_id))
+        printk(KERN_ERR EMSG_PCI_READ, netdev->name);
 
-    pci_read_config_word(pdev, PCI_COMMAND, &hw->pci_cmd_word);
+    if (pci_read_config_word(pdev, PCI_COMMAND, &hw->pci_cmd_word))
+        printk(KERN_ERR EMSG_PCI_READ, netdev->name);
 
     adapter->rx_buffer_len = E1000_RXBUFFER_2048;
     hw->max_frame_size = netdev->mtu +
@@ -1334,6 +1354,7 @@
 
             adapter->tx_fifo_head = 0;
             atomic_set(&adapter->tx_fifo_stall, 0);
+            printk(KERN_INFO EMSG_NET_START_QUEUE,  netdev->name );
             netif_wake_queue(netdev);
         } else {
             mod_timer(&adapter->tx_fifo_stall_timer, jiffies + 1);
@@ -1361,13 +1382,10 @@
             e1000_get_speed_and_duplex(&adapter->hw,
                                        &adapter->link_speed,
                                        &adapter->link_duplex);
-
-            printk(KERN_INFO
-                   "e1000: %s NIC Link is Up %d Mbps %s\n",
+            printk(KERN_INFO EMSG_NET_LINK_UP,
                    netdev->name, adapter->link_speed,
                    adapter->link_duplex == FULL_DUPLEX ?
-                   "Full Duplex" : "Half Duplex");
-
+                   "full" : "half");
             netif_carrier_on(netdev);
             netif_wake_queue(netdev);
             mod_timer(&adapter->phy_info_timer, jiffies + 2 * HZ);
@@ -1375,13 +1393,14 @@
         }
     } else {
         if(netif_carrier_ok(netdev)) {
+            uint16_t mii_status_reg;
             adapter->link_speed = 0;
             adapter->link_duplex = 0;
-            printk(KERN_INFO
-                   "e1000: %s NIC Link is Down\n",
-                   netdev->name);
+            e1000_read_phy_reg(&adapter->hw, PHY_STATUS,
+                              &mii_status_reg);
+            printk(KERN_INFO EMSG_NET_LINK_FAIL,
+                   netdev->name, mii_status_reg);
             netif_carrier_off(netdev);
-            netif_stop_queue(netdev);
             mod_timer(&adapter->phy_info_timer, jiffies + 2 * HZ);
         }
 
@@ -1420,9 +1439,21 @@
     i = txdr->next_to_clean;
     if(txdr->buffer_info[i].dma &&
        time_after(jiffies, txdr->buffer_info[i].time_stamp + HZ) &&
-       !(E1000_READ_REG(&adapter->hw, STATUS) & E1000_STATUS_TXOFF))
+       !(E1000_READ_REG(&adapter->hw, STATUS) & E1000_STATUS_TXOFF)) {
+        printk(KERN_INFO EMSG_NET_HUNG, netdev->name );
         netif_stop_queue(netdev);
+    }
 
+       /*
+    * Need to add some code here to see if an individual tx has timed out.
+    * Right now we only look for hangs when the entire tx buffer fills up
+    * and there is nowhere to put an in-bound transmit packet.  Then we
+    * could log the following error:
+    *
+    * netdev_err(netdev, EMSG_NET_TX_ERR);
+    *
+    */
+   
     /* Reset the timer */
     mod_timer(&adapter->watchdog_timer, jiffies + 2 * HZ);
 }
@@ -1697,12 +1728,14 @@
     }
 
     if(E1000_DESC_UNUSED(&adapter->tx_ring) < DESC_NEEDED) {
+        printk(KERN_INFO EMSG_NET_STOP_QUEUE,  netdev->name );
         netif_stop_queue(netdev);
         return 1;
     }
 
     if(adapter->hw.mac_type == e1000_82547) {
         if(e1000_82547_fifo_workaround(adapter, skb)) {
+            printk(KERN_INFO EMSG_NET_STOP_QUEUE,  netdev->name );
             netif_stop_queue(netdev);
             mod_timer(&adapter->tx_fifo_stall_timer, jiffies);
             return 1;
@@ -1828,6 +1861,8 @@
     struct e1000_hw *hw = &adapter->hw;
     unsigned long flags;
     uint16_t phy_tmp;
+    unsigned long rx_errors;
+    unsigned long tx_errors;
 
 #define PHY_IDLE_ERROR_COUNT_MASK 0x00FF
 
@@ -1920,10 +1955,14 @@
 
     /* Rx Errors */
 
+    rx_errors = adapter->net_stats.rx_errors;
     adapter->net_stats.rx_errors = adapter->stats.rxerrc +
         adapter->stats.crcerrs + adapter->stats.algnerrc +
         adapter->stats.rlec + adapter->stats.rnbc +
         adapter->stats.mpc + adapter->stats.cexterr;
+    if (rx_errors != adapter->net_stats.rx_errors)
+        printk(KERN_INFO EMSG_NET_RX_ERR, adapter->ifname,
+                adapter->net_stats.rx_errors);
     adapter->net_stats.rx_dropped = adapter->stats.rnbc;
     adapter->net_stats.rx_length_errors = adapter->stats.rlec;
     adapter->net_stats.rx_crc_errors = adapter->stats.crcerrs;
@@ -1933,8 +1972,12 @@
 
     /* Tx Errors */
 
+    tx_errors = adapter->net_stats.tx_errors;
     adapter->net_stats.tx_errors = adapter->stats.ecol +
                                    adapter->stats.latecol;
+    if ( tx_errors != adapter->net_stats.tx_errors)
+        printk(KERN_INFO EMSG_NET_TX_ERR, adapter->ifname,
+                adapter->net_stats.tx_errors);
     adapter->net_stats.tx_aborted_errors = adapter->stats.ecol;
     adapter->net_stats.tx_window_errors = adapter->stats.latecol;
     adapter->net_stats.tx_carrier_errors = adapter->stats.tncrs;
@@ -2105,8 +2148,10 @@
 
     tx_ring->next_to_clean = i;
 
-    if(cleaned && netif_queue_stopped(netdev) && netif_carrier_ok(netdev))
+    if(cleaned && netif_queue_stopped(netdev) && 
netif_carrier_ok(netdev)) {
+        printk(KERN_INFO EMSG_NET_START_QUEUE,  netdev->name );
         netif_wake_queue(netdev);
+    }
 
     return cleaned;
 }
@@ -2516,7 +2561,8 @@
 {
     struct e1000_adapter *adapter = hw->back;
 
-    pci_read_config_word(adapter->pdev, reg, value);
+    if (pci_read_config_word(adapter->pdev, reg, value))
+        printk(KERN_ERR EMSG_PCI_READ, adapter->netdev->name);
 }
 
 void
@@ -2524,7 +2570,8 @@
 {
     struct e1000_adapter *adapter = hw->back;
 
-    pci_write_config_word(adapter->pdev, reg, *value);
+    if (pci_write_config_word(adapter->pdev, reg, *value))
+        printk(KERN_ERR EMSG_PCI_WRITE, adapter->netdev->name);
 }
 
 uint32_t
diff -Naur linux-2.5.69.orig/drivers/net/e1000/e1000_param.c 
linux-2.5.69.newMsgs/drivers/net/e1000/e1000_param.c
--- linux-2.5.69.orig/drivers/net/e1000/e1000_param.c    2003-06-04 
13:24:46.000000000 -0500
+++ linux-2.5.69.newMsgs/drivers/net/e1000/e1000_param.c    2003-06-04 
13:14:58.000000000 -0500
@@ -27,6 +27,7 @@
 *******************************************************************************/
 
 #include "e1000.h"
+#include <linux/stdmsgs.h>
 
 /* This is the only thing that needs to be changed to adjust the
  * maximum number of ports that the driver can manage.
@@ -244,7 +245,8 @@
 };
 
 static int __devinit
-e1000_validate_option(int *value, struct e1000_option *opt)
+e1000_validate_option(struct e1000_adapter *adapter, int *value,
+        struct e1000_option *opt)
 {
     if(*value == OPTION_UNSET) {
         *value = opt->def;
@@ -255,16 +257,19 @@
     case enable_option:
         switch (*value) {
         case OPTION_ENABLED:
-            printk(KERN_INFO "%s Enabled\n", opt->name);
+            printk(KERN_INFO EMSG_DEV_CFG_ENABLED,
+                    adapter->netdev->name, opt->name);
             return 0;
         case OPTION_DISABLED:
-            printk(KERN_INFO "%s Disabled\n", opt->name);
+            printk(KERN_INFO EMSG_DEV_CFG_DISABLED,
+                    adapter->netdev->name, opt->name);
             return 0;
         }
         break;
     case range_option:
         if(*value >= opt->arg.r.min && *value <= opt->arg.r.max) {
-            printk(KERN_INFO "%s set to %i\n", opt->name, *value);
+            printk(KERN_INFO EMSG_DEV_CFG_ISET,
+                    adapter->netdev->name, opt->name, *value);
             return 0;
         }
         break;
@@ -330,7 +335,7 @@
             MAX_TXD : MAX_82544_TXD;
 
         tx_ring->count = TxDescriptors[bd];
-        e1000_validate_option(&tx_ring->count, &opt);
+        e1000_validate_option(adapter, &tx_ring->count, &opt);
         E1000_ROUNDUP(tx_ring->count, REQ_TX_DESCRIPTOR_MULTIPLE);
     }
     { /* Receive Descriptor Count */
@@ -346,7 +351,7 @@
         opt.arg.r.max = mac_type < e1000_82544 ? MAX_RXD : MAX_82544_RXD;
 
         rx_ring->count = RxDescriptors[bd];
-        e1000_validate_option(&rx_ring->count, &opt);
+        e1000_validate_option(adapter, &rx_ring->count, &opt);
         E1000_ROUNDUP(rx_ring->count, REQ_RX_DESCRIPTOR_MULTIPLE);
     }
     { /* Checksum Offload Enable/Disable */
@@ -358,7 +363,7 @@
         };
 
         int rx_csum = XsumRX[bd];
-        e1000_validate_option(&rx_csum, &opt);
+        e1000_validate_option(adapter, &rx_csum, &opt);
         adapter->rx_csum = rx_csum;
     }
     { /* Flow Control */
@@ -380,7 +385,7 @@
         };
 
         int fc = FlowControl[bd];
-        e1000_validate_option(&fc, &opt);
+        e1000_validate_option(adapter, &fc, &opt);
         adapter->hw.fc = adapter->hw.original_fc = fc;
     }
     { /* Transmit Interrupt Delay */
@@ -394,7 +399,7 @@
         };
 
         adapter->tx_int_delay = TxIntDelay[bd];
-        e1000_validate_option(&adapter->tx_int_delay, &opt);
+        e1000_validate_option(adapter, &adapter->tx_int_delay, &opt);
     }
     { /* Transmit Absolute Interrupt Delay */
         struct e1000_option opt = {
@@ -407,7 +412,7 @@
         };
 
         adapter->tx_abs_int_delay = TxAbsIntDelay[bd];
-        e1000_validate_option(&adapter->tx_abs_int_delay, &opt);
+        e1000_validate_option(adapter, &adapter->tx_abs_int_delay, &opt);
     }
     { /* Receive Interrupt Delay */
         struct e1000_option opt = {
@@ -420,7 +425,7 @@
         };
 
         adapter->rx_int_delay = RxIntDelay[bd];
-        e1000_validate_option(&adapter->rx_int_delay, &opt);
+        e1000_validate_option(adapter, &adapter->rx_int_delay, &opt);
     }
     { /* Receive Absolute Interrupt Delay */
         struct e1000_option opt = {
@@ -433,7 +438,7 @@
         };
 
         adapter->rx_abs_int_delay = RxAbsIntDelay[bd];
-        e1000_validate_option(&adapter->rx_abs_int_delay, &opt);
+        e1000_validate_option(adapter, &adapter->rx_abs_int_delay, &opt);
     }
     { /* Interrupt Throttling Rate */
         struct e1000_option opt = {
@@ -452,7 +457,7 @@
             /* Dynamic mode */
             adapter->itr = 1;
         } else {
-            e1000_validate_option(&adapter->itr, &opt);
+            e1000_validate_option(adapter, &adapter->itr, &opt);
         }
     }
 
@@ -525,7 +530,7 @@
         };
 
         speed = Speed[bd];
-        e1000_validate_option(&speed, &opt);
+        e1000_validate_option(adapter, &speed, &opt);
     }
     { /* Duplex */
         struct e1000_opt_list dplx_list[] = {{           0, "" },
@@ -542,7 +547,7 @@
         };
 
         dplx = Duplex[bd];
-        e1000_validate_option(&dplx, &opt);
+        e1000_validate_option(adapter, &dplx, &opt);
     }
 
     if(AutoNeg[bd] != OPTION_UNSET && (speed != 0 || dplx != 0)) {
@@ -595,7 +600,7 @@
         };
 
         int an = AutoNeg[bd];
-        e1000_validate_option(&an, &opt);
+        e1000_validate_option(adapter, &an, &opt);
         adapter->hw.autoneg_advertised = an;
     }
 
diff -Naur linux-2.5.69.orig/drivers/net/tg3.c 
linux-2.5.69.newMsgs/drivers/net/tg3.c
--- linux-2.5.69.orig/drivers/net/tg3.c    2003-06-04 13:24:35.000000000 
-0500
+++ linux-2.5.69.newMsgs/drivers/net/tg3.c    2003-06-04 
13:15:45.000000000 -0500
@@ -26,6 +26,7 @@
 #include <linux/ip.h>
 #include <linux/tcp.h>
 #include <linux/workqueue.h>
+#include <linux/stdmsgs.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -347,6 +348,7 @@
         udelay(40);
     }
 
+    if (ret) printk(KERN_ERR EMSG_DEV_PHY_READ, tp->dev->name);
     return ret;
 }
 
@@ -393,6 +395,7 @@
         udelay(40);
     }
 
+    if (ret) printk(KERN_ERR EMSG_DEV_PHY_WRITE, tp->dev->name);
     return ret;
 }
 
@@ -634,9 +637,11 @@
 static void tg3_link_report(struct tg3 *tp)
 {
     if (!netif_carrier_ok(tp->dev)) {
-        printk(KERN_INFO PFX "%s: Link is down.\n", tp->dev->name);
+        u32 mii_regval;
+        tg3_readphy(tp, MII_TG3_PHY_STAT, &mii_regval);
+        printk(KERN_INFO EMSG_NET_LINK_FAIL, tp->dev->name, mii_regval);
     } else {
-        printk(KERN_INFO PFX "%s: Link is up at %d Mbps, %s duplex.\n",
+        printk(KERN_INFO  EMSG_NET_LINK_UP,
                tp->dev->name,
                (tp->link_config.active_speed == SPEED_1000 ?
             1000 :
@@ -1780,8 +1785,10 @@
     tp->tx_cons = sw_idx;
 
     if (netif_queue_stopped(tp->dev) &&
-        (TX_BUFFS_AVAIL(tp) > TG3_TX_WAKEUP_THRESH))
+        (TX_BUFFS_AVAIL(tp) > TG3_TX_WAKEUP_THRESH)) {
+        printk(KERN_INFO EMSG_NET_START_QUEUE, tp->dev->name);
         netif_wake_queue(tp->dev);
+    }
 }
 
 /* Returns size of skb allocated or < 0 on error.
@@ -2580,8 +2587,10 @@
     }
 
     tp->tx_prod = entry;
-    if (TX_BUFFS_AVAIL(tp) <= (MAX_SKB_FRAGS + 1))
+    if (TX_BUFFS_AVAIL(tp) <= (MAX_SKB_FRAGS + 1)) {
+        printk(KERN_INFO EMSG_NET_STOP_QUEUE, dev->name);
         netif_stop_queue(dev);
+    }
 
 out_unlock:
     spin_unlock_irqrestore(&tp->tx_lock, flags);
@@ -2727,8 +2736,10 @@
     }
 
     tp->tx_prod = entry;
-    if (TX_BUFFS_AVAIL(tp) <= (MAX_SKB_FRAGS + 1))
+    if (TX_BUFFS_AVAIL(tp) <= (MAX_SKB_FRAGS + 1)) {
+        printk(KERN_INFO EMSG_NET_STOP_QUEUE, dev->name);
         netif_stop_queue(dev);
+    }
 
     spin_unlock_irqrestore(&tp->tx_lock, flags);
 
@@ -3436,10 +3447,7 @@
     }
 
     if (i >= 10000) {
-        printk(KERN_ERR PFX "tg3_reset_cpu timed out for %s, "
-               "and %s CPU\n",
-               tp->dev->name,
-               (offset == RX_CPU_BASE ? "RX" : "TX"));
+        printk(KERN_ERR EMSG_DEV_SW_RESET, tp->dev->name);
         return -ENODEV;
     }
     return 0;
@@ -4462,7 +4470,7 @@
     tw32(TG3PCI_MEM_WIN_BASE_ADDR, 0);
 
     err = tg3_reset_hw(tp);
-
+    if (err) printk( KERN_ERR EMSG_DEV_SW_RESET, tp->dev->name);
 out:
     return err;
 }
@@ -4963,11 +4971,15 @@
 
     stats->rx_errors = old_stats->rx_errors +
         get_stat64(&hw_stats->rx_errors);
+    if (stats->rx_errors != old_stats->rx_errors)
+        printk(KERN_INFO EMSG_NET_RX_ERR, dev->name, stats->rx_errors);
     stats->tx_errors = old_stats->tx_errors +
         get_stat64(&hw_stats->tx_errors) +
         get_stat64(&hw_stats->tx_mac_errors) +
         get_stat64(&hw_stats->tx_carrier_sense_errors) +
         get_stat64(&hw_stats->tx_discards);
+    if (stats->tx_errors != old_stats->tx_errors)
+        printk(KERN_INFO EMSG_NET_TX_ERR, dev->name, stats->tx_errors);
 
     stats->multicast = old_stats->multicast +
         get_stat64(&hw_stats->rx_mcast_packets);
@@ -5661,8 +5673,10 @@
     int i;
 
     if (offset > EEPROM_ADDR_ADDR_MASK ||
-        (offset % 4) != 0)
+        (offset % 4) != 0) {
+        printk(KERN_ERR EMSG_DEV_EEPROM_READ, tp->dev->name);
         return -EINVAL;
+    }
 
     tmp = tr32(GRC_EEPROM_ADDR) & ~(EEPROM_ADDR_ADDR_MASK |
                     EEPROM_ADDR_DEVID_MASK |
@@ -5681,8 +5695,10 @@
             break;
         udelay(100);
     }
-    if (!(tmp & EEPROM_ADDR_COMPLETE))
+    if (!(tmp & EEPROM_ADDR_COMPLETE)) {
+        printk(KERN_ERR EMSG_NET_HUNG, tp->dev->name);
         return -EBUSY;
+    }
 
     *val = tr32(GRC_EEPROM_DATA);
     return 0;
@@ -5875,8 +5891,10 @@
          */
         if (tp->phy_id == PHY_ID_INVALID) {
             if (!eeprom_signature_found ||
-                !KNOWN_PHY_ID(eeprom_phy_id & PHY_ID_MASK))
+                !KNOWN_PHY_ID(eeprom_phy_id & PHY_ID_MASK)) {
+                printk(KERN_ERR EMSG_PCI_BAD_ID, tp->dev->name);
                 return -ENODEV;
+            }
             tp->phy_id = eeprom_phy_id;
         }
     }
@@ -5953,6 +5971,7 @@
             ~(ADVERTISED_1000baseT_Half |
               ADVERTISED_1000baseT_Full);
 
+    if (err) printk(KERN_ERR EMSG_DEV_PHY_READ, tp->dev->name);
     return err;
 }
 
@@ -6046,9 +6065,11 @@
      * workaround but turns MWI off all the times so never uses
      * it.  This seems to suggest that the workaround is insufficient.
      */
-    pci_read_config_word(tp->pdev, PCI_COMMAND, &pci_cmd);
+    if (pci_read_config_word(tp->pdev, PCI_COMMAND, &pci_cmd))
+        printk(KERN_ERR EMSG_PCI_READ, tp->dev->name);
     pci_cmd &= ~PCI_COMMAND_INVALIDATE;
-    pci_write_config_word(tp->pdev, PCI_COMMAND, pci_cmd);
+    if (pci_write_config_word(tp->pdev, PCI_COMMAND, pci_cmd))
+        printk(KERN_ERR EMSG_PCI_WRITE, tp->dev->name);
 
     /* It is absolutely critical that TG3PCI_MISC_HOST_CTRL
      * has the register indirect write enable bit set before
@@ -6056,8 +6077,9 @@
      * critical that the PCI-X hw workaround situation is decided
      * before that as well.
      */
-    pci_read_config_dword(tp->pdev, TG3PCI_MISC_HOST_CTRL,
-                  &misc_ctrl_reg);
+    if (pci_read_config_dword(tp->pdev, TG3PCI_MISC_HOST_CTRL,
+                  &misc_ctrl_reg))
+        printk(KERN_ERR EMSG_PCI_READ, tp->dev->name);
 
     tp->pci_chip_rev_id = (misc_ctrl_reg >>
                    MISC_HOST_CTRL_CHIPREV_SHIFT);
@@ -6870,6 +6892,20 @@
     } else
         tp->tg3_flags &= ~TG3_FLAG_RX_CHECKSUMS;
 
+    if (dev->features & NETIF_F_SG)
+        printk(KERN_INFO EMSG_NET_SGATHER, dev->name);
+    else
+        printk(KERN_INFO EMSG_NET_NO_SGATHER, dev->name);
+
+    if (dev->features & NETIF_F_HW_CSUM) {
+        printk(KERN_INFO EMSG_NET_HW_CSUMS, dev->name);
+    } else {
+        if (dev->features & NETIF_F_IP_CSUM)
+                   printk(KERN_INFO EMSG_NET_CSUMS, dev->name);
+        else
+            printk(KERN_INFO EMSG_NET_NO_CSUMS, dev->name);
+    }
+
 #if TG3_DO_TSO != 0
     if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5700 ||
         (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5701 &&
@@ -7027,6 +7063,8 @@
 
 static int __init tg3_init(void)
 {
+        printk(KERN_INFO EMSG_BASICS, DRV_MODULE_NAME,
+        "Broadcom Tigon3 ethernet driver" , DRV_MODULE_VERSION);
     return pci_module_init(&tg3_driver);
 }
 
diff -Naur linux-2.5.69.orig/drivers/net/tg3.h 
linux-2.5.69.newMsgs/drivers/net/tg3.h
--- linux-2.5.69.orig/drivers/net/tg3.h    2003-06-04 13:24:35.000000000 
-0500
+++ linux-2.5.69.newMsgs/drivers/net/tg3.h    2003-06-04 
13:15:45.000000000 -0500
@@ -1319,6 +1319,8 @@
 /* Tigon3 specific PHY MII registers. */
 #define  TG3_BMCR_SPEED1000        0x0040
 
+#define MII_TG3_PHY_STAT        0x01 /* Status Register*/
+
 #define MII_TG3_CTRL            0x09 /* 1000-baseT control register */
 #define  MII_TG3_CTRL_ADV_1000_HALF    0x0100
 #define  MII_TG3_CTRL_ADV_1000_FULL    0x0200
diff -Naur linux-2.5.69.orig/include/linux/stdmsgs.h 
linux-2.5.69.newMsgs/include/linux/stdmsgs.h
--- linux-2.5.69.orig/include/linux/stdmsgs.h    1969-12-31 
18:00:00.000000000 -0600
+++ linux-2.5.69.newMsgs/include/linux/stdmsgs.h    2003-06-10 
10:44:12.000000000 -0500
@@ -0,0 +1,57 @@
+#ifndef _STDMSGS_
+#define _STDMSGS_
+
+/*
+ * Some common error messages for logging.
+ *
+ * Note: the "%s:" text preceeding each message
+ *       is used to describe the device name for
+ *       messages unique to a specific piece of h/w,
+ *       or the device driver name otherwise.
+ *
+
+/*********************************************************
+ * common system errors/msgs
+ */
+#define EMSG_BASICS        "%s: %s - version %s\n"
+#define EMGS_NOMEM
+
+
+/*********************************************************
+ * device errors/msgs
+ */
+#define EMSG_DEV_EEPROM_READ    "%s: hardware failure: EEPROM read error\n"
+#define EMSG_DEV_EEPROM_WRITE    "%s: hardware failure: EEPROM write 
error\n"
+#define EMSG_DEV_PHY_READ    "%s: hardware failure: read error on 
physical interface\n"
+#define EMSG_DEV_PHY_WRITE    "%s: hardware failure: write error on 
physical interface\n"
+#define EMSG_DEV_SW_RESET    "%s: software failure: unable to reset 
device \n"
+#define EMSG_DEV_CFG_ENABLED    "%s: configuration note: %s enabled\n"
+#define EMSG_DEV_CFG_DISABLED    "%s: configuration note: %s disabled\n"
+#define EMSG_DEV_CFG_ISET    "%s: configuration note: %s set to %i\n"
+
+
+
+/*********************************************************
+ * network errors/msgs
+ */
+#define EMSG_NET_LINK_FAIL    "%s: transient problem: link error 
detected - MII status %x\n"
+#define EMSG_NET_LINK_UP    "%s: state change: link up, %d Mbps, 
%s-duplex\n"
+#define EMSG_NET_HUNG        "%s: software failure: ethernet controller 
hung\n"
+#define EMSG_NET_RX_ERR        "%s: transient problem: packet receive 
error, rx_errors = %ld\n"
+#define EMSG_NET_TX_ERR        "%s: transient problem: packet transmit 
error, tx_errors = %ld\n"
+#define EMSG_NET_START_QUEUE    "%s: performance event: (re)starting 
netdev queue\n"
+#define EMSG_NET_STOP_QUEUE    "%s: performance event: stopping netdev 
queue\n"
+#define EMSG_NET_SGATHER    "%s: scatter/gather I/O enabled\n"
+#define EMSG_NET_NO_SGATHER    "%s: performance event: scatter/gather 
I/O disabled\n"   
+#define EMSG_NET_HW_CSUMS    "%s: all IP checksums on transmit 
enabled\n"   
+#define EMSG_NET_CSUMS        "%s: TCP/UDP over IPv6 checksums on 
transmit enabled\n"   
+#define EMSG_NET_NO_CSUMS    "%s: performance event: IP checksums on 
transmit disabled\n"
+
+/*********************************************************
+ * PCI device errors/msgs
+ */
+#define EMSG_PCI_BAD_ID        "%s: invalid device ID in PCI config 
header\n"
+#define EMSG_PCI_READ        "%s: hardware failure: PCI read error \n"
+#define EMSG_PCI_WRITE      "%s: hardware failure: PCI write error \n"
+
+#endif /* _STDMSGS_ */





