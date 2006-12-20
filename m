Return-Path: <linux-kernel-owner+w=401wt.eu-S964992AbWLTLFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWLTLFu (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 06:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWLTLFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 06:05:50 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:58437 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964992AbWLTLFt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 06:05:49 -0500
Date: Wed, 20 Dec 2006 12:05:44 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>
Subject: Fix IPMI watchdog set_param_str() using kstrdup
Message-ID: <20061220120544.36fdf518@frecb000686>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/12/2006 12:13:27,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/12/2006 12:13:29,
	Serialize complete at 20/12/2006 12:13:29
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  I've wondered for some time why my IPMI watchdog stopped working. I traced it
back to the following patch:

	[PATCH] ipmi: strstrip conversion

  Here is a patch to fix this issue.

  Sébastien.


                Fix IPMI watchdog set_param_str() using kstrdup

  set_param_str() cannot use kstrdup() to duplicate the parameter. That's
fine when the driver is compiled as a module but it sure is not when
built into the kernel as the kernel parameters are parsed before the
kmalloc slabs are setup.


 ipmi_watchdog.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>

Index: linux-2.6.20-rc1/drivers/char/ipmi/ipmi_watchdog.c
===================================================================
--- linux-2.6.20-rc1.orig/drivers/char/ipmi/ipmi_watchdog.c	2006-12-14 02:14:23.000000000 +0100
+++ linux-2.6.20-rc1/drivers/char/ipmi/ipmi_watchdog.c	2006-12-19 17:20:06.000000000 +0100
@@ -216,13 +216,13 @@ static int set_param_str(const char *val
 {
 	action_fn  fn = (action_fn) kp->arg;
 	int        rv = 0;
-	char       *dup, *s;
+	char       valcp[16];
+	char       *s;
 
-	dup = kstrdup(val, GFP_KERNEL);
-	if (!dup)
-		return -ENOMEM;
+	strncpy(valcp, val, 16);
+	valcp[15] = '\0';
 
-	s = strstrip(dup);
+	s = strstrip(valcp);
 
 	down_read(&register_sem);
 	rv = fn(s, NULL);
@@ -235,7 +235,6 @@ static int set_param_str(const char *val
 
  out_unlock:
 	up_read(&register_sem);
-	kfree(dup);
 	return rv;
 }
 
