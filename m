Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVHCWyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVHCWyD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 18:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVHCWyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 18:54:03 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:59563 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261614AbVHCWxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 18:53:06 -0400
Message-ID: <42F14AC9.2060109@acm.org>
Date: Wed, 03 Aug 2005 17:52:57 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] IPMI driver update part 1, add per-channel IPMB addresses
Content-Type: multipart/mixed;
 boundary="------------020509000605000901090809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020509000605000901090809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------020509000605000901090809
Content-Type: unknown/unknown;
 name="ipmi-per-channel-slave-address.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi-per-channel-slave-address.patch"

IPMI allows multiple IPMB channels on a single interface, and
each channel might have a different IPMB address.  However, the
driver has only one IPMB address that it uses for everything.
This patch adds new IOCTLS and a new internal interface for
setting per-channel IPMB addresses and LUNs.  New systems are
coming out with support for multiple IPMB channels, and they
are broken without this patch.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.13-rc5/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.13-rc5.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.13-rc5/drivers/char/ipmi/ipmi_msghandler.c
@@ -124,6 +124,14 @@
 {
 	unsigned char medium;
 	unsigned char protocol;
+
+	/* My slave address.  This is initialized to IPMI_BMC_SLAVE_ADDR,
+	   but may be changed by the user. */
+	unsigned char address;
+
+	/* My LUN.  This should generally stay the SMS LUN, but just in
+	   case... */
+	unsigned char lun;
 };
 
 #ifdef CONFIG_PROC_FS
@@ -135,7 +143,7 @@
 #endif
 
 #define IPMI_IPMB_NUM_SEQ	64
-#define IPMI_MAX_CHANNELS       8
+#define IPMI_MAX_CHANNELS       16
 struct ipmi_smi
 {
 	/* What interface number are we? */
@@ -199,14 +207,6 @@
 	   this is registered. */
 	ipmi_user_t all_cmd_rcvr;
 
-	/* My slave address.  This is initialized to IPMI_BMC_SLAVE_ADDR,
-	   but may be changed by the user. */
-	unsigned char my_address;
-
-	/* My LUN.  This should generally stay the SMS LUN, but just in
-	   case... */
-	unsigned char my_lun;
-
 	/* The event receiver for my BMC, only really used at panic
 	   shutdown as a place to store this. */
 	unsigned char event_receiver;
@@ -766,26 +766,44 @@
 	*minor = user->intf->version_minor;
 }
 
-void ipmi_set_my_address(ipmi_user_t   user,
-			 unsigned char address)
+int ipmi_set_my_address(ipmi_user_t   user,
+			unsigned int  channel,
+			unsigned char address)
 {
-	user->intf->my_address = address;
+	if (channel >= IPMI_MAX_CHANNELS)
+		return -EINVAL;
+	user->intf->channels[channel].address = address;
+	return 0;
 }
 
-unsigned char ipmi_get_my_address(ipmi_user_t user)
+int ipmi_get_my_address(ipmi_user_t   user,
+			unsigned int  channel,
+			unsigned char *address)
 {
-	return user->intf->my_address;
+	if (channel >= IPMI_MAX_CHANNELS)
+		return -EINVAL;
+	*address = user->intf->channels[channel].address;
+	return 0;
 }
 
-void ipmi_set_my_LUN(ipmi_user_t   user,
-		     unsigned char LUN)
+int ipmi_set_my_LUN(ipmi_user_t   user,
+		    unsigned int  channel,
+		    unsigned char LUN)
 {
-	user->intf->my_lun = LUN & 0x3;
+	if (channel >= IPMI_MAX_CHANNELS)
+		return -EINVAL;
+	user->intf->channels[channel].lun = LUN & 0x3;
+	return 0;
 }
 
-unsigned char ipmi_get_my_LUN(ipmi_user_t user)
+int ipmi_get_my_LUN(ipmi_user_t   user,
+		    unsigned int  channel,
+		    unsigned char *address)
 {
-	return user->intf->my_lun;
+	if (channel >= IPMI_MAX_CHANNELS)
+		return -EINVAL;
+	*address = user->intf->channels[channel].lun;
+	return 0;
 }
 
 int ipmi_set_gets_events(ipmi_user_t user, int val)
@@ -1213,7 +1231,7 @@
 		unsigned char         ipmb_seq;
 		long                  seqid;
 
