Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbUBXNyy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 08:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbUBXNyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 08:54:54 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:26304 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262134AbUBXNyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 08:54:25 -0500
Message-ID: <403B578E.5010902@acm.org>
Date: Tue, 24 Feb 2004 07:54:22 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] IPMI driver updates, part 1a
Content-Type: multipart/mixed;
 boundary="------------030804030205090001030702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030804030205090001030702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

It looks like part 1 of the IPMI driver updates was a little too big to 
get through.  So I've split it up.  Part 1a and part1b must both be 
applied.  Here's the original message.  Also, this is for the 2.6.3 kernel.

It has been far too long since the last IPMI driver updates, but now all 
the planets have aligned and all the pieces I needed are in and all seem 
to be working.  This update is coming as four parts that must be applied 
in order, but the later parts do not have to be applied for the former 
parts to work.

This first part does basic updates to the IPMI infrastructure.  It adds 
support for messaging through an IPMI LAN interface, which is required 
for some system software that already exists on other IPMI drivers.  It 
also does some renaming (in preparation for one of the later patches) 
and a lot of little cleanups.

FYI, IPMI is a standard for monitoring and maintaining a system.  It 
provides interfaces for detecting sensors (voltage, temperature, etc.) 
in the system and monitoring those sensors.  Many systems have extended 
capabilities that allow IPMI to control the system, doing things like 
lighting leds and controlling hot-swap.  This driver allows access to 
the IPMI system.

-Corey

--------------030804030205090001030702
Content-Type: text/plain;
 name="linux-2.6.3-ipmi-part1a-msghandler.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.3-ipmi-part1a-msghandler.diff"

diff -urN linux.orig/Documentation/IPMI.txt linux-a1/Documentation/IPMI.txt
--- linux.orig/Documentation/IPMI.txt	2003-12-17 20:58:04.000000000 -0600
+++ linux-a1/Documentation/IPMI.txt	2004-02-23 08:22:00.000000000 -0600
@@ -22,6 +22,49 @@
 http://www.intel.com/design/servers/ipmi/index.htm.  IPMI is a big
 subject and I can't cover it all here!
 
+Configuration
+-------------
+
+The LinuxIPMI driver is modular, which means you have to pick several
+things to have it work right depending on your hardware.  Most of
+these are available in the 'Character Devices' menu.
+
+No matter what, you must pick 'IPMI top-level message handler' to use
+IPMI.  What you do beyond that depends on your needs and hardware.
+
+The message handler does not provide any user-level interfaces.
+Kernel code (like the watchdog) can still use it.  If you need access
+from userland, you need to select 'Device interface for IPMI' if you
+want access through a device driver.  Another interface is also
+available, you may select 'IPMI sockets' in the 'Networking Support'
+main menu.  This provides a socket interface to IPMI.  You may select
+both of these at the same time, they will both work together.
+
+There is also a KCS-only driver interface supplied, most IPMI systems
+support KCS, so you need taht.
+
+You should generally enable ACPI on your system, as systems with IPMI
+should have ACPI tables describing them.
+
+If you have a standard interface and the board manufacturer has done
+their job correctly, the IPMI controller should be automatically
+detect (via ACPI or SMBIOS tables) and should just work.  Sadly, many
+boards do not have this information.  The driver attempts standard
+defaults, but they may not work.  If you fall into this situation, you
+need to read the section below named 'The SI Driver' on how to
+hand-configure your system.
+
+IPMI defines a standard watchdog timer.  You can enable this with the
+'IPMI Watchdog Timer' config option.  If you compile the driver into
+the kernel, then via a kernel command-line option you can have the
+watchdog timer start as soon as it intitializes.  It also have a lot
+of other options, see the 'Watchdog' section below for more details.
+Note that you can also have the watchdog continue to run if it is
+closed (by default it is disabled on close).  Go into the 'Watchdog
+Cards' menu, enable 'Watchdog Timer Support', and enable the option
+'Disable watchdog shutdown on close'.
+
+
 Basic Design
 ------------
 
