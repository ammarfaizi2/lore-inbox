Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263285AbVBDQ41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbVBDQ41 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 11:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265755AbVBDQ41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 11:56:27 -0500
Received: from moutng.kundenserver.de ([212.227.126.190]:57855 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263285AbVBDQzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 11:55:52 -0500
From: Hans-Peter Jansen <hpj@urpla.net>
To: Shane Hathaway <shane@hathawaymix.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Configure MTU via kernel DHCP
Date: Fri, 4 Feb 2005 17:55:41 +0100
User-Agent: KMail/1.5.4
References: <200502022148.00045.shane@hathawaymix.org>
In-Reply-To: <200502022148.00045.shane@hathawaymix.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502041755.41288.hpj@urpla.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:18d01dd0a2a377f0376b761557b5e99a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shane,

On Thursday 03 February 2005 05:47, Shane Hathaway wrote:
> The attached patch enhances the kernel's DHCP client support (in
> net/ipv4/ipconfig.c) to set the interface MTU if provided by the
> DHCP server. Without this patch, it's difficult to netboot on a
> network that uses jumbo frames.  The patch is based on 2.6.10, but
> I'll update it to the latest testing kernel if that would expedite
> its inclusion in the kernel.

Well, I've been there before, and asked for exact the same back in 
June 2003, but had much less luck, nobody of kernel fame even 
responded:
http://marc.theaimsgroup.com/?l=linux-kernel&m=105624464918574&w=4

Only Ken Yap of etherboot fame told me:
> I have a feeling you will not get much sympathy for 2.[56] because
> there ipconfig in the kernel is deprecated in favour of userspace
> config from the initrd.

Well that's life. 

For what is worth it, I ported my patch to current 2.6, which raised 
some comments compared to yours:

 - Is it really necessary to protect the dev_set_mtu call, since it is
   just setting up the device?
 - I prefer to call dev_set_mtu only, if a change mtu request is
   sent.. 
 - Are you sure, you got the endianess right? 

Here's the "cost": ipconfig.o without my patch on x86:

  3 .init.data    0000005a  00000000  00000000  00000220  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
  4 .rodata.str1.1 000001a2  00000000  00000000  0000027a  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  5 .rodata.str1.4 000003ad  00000000  00000000  0000041c  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  6 .init.text    00001a45  00000000  00000000  000007d0  2**4
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE

With patch:

  3 .init.data    0000005e  00000000  00000000  00000220  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
  4 .rodata.str1.1 000001ab  00000000  00000000  0000027e  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  5 .rodata.str1.4 000003e5  00000000  00000000  0000042c  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  6 .init.text    00001ab5  00000000  00000000  00000820  2**4
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE

Difference: 181 Bytes (padding ignored)

The whole module takes about 9K, compared to dhcp in initrd, which 
takes a few hundred K! Hmm.

> Incidentally, ipconfig.c doesn't appear to do enough bounds
> checking on byte 1 of DHCP/BOOTP extension fields (the length
> field).  It looks like a malicious DHCP server could mess with
> kernel memory that way.  I could try to fix the hole, but maybe
> someone more experienced with this code would like to verify
> there's a problem first.

That's an interesting question. Please keep me informed on any new 
perceptions in this respect.

May the linux gods indulge on this topic one day or remove the 
ipconfig module completely.

--- linux-2.6/net/ipv4/ipconfig.c.orig	2005-02-04 15:59:42.430518242 +0100
+++ linux-2.6/net/ipv4/ipconfig.c	2005-02-04 17:07:14.526384702 +0100
@@ -29,6 +29,10 @@
  *
  *  Multiple Nameservers in /proc/net/pnp
  *              --  Josef Siemes <jsiemes@web.de>, Aug 2002
+ *
+ *  Support for MTU selection via DHCP
+ *              -- Hans-Peter Jansen <hpj@urpla.net>, June 2003
+ *                              redone for 2.6 in February 2005
  */
 
 #include <linux/config.h>
@@ -151,6 +155,9 @@
 /* Protocols supported by available interfaces */
 static int ic_proto_have_if __initdata = 0;
 
+/* MTU of device (if requested) */
+static int ic_dev_mtu __initdata = 0;
+
 #ifdef IPCONFIG_DYNAMIC
 static DEFINE_SPINLOCK(ic_recv_lock);
 static volatile int ic_got_reply __initdata = 0;    /* Proto(s) that replied */
@@ -322,6 +329,12 @@
 		printk(KERN_ERR "IP-Config: Unable to set interface broadcast address (%d).\n", err);
 		return -1;
 	}
+	if (ic_dev_mtu) {
+		if ((err = dev_set_mtu(ic_dev, ic_dev_mtu)) < 0)
+			printk(KERN_ERR "IP-Config: Unable to set interface mtu to %d (%d).\n", 
+				ic_dev_mtu, err);
+			/* Don't error out because set mtu failure, just notice the operator */
+	}
 	return 0;
 }
 
@@ -609,6 +622,7 @@
 			12,	/* Host name */
 			15,	/* Domain name */
 			17,	/* Boot path */
+			26,	/* MTU */
 			40,	/* NIS domain name */
 		};
 
@@ -812,6 +826,9 @@
 			if (!root_server_path[0])
 				ic_bootp_string(root_server_path, ext+1, *ext, sizeof(root_server_path));
 			break;
+		case 26:	/* MTU */
+			ic_dev_mtu = ntohs(*(u16 *)(ext+1));
+			break;
 		case 40:	/* NIS Domain name (_not_ DNS) */
 			ic_bootp_string(system_utsname.domainname, ext+1, *ext, __NEW_UTS_LEN);
 			break;
@@ -1363,6 +1380,8 @@
 	 */
 	printk("IP-Config: Complete:");
 	printk("\n      device=%s", ic_dev->name);
+	if (ic_dev_mtu)
+		printk(", mtu=%d", ic_dev_mtu);
 	printk(", addr=%u.%u.%u.%u", NIPQUAD(ic_myaddr));
 	printk(", mask=%u.%u.%u.%u", NIPQUAD(ic_netmask));
 	printk(", gw=%u.%u.%u.%u", NIPQUAD(ic_gateway));


Compile tested. Any takers?

Cheers,
Pete