-		if (addr->channel > IPMI_NUM_CHANNELS) {
+		if (addr->channel >= IPMI_NUM_CHANNELS) {
 			spin_lock_irqsave(&intf->counter_lock, flags);
 			intf->sent_invalid_commands++;
 			spin_unlock_irqrestore(&intf->counter_lock, flags);
@@ -1346,6 +1364,18 @@
 	return rv;
 }
 
+static int check_addr(ipmi_smi_t       intf,
+		      struct ipmi_addr *addr,
+		      unsigned char    *saddr,
+		      unsigned char    *lun)
+{
+	if (addr->channel >= IPMI_MAX_CHANNELS)
+		return -EINVAL;
+	*lun = intf->channels[addr->channel].lun;
+	*saddr = intf->channels[addr->channel].address;
+	return 0;
+}
+
 int ipmi_request_settime(ipmi_user_t      user,
 			 struct ipmi_addr *addr,
 			 long             msgid,
@@ -1355,6 +1385,12 @@
 			 int              retries,
 			 unsigned int     retry_time_ms)
 {
+	unsigned char saddr, lun;
+	int           rv;
+
+	rv = check_addr(user->intf, addr, &saddr, &lun);
+	if (rv)
+		return rv;
 	return i_ipmi_request(user,
 			      user->intf,
 			      addr,
@@ -1363,8 +1399,8 @@
 			      user_msg_data,
 			      NULL, NULL,
 			      priority,
-			      user->intf->my_address,
-			      user->intf->my_lun,
+			      saddr,
+			      lun,
 			      retries,
 			      retry_time_ms);
 }
@@ -1378,6 +1414,12 @@
 			     struct ipmi_recv_msg *supplied_recv,
 			     int                  priority)
 {
+	unsigned char saddr, lun;
+	int           rv;
+
+	rv = check_addr(user->intf, addr, &saddr, &lun);
+	if (rv)
+		return rv;
 	return i_ipmi_request(user,
 			      user->intf,
 			      addr,
@@ -1387,8 +1429,8 @@
 			      supplied_smi,
 			      supplied_recv,
 			      priority,
-			      user->intf->my_address,
-			      user->intf->my_lun,
+			      saddr,
+			      lun,
 			      -1, 0);
 }
 
@@ -1397,8 +1439,15 @@
 {
 	char       *out = (char *) page;
 	ipmi_smi_t intf = data;
+	int        i;
+	int        rv= 0;
 
-	return sprintf(out, "%x\n", intf->my_address);
+	for (i=0; i<IPMI_MAX_CHANNELS; i++)
+		rv += sprintf(out+rv, "%x ", intf->channels[i].address);
+	out[rv-1] = '\n'; /* Replace the final space with a newline */
+	out[rv] = '\0';
+	rv++;
+	return rv;
 }
 
 static int version_file_read_proc(char *page, char **start, off_t off,
@@ -1592,8 +1641,8 @@
 			      NULL,
 			      NULL,
 			      0,
-			      intf->my_address,
-			      intf->my_lun,
+			      intf->channels[0].address,
+			      intf->channels[0].lun,
 			      -1, 0);
 }
 
@@ -1696,11 +1745,13 @@
 			new_intf->intf_num = i;
 			new_intf->version_major = version_major;
 			new_intf->version_minor = version_minor;
-			if (slave_addr == 0)
-				new_intf->my_address = IPMI_BMC_SLAVE_ADDR;
-			else
-				new_intf->my_address = slave_addr;
-			new_intf->my_lun = 2;  /* the SMS LUN. */
+			for (j=0; j<IPMI_MAX_CHANNELS; j++) {
+				new_intf->channels[j].address
+					= IPMI_BMC_SLAVE_ADDR;
+				new_intf->channels[j].lun = 2;
+			}
+			if (slave_addr != 0)
+				new_intf->channels[0].address = slave_addr;
 			rwlock_init(&(new_intf->users_lock));
 			INIT_LIST_HEAD(&(new_intf->users));
 			new_intf->handlers = handlers;
@@ -1985,7 +2036,7 @@
 		msg->data[3] = msg->rsp[6];
                 msg->data[4] = ((netfn + 1) << 2) | (msg->rsp[7] & 0x3);
 		msg->data[5] = ipmb_checksum(&(msg->data[3]), 2);
-		msg->data[6] = intf->my_address;
+		msg->data[6] = intf->channels[msg->rsp[3] & 0xf].address;
                 /* rqseq/lun */
                 msg->data[7] = (msg->rsp[7] & 0xfc) | (msg->rsp[4] & 0x3);
 		msg->data[8] = msg->rsp[8]; /* cmd */
@@ -2919,8 +2970,8 @@
 			       &smi_msg,
 			       &recv_msg,
 			       0,
