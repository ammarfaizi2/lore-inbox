Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932610AbWCVXg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbWCVXg5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbWCVXg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:36:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:63117 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932610AbWCVXgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:36:55 -0500
X-Authenticated: #704063
Subject: Re: [Patch] Possible NULL pointer dereference in fs/configfs/dir.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060322232709.GD7844@ca-server1.us.oracle.com>
References: <1143068729.27276.1.camel@alice>
	 <20060322232709.GD7844@ca-server1.us.oracle.com>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 00:36:54 +0100
Message-Id: <1143070614.27446.4.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

On Wed, 2006-03-22 at 15:27 -0800, Joel Becker wrote:
> On Thu, Mar 23, 2006 at 12:05:29AM +0100, Eric Sesterhenn wrote:
> > this fixes coverity bug #845, if group is NULL,
> > we dereference it when setting up dentry.
> 
> 	Is the converity checker merly looking at in-function patterns?

afaik it also looks what the functions which get called do. If you call
a function that might free a pointer you pass, it warns if you use
it afterwards.

> Where can I access the bug report (sorry for the question).

I would guess scan-admin@coverity.com 

> 	group cannot be null here, we aren't called any other way.  So
> while you are correct that the code below is needed in the presence of a
> NULL group, really the "if (group" isn't necessary, just the "if
> (group->default_groups)".  I could even BUG_ON() if you'd like.

I would then propose the following patch, so the check can be
removed for people who like small kernels. I dont think gcc notices
that all callers use non-NULL values and optimizes it away.

--- linux-2.6.16/fs/configfs/dir.c.orig	2006-03-23 00:31:16.000000000 +0100
+++ linux-2.6.16/fs/configfs/dir.c	2006-03-23 00:32:07.000000000 +0100
@@ -504,7 +504,9 @@ static int populate_groups(struct config
 	int ret = 0;
 	int i;
 
-	if (group && group->default_groups) {
+	BUG_ON(!group);		/* group == NULL is not allowed */
+	
+	if (group->default_groups) {
 		/* FYI, we're faking mkdir here
 		 * I'm not sure we need this semaphore, as we're called
 		 * from our parent's mkdir.  That holds our parent's