@@ -41,18 +84,19 @@
 driver, each open file for this device ties in to the message handler
 as an IPMI user.
 
-ipmi_kcs_drv - A driver for the KCS SMI.  Most system have a KCS
+ipmi_kcs_drv - A driver for the KCS SI.  Most systems have a KCS
 interface for IPMI.
 
 
 Much documentation for the interface is in the include files.  The
 IPMI include files are:
 
-ipmi.h - Contains the user interface and IOCTL interface for IPMI.
+linux/ipmi.h - Contains the user interface and IOCTL interface for IPMI.
 
-ipmi_smi.h - Contains the interface for SMI drivers to use.
+linux/ipmi_smi.h - Contains the interface for system management interfaces
+(things that interface to IPMI controllers) to use.
 
-ipmi_msgdefs.h - General definitions for base IPMI messaging.
+linux/ipmi_msgdefs.h - General definitions for base IPMI messaging.
 
 
 Addressing
@@ -260,8 +304,8 @@
 in the order they register, although if an SMI unregisters and then
 another one registers, all bets are off.
 
-The ipmi_smi.h defines the interface for SMIs, see that for more
-details.
+The ipmi_smi.h defines the interface for management interfaces, see
+that for more details.
 
 
 The KCS Driver
@@ -313,6 +357,7 @@
 ------------
 
 Watchdog
+--------
 
 A watchdog timer is provided that implements the Linux-standard
 watchdog timer interface.  It has three module parameters that can be
@@ -323,7 +368,10 @@
 
 The timeout is the number of seconds to the action, and the pretimeout
 is the amount of seconds before the reset that the pre-timeout panic will
-occur (if pretimeout is zero, then pretimeout will not be enabled).
+occur (if pretimeout is zero, then pretimeout will not be enabled).  Note
+that the pretimeout is the time before the final timeout.  So if the
+timeout is 50 seconds and the pretimeout is 10 seconds, then the pretimeout
+will occur in 40 second (10 seconds before the timeout).
 
 The action may be "reset", "power_cycle", or "power_off", and
 specifies what to do when the timer times out, and defaults to
diff -urN linux.orig/drivers/char/ipmi/ipmi_devintf.c linux-a1/drivers/char/ipmi/ipmi_devintf.c
--- linux.orig/drivers/char/ipmi/ipmi_devintf.c	2003-12-17 20:59:27.000000000 -0600
+++ linux-a1/drivers/char/ipmi/ipmi_devintf.c	2004-02-23 08:19:35.000000000 -0600
@@ -44,6 +44,8 @@
 #include <asm/semaphore.h>
 #include <linux/init.h>
 
+#define IPMI_DEVINTF_VERSION "v30"
+
 struct ipmi_file_private
 {
 	ipmi_user_t          user;
@@ -53,6 +55,8 @@
 	struct fasync_struct *fasync_queue;
 	wait_queue_head_t    wait;
 	struct semaphore     recv_sem;
+	int                  default_retries;
+	unsigned int         default_retry_time_ms;
 };
 
 static void file_receive_handler(struct ipmi_recv_msg *msg,
@@ -138,6 +142,10 @@
 	priv->fasync_queue = NULL;
 	sema_init(&(priv->recv_sem), 1);
 
+	/* Use the low-level defaults. */
+	priv->default_retries = -1;
+	priv->default_retry_time_ms = 0;
+
 	return 0;
 }
 
@@ -158,6 +166,48 @@
 	return 0;
 }
 
