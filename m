Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbTL3G0o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 01:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbTL3G0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 01:26:44 -0500
Received: from bay13-dav8.bay13.hotmail.com ([64.4.31.182]:16902 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264419AbTL3G0j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 01:26:39 -0500
X-Originating-IP: [67.195.216.52]
X-Originating-Email: [james_mcmechan@hotmail.com]
From: "James McMechan" <James_McMechan@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Cc: <user-mode-linux-devel-request@lists.sourceforge.net>
Subject: [PATCH] backport of fix for tmpfs oops from 2.6.0 final to 2.4.23
Date: Mon, 29 Dec 2003 22:09:03 -0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_002B_01C3CE58.5E725160"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY13-DAV8Hx5Th42jv0000d5a7@hotmail.com>
X-OriginalArrivalTime: 30 Dec 2003 06:26:38.0512 (UTC) FILETIME=[E1828300:01C3CE9D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_002B_01C3CE58.5E725160
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


------=_NextPart_000_002B_01C3CE58.5E725160
Content-Type: application/octet-stream;
	name="oops-2-4-23.fix"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="oops-2-4-23.fix"

Ok, here is a backport of the patch that went into 2.6.0=0A=
to fix the problem where the tmpfs/shmfs dcache could be=0A=
oopsed by any user doing a dirseek to offset 2.=0A=
This occurs because the when the seek is at the cursor=0A=
and then the cursor is deleted, the list_add_tail=0A=
tries to attach to the end of the list and gets the=0A=
old pointers (poisoned on 2.6) from the list_del.=0A=
This fix just deletes the cursor before going over the=0A=
list since it can not be a member of the list and should=0A=
not be counted, delete it before counting over the list.=0A=
=0A=
--- linux-2.4.23/fs/readdir.c	2002-08-02 17:39:45.000000000 -0700=0A=
+++ build-2.4.23-skas/fs/readdir.c	2003-12-23 17:18:37.000000000 -0800=0A=
@@ -69,6 +69,7 @@=0A=
 			loff_t n =3D file->f_pos - 2;=0A=
 =0A=
 			spin_lock(&dcache_lock);=0A=
+			list_del(&cursor->d_child);=0A=
 			p =3D file->f_dentry->d_subdirs.next;=0A=
 			while (n && p !=3D &file->f_dentry->d_subdirs) {=0A=
 				struct dentry *next;=0A=
@@ -77,7 +78,6 @@=0A=
 					n--;=0A=
 				p =3D p->next;=0A=
 			}=0A=
-			list_del(&cursor->d_child);=0A=
 			list_add_tail(&cursor->d_child, p);=0A=
 			spin_unlock(&dcache_lock);=0A=
 		}=0A=

------=_NextPart_000_002B_01C3CE58.5E725160--
