Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266099AbTFWS5h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 14:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266106AbTFWS5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 14:57:37 -0400
Received: from vena.lwn.net ([206.168.112.25]:3259 "HELO eklektix.com")
	by vger.kernel.org with SMTP id S266099AbTFWS5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 14:57:35 -0400
Message-ID: <20030623191141.31814.qmail@eklektix.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Allow arbitrary number of init funcs in modules 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Mon, 23 Jun 2003 19:19:48 +1000."
             <20030623092028.2B5272C2FC@lists.samba.org> 
Date: Mon, 23 Jun 2003 13:11:41 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Feedback is extremely welcome,

OK...you asked for it.  I found three separate bugs, two of them oopsed the
system, and the other prevented module unloading.  Did you try it with
CONFIG_MODULE_UNLOAD? :) You also need to test for null init functions,
because the module_init/module_exit mode creates them.  Patch appended.

Also...some guy once posted (http://lwn.net/Articles/22763/):

	I appeciate the series in modernizing modules, but just FYI, I
	don't think the old-style init_module/cleanup_module stuff will
	break any time soon: there are still a large number of drivers
	which use it, and there's not much point making such changes.

This patch breaks the old init_module/cleanup_module scheme; those
functions no longer get called.  Was that intentional?

jon

P.S. Beyond that, I think the patch makes sense :)

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net


--- 2.5.73-rr/kernel/module.c	Tue Jun 24 02:58:32 2003
+++ 2.5.73/kernel/module.c	Tue Jun 24 03:00:36 2003
@@ -617,9 +617,10 @@
 {
 	int i, balance = 0;
 
-	for (i = 0; i < num_pairs; i++)
+	for (i = 0; i < num_pairs; i++) {
 		balance += (pairs->init ? 1 : 0) - (pairs->exit ? 1 : 0);
-
+		pairs++;
+	}
 	return balance == 0;
 }
 
@@ -643,7 +644,7 @@
 {
 	struct module *mod;
 	char name[MODULE_NAME_LEN];
-	unsigned int i;
+	int i;
 	int ret, forced = 0;
 
 	if (!capable(CAP_SYS_MODULE))
@@ -1725,6 +1726,8 @@
 
 	/* Start the module */
 	for (i = 0; i < mod->num_ie_pairs; i++) {
+	    	if (mod->ie_pairs[i].init == NULL)
+		    	continue;
 		ret = mod->ie_pairs[i].init();
 		if (ret != 0) {
 			DEBUGP("%s: init/exit pair init=%p failed: %i\n",