+static int handle_send_req(ipmi_user_t     user,
+			   struct ipmi_req *req,
+			   int             retries,
+			   unsigned int    retry_time_ms)
+{
+	int              rv;
+	struct ipmi_addr addr;
+	unsigned char    msgdata[IPMI_MAX_MSG_LENGTH];
+
+	if (req->addr_len > sizeof(struct ipmi_addr))
+		return -EINVAL;
+
+	if (copy_from_user(&addr, req->addr, req->addr_len))
+		return -EFAULT;
+
+	rv = ipmi_validate_addr(&addr, req->addr_len);
+	if (rv)
+		return rv;
+
+	if (req->msg.data != NULL) {
+		if (req->msg.data_len > IPMI_MAX_MSG_LENGTH)
+			return -EMSGSIZE;
+
+		if (copy_from_user(&msgdata,
+				   req->msg.data,
+				   req->msg.data_len))
+			return -EFAULT;
+	} else {
+		req->msg.data_len = 0;
+	}
+	req->msg.data = msgdata;
+
+	return ipmi_request_settime(user,
+				    &addr,
+				    req->msgid,
+				    &(req->msg),
+				    NULL,
+				    0,
+				    retries,
+				    retry_time_ms);
+}
+
 static int ipmi_ioctl(struct inode  *inode,
 		      struct file   *file,
 		      unsigned int  cmd,
@@ -170,54 +220,33 @@
 	{
 	case IPMICTL_SEND_COMMAND:
 	{
-		struct ipmi_req    req;
-		struct ipmi_addr   addr;
-		unsigned char msgdata[IPMI_MAX_MSG_LENGTH];
+		struct ipmi_req req;
 
 		if (copy_from_user(&req, (void *) data, sizeof(req))) {
 			rv = -EFAULT;
 			break;
 		}
 
-		if (req.addr_len > sizeof(struct ipmi_addr))
-		{
-			rv = -EINVAL;
-			break;
-		}
+		rv = handle_send_req(priv->user,
+				     &req,
+				     priv->default_retries,
+				     priv->default_retry_time_ms);
+		break;
+	}
 
-		if (copy_from_user(&addr, req.addr, req.addr_len)) {
+	case IPMICTL_SEND_COMMAND_SETTIME:
+	{
+		struct ipmi_req_settime req;
+
+		if (copy_from_user(&req, (void *) data, sizeof(req))) {
 			rv = -EFAULT;
 			break;
 		}
 
-		rv = ipmi_validate_addr(&addr, req.addr_len);
-		if (rv)
-			break;
-
-		if (req.msg.data != NULL) {
-			if (req.msg.data_len > IPMI_MAX_MSG_LENGTH) {
-				rv = -EMSGSIZE;
-				break;
-			}
-
-			if (copy_from_user(&msgdata,
-					   req.msg.data,
-					   req.msg.data_len))
-			{
-				rv = -EFAULT;
-				break;
-			}
-		} else {
-			req.msg.data_len = 0;
-		}
-
-		req.msg.data = msgdata;
-
-		rv = ipmi_request(priv->user,
-				  &addr,
-				  req.msgid,
-				  &(req.msg),
-				  0);
+		rv = handle_send_req(priv->user,
+				     &req.req,
+				     req.retries,
+				     req.retry_time_ms);
 		break;
 	}
 
@@ -416,7 +445,36 @@
 		rv = 0;
 		break;
 	}
+	case IPMICTL_SET_TIMING_PARMS_CMD:
+	{
+		struct ipmi_timing_parms parms;
+
+		if (copy_from_user(&parms, (void *) data, sizeof(parms))) {
+			rv = -EFAULT;
+			break;
+		}
 
+		priv->default_retries = parms.retries;
+		priv->default_retry_time_ms = parms.retry_time_ms;
+		rv = 0;
+		break;
+	}
+
+	case IPMICTL_GET_TIMING_PARMS_CMD:
+	{
+		struct ipmi_timing_parms parms;
+
+		parms.retries = priv->default_retries;
+		parms.retry_time_ms = priv->default_retry_time_ms;
+
+		if (copy_to_user((void *) data, &parms, sizeof(parms))) {
+			rv = -EFAULT;
+			break;
+		}
+
+		rv = 0;
+		break;
+	}
 	}
   
 	return rv;
@@ -437,27 +495,23 @@
 static int ipmi_major = 0;
 MODULE_PARM(ipmi_major, "i");
 
-#define MAX_DEVICES 10
-
 static void ipmi_new_smi(int if_num)
 {
-	if (if_num <= MAX_DEVICES) {
-		devfs_mk_cdev(MKDEV(ipmi_major, if_num),
-				S_IFCHR | S_IRUSR | S_IWUSR,
-				"ipmidev/%d", if_num);
-	}
+	devfs_mk_cdev(MKDEV(ipmi_major, if_num),
+		      S_IFCHR | S_IRUSR | S_IWUSR,
+		      "ipmidev/%d", if_num);
 }
 
 static void ipmi_smi_gone(int if_num)
 {
-	if (if_num <= MAX_DEVICES)
-		devfs_remove("ipmidev/%d", if_num);
+	devfs_remove("ipmidev/%d", if_num);
 }
 
 static struct ipmi_smi_watcher smi_watcher =
 {
-	.new_smi	= ipmi_new_smi,
-	.smi_gone	= ipmi_smi_gone,
+	.owner    = THIS_MODULE,
+	.new_smi  = ipmi_new_smi,
+	.smi_gone = ipmi_smi_gone,
 };
 
 static __init int init_ipmi_devintf(void)
@@ -467,6 +521,9 @@
 	if (ipmi_major < 0)
 		return -EINVAL;
 
+	printk(KERN_INFO "ipmi device interface version "
+	       IPMI_DEVINTF_VERSION "\n");
+
 	rv = register_chrdev(ipmi_major, DEVICE_NAME, &ipmi_fops);
 	if (rv < 0) {
 		printk(KERN_ERR "ipmi: can't get major %d\n", ipmi_major);
@@ -482,13 +539,10 @@
 	rv = ipmi_smi_watcher_register(&smi_watcher);
 	if (rv) {
 		unregister_chrdev(ipmi_major, DEVICE_NAME);
-		printk(KERN_WARNING "ipmi: can't register smi watcher");
+		printk(KERN_WARNING "ipmi: can't register smi watcher\n");
 		return rv;
 	}
 
-	printk(KERN_INFO "ipmi: device interface at char major %d\n",
-	       ipmi_major);
-
 	return 0;
 }
 module_init(init_ipmi_devintf);
diff -urN linux.orig/drivers/char/ipmi/ipmi_watchdog.c linux-a1/drivers/char/ipmi/ipmi_watchdog.c
--- linux.orig/drivers/char/ipmi/ipmi_watchdog.c	2003-12-17 20:59:53.000000000 -0600
+++ linux-a1/drivers/char/ipmi/ipmi_watchdog.c	2004-02-23 08:19:36.000000000 -0600
@@ -50,6 +50,8 @@
 #include <asm/apic.h>
 #endif
 
+#define IPMI_WATCHDOG_VERSION "v30"
+
 /*
  * The IPMI command/response information for the watchdog timer.
  */
@@ -153,10 +155,18 @@
 static char pretimeout_since_last_heartbeat = 0;
 
 MODULE_PARM(timeout, "i");
+MODULE_PARM_DESC(timeout, "Timeout value in seconds.");
 MODULE_PARM(pretimeout, "i");
+MODULE_PARM_DESC(pretimeout, "Pretimeout value in seconds.");
 MODULE_PARM(action, "s");
+MODULE_PARM_DESC(action, "Timeout action. One of: "
+		 "reset, none, power_cycle, power_off.");
 MODULE_PARM(preaction, "s");
+MODULE_PARM_DESC(preaction, "Pretimeout action.  One of: "
+		 "pre_none, pre_smi, pre_nmi, pre_int.");
 MODULE_PARM(preop, "s");
+MODULE_PARM_DESC(preop, "Pretimeout driver operation.  One of: "
+		 "preop_none, preop_panic, preop_give_data.");
 
 /* Default state of the timer. */
 static unsigned char ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
@@ -260,6 +270,7 @@
 				      (struct ipmi_addr *) &addr,
 				      0,
 				      &msg,
+				      NULL,
 				      smi_msg,
 				      recv_msg,
 				      1);
