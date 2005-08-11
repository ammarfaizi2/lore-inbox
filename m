Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbVHKOAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbVHKOAS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 10:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbVHKOAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 10:00:18 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:33775 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1030312AbVHKOAR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 10:00:17 -0400
Message-ID: <42FB59EC.7040303@mvista.com>
Date: Thu, 11 Aug 2005 09:00:12 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix panic in the IPMI driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This panic would only occur in saving panic information to the
system log in another panic, and only when sending the panic
information to a remote management controller, so it's not a huge
deal, but needs to be fixed.  Hopefully pasting the message inline
will work ok (testing showed it to be fine, though mozilla did wierd
things with inline text), as I can't get thunderbird to attach a patch
with a valid mimetype (and inline makes everyone happier, I
guess).


The "null message handler" in the IPMI driver is used in startup
and panic situations to handle messages.  It was only designed to
work with messages from the local management controller, but in
some cases it was used to get messages from remote management
controllers, and the system would then panic.  This patch makes
the "null message handler" in the IPMI driver more general so
it works with any kind of message.

Signed-off-by: Corey Minyard <minyard@acm.org>

 drivers/char/ipmi/ipmi_msghandler.c |  107 
++++++++++++++++++++++--------------
 include/linux/ipmi.h                |    3 -
 2 files changed, 69 insertions(+), 41 deletions(-)

Index: linux-2.6.13-rc5/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.13-rc5.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.13-rc5/drivers/char/ipmi/ipmi_msghandler.c
@@ -219,7 +219,7 @@
        interface comes in with a NULL user, call this routine with
        it.  Note that the message will still be freed by the
        caller.  This only works on the system interface. */
-    void (*null_user_handler)(ipmi_smi_t intf, struct ipmi_smi_msg *msg);
+    void (*null_user_handler)(ipmi_smi_t intf, struct ipmi_recv_msg *msg);
 
     /* When we are scanning the channels for an SMI, this will
        tell which channel we are scanning. */
@@ -459,7 +459,27 @@
 
 static void deliver_response(struct ipmi_recv_msg *msg)
 {
-    msg->user->handler->ipmi_recv_hndl(msg, msg->user->handler_data);
+    if (! msg->user) {
+        ipmi_smi_t    intf = msg->user_msg_data;
+        unsigned long flags;
+
+        /* Special handling for NULL users. */
+        if (intf->null_user_handler) {
+            intf->null_user_handler(intf, msg);
+            spin_lock_irqsave(&intf->counter_lock, flags);
+            intf->handled_local_responses++;
+            spin_unlock_irqrestore(&intf->counter_lock, flags);
+        } else {
+            /* No handler, so give up. */
+            spin_lock_irqsave(&intf->counter_lock, flags);
+            intf->unhandled_local_responses++;
+            spin_unlock_irqrestore(&intf->counter_lock, flags);
+        }
+        ipmi_free_recv_msg(msg);
+    } else {
+        msg->user->handler->ipmi_recv_hndl(msg,
+                           msg->user->handler_data);
+    }
 }
 
 /* Find the next sequence number not being used and add the given
@@ -1389,6 +1409,8 @@
     unsigned char saddr, lun;
     int           rv;
 
+    if (! user)
+        return -EINVAL;
     rv = check_addr(user->intf, addr, &saddr, &lun);
     if (rv)
         return rv;
@@ -1418,6 +1440,8 @@
     unsigned char saddr, lun;
     int           rv;
 
+    if (! user)
+        return -EINVAL;
     rv = check_addr(user->intf, addr, &saddr, &lun);
     if (rv)
         return rv;
@@ -1638,7 +1662,7 @@
                   (struct ipmi_addr *) &si,
                   0,
                   &msg,
-                  NULL,
+                  intf,
                   NULL,
                   NULL,
                   0,
@@ -1648,19 +1672,20 @@
 }
 
 static void
-channel_handler(ipmi_smi_t intf, struct ipmi_smi_msg *msg)
+channel_handler(ipmi_smi_t intf, struct ipmi_recv_msg *msg)
 {
     int rv = 0;
     int chan;
 
-    if ((msg->rsp[0] == (IPMI_NETFN_APP_RESPONSE << 2))
-        && (msg->rsp[1] == IPMI_GET_CHANNEL_INFO_CMD))
+    if ((msg->addr.addr_type == IPMI_SYSTEM_INTERFACE_ADDR_TYPE)
+        && (msg->msg.netfn == IPMI_NETFN_APP_RESPONSE)
+        && (msg->msg.cmd == IPMI_GET_CHANNEL_INFO_CMD))
     {
         /* It's the one we want */
