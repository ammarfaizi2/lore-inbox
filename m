Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbUKSVxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbUKSVxR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 16:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbUKSVuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 16:50:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:14994 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261599AbUKSVtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:49:04 -0500
Date: Fri, 19 Nov 2004 13:48:40 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Driver Core fixes for 2.6.10-rc2
Message-ID: <20041119214840.GB15517@kroah.com>
References: <20041119214710.GA15517@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119214710.GA15517@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.2164, 2004/11/19 08:47:13-08:00, akpm@osdl.org

[PATCH] fix kobject varargs bug

From: Gerd Knorr <kraxel@bytesex.org>

It uses the varargs list twice in a illegal way.  That doesn't harm on i386
by pure luck, but blows things up on amd64 machines.

Using var args list twice without calling va_start twice is illegal.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 lib/kobject.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	2004-11-19 11:36:44 -08:00
+++ b/lib/kobject.c	2004-11-19 11:36:44 -08:00
@@ -232,11 +232,12 @@
 	va_list args;
 	char * name;
 
-	va_start(args,fmt);
 	/* 
 	 * First, try the static array 
 	 */
+	va_start(args,fmt);
 	need = vsnprintf(kobj->name,limit,fmt,args);
+	va_end(args);
 	if (need < limit) 
 		name = kobj->name;
 	else {
@@ -249,7 +250,9 @@
 			error = -ENOMEM;
 			goto Done;
 		}
+		va_start(args,fmt);
 		need = vsnprintf(name,limit,fmt,args);
+		va_end(args);
 
 		/* Still? Give up. */
 		if (need >= limit) {
@@ -266,7 +269,6 @@
 	/* Now, set the new name */
 	kobj->k_name = name;
  Done:
-	va_end(args);
 	return error;
 }
 