@@ -435,6 +446,7 @@
 				      (struct ipmi_addr *) &addr,
 				      0,
 				      &msg,
+				      NULL,
 				      &heartbeat_smi_msg,
 				      &heartbeat_recv_msg,
 				      1);
@@ -483,6 +495,7 @@
 				 (struct ipmi_addr *) &addr,
 				 0,
 				 &msg,
+				 NULL,
 				 &panic_halt_heartbeat_smi_msg,
 				 &panic_halt_heartbeat_recv_msg,
 				 1);
@@ -903,6 +916,7 @@
 
 static struct ipmi_smi_watcher smi_watcher =
 {
+	.owner    = THIS_MODULE,
 	.new_smi  = ipmi_new_smi,
 	.smi_gone = ipmi_smi_gone
 };
@@ -911,6 +925,9 @@
 {
 	int rv;
 
+	printk(KERN_INFO "IPMI watchdog driver version "
+	       IPMI_WATCHDOG_VERSION "\n");
+
 	if (strcmp(action, "reset") == 0) {
 		action_val = WDOG_TIMEOUT_RESET;
 	} else if (strcmp(action, "none") == 0) {
@@ -999,9 +1016,6 @@
 	register_reboot_notifier(&wdog_reboot_notifier);
 	notifier_chain_register(&panic_notifier_list, &wdog_panic_notifier);
 
-	printk(KERN_INFO "IPMI watchdog by "
-	       "Corey Minyard (minyard@mvista.com)\n");
-
 	return 0;
 }
 
@@ -1034,6 +1048,7 @@
 	   pointers to our buffers, we want to make sure they are done before
 	   we release our memory. */
 	while (atomic_read(&set_timeout_tofree)) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(1);
 	}
 
