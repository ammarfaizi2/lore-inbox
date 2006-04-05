Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWDEAEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWDEAEE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWDEADe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:03:34 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:62402
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750987AbWDEACG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:02:06 -0400
Date: Tue, 4 Apr 2006 17:01:22 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org, neilb@suse.de,
       ivan@kasenna.com
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 25/26] knfsd: Correct reserved reply space for read requests.
Message-ID: <20060405000122.GZ27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="knfsd-correct-reserved-reply-space-for-read-requests.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.de>


NFSd makes sure there is enough space to hold the maximum possible reply
before accepting a request.  The units for this maximum is (4byte) words. 
However in three places, particularly for read request, the number given is
a number of bytes.

This means too much space is reserved which is slightly wasteful.

This is the sort of patch that could uncover a deeper bug, and it is not
critical, so it would be best for it to spend a while in -mm before going
in to mainline.

(akpm: target 2.6.17-rc2, 2.6.16.3 (approx))

Discovered-by: "Eivind  Sarto" <ivan@kasenna.com>
Signed-off-by: Neil Brown <neilb@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/nfsd/nfs3proc.c |    2 +-
 fs/nfsd/nfs4proc.c |    2 +-
 fs/nfsd/nfsproc.c  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.16.1.orig/fs/nfsd/nfs3proc.c
+++ linux-2.6.16.1/fs/nfsd/nfs3proc.c
@@ -682,7 +682,7 @@ static struct svc_procedure		nfsd_proced
   PROC(lookup,	 dirop,		dirop,		fhandle2, RC_NOCACHE, ST+FH+pAT+pAT),
   PROC(access,	 access,	access,		fhandle,  RC_NOCACHE, ST+pAT+1),
   PROC(readlink, readlink,	readlink,	fhandle,  RC_NOCACHE, ST+pAT+1+NFS3_MAXPATHLEN/4),
-  PROC(read,	 read,		read,		fhandle,  RC_NOCACHE, ST+pAT+4+NFSSVC_MAXBLKSIZE),
+  PROC(read,	 read,		read,		fhandle,  RC_NOCACHE, ST+pAT+4+NFSSVC_MAXBLKSIZE/4),
   PROC(write,	 write,		write,		fhandle,  RC_REPLBUFF, ST+WC+4),
   PROC(create,	 create,	create,		fhandle2, RC_REPLBUFF, ST+(1+FH+pAT)+WC),
   PROC(mkdir,	 mkdir,		create,		fhandle2, RC_REPLBUFF, ST+(1+FH+pAT)+WC),
--- linux-2.6.16.1.orig/fs/nfsd/nfs4proc.c
+++ linux-2.6.16.1/fs/nfsd/nfs4proc.c
@@ -975,7 +975,7 @@ struct nfsd4_voidargs { int dummy; };
  */
 static struct svc_procedure		nfsd_procedures4[2] = {
   PROC(null,	 void,		void,		void,	  RC_NOCACHE, 1),
-  PROC(compound, compound,	compound,	compound, RC_NOCACHE, NFSD_BUFSIZE)
+  PROC(compound, compound,	compound,	compound, RC_NOCACHE, NFSD_BUFSIZE/4)
 };
 
 struct svc_version	nfsd_version4 = {
--- linux-2.6.16.1.orig/fs/nfsd/nfsproc.c
+++ linux-2.6.16.1/fs/nfsd/nfsproc.c
@@ -553,7 +553,7 @@ static struct svc_procedure		nfsd_proced
   PROC(none,	 void,		void,		none,		RC_NOCACHE, ST),
   PROC(lookup,	 diropargs,	diropres,	fhandle,	RC_NOCACHE, ST+FH+AT),
   PROC(readlink, readlinkargs,	readlinkres,	none,		RC_NOCACHE, ST+1+NFS_MAXPATHLEN/4),
-  PROC(read,	 readargs,	readres,	fhandle,	RC_NOCACHE, ST+AT+1+NFSSVC_MAXBLKSIZE),
+  PROC(read,	 readargs,	readres,	fhandle,	RC_NOCACHE, ST+AT+1+NFSSVC_MAXBLKSIZE/4),
   PROC(none,	 void,		void,		none,		RC_NOCACHE, ST),
   PROC(write,	 writeargs,	attrstat,	fhandle,	RC_REPLBUFF, ST+AT),
   PROC(create,	 createargs,	diropres,	fhandle,	RC_REPLBUFF, ST+FH+AT),

--
