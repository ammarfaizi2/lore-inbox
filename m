Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbUCBOXw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 09:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbUCBOXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 09:23:52 -0500
Received: from stan.yoobay.net ([62.111.67.220]:10505 "EHLO mail.authmail.net")
	by vger.kernel.org with ESMTP id S261651AbUCBOXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 09:23:50 -0500
Date: Tue, 2 Mar 2004 16:14:44 +0100
From: Daniel Mack <daniel@zonque.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6 series: fixed strange behaviour of scripts/modpost
Message-ID: <20040302151444.GA8217@zonque.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

as I found out this morning, it's impossible to use the build-chain
tool modpost of the 2.6 kernel series from within a directory that
contains the character sequence '.o'. Weird things happen if you
try to do so.

With a directory structure like on my system here, building the
current DVB driver in '/home/daniel/cvs.linuxtv.org/dvb-kernel/build-2.6'
generates a file called '/home/daniel/cvs.linuxtv.mod.c' since modpost
cuts every filename string at the first occurence of '.o'.
Funny enough that obviously nobody ever renamed a kernel tree to
something like 'linux-2.6.2.orig' and tried to remake it afterwards ;)

Here's the patch that fixes it:

--- modpost.orig.c      2004-02-18 04:57:17.000000000 +0100
+++ modpost.c   2004-03-02 14:43:42.000000000 +0100
@@ -63,12 +63,12 @@
 new_module(char *modname)
 {
        struct module *mod;
-       char *p;
+       int len;
 
        /* strip trailing .o */
-       p = strstr(modname, ".o");
-       if (p)
-               *p = 0;
+       len = strlen (modname);
+       if (len > 2 && modname[len-2] == '.' && modname[len-1] == 'o')
+               modname[len-2] = 0;
 
        mod = NOFAIL(malloc(sizeof(*mod)));
        memset(mod, 0, sizeof(*mod));


Daniel