diff -urN linux.orig/include/linux/ipmi.h linux-a1/include/linux/ipmi.h
--- linux.orig/include/linux/ipmi.h	2003-12-17 20:59:59.000000000 -0600
+++ linux-a1/include/linux/ipmi.h	2004-02-23 08:19:36.000000000 -0600
@@ -109,6 +109,35 @@
 	unsigned char lun;
 };
 
+/*
+ * A LAN Address.  This is an address to/from a LAN interface bridged
+ * by the BMC, not an address actually out on the LAN.
+ *
+ * A concious decision was made here to deviate slightly from the IPMI
+ * spec.  We do not use rqSWID and rsSWID like it shows in the
+ * message.  Instead, we use remote_SWID and local_SWID.  This means
+ * that any message (a request or response) from another device will
+ * always have exactly the same address.  If you didn't do this,
+ * requests and responses from the same device would have different
+ * addresses, and that's not too cool.
+ *
+ * In this address, the remote_SWID is always the SWID the remote
+ * message came from, or the SWID we are sending the message to.
+ * local_SWID is always our SWID.  Note that having our SWID in the
+ * message is a little wierd, but this is required.
+ */
+#define IPMI_LAN_ADDR_TYPE		0x04
+struct ipmi_lan_addr
+{
+	int           addr_type;
+	short         channel;
+	unsigned char privilege;
+	unsigned char session_handle;
+	unsigned char remote_SWID;
+	unsigned char local_SWID;
+	unsigned char lun;
+};
+
 
 /*
  * Channel for talking directly with the BMC.  When using this
@@ -145,10 +174,20 @@
  * Receive types for messages coming from the receive interface.  This
  * is used for the receive in-kernel interface and in the receive
  * IOCTL.
+ *
+ * The "IPMI_RESPONSE_RESPNOSE_TYPE" is a little strange sounding, but
+ * it allows you to get the message results when you send a response
+ * message.
  */
 #define IPMI_RESPONSE_RECV_TYPE		1 /* A response to a command */
 #define IPMI_ASYNC_EVENT_RECV_TYPE	2 /* Something from the event queue */
 #define IPMI_CMD_RECV_TYPE		3 /* A command from somewhere else */
+#define IPMI_RESPONSE_RESPONSE_TYPE	4 /* The response for
+					      a sent response, giving any
+					      error status for sending the
+					      response.  When you send a
+					      response message, this will
+					      be returned. */
 /* Note that async events and received commands do not have a completion
    code as the first byte of the incoming data, unlike a response. */
 
