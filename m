Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVCESFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVCESFY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 13:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVCESFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 13:05:23 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61702 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261703AbVCESDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:03:48 -0500
Date: Sat, 5 Mar 2005 19:03:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Bene Martin <martin.bene@icomedias.com>, minyard@mvista.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] readd ipmi_request
Message-ID: <20050305180346.GF6373@stusta.de>
References: <FA095C015271B64E99B197937712FD02510ACF@freedom.grz.icomedias.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FA095C015271B64E99B197937712FD02510ACF@freedom.grz.icomedias.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 10:41:31AM +0100, Bene Martin wrote:

> Hi Adrian,
> 
> bmcsensors package (reading hardware sensors provided by intel boards
> via ipmi) used to work fine with 2.6.10; no longer works with 2.6.11
> because of removal of the ipmi_request function (+ exported symbol).
> 
> correct fix would be to use ipmi_request_settime with retries=-1 and
> retry_time_ms=0?

I didn't know about this, the patch below readds ipmi_request.

> Thanks, Martin


<--  snip  -->


Readd ipmi_request because it's used by bmcsensors.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/ipmi/ipmi_msghandler.c |   21 +++++++++++++++++++++
 include/linux/ipmi.h                |   26 ++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

--- linux-2.6.11-mm1-full/include/linux/ipmi.h.old	2005-03-05 17:32:55.000000000 +0100
+++ linux-2.6.11-mm1-full/include/linux/ipmi.h	2005-03-05 17:43:14.000000000 +0100
@@ -302,6 +302,32 @@
 unsigned char ipmi_get_my_LUN(ipmi_user_t user);
 
 /*
+ * Send a command request from the given user.  The address is the
+ * proper address for the channel type.  If this is a command, then
+ * the message response comes back, the receive handler for this user
+ * will be called with the given msgid value in the recv msg.  If this
+ * is a response to a command, then the msgid will be used as the
+ * sequence number for the response (truncated if necessary), so when
+ * sending a response you should use the sequence number you received
+ * in the msgid field of the received command.  If the priority is >
+ * 0, the message will go into a high-priority queue and be sent
+ * first.  Otherwise, it goes into a normal-priority queue.
+ * The user_msg_data field will be returned in any response to this
+ * message.
+ *
+ * Note that if you send a response (with the netfn lower bit set),
+ * you *will* get back a SEND_MSG response telling you what happened
+ * when the response was sent.  You will not get back a response to
+ * the message itself.
+ */
+int ipmi_request(ipmi_user_t      user,
+		 struct ipmi_addr *addr,
+		 long             msgid,
+		 struct kernel_ipmi_msg *msg,
+		 void             *user_msg_data,
+		 int              priority);
+
+/*
  * Like ipmi_request, but lets you specify the number of retries and
  * the retry time.  The retries is the number of times the message
  * will be resent if no reply is received.  If set to -1, the default
--- linux-2.6.11-mm1-full/drivers/char/ipmi/ipmi_msghandler.c.old	2005-03-05 17:33:10.000000000 +0100
+++ linux-2.6.11-mm1-full/drivers/char/ipmi/ipmi_msghandler.c	2005-03-05 17:43:14.000000000 +0100
@@ -1339,6 +1339,27 @@
 	return rv;
 }
 
+int ipmi_request(ipmi_user_t      user,
+		 struct ipmi_addr *addr,
+		 long             msgid,
+		 struct kernel_ipmi_msg  *msg,
+		 void             *user_msg_data,
+		 int              priority)
+{
+	return i_ipmi_request(user,
+			      user->intf,
+			      addr,
+			      msgid,
+			      msg,
+			      user_msg_data,
+			      NULL, NULL,
+			      priority,
+			      user->intf->my_address,
+			      user->intf->my_lun,
+			      -1, 0);
+}
+EXPORT_SYMBOL(ipmi_request);
+
 int ipmi_request_settime(ipmi_user_t      user,
 			 struct ipmi_addr *addr,
 			 long             msgid,
