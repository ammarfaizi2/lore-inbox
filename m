Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751855AbWFVRjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbWFVRjp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 13:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbWFVRjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 13:39:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52139 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751855AbWFVRjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 13:39:44 -0400
Date: Thu, 22 Jun 2006 13:33:09 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-5.boston.redhat.com
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: make PROT_WRITE imply PROT_READ
Message-ID: <Pine.LNX.4.64.0606221329270.15442@dhcp83-5.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

Currently, if i mmap() a file PROT_WRITE only and then first read from it 
and then write to it, i get a SEGV. However, if i write to it first and 
then read from it, i get no SEGV. This seems rather inconsistent.

The current implementation seems to be to make PROT_WRITE imply PROT_READ, 
however it does not quite work correctly. The patch below resolves this 
issue, by explicitly setting the PROT_READ flag when PROT_WRITE is 
requested.

This might appear at first as a possible permissions subversion, as i 
could get PROT_READ on a file that i only have write permission 
to...however, the mmap implementation requires that the file be opened 
with at least read access already. Thus, i don't believe there is any 
issue with regards to permissions.

Another consequenece of this patch is that it forces PROT_READ even for 
architectures that might be able to support it, (I know that x86, x86_64 
and ia64 do not) but i think this is best for portability.

This was originally reported by Doug Chapman.

thanks,

-Jason


Signed-off-by: Jason Baron <jbaron@redhat.com>

--- linux-2.6/mm/mmap.c.bak	2006-06-21 17:07:52.000000000 -0400
+++ linux-2.6/mm/mmap.c	2006-06-21 17:22:54.000000000 -0400
@@ -910,6 +910,13 @@
 		if (!(file && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC)))
 			prot |= PROT_EXEC;
 
+	 /* SuSv3: "if the application requests only PROT_WRITE, the 
+	 *          implementation may also allow read access."
+ 	 */
+
+	if (prot & PROT_WRITE)
+		prot |= PROT_READ;
+
 	if (!len)
 		return -EINVAL;
 