@@ -160,6 +199,7 @@
  * The in-kernel interface.
  */
 #include <linux/list.h>
+#include <linux/module.h>
 
 /* Opaque type for a IPMI message user.  One of these is needed to
    send and receive messages. */
@@ -185,6 +225,12 @@
 	long             msgid;
 	struct ipmi_msg  msg;
 
+	/* The user_msg_data is the data supplied when a message was
+	   sent, if this is a response to a sent message.  If this is
+	   not a response to a sent message, then user_msg_data will
+	   be NULL. */
+	void             *user_msg_data;
+
 	/* Call this when done with the message.  It will presumably free
 	   the message and do any other necessary cleanup. */
 	void (*done)(struct ipmi_recv_msg *msg);
@@ -206,9 +252,10 @@
         /* Routine type to call when a message needs to be routed to
 	   the upper layer.  This will be called with some locks held,
 	   the only IPMI routines that can be called are ipmi_request
-	   and the alloc/free operations. */
+	   and the alloc/free operations.  The handler_data is the
+	   variable supplied when the receive handler was registered. */
 	void (*ipmi_recv_hndl)(struct ipmi_recv_msg *msg,
-			       void                 *handler_data);
+			       void                 *user_msg_data);
 
 	/* Called when the interface detects a watchdog pre-timeout.  If
 	   this is NULL, it will be ignored for the user. */
@@ -221,7 +268,12 @@
 		     void                  *handler_data,
 		     ipmi_user_t           *user);
 
-/* Destroy the given user of the IPMI layer. */
+/* Destroy the given user of the IPMI layer.  Note that after this
+   function returns, the system is guaranteed to not call any
+   callbacks for the user.  Thus as long as you destroy all the users
+   before you unload a module, you will be safe.  And if you destroy
+   the users before you destroy the callback structures, it should be
+   safe, too. */
 int ipmi_destroy_user(ipmi_user_t user);
 
 /* Get the IPMI version of the BMC we are talking to. */
@@ -253,20 +305,51 @@
  * in the msgid field of the received command.  If the priority is >
  * 0, the message will go into a high-priority queue and be sent
  * first.  Otherwise, it goes into a normal-priority queue.
+ * The user_msg_data field will be returned in any response to this
+ * message.
+ *
+ * Note that if you send a response (with the netfn lower bit set),
+ * you *will* get back a SEND_MSG response telling you what happened
+ * when the response was sent.  You will not get back a response to
+ * the message itself.
  */
 int ipmi_request(ipmi_user_t      user,
 		 struct ipmi_addr *addr,
 		 long             msgid,
 		 struct ipmi_msg  *msg,
+		 void             *user_msg_data,
 		 int              priority);
 
 /*
+ * Like ipmi_request, but lets you specify the number of retries and
+ * the retry time.  The retries is the number of times the message
+ * will be resent if no reply is received.  If set to -1, the default
+ * value will be used.  The retry time is the time in milliseconds
+ * between retries.  If set to zero, the default value will be
+ * used.
+ *
+ * Don't use this unless you *really* have to.  It's primarily for the
+ * IPMI over LAN converter; since the LAN stuff does its own retries,
+ * it makes no sense to do it here.  However, this can be used if you
+ * have unusual requirements.
+ */
+int ipmi_request_settime(ipmi_user_t      user,
+			 struct ipmi_addr *addr,
+			 long             msgid,
+			 struct ipmi_msg  *msg,
+			 void             *user_msg_data,
+			 int              priority,
+			 int              max_retries,
+			 unsigned int     retry_time_ms);
+
+/*
  * Like ipmi_request, but lets you specify the slave return address.
  */
 int ipmi_request_with_source(ipmi_user_t      user,
 			     struct ipmi_addr *addr,
 			     long             msgid,
 			     struct ipmi_msg  *msg,
+			     void             *user_msg_data,
 			     int              priority,
 			     unsigned char    source_address,
 			     unsigned char    source_lun);
@@ -284,6 +367,7 @@
 			     struct ipmi_addr     *addr,
 			     long                 msgid,
 			     struct ipmi_msg      *msg,
