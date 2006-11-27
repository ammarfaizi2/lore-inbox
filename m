Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933073AbWK0S4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933073AbWK0S4z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933156AbWK0S4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:56:55 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:24546 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S933073AbWK0S4x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:56:53 -0500
Date: Mon, 27 Nov 2006 12:56:51 -0600
To: juanslayton@dslextreme.com
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [RFC/PATCH] Uncap max number of evdev devices [was: Re: need more events]
Message-ID: <20061127185651.GC10879@austin.ibm.com>
References: <7c50a14e8ca157b0abe20a.20061124170952.whnafynlgba@www.dslextreme.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c50a14e8ca157b0abe20a.20061124170952.whnafynlgba@www.dslextreme.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2006 at 05:09:52PM -0800, juanslayton@dslextreme.com wrote:
> 
>      The object is to poll 20 usb keyboards in an elementary school
> classroom, each of which generates 2
> events (one keyboard and one mouse).  The stock kernel maxes out at event
> 31, leaving me 4
> keyboards short.
>      I thought to fix this by changing the definition of EVDEV_MINORS
> (line 12, evdev.c) from 32 to 64.  It almost worked.  The extra
> events showed up in /dev/input/* and /proc/bus/input/devices.
> However, attempting to access the new events in the application
> program only yields a segmentation fault.  Obviously I've got to change
> something else.

The problem is in input_register_handler() in drivers/input/input.c
which does things like 
if (input_table[handler->minor >> 5])
 and 
input_table[handler->minor >> 5] = handler;

which implicitly makes 32 the max. 

The kernel path below removes this limitation. Does it fix your problem?

--linas


The evdev code is limited to 32 input devices max, because
the generic input layer puts a 32-device cap on the number
of minor device numbers that a device driver can register.

This patch hacks around the 32-device limitation for 
the number of evdev drivers. Not clear to me if this
this is the best solution. 

Not-even-compile-tested.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/input/input.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

Index: linux-2.6.19-rc4-git3/drivers/input/input.c
===================================================================
--- linux-2.6.19-rc4-git3.orig/drivers/input/input.c	2006-11-01 16:15:19.000000000 -0600
+++ linux-2.6.19-rc4-git3/drivers/input/input.c	2006-11-27 12:50:12.000000000 -0600
@@ -28,12 +28,16 @@ MODULE_AUTHOR("Vojtech Pavlik <vojtech@s
 MODULE_DESCRIPTION("Input core");
 MODULE_LICENSE("GPL");
 
-#define INPUT_DEVICES	256
+#define INPUT_MINOR_BITS   8
+#define INPUT_DEVICES      (1<<INPUT_MINOR_BITS)
+#define MINOR_RANGE_BITS   6
+#define MINOR_RANGES       (1<<(INPUT_MINOR_BITS-MINOR_RANGE_BITS))
+#define TABLE_OFFSET(minor) ((minor)>>MINOR_RANGE_BITS)
 
 static LIST_HEAD(input_dev_list);
 static LIST_HEAD(input_handler_list);
 
-static struct input_handler *input_table[8];
+static struct input_handler *input_table[MINOR_RANGES];
 
 /**
  * input_event() - report new input event
@@ -1046,10 +1050,10 @@ int input_register_handler(struct input_
 	INIT_LIST_HEAD(&handler->h_list);
 
 	if (handler->fops != NULL) {
-		if (input_table[handler->minor >> 5])
+		if (input_table[TABLE_OFFSET(handler->minor)])
 			return -EBUSY;
 
-		input_table[handler->minor >> 5] = handler;
+		input_table[TABLE_OFFSET(handler->minor)] = handler;
 	}
 
 	list_add_tail(&handler->node, &input_handler_list);
@@ -1082,7 +1086,7 @@ void input_unregister_handler(struct inp
 	list_del_init(&handler->node);
 
 	if (handler->fops != NULL)
-		input_table[handler->minor >> 5] = NULL;
+		input_table[TABLE_OFFSET(handler->minor)] = NULL;
 
 	input_wakeup_procfs_readers();
 }
@@ -1090,7 +1094,7 @@ EXPORT_SYMBOL(input_unregister_handler);
 
 static int input_open_file(struct inode *inode, struct file *file)
 {
-	struct input_handler *handler = input_table[iminor(inode) >> 5];
+	struct input_handler *handler = input_table[TABLE_OFFSET(iminor(inode))];
 	const struct file_operations *old_fops, *new_fops = NULL;
 	int err;
 
