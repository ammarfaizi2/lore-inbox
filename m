Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVCVTqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVCVTqT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 14:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVCVToV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 14:44:21 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:43228 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261761AbVCVTnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 14:43:31 -0500
Subject: [patch 04/12] uml: cope with uml_net security fix
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Tue, 22 Mar 2005 17:21:26 +0100
Message-Id: <20050322162126.B232197666@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pass the interface to close as an fd besides that by name... passing it by
name does not work with newer uml_net because that allows to ifconfig down
arbitrary interfaces, while if you have an open fd to the SLIP interface it
means you have full access to it (and thus can close it). Passing only by fd
does not work with older utilities, so we do both things (which does not
hurt).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/drivers/slip_user.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

diff -puN arch/um/drivers/slip_user.c~uml-uml_net-security-fix arch/um/drivers/slip_user.c
--- linux-2.6.11/arch/um/drivers/slip_user.c~uml-uml_net-security-fix	2005-03-21 15:25:41.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/drivers/slip_user.c	2005-03-21 15:25:41.000000000 +0100
@@ -108,6 +108,9 @@ static int slip_tramp(char **argv, int f
 			err = -EINVAL;
 		}
 	}
+
+	os_close_file(fds[0]);
+
 	return(err);
 }
 
@@ -128,6 +131,7 @@ static int slip_open(void *data)
 	sfd = os_open_file(ptsname(mfd), of_rdwr(OPENFLAGS()), 0);
 	if(sfd < 0){
 		printk("Couldn't open tty for slip line, err = %d\n", -sfd);
+		os_close_file(mfd);
 		return(sfd);
 	}
 	if(set_up_tty(sfd)) return(-1);
@@ -175,7 +179,7 @@ static void slip_close(int fd, void *dat
 
 	sprintf(version_buf, "%d", UML_NET_VERSION);
 
-	err = slip_tramp(argv, -1);
+	err = slip_tramp(argv, pri->slave);
 
 	if(err != 0)
 		printk("slip_tramp failed - errno = %d\n", -err);
_
