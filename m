Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbUKPXYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbUKPXYS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 18:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUKPXWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 18:22:42 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:53702 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261892AbUKPXTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:19:46 -0500
Date: Tue, 16 Nov 2004 18:19:35 -0500
To: Ravikiran G Thirumalai <kiran@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kai Makisara <Kai.Makisara@metla.fi>, Willem Riede <osst@riede.org>,
       coda@cs.cmu.edu, Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 0/4] Cleanup file_count usage
Message-ID: <20041116231935.GB1341@delft.aura.cs.cmu.edu>
Mail-Followup-To: Ravikiran G Thirumalai <kiran@in.ibm.com>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Kai Makisara <Kai.Makisara@metla.fi>, Willem Riede <osst@riede.org>,
	coda@cs.cmu.edu, Paul Mackerras <paulus@samba.org>
References: <20041116135200.GA23257@impedimenta.in.ibm.com> <20041116225658.GA1341@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116225658.GA1341@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.5.6+20040907i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 05:56:58PM -0500, Jan Harkes wrote:
> On Tue, Nov 16, 2004 at 07:22:00PM +0530, Ravikiran G Thirumalai wrote:
> > What remains:
> > 1. Hack to return error code to user space at last close through file_count
> >    check at the driver's flush routine.  This hack is used in scsi/st.c,
> >    scsi/osst.c and coda/file.c to return error code through .flush() 
> >    (Although it is doubtful if applications check for error during close(2)).
> >    Kai has a patch to cleanup scsi/st.c.  I will make patches to move last 
> >    close code from .flush() to .release() in the coda filesystem if no one 
> >    objects to it.  Not sure if you can do anything on errors at close...

If this f_count/file_count cleanup really has to go in, instead of moving
the Coda code from flush to release, use the attached patch which simply
removes last_close semantics from the kernel. This way I'll have to deal
with an upcall for every close, but  I can try to track the open count
in our userspace cachemanager and do the last writer thing up there.

I would rather take the performance hit than lose the possibility to
return meaningful errors on close.

Jan


--- linux/fs/coda/file.c.orig	2004-11-16 18:03:17.000000000 -0500
+++ linux/fs/coda/file.c	2004-11-16 18:04:03.000000000 -0500
@@ -157,11 +157,6 @@
 
 	coda_vfs_stat.flush++;
 
-	/* last close semantics */
-	fcnt = file_count(coda_file);
-	if (fcnt > 1)
-		goto out;
-
 	/* No need to make an upcall when we have not made any modifications
 	 * to the file */
 	if ((coda_file->f_flags & O_ACCMODE) == O_RDONLY)

