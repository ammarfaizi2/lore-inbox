Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262798AbUKRRXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbUKRRXV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbUKRRVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:21:30 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:39647 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262791AbUKRRUt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:20:49 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 18 Nov 2004 17:58:54 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Subject: Re: [patch] 2.6.10-rc1-mm4: bttv-driver.c compile error
Message-ID: <20041118165853.GA22216@bytesex>
References: <20041109074909.3f287966.akpm@osdl.org> <1100018489.7011.4.camel@lb.loomes.de> <20041109211107.GB5892@stusta.de> <1100037358.1519.6.camel@lb.loomes.de> <20041110082407.GA23090@bytesex> <1100085569.1591.6.camel@lb.loomes.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1100085569.1591.6.camel@lb.loomes.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kobject_register failed forBA€ÿÿÿÿ (-17)

Yet another kobject bug.  It uses the varargs list twice in a illegal
way.  That doesn't harm on i386 by pure luck, but blows things up on
amd64 machines.  The patch below fixes it.

Enjoy,

  Gerd

==============================[ cut here ]==============================
Subject: [patch] fix kobject varargs bug

Using var args list twice without calling va_start twice is illegal.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 lib/kobject.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6.10-rc2/lib/kobject.c
===================================================================
--- linux-2.6.10-rc2.orig/lib/kobject.c	2004-11-17 18:41:43.000000000 +0100
+++ linux-2.6.10-rc2/lib/kobject.c	2004-11-18 17:37:08.851041667 +0100
@@ -232,11 +232,12 @@ int kobject_set_name(struct kobject * ko
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
@@ -249,7 +250,9 @@ int kobject_set_name(struct kobject * ko
 			error = -ENOMEM;
 			goto Done;
 		}
+		va_start(args,fmt);
 		need = vsnprintf(name,limit,fmt,args);
+		va_end(args);
 
 		/* Still? Give up. */
 		if (need >= limit) {
@@ -266,7 +269,6 @@ int kobject_set_name(struct kobject * ko
 	/* Now, set the new name */
 	kobj->k_name = name;
  Done:
-	va_end(args);
 	return error;
 }
 