-			       intf->my_address,
-			       intf->my_lun,
+			       intf->channels[0].address,
+			       intf->channels[0].lun,
 			       0, 1); /* Don't retry, and don't wait. */
 	}
 
@@ -2965,8 +3016,8 @@
 			       &smi_msg,
 			       &recv_msg,
 			       0,
-			       intf->my_address,
-			       intf->my_lun,
+			       intf->channels[0].address,
+			       intf->channels[0].lun,
 			       0, 1); /* Don't retry, and don't wait. */
 
 		if (intf->local_event_generator) {
@@ -2985,8 +3036,8 @@
 				       &smi_msg,
 				       &recv_msg,
 				       0,
-				       intf->my_address,
-				       intf->my_lun,
+				       intf->channels[0].address,
+				       intf->channels[0].lun,
 				       0, 1); /* no retry, and no wait. */
 		}
 		intf->null_user_handler = NULL;
@@ -2996,7 +3047,7 @@
 		   be zero, and it must not be my address. */
                 if (((intf->event_receiver & 1) == 0)
 		    && (intf->event_receiver != 0)
-		    && (intf->event_receiver != intf->my_address))
+		    && (intf->event_receiver != intf->channels[0].address))
 		{
 			/* The event receiver is valid, send an IPMB
 			   message. */
@@ -3031,7 +3082,7 @@
 			data[0] = 0;
 			data[1] = 0;
 			data[2] = 0xf0; /* OEM event without timestamp. */
-			data[3] = intf->my_address;
+			data[3] = intf->channels[0].address;
 			data[4] = j++; /* sequence # */
 			/* Always give 11 bytes, so strncpy will fill
 			   it with zeroes for me. */
@@ -3047,8 +3098,8 @@
 				       &smi_msg,
 				       &recv_msg,
 				       0,
-				       intf->my_address,
-				       intf->my_lun,
+				       intf->channels[0].address,
+				       intf->channels[0].lun,
 				       0, 1); /* no retry, and no wait. */
 		}
 	}	
Index: linux-2.6.13-rc5/include/linux/ipmi.h
===================================================================
--- linux-2.6.13-rc5.orig/include/linux/ipmi.h
+++ linux-2.6.13-rc5/include/linux/ipmi.h
@@ -298,13 +298,19 @@
    this user, so it will affect all users of this interface.  This is
    so some initialization code can come in and do the OEM-specific
    things it takes to determine your address (if not the BMC) and set
-   it for everyone else. */
-void ipmi_set_my_address(ipmi_user_t   user,
-			 unsigned char address);
-unsigned char ipmi_get_my_address(ipmi_user_t user);
-void ipmi_set_my_LUN(ipmi_user_t   user,
-		     unsigned char LUN);
-unsigned char ipmi_get_my_LUN(ipmi_user_t user);
+   it for everyone else.  Note that each channel can have its own address. */
+int ipmi_set_my_address(ipmi_user_t   user,
+			unsigned int  channel,
+			unsigned char address);
+int ipmi_get_my_address(ipmi_user_t   user,
+			unsigned int  channel,
+			unsigned char *address);
+int ipmi_set_my_LUN(ipmi_user_t   user,
+		    unsigned int  channel,
+		    unsigned char LUN);
+int ipmi_get_my_LUN(ipmi_user_t   user,
+		    unsigned int  channel,
+		    unsigned char *LUN);
 
 /*
  * Like ipmi_request, but lets you specify the number of retries and
@@ -585,6 +591,16 @@
  * things it takes to determine your address (if not the BMC) and set
  * it for everyone else.  You should probably leave the LUN alone.
  */
+struct ipmi_channel_lun_address_set
+{
+	unsigned short channel;
+	unsigned char  value;
+};
+#define IPMICTL_SET_MY_CHANNEL_ADDRESS_CMD _IOR(IPMI_IOC_MAGIC, 24, struct ipmi_channel_lun_address_set)
+#define IPMICTL_GET_MY_CHANNEL_ADDRESS_CMD _IOR(IPMI_IOC_MAGIC, 25, struct ipmi_channel_lun_address_set)
+#define IPMICTL_SET_MY_CHANNEL_LUN_CMD	   _IOR(IPMI_IOC_MAGIC, 26, struct ipmi_channel_lun_address_set)
+#define IPMICTL_GET_MY_CHANNEL_LUN_CMD	   _IOR(IPMI_IOC_MAGIC, 27, struct ipmi_channel_lun_address_set)
+/* Legacy interfaces, these only set IPMB 0. */
 #define IPMICTL_SET_MY_ADDRESS_CMD	_IOR(IPMI_IOC_MAGIC, 17, unsigned int)
 #define IPMICTL_GET_MY_ADDRESS_CMD	_IOR(IPMI_IOC_MAGIC, 18, unsigned int)
 #define IPMICTL_SET_MY_LUN_CMD		_IOR(IPMI_IOC_MAGIC, 19, unsigned int)
