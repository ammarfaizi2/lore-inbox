Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbTLPXDA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 18:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbTLPXDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 18:03:00 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:31435 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264411AbTLPXC6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 18:02:58 -0500
Message-ID: <3FDF902A.4000903@us.ltcfwd.linux.ibm.com>
Date: Tue, 16 Dec 2003 17:07:22 -0600
From: Linda Xie <lxiep@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: scheel@us.ibm.com, wortman@us.ibm.com, Greg KH <gregkh@us.ibm.com>
Subject: PATCPATCH -- add unlimited name lengths support to sysfs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

In the development of RPA PCI Hot Plug Controller driver, I have found 
it is needed to create some kernel objects which have more than 20 
(KOBJECT_NAME_SIZE) charaters in their name strings. At a later time the 
names will be used for creating some symlinks. The attached patch adds 
unlimited name lengths support to sysfs symlink.c.

  Comments are welcome.

Linda


diff -Nru a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
--- a/fs/sysfs/symlink.c	Sun Dec 14 21:19:29 2003
+++ b/fs/sysfs/symlink.c	Sun Dec 14 21:19:29 2003
@@ -42,7 +42,10 @@
  	struct kobject * p = kobj;
  	int length = 1;
  	do {
-		length += strlen(p->name) + 1;
+		if (p->k_name)
+			length += strlen(p->k_name) + 1;
+		else
+			length += strlen(p->name) + 1;
  		p = p->parent;
  	} while (p);
  	return length;
@@ -54,11 +57,20 @@

  	--length;
  	for (p = kobj; p; p = p->parent) {
-		int cur = strlen(p->name);
-
+		int cur;
+		char *name;
+		
+		if (p->k_name) {
+			cur = strlen(p->k_name);
+			name = p->k_name;
+		}
+		else {
+			cur = strlen(p->name);
+			name = p->name;
+		}
  		/* back up enough to print this bus id with '/' */
  		length -= cur;
-		strncpy(buffer + length,p->name,cur);
+		strncpy(buffer + length,name,cur);
  		*(buffer + --length) = '/';
  	}
  }

