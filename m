Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266849AbUHCUyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266849AbUHCUyi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 16:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266845AbUHCUyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 16:54:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56492 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266838AbUHCUyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 16:54:33 -0400
Date: Tue, 3 Aug 2004 16:54:26 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Chris Wright <chrisw@osdl.org>
cc: Arjan van de Ven <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>,
       <akpm@osdl.org>, <andrea@suse.de>
Subject: Re: [patch] mlock-as-nonroot revisted
In-Reply-To: <20040729185215.Q1973@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0408031653350.5948-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2004, Chris Wright wrote:

> 2) mlock_user isn't ever set, so SHM_LOCK accounting looks broken
> (trivial to fix).

Should be fixed by the patch below.  Does this look
acceptable ?

--- ipc/shm.c.mlock	2004-08-03 10:19:49.470575891 -0400
+++ ipc/shm.c	2004-08-03 11:44:10.047294881 -0400
@@ -524,15 +524,19 @@
 			goto out_unlock;
 		
 		if(cmd==SHM_LOCK) {
+			struct user_struct * user = current->user;
 			if (!is_file_hugepages(shp->shm_file)) {
 				err = shmem_lock(shp->shm_file, 1, current->user);
-				if (!err)
+				if (!err) {
 					shp->shm_flags |= SHM_LOCKED;
+					shp->mlock_user = user;
+				}
 			}
 		} else {
 			if (!is_file_hugepages(shp->shm_file))
 				shmem_lock(shp->shm_file, 0, shp->mlock_user);
 			shp->shm_flags &= ~SHM_LOCKED;
+			shp->mlock_user = NULL;
 		}
 		shm_unlock(shp);
 		goto out;

