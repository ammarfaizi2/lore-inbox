Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbTEKNnt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 09:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbTEKNnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 09:43:49 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:23817 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261387AbTEKNns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 09:43:48 -0400
Date: Sun, 11 May 2003 14:56:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lilo and 2.5.69?
Message-ID: <20030511145610.B20017@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Gregoire Favre <greg@ulima.unil.ch>, linux-kernel@vger.kernel.org
References: <20030511130945.GA10607@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030511130945.GA10607@ulima.unil.ch>; from greg@ulima.unil.ch on Sun, May 11, 2003 at 03:09:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 03:09:45PM +0200, Gregoire Favre wrote:
> Is there something special to do with this new kernel?

You need to fix lilo to not assume the names listet in /proc/partitions are
actual device files.  In 2.5.69 there's a bug that it prints truncated devfs
names instead of traditional device names as it should, but relying on the
names to mean anything is broken - that kernel can't enforce the device names
used.

The following patch that is in Linus BK tree should get it working for you
again for now..


--- 1.108/fs/partitions/check.c	Tue Apr 29 17:42:50 2003
+++ edited/fs/partitions/check.c	Fri May  2 09:41:04 2003
@@ -96,19 +96,6 @@
 
 char *disk_name(struct gendisk *hd, int part, char *buf)
 {
-#ifdef CONFIG_DEVFS_FS
-	if (hd->devfs_name[0] != '\0') {
-		if (part)
-			snprintf(buf, BDEVNAME_SIZE, "%s/part%d",
-					hd->devfs_name, part);
-		else if (hd->minors != 1)
-			snprintf(buf, BDEVNAME_SIZE, "%s/disc", hd->devfs_name);
-		else
-			snprintf(buf, BDEVNAME_SIZE, "%s", hd->devfs_name);
-		return buf;
-	}
-#endif
-
 	if (!part)
 		snprintf(buf, BDEVNAME_SIZE, "%s", hd->disk_name);
 	else if (isdigit(hd->disk_name[strlen(hd->disk_name)-1]))
