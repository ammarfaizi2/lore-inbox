Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbTDUSto (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTDUSsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:48:32 -0400
Received: from verein.lst.de ([212.34.181.86]:34832 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S261877AbTDUSsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:48:20 -0400
Date: Mon, 21 Apr 2003 21:00:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68-bk1 crash in devfs_remove() for defpts files
Message-ID: <20030421210020.A29421@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.55.0304211338540.1491@marabou.research.att.com> <20030421195555.A28583@lst.de> <20030421195847.A28684@lst.de> <Pine.LNX.4.55.0304211451110.1798@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.55.0304211451110.1798@marabou.research.att.com>; from proski@gnu.org on Mon, Apr 21, 2003 at 02:53:54PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 02:53:54PM -0400, Pavel Roskin wrote:
> On Mon, 21 Apr 2003, Christoph Hellwig wrote:
> 
> > On Mon, Apr 21, 2003 at 07:55:55PM +0200, Christoph Hellwig wrote:
> > > Could you please try this patch?
> >
> > Better this one :)  Sorry.
> 
> No, it doesn't help, although the stack trace is different this time:

Hmm.  Can you please apply the following patch in addition and
see what the printk I added sais?


--- 1.87/fs/devfs/base.c	Mon Apr 21 10:43:52 2003
+++ edited/fs/devfs/base.c	Mon Apr 21 19:36:20 2003
@@ -1754,6 +1803,12 @@
 	n = vsnprintf(buf, 64, fmt, args);
 	if (n < 64 && buf[0]) {
 		devfs_handle_t de = _devfs_find_entry(NULL, buf, 0);
+
+		if (!de) {
+			printk(KERN_WARNING "%s: no entry for %s!\n",
+					__FUNCTION__, buf);
+			return;
+		}
 
 		write_lock(&de->parent->u.dir.lock);
 		_devfs_unregister(de->parent, de);
