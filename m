Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262871AbVAFO6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbVAFO6J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 09:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbVAFO4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 09:56:39 -0500
Received: from [213.146.154.40] ([213.146.154.40]:18855 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262852AbVAFOzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 09:55:31 -0500
Date: Thu, 6 Jan 2005 14:55:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org, ak@suse.de,
       mingo@elte.hu, rlrevell@joe-job.com, tiwai@suse.de,
       linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org,
       gordon.jin@intel.com, alsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: Re: [PATCH] deprecate (un)register_ioctl32_conversion
Message-ID: <20050106145527.GB18725@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>,
	Andrew Morton <akpm@osdl.org>, ak@suse.de, mingo@elte.hu,
	rlrevell@joe-job.com, tiwai@suse.de, linux-kernel@vger.kernel.org,
	pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com,
	alsa-devel@lists.sourceforge.net, greg@kroah.com
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050105144043.GB19434@mellanox.co.il> <20050105144603.GA1419@infradead.org> <20050105150310.GA19758@mellanox.co.il> <20050105133358.16ce6891.akpm@osdl.org> <20050106144116.GA25898@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106144116.GA25898@mellanox.co.il>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Stare at this as I might, I dont understand why does it make sence.
> So if filp->f_op is NULL, you are then checking filp->f_op->ioctl?
> Looks like an oops to me.

I doesn't make sense, but fortunately files with NULL filp->f_op don't
happen in practice (need to research whether it can't happen in theory
either so we could lose lots of checks)

> 
> What should be there:
> 
> > +	if (!filp->f_op) {
> > +		goto do_ioctl;
> > +	} else if (filp->f_op->compat_ioctl) {
> > +		error = filp->f_op->compat_ioctl(filp, cmd, arg);
> > +		goto out_fput;

not correct either, see the incremental patch below.

> Look, was this patch even tested?

Yes.

--- linux-2.6.10-mm2.orig/fs/compat.c	2005-01-06 11:40:18.831900000 +0100
+++ linux-2.6.10-mm2/fs/compat.c	2005-01-06 15:50:23.802874672 +0100
@@ -436,10 +436,10 @@
 	if (!filp)
 		goto out;
 
-	if (!filp->f_op) {
-		if (!filp->f_op->ioctl)
-			goto do_ioctl;
-	} else if (filp->f_op->compat_ioctl) {
+	if (!filp->f_op || !filp->f_op->ioctl)
+		goto do_ioctl;
+
+	if (filp->f_op || filp->f_op->compat_ioctl) {
 		error = filp->f_op->compat_ioctl(filp, cmd, arg);
 		goto out_fput;
 	}
