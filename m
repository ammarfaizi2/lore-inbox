Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264575AbTLGW7V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 17:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264578AbTLGW7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 17:59:21 -0500
Received: from bay13-dav65.bay13.hotmail.com ([64.4.31.239]:21513 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264575AbTLGW7T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 17:59:19 -0500
X-Originating-IP: [66.42.122.98]
X-Originating-Email: [james_mcmechan@hotmail.com]
From: "James McMechan" <James_McMechan@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Oops with tmpfs on both 2.4.22 & 2.6.0-test11
Date: Sun, 7 Dec 2003 14:48:57 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY13-DAV65qqtJ1BEz000010ce@hotmail.com>
X-OriginalArrivalTime: 07 Dec 2003 22:59:19.0100 (UTC) FILETIME=[BEE2BFC0:01C3BD15]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After tinkering with patches for the last week I finally have a version
that does not look quite so bad, my first attempts at improvement were
awful in their awkwardness.
The problem was that the cursor was in the list being walked, and when
the pointer pointed to the cursor the list_del/list_add_tail pair would
oops trying to find the entry pointed to by the prev pointer of the
deleted cursor element.

The solution I finally found was to move the list_del earlier, before
the
begining of the list walk, since it is not used during the list walk and
should not count in the list enumeration it can be deleted, then the
list
pointer cannot point to it so it can be added safely with the
list_add_tail
without oopsing, and everything works as expected I am unable to oops
this
version with any of my test programs.

And of course since this Oops both 2.4 & 2.6 I will need to prepare
a second set for the 2.4 tree.

My question to you who expressed interest, is anything odd looking about
this code, anything that I am doing wrong or could do better?

diff -Nur linux-2.6.0-test11/fs/libfs.c
build-2.6.0-test11-bug/fs/libfs.c
--- linux-2.6.0-test11/fs/libfs.c 2003-11-26 12:42:48.000000000 -0800
+++ build-2.6.0-test11-bug/fs/libfs.c 2003-12-07
13:07:19.000000000 -0800
@@ -79,6 +79,7 @@
    loff_t n = file->f_pos - 2;

    spin_lock(&dcache_lock);
+   list_del(&cursor->d_child);
    p = file->f_dentry->d_subdirs.next;
    while (n && p != &file->f_dentry->d_subdirs) {
     struct dentry *next;
@@ -87,7 +88,6 @@
      n--;
     p = p->next;
    }
-   list_del(&cursor->d_child);
    list_add_tail(&cursor->d_child, p);
    spin_unlock(&dcache_lock);
   }
