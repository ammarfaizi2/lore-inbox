Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWGEQ4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWGEQ4t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 12:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWGEQ4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 12:56:49 -0400
Received: from ns.suse.de ([195.135.220.2]:46536 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964887AbWGEQ4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 12:56:48 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: Novell, SUSE Labs
To: Andrew Morton <akpm@osdl.org>
Subject: NULL terminate over-long /proc/kallsyms symbols
Date: Wed, 5 Jul 2006 18:59:41 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1472
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200607051859.41638.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got a customer bug report (https://bugzilla.novell.com/190296)
about kernel symbols longer than 127 characters which end up in
a string buffer that is not NULL terminated, leading to garbage 
in /proc/kallsyms. Using strlcpy prevents this from happening,
even though such symbols still won't come out right.

A better fix would be to not use a fixed-size buffer, but it's
probably not worth the trouble. (Modversion'ed symbols even have
a length limit of 60.)

(This patch has been ested on a 2.6.16 kernel.)

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.17/kernel/module.c
===================================================================
--- linux-2.6.17.orig/kernel/module.c
+++ linux-2.6.17/kernel/module.c
@@ -1935,7 +1935,7 @@ struct module *module_get_kallsym(unsign
 		if (symnum < mod->num_symtab) {
 			*value = mod->symtab[symnum].st_value;
 			*type = mod->symtab[symnum].st_info;
-			strncpy(namebuf,
+			strlcpy(namebuf,
 				mod->strtab + mod->symtab[symnum].st_name,
 				127);
 			mutex_unlock(&module_mutex);
