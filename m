Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUBDOWf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 09:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbUBDOWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 09:22:35 -0500
Received: from gw2.cosmosbay.com ([195.115.130.129]:42948 "EHLO
	gw2.cosmosbay.com") by vger.kernel.org with ESMTP id S261931AbUBDOWd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 09:22:33 -0500
Message-ID: <40210027.4080808@cosmosbay.com>
Date: Wed, 04 Feb 2004 15:22:31 +0100
From: dada1 <dada1@cosmosbay.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: fs/eventpoll : reduce sizeof(struct epitem)
References: <Pine.LNX.4.44.0402011854560.12618-100000@bigblue.dev.mdolabs.com>
In-Reply-To: <Pine.LNX.4.44.0402011854560.12618-100000@bigblue.dev.mdolabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davide

On a x86_64 platform, I noticed that the size of (struct epitem) is 136 
bytes, rounded to 192 (because of  L1_CACHE alignment of 64 bytes)

If you reorder some fields of this structure, we can reduce the size to 
128 bytes.

The rationale is to group nwait & fd integer (32bits) fields, instead of 
mixing them with pointers (64 bits)

See you

Eric Dumazet

diff -u  linux-2.6.2/fs/eventpoll.c.save linux-2.6.2/fs/eventpoll.c
--- eventpoll.c.save    2004-02-04 14:59:49.000000000 +0100
+++ eventpoll.c 2004-02-04 15:02:20.000000000 +0100
@@ -241,14 +241,15 @@
        /* Number of active wait queue attached to poll operations */
        int nwait;

+       /* The file descriptor this item refers to */
+       int fd;
+
        /* List containing poll wait queues */
        struct list_head pwqlist;

        /* The "container" of this item */
        struct eventpoll *ep;

-       /* The file descriptor this item refers to */
-       int fd;

        /* The file this item refers to */
        struct file *file;