+			     void                 *user_msg_data,
 			     void                 *supplied_smi,
 			     struct ipmi_recv_msg *supplied_recv,
 			     int                  priority);
@@ -331,6 +415,10 @@
 {
 	struct list_head link;
 
+	/* You must set the owner to the current module, if you are in
+	   a module (generally just set it to "THIS_MODULE"). */
+	struct module *owner;
+
 	/* These two are called with read locks held for the interface
 	   the watcher list.  So you can add and remove users from the
 	   IPMI interface, send messages, etc., but you cannot add
@@ -422,6 +510,29 @@
 #define IPMICTL_SEND_COMMAND		_IOR(IPMI_IOC_MAGIC, 13,	\
 					     struct ipmi_req)
 
+/* Messages sent to the interface with timing parameters are this
+   format. */
+struct ipmi_req_settime
+{
+	struct ipmi_req req;
+
+	/* See ipmi_request_settime() above for details on these
+           values. */
+	int          retries;
+	unsigned int retry_time_ms;
+};
+/*
+ * Send a message to the interfaces with timing parameters.  error values
+ * are:
+ *   - EFAULT - an address supplied was invalid.
+ *   - EINVAL - The address supplied was not valid, or the command
+ *              was not allowed.
+ *   - EMSGSIZE - The message to was too large.
+ *   - ENOMEM - Buffers could not be allocated for the command.
+ */
+#define IPMICTL_SEND_COMMAND_SETTIME	_IOR(IPMI_IOC_MAGIC, 21,	\
+					     struct ipmi_req_settime)
+
 /* Messages received from the interface are this format. */
 struct ipmi_recv
 {
@@ -513,4 +624,18 @@
 #define IPMICTL_SET_MY_LUN_CMD		_IOR(IPMI_IOC_MAGIC, 19, unsigned int)
 #define IPMICTL_GET_MY_LUN_CMD		_IOR(IPMI_IOC_MAGIC, 20, unsigned int)
 
+/*
+ * Get/set the default timing values for an interface.  You shouldn't
+ * generally mess with these.
+ */
+struct ipmi_timing_parms
+{
+	int          retries;
+	unsigned int retry_time_ms;
+};
+#define IPMICTL_SET_TIMING_PARMS_CMD	_IOR(IPMI_IOC_MAGIC, 22, \
+					     struct ipmi_timing_parms)
+#define IPMICTL_GET_TIMING_PARMS_CMD	_IOR(IPMI_IOC_MAGIC, 23, \
+					     struct ipmi_timing_parms)
+
 #endif /* __LINUX_IPMI_H */
diff -urN linux.orig/include/linux/ipmi_msgdefs.h linux-a1/include/linux/ipmi_msgdefs.h
--- linux.orig/include/linux/ipmi_msgdefs.h	2003-12-17 20:59:06.000000000 -0600
+++ linux-a1/include/linux/ipmi_msgdefs.h	2004-02-23 08:19:36.000000000 -0600
@@ -53,6 +53,7 @@
 #define IPMI_SET_BMC_GLOBAL_ENABLES_CMD	0x2e
 #define IPMI_GET_BMC_GLOBAL_ENABLES_CMD	0x2f
 #define IPMI_READ_EVENT_MSG_BUFFER_CMD	0x35
+#define IPMI_GET_CHANNEL_INFO_CMD	0x42
 
 #define IPMI_NETFN_STORAGE_REQUEST		0x0a
 #define IPMI_NETFN_STORAGE_RESPONSE		0x0b
@@ -61,8 +62,39 @@
 /* The default slave address */
 #define IPMI_BMC_SLAVE_ADDR	0x20
 
-#define IPMI_MAX_MSG_LENGTH	80
+/* The BT interface on high-end HP systems supports up to 255 bytes in
+ * one transfer.  Its "virtual" BMC supports some commands that are longer
+ * than 128 bytes.  Use the full 256, plus NetFn/LUN, Cmd, cCode, plus
+ * some overhead.  It would be nice to base this on the "BT Capabilities"
+ * but that's too hard to propogate to the rest of the driver. */
+#define IPMI_MAX_MSG_LENGTH	272	/* multiple of 16 */
 
