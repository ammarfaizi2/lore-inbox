Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWDGStG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWDGStG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWDGSsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:48:51 -0400
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:656
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S964868AbWDGSsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:48:36 -0400
From: =?utf-8?q?T=C3=B6r=C3=B6k_Edwin?= <edwin@gurde.com>
To: linux-security-module@vger.kernel.org
Subject: [RFC][PATCH 6/7] userspace
Date: Fri, 7 Apr 2006 21:44:55 +0300
User-Agent: KMail/1.9.1
Cc: James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net, sds@tycho.nsa.gov
References: <200604021240.21290.edwin@gurde.com> <200604072034.20972.edwin@gurde.com> <200604072124.24000.edwin@gurde.com>
In-Reply-To: <200604072124.24000.edwin@gurde.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604072144.55444.edwin@gurde.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - main.astronetworks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - gurde.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The makefile for the lsm module, and a test app I used to verify that 
getxattr() works properly with my lsm.

---
 Makefile         |   10 ++++++++++
 xattr_helper.cpp |   54 
++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff -uprN null/Makefile fireflier_lsm/Makefile
--- null/Makefile	1970-01-01 02:00:00.000000000 +0200
+++ fireflier_lsm/Makefile	2006-04-07 15:08:00.000000000 +0300
@@ -0,0 +1,10 @@
+obj-m += fireflier.o
+fireflier-objs := hooks.o autolabel.o sidtab.o fireflier_debug.o
+KERN = $(shell uname -r)
+#KERN = 2.6.16.1
+all: 
+	make -C /lib/modules/$(KERN)/build M=$(PWD) modules
+
+clean:
+	make -C /lib/modules/$(KERN)/build M=$(PWD) clean
+      
diff -uprN null/xattr_helper.cpp fireflier_lsm/xattr_helper.cpp
--- null/xattr_helper.cpp	1970-01-01 02:00:00.000000000 +0200
+++ fireflier_lsm/xattr_helper.cpp	2006-04-07 18:06:38.000000000 +0300
@@ -0,0 +1,54 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <attr/xattr.h>
+
+void die(const char* msg)
+{
+
+   perror(msg);
+   exit(1);
+}
+
+void showArray(const char* array,ssize_t len)
+{
+   for(int i=0;i<len;i++)
+     if(array[i])
+       putchar(array[i]);
+   else putchar('\n');
+}
+
+int main(int argc,char* argv[])
+{
+
+   if(argc==2) 
+     {
+	const char* filename = argv[1];
+	ssize_t len = listxattr(filename,NULL,0);
+	if(len==-1)
+	  die("error getting list size");
+	char* list = new char[len+1];
+	if((len=listxattr(filename,list,len))==-1)
+	  die("error listing attributes names");
+	printf("List of security attributes:\n");
+	showArray(list,len);
+	delete[] list;
+     }
+   else if(argc==3) 
+     {
+	const char* filename = argv[1];
+	const char* name = argv[2];
+	ssize_t len = getxattr(filename,name,NULL,0);
+	if(len==-1)
+	  die("error getting xattr list size");
+	char* list = new char[len+1];
+	if((len = getxattr(filename,name,list,len))==-1)
+	  die("error getting xattr");
+	printf("xattr %s of %s is:",name,filename);
+	showArray(list,len);
+	delete[] list;
+     }
+   else
+     printf("Usage: %s filename [xattr_name]\n",argv[0]);   
+   return 0;
+}
