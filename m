Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966641AbWK2J5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966641AbWK2J5l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 04:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966646AbWK2J5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 04:57:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52935 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966641AbWK2J5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 04:57:40 -0500
Subject: Re: [GFS2] Fix Kconfig wrt CRC32 [8/9]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Patrick Caulfield <pcaulfie@redhat.com>, linux-kernel@vger.kernel.org,
       cluster-devel@redhat.com,
       Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
In-Reply-To: <456C80FE.7090902@oracle.com>
References: <1164360889.3392.146.camel@quoit.chygwyn.com>
	 <20061124214338.0e4d0510.randy.dunlap@oracle.com>
	 <1164633855.3392.167.camel@quoit.chygwyn.com> <456B149C.4050605@oracle.com>
	 <1164736932.3752.28.camel@quoit.chygwyn.com> <456C80FE.7090902@oracle.com>
Content-Type: multipart/mixed; boundary="=-eoGhuo/yICB5hOEWfMH0"
Organization: Red Hat (UK) Ltd
Date: Wed, 29 Nov 2006 09:57:43 +0000
Message-Id: <1164794263.3752.41.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eoGhuo/yICB5hOEWfMH0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

On Tue, 2006-11-28 at 10:33 -0800, Randy Dunlap wrote:
> Steven Whitehouse wrote:
[bits snipped to cut down size of reply]
> > You'll need the patch:
> > http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6-nmw.git;a=commitdiff;h=4a28fda50d864ede7d2724723949407e0e4043b8
> > as well. I'm also slightly surprised that you managed to get the errors
> > that you did, since most of those symbols appear to be networking
> > related and the DLM depends on INET which is clearly not set since NET
> > is not set.
> 
> Thanks, I'll apply that patch also and test again.
> 
> Part of the problem (IMO) is that kconfig s/w doesn't follow dependency
> chains when applying "select"s.
> 
Ah, light begins to dawn :-) Sorry for being a bit slow on the uptake...
I think I see what the problem might be now. I've attached a patch as a
possible solution, let me know if you agree. Its against my -nmw tree,
so for the current upstream it would be the same except for not needing
the "if DLM_SCTP" on the end of the select line,

Steve.


--=-eoGhuo/yICB5hOEWfMH0
Content-Disposition: attachment; filename=kconfig.diff
Content-Type: text/x-patch; name=kconfig.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/fs/dlm/Kconfig b/fs/dlm/Kconfig
index b5654a2..a1d083d 100644
--- a/fs/dlm/Kconfig
+++ b/fs/dlm/Kconfig
@@ -1,5 +1,5 @@
 menu "Distributed Lock Manager"
-	depends on EXPERIMENTAL && INET
+	depends on EXPERIMENTAL && NET && INET
 
 config DLM
 	tristate "Distributed Lock Manager (DLM)"
diff --git a/fs/gfs2/Kconfig b/fs/gfs2/Kconfig
index c0791cb..6a2ffa2 100644
--- a/fs/gfs2/Kconfig
+++ b/fs/gfs2/Kconfig
@@ -34,7 +34,9 @@ config GFS2_FS_LOCKING_NOLOCK
 
 config GFS2_FS_LOCKING_DLM
 	tristate "GFS2 DLM locking module"
-	depends on GFS2_FS
+	depends on GFS2_FS && NET && INET && (IPV6 || IPV6=n)
+	select IP_SCTP if DLM_SCTP
+	select CONFIGFS_FS
 	select DLM
 	help
 	Multiple node locking module for GFS2

--=-eoGhuo/yICB5hOEWfMH0--

