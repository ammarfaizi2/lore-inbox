Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282076AbRK1H1m>; Wed, 28 Nov 2001 02:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282029AbRK1H1d>; Wed, 28 Nov 2001 02:27:33 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:9925 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S281815AbRK1H1Z>;
	Wed, 28 Nov 2001 02:27:25 -0500
Message-ID: <3C0491DA.9040602@candelatech.com>
Date: Wed, 28 Nov 2001 00:27:22 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: VLAN Mailing List <vlan@Scry.WANfear.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] VLAN 1.6 against 2.4.16
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is in response to the module compile problem
noticed by Maciej.  It also fixes a memory leak on module
remove noticed by Ard van Breemen.  Contact information
has also been updated...

I've tested it on x86, both modular and otherwise, and it
seems to work fine....

Enjoy,
Ben

*****************************************************************

diff -u -r -N -X /home/greear/exclude.list linux/net/8021q/vlan.c linux.dev/net/8021q/vlan.c
--- linux/net/8021q/vlan.c	Tue Oct 30 16:08:12 2001
+++ linux.dev/net/8021q/vlan.c	Tue Nov 27 21:34:11 2001
@@ -1,11 +1,10 @@
  /*
- * INET		An implementation of the TCP/IP protocol suite for the LINUX
- *		operating system.  INET is implemented using the  BSD Socket
- *		interface as the means of communication with the user level.
- *
+ * INET		802.1Q VLAN
   *		Ethernet-type device handling.
   *
- * Authors:	Ben Greear <greearb@candelatech.com>, <greearb@agcs.com>
+ * Authors:	Ben Greear <greearb@candelatech.com>
+ *              Please send support related email to: vlan@scry.wanfear.com
+ *              VLAN Home Page: http://www.candelatech.com/~greear/vlan.html
   *
   * Fixes:
   *              Fix for packet capture - Nick Eggleston <nick@dccinc.com>;
@@ -42,7 +41,7 @@

  static char vlan_fullname[] = "802.1Q VLAN Support";
  static unsigned int vlan_version = 1;
-static unsigned int vlan_release = 5;
+static unsigned int vlan_release = 6;
  static char vlan_copyright[] = " Ben Greear <greearb@candelatech.com>";

  static int vlan_device_event(struct notifier_block *, unsigned long, void *);
@@ -105,6 +104,24 @@
  	return 0;
  }

+
+/*
+ * Cleanup of groups before exit
+ */
+
+static void vlan_group_cleanup(void)
+{
+ 
struct vlan_group* grp = NULL;
+        struct vlan_group* nextgroup;
+ 
for (grp = p802_1Q_vlan_list; (grp != NULL);) {
+ 
	nextgroup = grp->next;
+ 
	kfree(grp);
+ 
	grp = nextgroup;
+ 
}
+        p802_1Q_vlan_list = NULL;
+}/* vlan_group_cleanup */
+
+
  /*
   *     Module 'remove' entry point.
   *     o delete /proc/net/router directory and static entries.
@@ -116,7 +133,7 @@

  	dev_remove_pack(&vlan_packet_type);
  	vlan_proc_cleanup();
-
+        vlan_group_cleanup();
  	vlan_ioctl_hook = NULL;
  }

diff -u -r -N -X /home/greear/exclude.list linux/net/8021q/vlan_dev.c linux.dev/net/8021q/vlan_dev.c
--- linux/net/8021q/vlan_dev.c	Tue Oct 30 16:08:12 2001
+++ linux.dev/net/8021q/vlan_dev.c	Tue Nov 27 21:28:34 2001
@@ -1,11 +1,10 @@
  /*
- * INET		An implementation of the TCP/IP protocol suite for the LINUX
- *		operating system.  INET is implemented using the  BSD Socket
- *		interface as the means of communication with the user level.
- *
+ * INET		802.1Q VLAN
   *		Ethernet-type device handling.
   *
- * Authors:	Ben Greear <greearb@candelatech.com>, <greearb@agcs.com>
+ * Authors:	Ben Greear <greearb@candelatech.com>
+ *              Please send support related email to: vlan@scry.wanfear.com
+ *              VLAN Home Page: http://www.candelatech.com/~greear/vlan.html
   *
   * Fixes:       Mar 22 2001: Martin Bokaemper <mbokaemper@unispherenetworks.com>
   *                - reset skb->pkt_type on incoming packets when MAC was changed
diff -u -r -N -X /home/greear/exclude.list linux/net/8021q/vlanproc.c linux.dev/net/8021q/vlanproc.c
--- linux/net/8021q/vlanproc.c	Tue Nov 13 10:19:41 2001
+++ linux.dev/net/8021q/vlanproc.c	Tue Nov 27 16:32:30 2001
@@ -116,7 +116,7 @@
   *	Clean up /proc/net/vlan entries
   */

-void __exit vlan_proc_cleanup(void)
+void vlan_proc_cleanup(void)
  {
  	if (proc_vlan_conf)
  		remove_proc_entry(name_conf, proc_vlan_dir);
@@ -462,7 +462,7 @@
  	return 0;
  }

-void __exit vlan_proc_cleanup(void)
+void vlan_proc_cleanup(void)
  {
  	return;
  }
diff -u -r -N -X /home/greear/exclude.list linux/net/README linux.dev/net/README
--- linux/net/README	Mon Jun 11 19:15:27 2001
+++ linux.dev/net/README	Tue Nov 27 21:30:35 2001
@@ -23,4 +23,4 @@
  unix	 
	alan@lxorguk.ukuu.org.uk
  x25	 
	g4klx@g4klx.demon.co.uk
  bluetooth		maxk@qualcomm.com
-
+8021q                   greearb@candelatech.com, vlan@scry.wanfear.com



-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


