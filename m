Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbUCDKxh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 05:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbUCDKxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 05:53:36 -0500
Received: from stan.yoobay.net ([62.111.67.220]:528 "EHLO mail.authmail.net")
	by vger.kernel.org with ESMTP id S261826AbUCDKxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 05:53:35 -0500
Date: Thu, 4 Mar 2004 12:37:49 +0100
From: Daniel Mack <daniel@zonque.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.4-rc2: scripts/modpost.c
Message-ID: <20040304113749.GD5569@zonque.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(This is is a repost - now with a patch for 2.6.4-rc2).

Hi,

as I found out, it's impossible to use the build-chain tool scripts/modpost
of the 2.6 kernel series to externally build modules from a directory that
contains the character sequence '.o'. Weird things happen if you try to do
so.

With a directory structure like on my system here, building the current DVB
driver in '/home/daniel/cvs.linuxtv.org/dvb-kernel/build-2.6i/' generates a 
file called '/home/daniel/cvs.linuxtv.mod.c' since modpost cuts every 
filename string at the first occurence of '.o', not only the 'trailing .o',
as the comment says.

Here's the patch for 2.6.4-rc2:


--- linux-2.6.4-rc2.orig/scripts/modpost.c      2004-03-04 11:40:21.000000000 +0100
+++ linux-2.6.4-rc2/scripts/modpost.c   2004-03-04 11:23:08.000000000 +0100
@@ -63,16 +63,16 @@
 new_module(char *modname)
 {
        struct module *mod;
-       char *p;
+       int len;
 
        mod = NOFAIL(malloc(sizeof(*mod)));
        memset(mod, 0, sizeof(*mod));
        mod->name = NOFAIL(strdup(modname));
 
        /* strip trailing .o */
-       p = strstr(mod->name, ".o");
-       if (p)
-               *p = 0;
+       len = strlen(mod->name);
+       if (len > 2 && mod->name[len-2] == '.' && mod->name[len-1] == 'o')
+               mod->name[len-2] = 0;
 
        /* add to list */
        mod->next = modules;



Daniel