Index: linux-2.6.13-rc5/drivers/char/ipmi/ipmi_devintf.c
===================================================================
--- linux-2.6.13-rc5.orig/drivers/char/ipmi/ipmi_devintf.c
+++ linux-2.6.13-rc5/drivers/char/ipmi/ipmi_devintf.c
@@ -411,6 +411,7 @@
 		break;
 	}
 
+	/* The next four are legacy, not per-channel. */
 	case IPMICTL_SET_MY_ADDRESS_CMD:
 	{
 		unsigned int val;
@@ -420,22 +421,25 @@
 			break;
 		}
 
-		ipmi_set_my_address(priv->user, val);
-		rv = 0;
+		rv = ipmi_set_my_address(priv->user, 0, val);
 		break;
 	}
 
 	case IPMICTL_GET_MY_ADDRESS_CMD:
 	{
-		unsigned int val;
+		unsigned int  val;
+		unsigned char rval;
+
+		rv = ipmi_get_my_address(priv->user, 0, &rval);
+		if (rv)
+			break;
 
-		val = ipmi_get_my_address(priv->user);
+		val = rval;
 
 		if (copy_to_user(arg, &val, sizeof(val))) {
 			rv = -EFAULT;
 			break;
 		}
-		rv = 0;
 		break;
 	}
 
@@ -448,24 +452,94 @@
 			break;
 		}
 
-		ipmi_set_my_LUN(priv->user, val);
-		rv = 0;
+		rv = ipmi_set_my_LUN(priv->user, 0, val);
 		break;
 	}
 
 	case IPMICTL_GET_MY_LUN_CMD:
 	{
-		unsigned int val;
+		unsigned int  val;
+		unsigned char rval;
+
+		rv = ipmi_get_my_LUN(priv->user, 0, &rval);
+		if (rv)
+			break;
 
-		val = ipmi_get_my_LUN(priv->user);
+		val = rval;
 
 		if (copy_to_user(arg, &val, sizeof(val))) {
 			rv = -EFAULT;
 			break;
 		}
-		rv = 0;
 		break;
 	}
+
+	case IPMICTL_SET_MY_CHANNEL_ADDRESS_CMD:
+	{
+		struct ipmi_channel_lun_address_set val;
+
+		if (copy_from_user(&val, arg, sizeof(val))) {
+			rv = -EFAULT;
+			break;
+		}
+
+		return ipmi_set_my_address(priv->user, val.channel, val.value);
+		break;
+	}
+
+	case IPMICTL_GET_MY_CHANNEL_ADDRESS_CMD:
+	{
+		struct ipmi_channel_lun_address_set val;
+
+		if (copy_from_user(&val, arg, sizeof(val))) {
+			rv = -EFAULT;
+			break;
+		}
+
+		rv = ipmi_get_my_address(priv->user, val.channel, &val.value);
+		if (rv)
+			break;
+
+		if (copy_to_user(arg, &val, sizeof(val))) {
+			rv = -EFAULT;
+			break;
+		}
+		break;
+	}
+
+	case IPMICTL_SET_MY_CHANNEL_LUN_CMD:
+	{
+		struct ipmi_channel_lun_address_set val;
+
+		if (copy_from_user(&val, arg, sizeof(val))) {
+			rv = -EFAULT;
+			break;
+		}
+
+		rv = ipmi_set_my_LUN(priv->user, val.channel, val.value);
+		break;
+	}
+
+	case IPMICTL_GET_MY_CHANNEL_LUN_CMD:
+	{
+		struct ipmi_channel_lun_address_set val;
+
+		if (copy_from_user(&val, arg, sizeof(val))) {
+			rv = -EFAULT;
+			break;
+		}
+
+		rv = ipmi_get_my_LUN(priv->user, val.channel, &val.value);
+		if (rv)
+			break;
+
+		if (copy_to_user(arg, &val, sizeof(val))) {
+			rv = -EFAULT;
+			break;
+		}
+		break;
+	}
+
 	case IPMICTL_SET_TIMING_PARMS_CMD:
 	{
 		struct ipmi_timing_parms parms;

--------------020509000605000901090809--
