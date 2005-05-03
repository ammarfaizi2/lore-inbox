Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVECP2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVECP2f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 11:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVECP2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 11:28:34 -0400
Received: from optimus.nocdirect.com ([69.73.171.5]:28639 "EHLO
	optimus.nocdirect.com") by vger.kernel.org with ESMTP
	id S261778AbVECP2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 11:28:10 -0400
From: Benjamin Reed <breed@zuzulu.com>
To: netdev@oss.sgi.com
Subject: [PATCH] dynamic wep keys for airo.c
Date: Tue, 3 May 2005 08:26:42 -0700
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200505030826.42564.breed@zuzulu.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - optimus.nocdirect.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - zuzulu.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm resubmitting a patch for the 2.6.11.8 aironet driver (airo.c) that will 
enable dynamic wep keying without disabling the MAC. It allows 
us to use xsupplicant with the driver.

Aironet provides the ability to set WEP keys permanently or 
temporarily. There is a special IW_ENCODE_TEMP flag for selecting
 which type of key you are setting. However, apart from iwconfig, 
nobody seems to use this flag. When a permanent WEP key is set, 
the MAC must be disabled. I have added a module parameter to skip
 disabling the MAC even if a permanent WEP key is set. Using this 
flag allows xsupplicant to work without modification.

ben

Signed-off-by: Benjamin Reed <breed@zuzulu.com>

--- drivers/net/wireless/airo.c.orig 2005-05-02 10:15:24.000000000 -0700
+++ drivers/net/wireless/airo.c 2005-05-02 11:16:43.000000000 -0700
@@ -224,6 +224,8 @@ static
 int maxencrypt /* = 0 */; /* The highest rate that the card can encrypt at.
          0 means no limit.  For old cards this was 4 */
 
+static int perm_key_support = 1; /* If set, the MAC will be disabled when 
+        permanent wep keys are set. */
 static int auto_wep /* = 0 */; /* If set, it tries to figure out the wep mode */
 static int aux_bap /* = 0 */; /* Checks to see if the aux ports are needed to read
       the bap, needed on some older cards and buses. */
@@ -251,6 +253,13 @@ module_param(basic_rate, int, 0);
 module_param_array(rates, int, NULL, 0);
 module_param_array(ssids, charp, NULL, 0);
 module_param(auto_wep, int, 0);
+module_param(perm_key_support, int, 1);
+MODULE_PARM_DESC(perm_key_support, "The MAC is supposed to be disabled before \
+a permanent WEP key (the default) is set. Applications that want to set the \
+temporary keys, and thus not disable the MAC, are supposed to use the \
+IW_ENCODE_TEMP flag. Unfortunately, life doesn't always work the way it is \
+supposed to. If the IW_ENCODE_TEMP flag is not used and the MAC should not be \
+disabled, set this flag to 0.");
 MODULE_PARM_DESC(auto_wep, "If non-zero, the driver will keep looping through \
 the authentication options until an association is made.  The value of \
 auto_wep is number of the wep keys to check.  A value of 2 will try using \
@@ -1738,9 +1747,12 @@ static int writeWepKeyRid(struct airo_in
  rc = PC4500_writerid(ai, RID_WEP_TEMP, &wkr, sizeof(wkr), lock);
  if (rc!=SUCCESS) printk(KERN_ERR "airo:  WEP_TEMP set %x\n", rc);
  if (perm) {
+  // We make these messages debug. They really should be error,
+  // but no one seems to use the TEMP flag and writing a PERM key
+  // with the MAC disable throws this error
   rc = PC4500_writerid(ai, RID_WEP_PERM, &wkr, sizeof(wkr), lock);
   if (rc!=SUCCESS) {
-   printk(KERN_ERR "airo:  WEP_PERM set %x\n", rc);
+   printk(KERN_DEBUG "airo:  WEP_PERM set %x\n", rc);
   }
  }
  return rc;
@@ -3813,11 +3825,14 @@ static u16 issuecommand(struct airo_info
  pRsp->rsp1 = IN4500(ai, RESP1);
  pRsp->rsp2 = IN4500(ai, RESP2);
  if ((pRsp->status & 0xff00)!=0 && pCmd->cmd != CMD_SOFTRESET) {
-  printk (KERN_ERR "airo: cmd= %x\n", pCmd->cmd);
-  printk (KERN_ERR "airo: status= %x\n", pRsp->status);
-  printk (KERN_ERR "airo: Rsp0= %x\n", pRsp->rsp0);
-  printk (KERN_ERR "airo: Rsp1= %x\n", pRsp->rsp1);
-  printk (KERN_ERR "airo: Rsp2= %x\n", pRsp->rsp2);
+  /* These really should be error, but supplicants don't seem
+   * to use the TEMP flag when setting the keys, so this
+   * error is common */
+  printk (KERN_DEBUG "airo: cmd= %x\n", pCmd->cmd);
+  printk (KERN_DEBUG "airo: status= %x\n", pRsp->status);
+  printk (KERN_DEBUG "airo: Rsp0= %x\n", pRsp->rsp0);
+  printk (KERN_DEBUG "airo: Rsp1= %x\n", pRsp->rsp1);
+  printk (KERN_DEBUG "airo: Rsp2= %x\n", pRsp->rsp2);
  }
 
  // clear stuck command busy if necessary
@@ -4046,10 +4061,12 @@ static int PC4500_writerid(struct airo_i
   Cmd cmd;
   Resp rsp;
 
+#if 0 /* This check is to catch bugs, not needed for WepRid with temp key */
   if (test_bit(FLAG_ENABLED, &ai->flags))
    printk(KERN_ERR
     "%s: MAC should be disabled (rid=%04x)\n",
     __FUNCTION__, rid);
+#endif
   memset(&cmd, 0, sizeof(cmd));
   memset(&rsp, 0, sizeof(rsp));
 
@@ -5094,7 +5111,7 @@ static int set_wep_key(struct airo_info 
   wkr.len = sizeof(wkr);
   wkr.kindex = 0xffff;
   wkr.mac[0] = (char)index;
-  if (perm) printk(KERN_INFO "Setting transmit key to %d\n", index);
+  if (perm) printk(KERN_DEBUG "Setting transmit key to %d\n", index);
   if (perm) ai->defindex = (char)index;
  } else {
 // We are actually setting the key
@@ -5103,12 +5120,11 @@ static int set_wep_key(struct airo_info 
   wkr.klen = keylen;
   memcpy( wkr.key, key, keylen );
   memcpy( wkr.mac, macaddr, ETH_ALEN );
-  printk(KERN_INFO "Setting key %d\n", index);
  }
 
- disable_MAC(ai, lock);
+ if (perm_key_support && perm) disable_MAC(ai, lock);
  writeWepKeyRid(ai, &wkr, perm, lock);
- enable_MAC(ai, &rsp, lock);
+ if (perm_key_support && perm) enable_MAC(ai, &rsp, lock);
  return 0;
 }
 
@@ -5562,9 +5578,9 @@ static int __init airo_init_module( void
  }
 
 #ifdef CONFIG_PCI
- printk( KERN_INFO "airo:  Probing for PCI adapters\n" );
+ printk( KERN_DEBUG "airo:  Probing for PCI adapters\n" );
  pci_register_driver(&airo_driver);
- printk( KERN_INFO "airo:  Finished probing for PCI adapters\n" );
+ printk( KERN_DEBUG "airo:  Finished probing for PCI adapters\n" );
 #endif
 
  /* Always exit with success, as we are a library module
@@ -5576,7 +5592,7 @@ static int __init airo_init_module( void
 static void __exit airo_cleanup_module( void )
 {
  while( airo_devices ) {
-  printk( KERN_INFO "airo: Unregistering %s\n", airo_devices->dev->name );
+  printk( KERN_DEBUG "airo: Unregistering %s\n", airo_devices->dev->name );
   stop_airo_card( airo_devices->dev, 1 );
  }
 #ifdef CONFIG_PCI
@@ -6166,6 +6182,7 @@ static int airo_set_encode(struct net_de
 {
  struct airo_info *local = dev->priv;
  CapabilityRid cap_rid;  /* Card capability info */
+ u16 oldAuthType;
 
  /* Is WEP supported ? */
  readCapabilityRid(local, &cap_rid, 1);
@@ -6208,7 +6225,8 @@ static int airo_set_encode(struct net_de
    /* Copy the key in the driver */
    memcpy(key.key, extra, dwrq->length);
    /* Send the key to the card */
-   set_wep_key(local, index, key.key, key.len, 1, 1);
+   set_wep_key(local, index, key.key, key.len,
+        !(dwrq->flags&IW_ENCODE_TEMP), 1);
   }
   /* WE specify that if a valid key is set, encryption
    * should be enabled (user may turn it off later)
@@ -6222,13 +6240,15 @@ static int airo_set_encode(struct net_de
   /* Do we want to just set the transmit key index ? */
   int index = (dwrq->flags & IW_ENCODE_INDEX) - 1;
   if ((index >= 0) && (index < ((cap_rid.softCap & 0x80)?4:1))) {
-   set_wep_key(local, index, NULL, 0, 1, 1);
+   set_wep_key(local, index, NULL, 0,
+        !(dwrq->flags&IW_ENCODE_TEMP), 1);
   } else
    /* Don't complain if only change the mode */
    if(!dwrq->flags & IW_ENCODE_MODE) {
     return -EINVAL;
    }
  }
+ oldAuthType = local->config.authType;
  /* Read the flags */
  if(dwrq->flags & IW_ENCODE_DISABLED)
   local->config.authType = AUTH_OPEN; // disable encryption
@@ -6237,7 +6257,7 @@ static int airo_set_encode(struct net_de
  if(dwrq->flags & IW_ENCODE_OPEN)
   local->config.authType = AUTH_ENCRYPT; // Only Wep
  /* Commit the changes to flags if needed */
- if(dwrq->flags & IW_ENCODE_MODE)
+ if(oldAuthType != local->config.authType)
   set_bit (FLAG_COMMIT, &local->flags);
  return -EINPROGRESS;  /* Call commit handler */
 }
