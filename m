Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267041AbTBHRLC>; Sat, 8 Feb 2003 12:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbTBHRLC>; Sat, 8 Feb 2003 12:11:02 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:4480 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S267041AbTBHRLA>;
	Sat, 8 Feb 2003 12:11:00 -0500
Date: Sat, 8 Feb 2003 20:18:38 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: 2.4.21-pre4 comparison bugs
Message-ID: <20030208171838.GA2230@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Thanks to whoever mentioned "gcc -W", it's *sweet*  ;)
   Looking at it's output I found few cases where error checking
   does not work.
   Though nothing too serious it seems (except maybe IDE setup-pci stuff,
   I just do not know about that, and may be in that case
   we actually want to change all the functions to return signed
   value, though my fix is certainly less intrusive ;) )
   Most of the patched stuff in here assigns signed value to unsigned
   variable and then checks if it is less than zero which does not work
   for obvious reasons ;)
   I decided taht in most cases simple casting to int would be best
   and least intrusive resolution of a problem.
   The only exception is fs/isofs/inode.c, there we have unsigned int
   (so it is unsigned not depending on any arch) and so '> some num'
   stuff will also check for former negative numbers anyway. So
   I removed one extra comparison in that case.
   See the patch below.

Bye,
    Oleg

===== drivers/ide/setup-pci.c 1.2 vs edited =====
--- 1.2/drivers/ide/setup-pci.c	Thu Dec 12 04:09:23 2002
+++ edited/drivers/ide/setup-pci.c	Sat Feb  8 19:06:13 2003
@@ -582,7 +582,7 @@
 
 	index.all = 0xf0f0;
 
-	if((autodma = ide_setup_pci_controller(dev, d, noisy, &tried_config)) < 0)
+	if((int)(autodma = ide_setup_pci_controller(dev, d, noisy, &tried_config)) < 0)
 		return index;
 
 	/*
@@ -613,7 +613,7 @@
 	} else {
 		if (d->init_chipset)
 		{
-			if(d->init_chipset(dev, d->name) < 0)
+			if((int)d->init_chipset(dev, d->name) < 0)
 				return index;
 		}
 		if (noisy)
===== drivers/net/tun.c 1.8 vs edited =====
--- 1.8/drivers/net/tun.c	Mon Apr 22 21:38:08 2002
+++ edited/drivers/net/tun.c	Sat Feb  8 19:07:28 2003
@@ -188,7 +188,7 @@
 	size_t len = count;
 
 	if (!(tun->flags & TUN_NO_PI)) {
-		if ((len -= sizeof(pi)) < 0)
+		if ((int)(len -= sizeof(pi)) < 0)
 			return -EINVAL;
 
 		memcpy_fromiovec((void *)&pi, iv, sizeof(pi));
===== fs/isofs/inode.c 1.9 vs edited =====
--- 1.9/fs/isofs/inode.c	Mon Jul  1 02:25:33 2002
+++ edited/fs/isofs/inode.c	Sat Feb  8 19:15:41 2003
@@ -343,13 +343,13 @@
 		if (!strcmp(this_char,"session") && value) {
 			char * vpnt = value;
 			unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
-			if(ivalue < 0 || ivalue >99) return 0;
+			if(ivalue > 99) return 0;
 			popt->session=ivalue+1;
 		}
 		if (!strcmp(this_char,"sbsector") && value) {
 			char * vpnt = value;
 			unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
-			if(ivalue < 0 || ivalue >660*512) return 0;
+			if(ivalue > 660*512) return 0;
 			popt->sbsector=ivalue;
 		}
 		else if (!strcmp(this_char,"check") && value) {
===== net/sunrpc/pmap_clnt.c 1.3 vs edited =====
--- 1.3/net/sunrpc/pmap_clnt.c	Wed Apr 24 12:58:19 2002
+++ edited/net/sunrpc/pmap_clnt.c	Sat Feb  8 19:09:20 2003
@@ -149,7 +149,7 @@
 	struct sockaddr_in	sin;
 	struct rpc_portmap	map;
 	struct rpc_clnt		*pmap_clnt;
-	unsigned int		error = 0;
+	int			error = 0;
 
 	dprintk("RPC: registering (%d, %d, %d, %d) with portmapper.\n",
 			prog, vers, prot, port);
