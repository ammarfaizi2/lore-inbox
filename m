Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVDZGDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVDZGDf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 02:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVDZGDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 02:03:35 -0400
Received: from iabervon.org ([66.92.72.58]:47621 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261343AbVDZGD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 02:03:26 -0400
Date: Tue, 26 Apr 2005 02:03:23 -0400 (EDT)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Jeff Garzik <jgarzik@pobox.com>, pasky@ucw.cz, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Don't use commit-id in building
In-Reply-To: <20050426054017.GS13052@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.21.0504260142130.30848-100000@iabervon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005, Al Viro wrote:

> > > So, it still complains about commit-id
> > 
> > In this case, it would complain about .git/HEAD even if it found
> > commit-id. The right solution is probably to suppress that part if there's
> > no .git/HEAD.
> 
> The right thing is to stop assuming that everyone has . in their $PATH,
> to start with...

Does anyone have . in their $PATH? I've only used the commit-id that I
installed previously. Since the tarball doesn't have a .git directory, the
only way you end up building cogito from a directory with a repository is
by using an earlier cogito or something of the sort, in which case, you
probably have the program.

In any case, commit-id isn't actually necessary for this operation.

-
We don't necessarily have commit-id available when building. Furthermore,
we don't necessarily have a repository. Just put in .git/HEAD if it
exists; otherwise, it's a base distribution.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>

Index: Makefile
===================================================================
--- f262000f302b749e485f5eb971e6aabefbb85680/Makefile  (mode:100644 sha1:4f01bbbbb3fd0e53e9ce968f167b6dae68fcfa92)
+++ uncommitted/Makefile  (mode:100644)
@@ -87,11 +87,13 @@
 http-pull: LIBS += -lcurl
 
 
-cg-version: $(VERSION)
+cg-version: $(VERSION) .git/HEAD
 	@echo Generating cg-version...
 	@rm -f $@
 	@echo "#!/bin/sh" > $@
-	@PATH=.:$(PATH) echo "echo \"$(shell cat $(VERSION)) ($(shell commit-id))\"" >> $@
+	@echo -n "echo \"$(shell cat $(VERSION))" >> $@
+	@if [ -r .git/HEAD ]; then echo -n " ($(shell cat .git/HEAD))" >> $@; fi
+	@echo "\"" >> $@
 	@chmod +x $@
 
 install: $(PROG) $(SCRIPTS) $(SCRIPT) $(GEN_SCRIPT)

