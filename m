Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUJ3Cyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUJ3Cyf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 22:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbUJ3Cyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 22:54:32 -0400
Received: from soundwarez.org ([217.160.171.123]:5307 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S263024AbUJ3CyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 22:54:15 -0400
Date: Sat, 30 Oct 2004 04:54:29 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: Andrew <cmkrnl@speakeasy.net>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.6.10.rc1.bk6 /lib/kobject_uevent.c buffer issues
Message-ID: <20041030025429.GA13757@vrfy.org>
References: <20041027142925.GA17484@imladris.arnor.me> <20041027152134.GA13991@kroah.com> <417FCD78.6020807@speakeasy.net> <20041029201314.GA29171@kroah.com> <20041029212856.GA12582@vrfy.org> <20041029231319.GA503@kroah.com> <20041030000045.GA13356@vrfy.org> <20041030002523.GA13425@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041030002523.GA13425@vrfy.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 02:25:23AM +0200, Kay Sievers wrote:
> On Sat, Oct 30, 2004 at 02:00:45AM +0200, Kay Sievers wrote:
> > On Fri, Oct 29, 2004 at 06:13:19PM -0500, Greg KH wrote:
> > > On Fri, Oct 29, 2004 at 11:28:56PM +0200, Kay Sievers wrote:
> > > > > But there might still be a problem.  With this change, the sequence
> > > > > number is not sent out the kevent message.  Kay, do you think this is an
> > > > > issue?  I don't think we can get netlink messages out of order, right?
> > > > 
> > > > Right, especially not the events with the same DEVPATH, like "remove"
> > > > beating an "add". But I'm not sure if the number isn't useful. Whatever
> > > > we may do with the hotplug over netlink in the future, we will only have
> > > > /sbin/hotplug for the early boot and it may be nice to know, what events
> > > > we have already handled...
> > > > 
> > > > > I'll hold off on applying this patch until we figure this out...
> > > > 
> > > > How about just reserving 20 bytes for the number (u64 will never be
> > > > more than that), save the pointer to that field, and fill the number in
> > > > later?
> > > 
> > > Ah, something like this instead?  I like it, it's even smaller than the
> > > previous patch.  Compile tested only...
> > 
> > I like that. How about the following. It will keep the buffer clean from
> > random chars, cause the kevent does not have the vector and relies on
> > the '\0' to separate the strings from each other.
> > I've tested it. The netlink-hotplug message looks like this:
> > 
> > recv(3, "remove@/class/input/mouse2\0ACTION=remove\0DEVPATH=/class/input/mouse2\0SUBSYSTEM=input\0SEQNUM=961                 \0", 1024, 0) = 113
> 
> Hmm, these trailing spaces are just bad, sorry. I'll better pass the
> envp array over to send_uevent() and clean up the keys while copying
> the env values into the skb buffer. This will make the event payload
> more safe too. So your first version looks better.

How about this? We copy over key by key into the skb buffer and the
netlink message can get the envp array without depending on a single
continuous buffer.

The netlink message looks nice like this now:

recv(3, "
  add@/devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0\0
  HOME=/\0
  PATH=/sbin:/bin:/usr/sbin:/usr/bin\0
  ACTION=add\0
  DEVPATH=/devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0\0
  SUBSYSTEM=usb\0
  SEQNUM=991\0
  DEVICE=/proc/bus/usb/003/008\0
  PRODUCT=46d/c03e/2000\0
  TYPE=0/0/0\0
  INTERFACE=3/1/2\0
", 1024, 0) = 268


Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

===== lib/kobject_uevent.c 1.10 vs edited =====
--- 1.10/lib/kobject_uevent.c	2004-10-23 00:42:52 +02:00
+++ edited/lib/kobject_uevent.c	2004-10-30 03:53:18 +02:00
@@ -23,6 +23,9 @@
 #include <linux/kobject.h>
 #include <net/sock.h>
 
+#define BUFFER_SIZE	1024	/* buffer for the hotplug env */
+#define NUM_ENVP	32	/* number of env pointers */
+
 #if defined(CONFIG_KOBJECT_UEVENT) || defined(CONFIG_HOTPLUG)
 static char *action_to_string(enum kobject_action action)
 {
@@ -57,28 +60,40 @@ static struct sock *uevent_sock;
  * @buflen:
  * gfp_mask:
  */
-static int send_uevent(const char *signal, const char *obj, const void *buf,
-			int buflen, int gfp_mask)
+static int send_uevent(const char *signal, const char *obj,
+		       char **envp, int gfp_mask)
 {
 	struct sk_buff *skb;
 	char *pos;
-	int len;
+	int i;
+	int skblen, linelen;
 
 	if (!uevent_sock)
 		return -EIO;
 
-	len = strlen(signal) + 1;
-	len += strlen(obj) + 1;
-	len += buflen;
+	skblen = strlen(signal) + 1;
+	skblen += strlen(obj) + 1;
 
-	skb = alloc_skb(len, gfp_mask);
+	/* allocate buffer with maximum message size */
+	skb = alloc_skb(skblen + BUFFER_SIZE, gfp_mask);
 	if (!skb)
 		return -ENOMEM;
 
-	pos = skb_put(skb, len);
+	pos = skb_put(skb, skblen + BUFFER_SIZE);
 
 	pos += sprintf(pos, "%s@%s", signal, obj) + 1;
-	memcpy(pos, buf, buflen);
+
+	/* copy the environment key by key to our '\0' delimited buffer */
+	if (envp) {
+		for (i = 0; envp[i]; i++) {
+			linelen = strlcpy(pos, envp[i], BUFFER_SIZE) + 1;
+			skblen += linelen;
+			pos += linelen;
+		}
+	}
+
+	/* trim skb buffer to the actual used size */
+	skb_trim(skb, skblen);
 
 	return netlink_broadcast(uevent_sock, skb, 0, 1, gfp_mask);
 }
@@ -107,10 +122,10 @@ static int do_kobject_uevent(struct kobj
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
@@ -169,8 +184,6 @@ static inline int send_uevent(const char
 u64 hotplug_seqnum;
 static spinlock_t sequence_lock = SPIN_LOCK_UNLOCKED;
 
-#define BUFFER_SIZE	1024	/* should be enough memory for the env */
-#define NUM_ENVP	32	/* number of env pointers */
 /**
  * kobject_hotplug - notify userspace by executing /sbin/hotplug
  *
@@ -182,6 +195,7 @@ void kobject_hotplug(struct kobject *kob
 	char *argv [3];
 	char **envp = NULL;
 	char *buffer = NULL;
+	char *seq_buff;
 	char *scratch;
 	int i = 0;
 	int retval;
@@ -258,6 +272,11 @@ void kobject_hotplug(struct kobject *kob
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
@@ -273,15 +292,13 @@ void kobject_hotplug(struct kobject *kob
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

