Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268641AbUH3S1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268641AbUH3S1z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 14:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268883AbUH3SZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:25:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:43914 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268806AbUH3SNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 14:13:04 -0400
Date: Mon, 30 Aug 2004 11:10:19 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: jmerkey@comcast.net
Cc: alan@lxorguk.ukuu.org.uk, wli@holomorphy.com, roland@topspin.com,
       linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
Message-Id: <20040830111019.5ddc99ab.rddunlap@osdl.org>
In-Reply-To: <083020040556.26446.4132C1810009E19F0000674E2200751150970A059D0A0306@comcast.net>
References: <083020040556.26446.4132C1810009E19F0000674E2200751150970A059D0A0306@comcast.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2004 05:56:17 +0000 jmerkey@comcast.net wrote:

| 
| 
| 
| 
| > What kernel version?  I can't even find usb_read_device() in 2.6.9-rc1.
| > 
| > BTW, as someone else requested, please teach your mail client to wrap
| > lines around column 70-72.  Thanks.
| > 
| > ~Randy
| 
| linux-2.6.8.1.tar.gz


usb_device_read here (usb_read_device above :)


| static ssize_t usb_device_read(struct file *file, 
|                                                          char __user *buf, 
|                                                          size_t nbytes, 
|                                                          loff_t *ppos)
| {
|         struct list_head *buslist;
|         struct usb_bus *bus;
|         ssize_t ret, total_written = 0;
|         loff_t skip_bytes = *ppos;
|                                                                                 
|         if (*ppos < 0)
|                 return -EINVAL;
|         if (nbytes <= 0)
|                 return 0;
|         if (!access_ok(VERIFY_WRITE, buf, nbytes))
|                 return -EFAULT;
|                                                                                 
|         /* enumerate busses */
|         down (&usb_bus_list_lock);
|         for (buslist = usb_bus_list.next; 
|                buslist != &usb_bus_list; 
|                buslist = buslist->next) {
|                 /* print devices for this bus */
|                 bus = list_entry(buslist, struct usb_bus, 
|                                              bus_list);
|                 /* print devices for this bus */
|                 bus = list_entry(buslist, struct usb_bus, 
|                                              bus_list);
|                                                                                 
|                 /* recurse through all children of the root hub */
|                 if (!bus->root_hub)
|                         continue;
| 
| // IT BARFS RIGHT HERE -->
|                 down(&bus->root_hub->serialize);

It doesn't barf on me.  I added one other patch on top of yours:
one from Roland Dreier, for arch/i386/kernel/doublefault.c [below].

| P.S.  I am using my comcast account which
| is not as good as MUTT -- line wrap settings
| since it is web based.  
| drdos.com gets rejected
| so I am typing less characters/line. :-)
| -
Thanks.

--
~Randy



Looks like arch/i386/kernel/doublefault.c is one place in the code
that hardcodes the assumption that PAGE_OFFSET == 0xC0000000.  Here's
a patch that fixes that.

(Of course this doesn't really fix anything except debugging output)

 - Roland

Signed-off-by: Roland Dreier <roland@topspin.com>

Index: linux-2.6.8-rc1/arch/i386/kernel/doublefault.c
===================================================================
--- linux-2.6.8-rc1.orig/arch/i386/kernel/doublefault.c
+++ linux-2.6.8-rc1/arch/i386/kernel/doublefault.c
@@ -13,7 +13,7 @@
 static unsigned long doublefault_stack[DOUBLEFAULT_STACKSIZE];
 #define STACK_START (unsigned long)(doublefault_stack+DOUBLEFAULT_STACKSIZE)
 
-#define ptr_ok(x) ((x) > 0xc0000000 && (x) < 0xc1000000)
+#define ptr_ok(x) ((x) > PAGE_OFFSET && (x) < PAGE_OFFSET + 0x1000000)
 
 static void doublefault_fn(void)
 {
-
