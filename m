Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261340AbSJQKlQ>; Thu, 17 Oct 2002 06:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261345AbSJQKk3>; Thu, 17 Oct 2002 06:40:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30471 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261347AbSJQKje>; Thu, 17 Oct 2002 06:39:34 -0400
To: LKML <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 2.5.43-menuconfig
Message-Id: <E18289h-0007tu-00@flint.arm.linux.org.uk>
Date: Thu, 17 Oct 2002 11:45:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch appears not to be in 2.5.43, but applies cleanly.

This patch fixes a failure case in menuconfig which can occur if a kernel
tree is configured on one architecture with menuconfig, and then attempted
to be reconfigured on another architecture.

The kernel detects that the binary can't be run on the second architecture
and correctly returns the appropriate error code.  However, the Menuconfig
script ignores this error and retries endlessly, appearing to hang.

This patch makes menuconfig display a message and exit rather than
endlessly looping.

 scripts/Menuconfig |   20 ++++++++++++++++++++
 1 files changed, 20 insertions

diff -ur orig/scripts/Menuconfig linux/scripts/Menuconfig
--- orig/scripts/Menuconfig	Sat Oct 12 10:02:17 2002
+++ linux/scripts/Menuconfig	Sat Oct 12 10:45:13 2002
@@ -909,6 +909,26 @@
 			cleanup
 			exit 139
 			;;
+		126|127)
+			stty sane
+			clear
+			cat << EOM
+
+There seems to be a problem with the lxdialog companion utility which is
+built prior to running Menuconfig.  lxdialog could not be found, or could
+not be executed.  This can be caused when lxdialog has been built for a
+different architecture.
+
+You should rebuild lxdialog.  This can be done by moving to the
+/usr/src/linux/scripts/lxdialog directory and issuing the "make clean all"
+command.
+
+If the problem persists, you may email the maintainer <mec@shout.net> or
+post a message to <linux-kernel@vger.kernel.org> for additional assistance. 
+
+EOM
+			cleanup
+			exit 1
 		esac
 	done
 }

