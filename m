Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269610AbUKAXGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269610AbUKAXGK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S287108AbUKAXGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:06:09 -0500
Received: from mail.kroah.org ([69.55.234.183]:932 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S320688AbUKAV7R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:59:17 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
In-Reply-To: <1099346277177@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Mon, 1 Nov 2004 13:57:57 -0800
Message-Id: <10993462772966@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2450, 2004/11/01 13:06:02-08:00, kay.sievers@vrfy.org

[PATCH] kobject: fix hotplug bug with seqnum

On Sat, Oct 30, 2004 at 04:54:29AM +0200, Kay Sievers wrote:
> On Sat, Oct 30, 2004 at 02:25:23AM +0200, Kay Sievers wrote:
> > On Sat, Oct 30, 2004 at 02:00:45AM +0200, Kay Sievers wrote:
> > > On Fri, Oct 29, 2004 at 06:13:19PM -0500, Greg KH wrote:
> > > > On Fri, Oct 29, 2004 at 11:28:56PM +0200, Kay Sievers wrote:
> > > > > > But there might still be a problem.  With this change, the sequence
> > > > > > number is not sent out the kevent message.  Kay, do you think this is an
> > > > > > issue?  I don't think we can get netlink messages out of order, right?
> > > > >
> > > > > Right, especially not the events with the same DEVPATH, like "remove"
> > > > > beating an "add". But I'm not sure if the number isn't useful. Whatever
> > > > > we may do with the hotplug over netlink in the future, we will only have
> > > > > /sbin/hotplug for the early boot and it may be nice to know, what events
> > > > > we have already handled...
> > > > >
> > > > > > I'll hold off on applying this patch until we figure this out...
> > > > >
> > > > > How about just reserving 20 bytes for the number (u64 will never be
> > > > > more than that), save the pointer to that field, and fill the number in
> > > > > later?
> > > >
> > > > Ah, something like this instead?  I like it, it's even smaller than the
> > > > previous patch.  Compile tested only...
> > >
> > > I like that. How about the following. It will keep the buffer clean from
> > > random chars, cause the kevent does not have the vector and relies on
> > > the '\0' to separate the strings from each other.
> > > I've tested it. The netlink-hotplug message looks like this:
> > >
> > > recv(3, "remove@/class/input/mouse2\0ACTION=remove\0DEVPATH=/class/input/mouse2\0SUBSYSTEM=input\0SEQNUM=961                 \0", 1024, 0) = 113
> >
> > Hmm, these trailing spaces are just bad, sorry. I'll better pass the
> > envp array over to send_uevent() and clean up the keys while copying
> > the env values into the skb buffer. This will make the event payload
> > more safe too. So your first version looks better.
>
> How about this? We copy over key by key into the skb buffer and the
> netlink message can get the envp array without depending on a single
> continuous buffer.
>
> The netlink message looks nice like this now:
>
> recv(3, "
>   add@/devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0\0
>   HOME=/\0
>   PATH=/sbin:/bin:/usr/sbin:/usr/bin\0
>   ACTION=add\0
>   DEVPATH=/devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0\0
>   SUBSYSTEM=usb\0
>   SEQNUM=991\0
>   DEVICE=/proc/bus/usb/003/008\0
>   PRODUCT=46d/c03e/2000\0
>   TYPE=0/0/0\0
>   INTERFACE=3/1/2\0
> ", 1024, 0) = 268

Here is an improved version that uses skb_put() to fill the skb buffer,
instead of trimming the buffer to the final size after we've copied over
all keys.


Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 lib/kobject_uevent.c |   47 ++++++++++++++++++++++++++++++-----------------
 1 files changed, 30 insertions(+), 17 deletions(-)


diff -Nru a/lib/kobject_uevent.c b/lib/kobject_uevent.c
--- a/lib/kobject_uevent.c	2004-11-01 13:36:12 -08:00
+++ b/lib/kobject_uevent.c	2004-11-01 13:36:12 -08:00
@@ -23,6 +23,9 @@
 #include <linux/kobject.h>
 #include <net/sock.h>
 
+#define BUFFER_SIZE	1024	/* buffer for the hotplug env */
+#define NUM_ENVP	32	/* number of env pointers */
+
 #if defined(CONFIG_KOBJECT_UEVENT) || defined(CONFIG_HOTPLUG)
 static char *action_to_string(enum kobject_action action)
 {
@@ -53,12 +56,11 @@
  *
  * @signal: signal name
  * @obj: object path (kobject)
- * @buf: buffer used to pass auxiliary data like the hotplug environment
- * @buflen:
- * gfp_mask:
+ * @envp: possible hotplug environment to pass with the message
+ * @gfp_mask:
  */
-static int send_uevent(const char *signal, const char *obj, const void *buf,
-			int buflen, int gfp_mask)
+static int send_uevent(const char *signal, const char *obj,
+		       char **envp, int gfp_mask)
 {
 	struct sk_buff *skb;
 	char *pos;
@@ -69,16 +71,25 @@
 
 	len = strlen(signal) + 1;
 	len += strlen(obj) + 1;
-	len += buflen;
 
-	skb = alloc_skb(len, gfp_mask);
+	/* allocate buffer with the maximum possible message size */
+	skb = alloc_skb(len + BUFFER_SIZE, gfp_mask);
 	if (!skb)
 		return -ENOMEM;
 
 	pos = skb_put(skb, len);
+	sprintf(pos, "%s@%s", signal, obj);
 
-	pos += sprintf(pos, "%s@%s", signal, obj) + 1;
-	memcpy(pos, buf, buflen);
+	/* copy the environment key by key to our continuous buffer */
+	if (envp) {
+		int i;
+
+		for (i = 2; envp[i]; i++) {
+			len = strlen(envp[i]) + 1;
+			pos = skb_put(skb, len);
+			strcpy(pos, envp[i]);
+		}
+	}
 
 	return netlink_broadcast(uevent_sock, skb, 0, 1, gfp_mask);
 }
@@ -107,10 +118,10 @@
 		if (!attrpath)
 			goto exit;
 		sprintf(attrpath, "%s/%s", path, attr->name);
-		rc = send_uevent(signal, attrpath, NULL, 0, gfp_mask);
+		rc = send_uevent(signal, attrpath, NULL, gfp_mask);
 		kfree(attrpath);
 	} else {
-		rc = send_uevent(signal, path, NULL, 0, gfp_mask);
+		rc = send_uevent(signal, path, NULL, gfp_mask);
 	}
 
 exit:
@@ -169,8 +180,6 @@
 u64 hotplug_seqnum;
 static spinlock_t sequence_lock = SPIN_LOCK_UNLOCKED;
 
-#define BUFFER_SIZE	1024	/* should be enough memory for the env */
-#define NUM_ENVP	32	/* number of env pointers */
 /**
  * kobject_hotplug - notify userspace by executing /sbin/hotplug
  *
@@ -182,6 +191,7 @@
 	char *argv [3];
 	char **envp = NULL;
 	char *buffer = NULL;
+	char *seq_buff;
 	char *scratch;
 	int i = 0;
 	int retval;
@@ -258,6 +268,11 @@
 	envp [i++] = scratch;
 	scratch += sprintf(scratch, "SUBSYSTEM=%s", name) + 1;
 
+	/* reserve space for the sequence,
+	 * put the real one in after the hotplug call */
+	envp[i++] = seq_buff = scratch;
+	scratch += strlen("SEQNUM=18446744073709551616") + 1;
+
 	if (hotplug_ops->hotplug) {
 		/* have the kset specific function add its stuff */
 		retval = hotplug_ops->hotplug (kset, kobj,
@@ -273,15 +288,13 @@
 	spin_lock(&sequence_lock);
 	seq = ++hotplug_seqnum;
 	spin_unlock(&sequence_lock);
-
-	envp [i++] = scratch;
-	scratch += sprintf(scratch, "SEQNUM=%lld", (long long)seq) + 1;
+	sprintf(seq_buff, "SEQNUM=%lld", (long long)seq);
 
 	pr_debug ("%s: %s %s seq=%lld %s %s %s %s %s\n",
 		  __FUNCTION__, argv[0], argv[1], (long long)seq,
 		  envp[0], envp[1], envp[2], envp[3], envp[4]);
 
-	send_uevent(action_string, kobj_path, buffer, scratch - buffer, GFP_KERNEL);
+	send_uevent(action_string, kobj_path, envp, GFP_KERNEL);
 
 	if (!hotplug_path[0])
 		goto exit;

