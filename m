Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751704AbWFADi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbWFADi7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 23:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbWFADi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 23:38:59 -0400
Received: from [203.144.27.9] ([203.144.27.9]:59144 "EHLO surfers.oz.agile.tv")
	by vger.kernel.org with ESMTP id S1751703AbWFADi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 23:38:59 -0400
Message-ID: <447E614F.3090905@agile.tv>
Date: Thu, 01 Jun 2006 13:38:55 +1000
From: Tony Griffiths <tonyg@agile.tv>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060202 Fedora/1.7.12-1.5.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Some socket syscalls fail to return an error on bad file-descriptor#
 argument
Content-Type: multipart/mixed;
 boundary="------------000100050907040200040009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000100050907040200040009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Description:

The sockfd_lookup_light() function does not set the return error status 
on a particular failure mode when the passed-in fd# is erroneous.

Environment:

2.6.16 kernel with the -mm2 patch-set applied.  Linux 2.6.17 kernels are 
also affected.  Without the fix, a number of tests in LTP fail!  Any 
program calling one of the syscalls listed below with a bad fd# will not 
get an error return indicating that the syscall failed.

Fix:

The attached patch correctly sets *err = -EBADF if the attempt to map 
the fd# to a file pointer returns NULL.  The following syscalls are 
affected-

bind()
listen()
accept()
connect()
getsockname()
getpeername()
setsockopt()
setsockopt()
shutdown()
sendmsg()
recvmsg()




--------------000100050907040200040009
Content-Type: text/x-patch;
 name="atv-40018-socket-fix-2.6.16.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atv-40018-socket-fix-2.6.16.patch"

diff -urpN ./net/socket.c.orig ./net/socket.c
--- ./net/socket.c.orig	2006-06-01 10:28:30.000000000 +1000
+++ ./net/socket.c	2006-06-01 10:34:09.000000000 +1000
@@ -496,6 +496,8 @@ static struct socket *sockfd_lookup_ligh
 		if (sock)
 			return sock;
 		fput_light(file, *fput_needed);
+	} else {
+		*err = -EBADF;
 	}
 	return NULL;
 }

--------------000100050907040200040009--
