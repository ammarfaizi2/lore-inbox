Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWG1OJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWG1OJI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 10:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWG1OJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 10:09:08 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:32901 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751207AbWG1OJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 10:09:06 -0400
Date: Fri, 28 Jul 2006 16:09:03 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: LKML <linux-kernel@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH/RFC] kconfig/lxdialog: make lxdialof a built-in
In-Reply-To: <20060727202726.GA3900@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.64.0607281348420.6761@scrub.home>
References: <20060727202726.GA3900@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 27 Jul 2006, Sam Ravnborg wrote:

> Dedided to take another stamp on an old TODO item of making lxdialog
> a built-in. Following patch is first step to do so.
> The patch makes it a built-in - but with two open issues that I yet
> have to address.

Looks good. :)
There is a NULL pointer problem with empty menus, item_cur is NULL and a 
select or exit will cause a segfault in item_set_selected().

> I will during the weekend try to address the resize issue.

Wasn't it working at some point?
Anyway, it doesn't has to be overly complex either, e.g. if you delay it 
to the next key event, it's fine too. The signal handler would just set a 
flag and when wgetch returns, the display is reinitialized.

> The double ESC ESC thing I dunno how to fix.

I think the easiest would be to just ignore the first ESC, it matches the 
documented behaviour and e.g. mc has the same behaviour. The delay of the 
single ESC makes it a bit annoying/confusing to use, so that sticking to 
the double ESC is IMO safer.
I played with it a little and below is an example, which implements this 
behaviour for the menu window. 

bye, Roman


Index: linux-2.6-git/scripts/kconfig/lxdialog/menubox.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/lxdialog/menubox.c	2006-07-28 14:54:49.000000000 +0200
+++ linux-2.6-git/scripts/kconfig/lxdialog/menubox.c	2006-07-28 15:50:15.000000000 +0200
@@ -265,6 +265,14 @@ int dialog_menu(const char *title, const
 
 	while (key != ESC) {
 		key = wgetch(menu);
+		if (key == ESC) {
+			notimeout(menu, TRUE);
+			keypad(menu, FALSE);
+			key = wgetch(menu);
+			notimeout(menu, FALSE);
+			keypad(menu, TRUE);
+		}
+		
 
 		if (key < 256 && isalpha(key))
 			key = tolower(key);
