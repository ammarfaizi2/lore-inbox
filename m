Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262566AbVAETZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbVAETZH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 14:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVAETXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 14:23:49 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:17544 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262566AbVAETWQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 14:22:16 -0500
Subject: [PATCH] prohibit slash in proc directory entry names
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Olaf Hering <olh@suse.de>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050105000129.63478670.akpm@osdl.org>
References: <20050105075357.GA12473@suse.de>
	 <20050105000129.63478670.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1104952961.10796.41.camel@pants.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 05 Jan 2005 13:22:41 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-05 at 02:01, Andrew Morton wrote:
> Olaf Hering <olh@suse.de> wrote:
> >
> > A few users of request_irq pass a string with '/'.
> >  As a result, ls -l /proc/irq/*/* will fail to list these entries.
> 
> hrm, interesting.  So how do these entries appear in /proc?  Do they
> actually have slashes in them?
> 
> I get the feeling that something somewhere should be detecting this and
> should be propagating an error back.

proc_create() needs to check that the name of an entry to be created
does not contain a '/' character.

To test, I hacked the ibmveth driver to try to call request_irq with a
bogus "foo/bar" devname.  The creation of the /proc/irq/1234/xxx entry
silently fails, as intended.  Perhaps the irq code should be made to
check for the failure.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>

Index: 2.6.10/fs/proc/generic.c
===================================================================
--- 2.6.10.orig/fs/proc/generic.c	2004-12-24 21:35:40.000000000 +0000
+++ 2.6.10/fs/proc/generic.c	2005-01-05 18:44:56.000000000 +0000
@@ -551,6 +551,11 @@
 
 	if (!(*parent) && xlate_proc_name(name, parent, &fn) != 0)
 		goto out;
+
+	/* At this point there must not be any '/' characters beyond *fn */
+	if (strchr(fn, '/'))
+		goto out;
+
 	len = strlen(fn);
 
 	ent = kmalloc(sizeof(struct proc_dir_entry) + len + 1, GFP_KERNEL);