-#define IPMI_CC_NO_ERROR	0
+#define IPMI_CC_NO_ERROR		0x00
+#define IPMI_NODE_BUSY_ERR		0xc0
+#define IPMI_ERR_MSG_TRUNCATED		0xc6
+#define IPMI_LOST_ARBITRATION_ERR	0x81
+#define IPMI_ERR_UNSPECIFIED		0xff
+
+#define IPMI_CHANNEL_PROTOCOL_IPMB	1
+#define IPMI_CHANNEL_PROTOCOL_ICMB	2
+#define IPMI_CHANNEL_PROTOCOL_SMBUS	4
+#define IPMI_CHANNEL_PROTOCOL_KCS	5
+#define IPMI_CHANNEL_PROTOCOL_SMIC	6
+#define IPMI_CHANNEL_PROTOCOL_BT10	7
+#define IPMI_CHANNEL_PROTOCOL_BT15	8
+#define IPMI_CHANNEL_PROTOCOL_TMODE	9
+
+#define IPMI_CHANNEL_MEDIUM_IPMB	1
+#define IPMI_CHANNEL_MEDIUM_ICMB10	2
+#define IPMI_CHANNEL_MEDIUM_ICMB09	3
+#define IPMI_CHANNEL_MEDIUM_8023LAN	4
+#define IPMI_CHANNEL_MEDIUM_ASYNC	5
+#define IPMI_CHANNEL_MEDIUM_OTHER_LAN	6
+#define IPMI_CHANNEL_MEDIUM_PCI_SMBUS	7
+#define IPMI_CHANNEL_MEDIUM_SMBUS1	8
+#define IPMI_CHANNEL_MEDIUM_SMBUS2	9
+#define IPMI_CHANNEL_MEDIUM_USB1	10
+#define IPMI_CHANNEL_MEDIUM_USB2	11
+#define IPMI_CHANNEL_MEDIUM_SYSINTF	12
 
 #endif /* __LINUX_IPMI_MSGDEFS_H */
diff -urN linux.orig/include/linux/ipmi_smi.h linux-a1/include/linux/ipmi_smi.h
--- linux.orig/include/linux/ipmi_smi.h	2003-12-17 20:59:05.000000000 -0600
+++ linux-a1/include/linux/ipmi_smi.h	2004-02-23 08:19:36.000000000 -0600
@@ -35,6 +35,8 @@
 #define __LINUX_IPMI_SMI_H
 
 #include <linux/ipmi_msgdefs.h>
+#include <linux/proc_fs.h>
+#include <linux/module.h>
 
 /* This files describes the interface for IPMI system management interface
    drivers to bind into the IPMI message handler. */
@@ -48,7 +50,7 @@
  * been received, it will report this same data structure back up to
  * the upper layer.  If an error occurs, it should fill in the
  * response with an error code in the completion code location. When
- * asyncronous data is received, one of these is allocated, the
+ * asynchronous data is received, one of these is allocated, the
  * data_size is set to zero and the response holds the data from the
  * get message or get event command that the interface initiated.
  * Note that it is the interfaces responsibility to detect
@@ -62,9 +64,6 @@
 	long    msgid;
 	void    *user_data;
 
-	/* If 0, add to the end of the queue.  If 1, add to the beginning. */
-	int     prio;
-
 	int           data_size;
 	unsigned char data[IPMI_MAX_MSG_LENGTH];
 
@@ -134,4 +133,11 @@
 	msg->done(msg);
 }
 
+/* Allow the lower layer to add things to the proc filesystem
+   directory for this interface.  Note that the entry will
+   automatically be dstroyed when the interface is destroyed. */
+int ipmi_smi_add_proc_entry(ipmi_smi_t smi, char *name,
+			    read_proc_t *read_proc, write_proc_t *write_proc,
+			    void *data, struct module *owner);
+
 #endif /* __LINUX_IPMI_SMI_H */

--------------030804030205090001030702--

