Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262776AbSJLCn5>; Fri, 11 Oct 2002 22:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262779AbSJLCn5>; Fri, 11 Oct 2002 22:43:57 -0400
Received: from smtp02.fields.gol.com ([203.216.5.132]:29574 "EHLO
	smtp02.fields.gol.com") by vger.kernel.org with ESMTP
	id <S262776AbSJLCn4>; Fri, 11 Oct 2002 22:43:56 -0400
X-From-Line: miles@lsi.nec.co.jp Fri Oct 11 09:51:48 2002
To: linux-kernel@vger.kernel.org
Subject: compiling without CONFIG_NET broken in 2.5.41
Reply-To: Miles Bader <miles@gnu.org>
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 11 Oct 2002 13:22:37 +0900
Message-ID: <buo1y6xy582.fsf@mcspd15.ucom.lsi.nec.co.jp>
X-Abuse-Complaints: abuse@gol.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I used to be able to compile linux without CONFIG_NET, but in 2.5.41,
doing so makes compilation fail.  The reason is that net/socket.c
references `dev_ioctl', which is only defined when CONFIG_NET is
enabled.

I can avoid the problem like this:


--- ../orig/linux-2.5.41/net/socket.c	2002-10-10 11:40:28.000000000 +0900
+++ net/socket.c	2002-10-11 13:06:39.000000000 +0900
@@ -691,9 +691,11 @@
 
 	unlock_kernel();
 	sock = SOCKET_I(inode);
+#ifdef CONFIG_NET
 	if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
 		err = dev_ioctl(cmd, (void *)arg);
 	} else
+#endif /* CONFIG_NET */
 #ifdef WIRELESS_EXT
 	if (cmd >= SIOCIWFIRST && cmd <= SIOCIWLAST) {
 		err = dev_ioctl(cmd, (void *)arg);


It seems to work fine, but I have no idea if this is really the correct
solution or not.

I'd appreciate it if someone could look at this and install a fix.

Thanks,

-Miles

-- 
The secret to creativity is knowing how to hide your sources.
  --Albert Einstein

