Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbVKESs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbVKESs0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVKESs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:48:26 -0500
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:50890 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S932199AbVKESsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:48:25 -0500
Date: Sat, 5 Nov 2005 19:48:02 +0100
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Kay Sievers <kay.sievers@vrfy.org>, Rusty Russell <rusty@rustcorp.com.au>,
       333052@bugs.debian.org
Cc: Harald Dunkel <harald.dunkel@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14, udev: unknown symbols for ehci_hcd
Message-ID: <20051105184802.GB25468@ojjektum.uhulinux.hu>
References: <436CD1BC.8020102@t-online.de> <20051105173104.GA31048@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105173104.GA31048@vrfy.org>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, Nov 05, 2005 at 06:31:04PM +0100, Kay Sievers wrote:
> I've got these messages several times on the experimental SUSE too,
> but can't reproduce it so far, even without Rusty's patch to modprobe
> they have disappeared. See here for the details:
>   http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=333052


Just to let you know, I've also met this problem (on another distro), 
and did not know about this bugreport until now.
So I've done another workaround: modprobe already parses /proc/modules 
to check whether the modules needed are already loaded, and this file 
also shows us the state of the modules, being "Loading", "Live" or 
"Unloading".

With my patch, modprobe waits until the needed modules come out of the 
"Loading" or "Unloading" state.


-- 
pozsy


--- module-init-tools-3.2-pre4.orig/modprobe.c	2005-05-08 09:38:52.000000000 +0200
+++ module-init-tools-3.2-pre4/modprobe.c	2005-10-24 13:19:39.000000000 +0200
@@ -363,6 +363,7 @@
 	FILE *proc_modules;
 	char *line;
 
+start:
 	/* Might not be mounted yet.  Don't fail. */
 	proc_modules = fopen("/proc/modules", "r");
 	if (!proc_modules)
@@ -373,12 +374,31 @@
 
 		if (entry && strcmp(entry, modname) == 0) {
 			/* If it exists, usecount is the third entry. */
-			if (usecount) {
-				entry = strtok(NULL, " \n");
-				if (entry
-				    && (entry = strtok(NULL, " \n")) != NULL)
+			if (!(entry = strtok(NULL, " \n")))
+				goto out;
+
+			if (!(entry = strtok(NULL, " \n"))) /* usecount */
+				goto out;
+			else
+				if (usecount)
 					*usecount = atoi(entry);
+
+			if (!(entry = strtok(NULL, " \n"))) /* "-" */
+				goto out;
+
+			if (!(entry = strtok(NULL, " \n"))) /* status */
+				goto out;
+			else {
+				if (!strcmp(entry, "Loading") || !strcmp(entry, "Unloading")) {
+					usleep(100000);
+					free(line);
+					fclose(proc_modules);
+					goto start;
+				}
+				goto out;
 			}
+
+		out:
 			free(line);
 			fclose(proc_modules);
 			return 1;
