Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262629AbTCIVMG>; Sun, 9 Mar 2003 16:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262630AbTCIVMG>; Sun, 9 Mar 2003 16:12:06 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:57751 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262629AbTCIVMF>;
	Sun, 9 Mar 2003 16:12:05 -0500
Date: Mon, 10 Mar 2003 00:21:52 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: memleak in 802.1q vlan proc code
Message-ID: <20030309212152.GA31920@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   There is a memleak on error exit path, identical in 2.4 and 2.5.
   Same patch should apply to 2.4 and 2.5.

   Found with help of smatch + enhanced unfree script.

Bye,
    Oleg
===== net/8021q/vlanproc.c 1.6 vs edited =====
--- 1.6/net/8021q/vlanproc.c	Sat Aug 10 06:36:57 2002
+++ edited/net/8021q/vlanproc.c	Mon Mar 10 00:17:23 2003
@@ -252,8 +252,10 @@
 	offs = file->f_pos;
 	if (offs < pos) {
 		len = min_t(int, pos - offs, count);
-		if (copy_to_user(buf, (page + offs), len))
+		if (copy_to_user(buf, (page + offs), len)) {
+			kfree(page);
 			return -EFAULT;
+		}
 
 		file->f_pos += len;
 	} else {
