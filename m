Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbVIBPjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbVIBPjO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 11:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbVIBPjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 11:39:14 -0400
Received: from dilbert.robsims.com ([209.120.158.98]:10512 "EHLO
	mail.robsims.com") by vger.kernel.org with ESMTP id S1751410AbVIBPjO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 11:39:14 -0400
Date: Fri, 2 Sep 2005 09:39:13 -0600
From: Rob Sims <lkml-z@robsims.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Change in NFS client behavior
Message-ID: <20050902153913.GA23328@robsims.com>
References: <20050831145545.GA8426@robsims.com> <1125617897.7627.14.camel@lade.trondhjem.org> <1125632597.8635.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125632597.8635.9.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 11:43:17PM -0400, Trond Myklebust wrote:
> to den 01.09.2005 Klokka 19:38 (-0400) skreiv Trond Myklebust:
> > This is a consequence of 2.6 NFS clients optimising away unnecessary
> > truncate calls. Whereas this is correct behaviour for truncate(), it
> > appears to be incorrect for open(O_TRUNC).

> > In fact, local filesystems like xfs and ext3 appear to have the opposite
> > problem: they change ctime if you call ftruncate(0) on the zero-length
> > file, as the attached test shows.
 
The following patch fixes the problem, at least when applied against
2.6.8:

--- inode.c.orig        2005-08-31 16:54:27.000000000 -0600
+++ inode.c     2005-08-31 17:06:52.000000000 -0600
@@ -756,7 +756,7 @@
 	int error;
 
 	if (attr->ia_valid & ATTR_SIZE) {
-		if (!S_ISREG(inode->i_mode) || attr->ia_size == i_size_read(inode))
+		if (!S_ISREG(inode->i_mode))
 	attr->ia_valid &= ~ATTR_SIZE;
 	}

> Could you please check if the following patch fixes NFS (and also the
> local filesystems) for you?
 
I'll try the latest in the flood today.  Thanks for all the help!
-- 
Rob
