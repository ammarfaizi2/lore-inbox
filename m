Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319147AbSHMXFq>; Tue, 13 Aug 2002 19:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319144AbSHMXFV>; Tue, 13 Aug 2002 19:05:21 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:38908 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319170AbSHMXDi>; Tue, 13 Aug 2002 19:03:38 -0400
Date: Tue, 13 Aug 2002 19:07:28 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.ne>
Subject: patch 26/38: SERVER: wipe out all evidence in fh_put()
Message-ID: <Pine.SOL.4.44.0208131907030.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When a filehandle is cleared with fh_put(), wipe out all traces by
clearing ->fh_pre_saved and ->fh_post_saved.  This prevents
fill_post_wcc() from complaining if the filehandle is later reused.
(This could happen to CURRENT_FH if, for example, LOOKUP LOOKUP
occurs in a COMPOUND.)

--- old/fs/nfsd/nfsfh.c	Tue Jul 30 21:50:32 2002
+++ new/fs/nfsd/nfsfh.c	Mon Jul 29 12:39:43 2002
@@ -438,6 +438,10 @@ fh_put(struct svc_fh *fhp)
 		fh_unlock(fhp);
 		fhp->fh_dentry = NULL;
 		dput(dentry);
+#ifdef CONFIG_NFSD_V3
+		fhp->fh_pre_saved = 0;
+		fhp->fh_post_saved = 0;
+#endif
 		nfsd_nr_put++;
 	}
 	return;

