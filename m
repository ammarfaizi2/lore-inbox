Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbSJLD23>; Fri, 11 Oct 2002 23:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262790AbSJLD23>; Fri, 11 Oct 2002 23:28:29 -0400
Received: from air-2.osdl.org ([65.172.181.6]:21893 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262789AbSJLD2Z>;
	Fri, 11 Oct 2002 23:28:25 -0400
Date: Fri, 11 Oct 2002 20:32:33 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Corey Minyard <minyard@acm.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IPMI driver for Linux, version 5
In-Reply-To: <3DA4904F.7000801@acm.org>
Message-ID: <Pine.LNX.4.33L2.0210112029430.9200-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2002, Corey Minyard wrote:

| I have put a new version of the IPMI driver on my home page
| (http://home.attbi.com/~minyard) that removes the Linus-incompatable
| typedefs.  The only typedefs left are "handle" ones.
|
| PS - In case you don't know, IPMI is a standard for system management,
| it provides ways to detect the managed devices in the system and sensors
| attached to them.  You can get more information at
| http://www.intel.com/design/servers/ipmi/spec.htm
| -


Hi Corey,

Thanks for eliminating most of those typedefs.
What is a handle, and why did you leave those?

I applied and built this on 2.5.41 (in-kernel and modular).
Only one compile warning:
## drivers/char/ipmi/ipmi_kcs_sm.c:234: warning: implicit declaration of function 'memcpy'

Alan has reviewed this driver, right?  (at least an earlier
version of it)

And you are asking for a major device number assignment?

I believe that this driver is in pretty good condition for
addition to the 2.5 kernel.

Specific comments below, each beginning with "##".

Warning to others: long-ish.

~Randy


+++ linux/drivers/char/Config.help	Fri Sep 20 08:37:00 2002

+CONFIG_IPMI_EMULATE_RADISYS
+  This enables emulation of the Radisys IPMI device driver.
+CONFIG_IPMI_EMULATE_INTEL
+  This enables emulation of the Intel IMB device driver.

## These CONFIG_'s aren't used.  Can be removed from help file
## unless there is code to be added for them.

+++ linux/drivers/char/ipmi/Makefile	Thu Aug 22 20:58:47 2002

+O_TARGET	:= built-in.o
## delete O_TARGET for 2.5.lately

+list-multi := ipmi_kcs_drv.o
## delete list-multi for 2.5.lately

+++ linux/drivers/char/ipmi/ipmi_devintf.c	Wed Oct  9 14:38:56 2002

+static int init_ipmi_devintf(void)
## use __init here.
+{
+	int rv;
...
+	rv = ipmi_smi_watcher_register(&smi_watcher);
+	if (rv) {
+		printk(KERN_WARNING "ipmi: can't register smi watcher");
##  need to undo/return/free anything here ?? (see cleanup_ipmi())
+		return rv;
+	}
+}

+#ifdef MODULE
##  don't need this #ifdef
+static void cleanup_ipmi(void)
##  use __exit here
+{
+	ipmi_smi_watcher_unregister(&smi_watcher);
+	devfs_unregister(devfs_handle);
+	unregister_chrdev(ipmi_major, DEVICE_NAME);
+}
+module_exit(cleanup_ipmi);
+#else
## #ifndef MODULE (or nothing since it's __init)
+static int __init ipmi_setup (char *str)
+{
...
+}
+#endif

+++ linux/drivers/char/ipmi/ipmi_kcs_intf.c	Wed Oct  9 14:38:56 2002

+	/* Flags from the last GET_MSG_FLAGS command, used when an ATTN
+	   is set to hold the flags until we are done handling everything
+	   from the flags. */
+	unsigned char       msg_flags;
#define RECEIVE_MSG_AVAIL	0x01
#define EVENT_MSG_BUFFER_FULL	0x02
#define WDT_PRE_TIMEOUT_INT	0x08
## and use these instead of magic numbers when testing <msg_flags> below.

+static int init_ipmi_kcs(void)
## use __init

+#ifdef MODULE
+void cleanup_one_kcs(struct kcs_info *to_clean)
## use __exit

+static void cleanup_ipmi_kcs(void)
## use __exit

+++ linux/drivers/char/ipmi/ipmi_kcs_sm.c	Fri Aug 23 12:03:31 2002

+/* The states the KCS driver may be in. */
+typedef enum kcs_states_e {
...
+} kcs_states_t;
## still have typedefs

+int kcs_get_result(kcs_data_t *kcs, unsigned char *data, int length)
+{
...
+		data[2] = 0xc6; /* Report a truncated error.  We might
+                                   overwrite another error, but that's
+                                   too bad, the user needs to know it
+                                   was truncated. */
## use #defines (with useful names) for magic values

+int kcs_size(void)
+{
+	return sizeof(kcs_data_t);
+}
## why a function ? maybe inline in a header file ?

+++ linux/drivers/char/ipmi/ipmi_kcs_sm.h	Fri Aug 23 11:21:44 2002

+typedef struct kcs_data_s kcs_data_t;
+typedef enum kcs_result_e
+{
...
+} kcs_result_t;
## still have typedefs

+/* Return the size of the KCS structure in bytes. */
+int kcs_size(void);
## put inline here.

+++ linux/drivers/char/ipmi/ipmi_msghandler.c	Wed Oct  9 14:38:56 2002

+int ipmi_request(ipmi_user_t      *user,
+		 struct ipmi_addr *addr,
+		 long             msgid,
+		 struct ipmi_msg  *msg,
+		 int              priority)
+{
+	return i_ipmi_request(user,
+			      user->intf,
+			      addr,
+			      msgid,
+			      msg,
+			      NULL, NULL,
+			      priority);
+}
## why not inline ?

+int ipmi_request_supply_msgs(ipmi_user_t          *user,
+			     struct ipmi_addr     *addr,
+			     long                 msgid,
+			     struct ipmi_msg      *msg,
+			     void                 *supplied_smi,
+			     struct ipmi_recv_msg *supplied_recv,
+			     int                  priority)
+{
+	return i_ipmi_request(user,
+			      user->intf,
+			      addr,
+			      msgid,
+			      msg,
+			      supplied_smi,
+			      supplied_recv,
+			      priority);
+}
## why not inline ?

## Lots of pre-function comments throughout the driver(s) should be in
## typical kernel style, like this one copied from kernel/exit.c:
/*
 * Send signals to all our closest relatives so that they know
 * to properly mourn us..
 */
## as compared to:
+/* Handle a new message.  Return 1 if the message should be requeued,
+   0 if the message should be freed, or -1 if the message should not
+   be freed or requeued. */

+static int has_paniced = 0;
## why are these (data, code) not inside CONFIG_IPMI_PANIC_EVENT ?
## along with notifier_chain_[un]register() calls ?
## except do it _without_ #ifdefs in the middle of functions.
## i.e., hide the #ifdefs in a header file.
+static int panic_event(struct notifier_block *this,
+		       unsigned long         event,
+                       void                  *ptr)
+{
+	int        i;
+	ipmi_smi_t *intf;
+
+	if (has_paniced)
+		return NOTIFY_DONE;
+	has_paniced = 1;
+
+	/* For every registered interface, set it to run to completion. */
+	for (i=0; i<MAX_IPMI_INTERFACES; i++) {
+		intf = ipmi_interfaces[i];
+		if (intf == NULL)
+			continue;
+
+		intf->handlers->set_run_to_completion(intf->send_info, 1);
+	}
+
+#ifdef CONFIG_IPMI_PANIC_EVENT
+	send_panic_events();
+#endif
## hide this #ifdef in a header file.
+
+	return NOTIFY_DONE;
+}

+static int ipmi_init_msghandler(void)
+{
...
+	notifier_chain_register(&panic_notifier_list, &panic_block);
## should be conditional on CONFIG_IPMI_PANIC_EVENT

+#ifdef MODULE
## don't need this #ifdef
+static void cleanup_ipmi(void)
## use __exit

+	notifier_chain_unregister(&panic_notifier_list, &panic_block);
## should be conditional on CONFIG_IPMI_PANIC_EVENT

+++ linux/drivers/char/ipmi/ipmi_watchdog.c	Wed Oct  9 14:38:56 2002

+static void ipmi_wdog_pretimeout_handler(void *handler_data)
+{
+	panic("Watchdog pre-timeout");
## why panic on a pre-timeout condition ?

+#ifdef MODULE
+static void ipmi_unregister_watchdog(void)
## can be __exit

+++ linux/include/linux/ipmi.h	Wed Oct  9 14:38:56 2002

+#ifdef __KERNEL__
## why is this needed?  kernel headers shouldn't be used in userspace.

+typedef struct ipmi_user_s ipmi_user_t;
## remove typedefs

+/*
+ * The userland interface
+ */
## userspace interface in a kernel header file ??  not good.

+++ linux/include/linux/ipmi_smi.h	Wed Oct  9 14:38:56 2002

+typedef struct ipmi_smi_s ipmi_smi_t;
## remove typedefs

+++ linux/kernel/ksyms.c	Fri Sep 20 08:37:16 2002

+EXPORT_SYMBOL(panic_notifier_list);
## don't need this.  (it's already extern; build works without this)

--

