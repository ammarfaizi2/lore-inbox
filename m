Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbTDURny (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 13:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTDURny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 13:43:54 -0400
Received: from verein.lst.de ([212.34.181.86]:12560 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S261819AbTDURnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 13:43:53 -0400
Date: Mon, 21 Apr 2003 19:55:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] 2.5.68-bk1 crash in devfs_remove() for defpts files
Message-ID: <20030421195555.A28583@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.55.0304211338540.1491@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.55.0304211338540.1491@marabou.research.att.com>; from proski@gnu.org on Mon, Apr 21, 2003 at 01:49:18PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 01:49:18PM -0400, Pavel Roskin wrote:
> This patch
> helps, but it probably shouldn't be applied unless it turns out to be
> correct.

Right, the patch only hides the bug.

> By the way, I wonder why devfs_put(de) is called twice in a row in
> devfs_remove().

Once for the temporary reference we got from _devfs_find_entry,
the second time to actually make it go away.

Could you please try this patch?

--- 1.11/drivers/char/pty.c	Mon Mar 31 03:16:19 2003
+++ edited/drivers/char/pty.c	Mon Apr 21 18:32:46 2003
@@ -459,6 +459,7 @@
 		pts_driver[i].name_base = i*NR_PTYS;
 		pts_driver[i].num = ptm_driver[i].num;
 		pts_driver[i].other = &ptm_driver[i];
+		ptm_driver[i].flags |= TTY_DRIVER_NO_DEVFS;
 		pts_driver[i].table = pts_table[i];
 		pts_driver[i].termios = pts_termios[i];
 		pts_driver[i].termios_locked = pts_termios_locked[i];
