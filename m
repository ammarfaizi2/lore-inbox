Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264842AbTFVRyc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 13:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264843AbTFVRyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 13:54:32 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:63495 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S264842AbTFVRy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 13:54:29 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru> (by way of Andrey Borzenkov
	<arvidjaar@mail.ru>)
Subject: [PATCH][RESEND] 2.4 devfs deadlock on concurrent lookups on non-existent entry
Date: Sun, 22 Jun 2003 22:06:32 +0400
User-Agent: KMail/1.5
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oAf9+ycyyAdmRUn"
Message-Id: <200306222206.32696.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_oAf9+ycyyAdmRUn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I resend this patch on request of Pavel Roskin. Unfortunately, I do not know 
who is current active devfs maintainer.

It appears, so far no negative effects with this patch was observed; the patch 
is used in unofficial Mandrake Club kernel as well. The problem is real, 
recently there was increased number of complaints on a.o.l.m

Original message follows:

============================

This problem has first been reported for over two years ago. Usually it
happened during system boot using RH initscripts with two minilogds hanging
on access to /dev/log and blocking rc.sysinit; this condition was triggered
by unrelated bug in minilogd.

Pavel Roskin provided detailed debug info for this problem; details including
stack are available at
<https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=85621>. It turned out a
deadlock between devfs_lookup and devfs_d_revalidate_wait for cases when
->d_revalidate was called under parent->i_sem (mostly all places where
lookup_hash was used). The deadlock looked like:

                               path_lookup("dev/log", LOOKUP_PARENT, &nd);
                                -> yields dentry for  </dev>

path_lookup("dev/log", LOOKUP_PARENT, &nd);
   -> yields dentry for  </dev>
down(</dev>->i_sem) holds i_sem

                                        down(</dev>->i_sem) - sleeps

lookup_hash("log", </dev>)                          .
devfs_lookup(</dev>, "log")                         .
   MISS                                             .
try_modload
set "log"->d_op to &devfs_wait_dops;                .
init "log"->wait_queue                              .
up(</dev>->i_sem)                                   .
                                                    .
                                             obtains i_sem
                                 lookup_hash("log", </dev>);
                                 cached_lookup(</dev>, "log", 0)
                                 devfs_d_revalidate_wait("log", 0)
                                 wait on "log"->wait_queue
                                ... waits to be waked up by devfs_lookup

down(</dev>->i_sem)

the patch fixes it by moving i_sem re-acquire after
wake_up(&lookup_info.wait_queue). It does not look like it adds any
additional races. Please check.

Pavel said it applies unchanged to 2.5 tree. Which may indicate it has the
same race condition. I do not have 2.5 available.

please consider for 2.4.21

regards

-andrey



--Boundary-00=_oAf9+ycyyAdmRUn
Content-Type: text/x-diff;
  charset="us-ascii";
  name="devfs.minilogd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="devfs.minilogd.patch"

--- linux-2.4.21-0.13mdk/fs/devfs/base.c.minilogd	2002-11-29 02:53:15.000000000 +0300
+++ linux-2.4.21-0.13mdk/fs/devfs/base.c	2003-05-06 00:41:35.000000000 +0400
@@ -3038,7 +3038,6 @@ static struct dentry *devfs_lookup (stru
 	revalidation  */
     up (&dir->i_sem);
     wait_for_devfsd_finished (fs_info);  /*  If I'm not devfsd, must wait  */
-    down (&dir->i_sem);      /*  Grab it again because them's the rules  */
     de = lookup_info.de;
     /*  If someone else has been so kind as to make the inode, we go home
 	early  */
@@ -3068,6 +3067,7 @@ out:
     write_lock (&parent->u.dir.lock);
     wake_up (&lookup_info.wait_queue);
     write_unlock (&parent->u.dir.lock);
+    down (&dir->i_sem);      /*  Grab it again because them's the rules  */
     devfs_put (de);
     return retval;
 }   /*  End Function devfs_lookup  */

--Boundary-00=_oAf9+ycyyAdmRUn--