-        if (msg->rsp[2] != 0) {
+        if (msg->msg.data[0] != 0) {
             /* Got an error from the channel, just go on. */
 
-            if (msg->rsp[2] == IPMI_INVALID_COMMAND_ERR) {
+            if (msg->msg.data[0] == IPMI_INVALID_COMMAND_ERR) {
                 /* If the MC does not support this
                    command, that is legal.  We just
                    assume it has one IPMB at channel
@@ -1677,13 +1702,13 @@
             }
             goto next_channel;
         }
-        if (msg->rsp_size < 6) {
+        if (msg->msg.data_len < 4) {
             /* Message not big enough, just go on. */
             goto next_channel;
         }
         chan = intf->curr_channel;
-        intf->channels[chan].medium = msg->rsp[4] & 0x7f;
-        intf->channels[chan].protocol = msg->rsp[5] & 0x1f;
+        intf->channels[chan].medium = msg->msg.data[2] & 0x7f;
+        intf->channels[chan].protocol = msg->msg.data[3] & 0x1f;
 
     next_channel:
         intf->curr_channel++;
@@ -2382,6 +2407,14 @@
     unsigned long        flags;
 
     recv_msg = (struct ipmi_recv_msg *) msg->user_data;
+    if (recv_msg == NULL)
+    {
+        printk(KERN_WARNING"IPMI message received with no owner. This\n"
+            "could be because of a malformed message, or\n"
+            "because of a hardware error.  Contact your\n"
+            "hardware vender for assistance\n");
+        return 0;
+    }
 
     /* Make sure the user still exists. */
     list_for_each_entry(user, &(intf->users), link) {
@@ -2392,19 +2425,11 @@
         }
     }
 
-    if (!found) {
-        /* Special handling for NULL users. */
-        if (!recv_msg->user && intf->null_user_handler){
-            intf->null_user_handler(intf, msg);
-            spin_lock_irqsave(&intf->counter_lock, flags);
-            intf->handled_local_responses++;
-            spin_unlock_irqrestore(&intf->counter_lock, flags);
-        }else{
-            /* The user for the message went away, so give up. */
-            spin_lock_irqsave(&intf->counter_lock, flags);
-            intf->unhandled_local_responses++;
-            spin_unlock_irqrestore(&intf->counter_lock, flags);
-        }
+    if ((! found) && recv_msg->user) {
+        /* The user for the message went away, so give up. */
+        spin_lock_irqsave(&intf->counter_lock, flags);
+        intf->unhandled_local_responses++;
+        spin_unlock_irqrestore(&intf->counter_lock, flags);
         ipmi_free_recv_msg(recv_msg);
     } else {
         struct ipmi_system_interface_addr *smi_addr;
@@ -2890,28 +2915,30 @@
 }
 
 #ifdef CONFIG_IPMI_PANIC_STRING
-static void event_receiver_fetcher(ipmi_smi_t intf, struct ipmi_smi_msg 
*msg)
+static void event_receiver_fetcher(ipmi_smi_t intf, struct 
ipmi_recv_msg *msg)
 {
-    if ((msg->rsp[0] == (IPMI_NETFN_SENSOR_EVENT_RESPONSE << 2))
-        && (msg->rsp[1] == IPMI_GET_EVENT_RECEIVER_CMD)
-        && (msg->rsp[2] == IPMI_CC_NO_ERROR))
+    if ((msg->addr.addr_type == IPMI_SYSTEM_INTERFACE_ADDR_TYPE)
+        && (msg->msg.netfn == IPMI_NETFN_SENSOR_EVENT_RESPONSE)
+        && (msg->msg.cmd == IPMI_GET_EVENT_RECEIVER_CMD)
+        && (msg->msg.data[0] == IPMI_CC_NO_ERROR))
     {
         /* A get event receiver command, save it. */
-        intf->event_receiver = msg->rsp[3];
-        intf->event_receiver_lun = msg->rsp[4] & 0x3;
+        intf->event_receiver = msg->msg.data[1];
+        intf->event_receiver_lun = msg->msg.data[2] & 0x3;
     }
 }
 
-static void device_id_fetcher(ipmi_smi_t intf, struct ipmi_smi_msg *msg)
+static void device_id_fetcher(ipmi_smi_t intf, struct ipmi_recv_msg *msg)
 {
-    if ((msg->rsp[0] == (IPMI_NETFN_APP_RESPONSE << 2))
-        && (msg->rsp[1] == IPMI_GET_DEVICE_ID_CMD)
-        && (msg->rsp[2] == IPMI_CC_NO_ERROR))
+    if ((msg->addr.addr_type == IPMI_SYSTEM_INTERFACE_ADDR_TYPE)
+        && (msg->msg.netfn == IPMI_NETFN_APP_RESPONSE)
+        && (msg->msg.cmd == IPMI_GET_DEVICE_ID_CMD)
+        && (msg->msg.data[0] == IPMI_CC_NO_ERROR))
     {
         /* A get device id command, save if we are an event
            receiver or generator. */
-        intf->local_sel_device = (msg->rsp[8] >> 2) & 1;
-        intf->local_event_generator = (msg->rsp[8] >> 5) & 1;
+        intf->local_sel_device = (msg->msg.data[6] >> 2) & 1;
+        intf->local_event_generator = (msg->msg.data[6] >> 5) & 1;
     }
 }
 #endif
@@ -2967,7 +2994,7 @@
                    &addr,
                    0,
                    &msg,
-                   NULL,
+                   intf,
                    &smi_msg,
                    &recv_msg,
                    0,
@@ -3013,7 +3040,7 @@
                    &addr,
                    0,
                    &msg,
-                   NULL,
+                   intf,
                    &smi_msg,
                    &recv_msg,
                    0,
@@ -3033,7 +3060,7 @@
                        &addr,
                        0,
                        &msg,
-                       NULL,
+                       intf,
                        &smi_msg,
                        &recv_msg,
                        0,
@@ -3095,7 +3122,7 @@
                        &addr,
                        0,
                        &msg,
-                       NULL,
+                       intf,
                        &smi_msg,
                        &recv_msg,
                        0,
Index: linux-2.6.13-rc5/include/linux/ipmi.h
===================================================================
--- linux-2.6.13-rc5.orig/include/linux/ipmi.h
+++ linux-2.6.13-rc5/include/linux/ipmi.h
@@ -242,7 +242,8 @@
     /* The user_msg_data is the data supplied when a message was
        sent, if this is a response to a sent message.  If this is
        not a response to a sent message, then user_msg_data will
-       be NULL. */
+       be NULL.  If the user above is NULL, then this will be the
+       intf. */
     void             *user_msg_data;
 
     /* Call this when done with the message.  It will presumably free

