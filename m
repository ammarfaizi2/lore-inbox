Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTFHMMW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 08:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbTFHMMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 08:12:22 -0400
Received: from verein.lst.de ([212.34.189.10]:16108 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261678AbTFHMMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 08:12:21 -0400
Date: Sun, 8 Jun 2003 14:25:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Alexander Hoogerhuis <alexh@ihatent.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.70-mm6
Message-ID: <20030608122546.GA18050@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@digeo.com>,
	Alexander Hoogerhuis <alexh@ihatent.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030607151440.6982d8c6.akpm@digeo.com> <873cilz9os.fsf@lapper.ihatent.com> <20030607175649.6bf3813b.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607175649.6bf3813b.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5.5 () EMAIL_ATTRIBUTION,IN_REP_TO,PATCH_UNIFIED_DIFF,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 05:56:49PM -0700, Andrew Morton wrote:
> > Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
> > spurious 8259A interrupt: IRQ7.
> > SCSI device sda: 490232832 512-byte hdwr sectors (250999 MB)
> > sda: cache data unavailable
> > sda: assuming drive cache: write through
> >  /dev/scsi/host0/bus0/target0/lun0: p1
> > devfs_mk_dir(scsi/host0/bus0/target0/lun0): could not append to dir: ea549820 "target0"
> 
> Maybe Christph can decode this one for us.

There's multiple gendisks with the same .devfs_name in scsi and we call
devfs_mk_dir on each of them.  I think the right fix is to let
devfs_mk_dir succeed on an existing directory.


--- 1.91/fs/devfs/base.c	Wed Jun  4 09:50:29 2003
+++ edited/fs/devfs/base.c	Sat Jun  7 16:09:26 2003
@@ -1684,7 +1684,10 @@
 	}
 
 	error = _devfs_append_entry(dir, de, &old);
-	if (error) {
+	if (error == -EEXIST) {
+		error = 0;
+		devfs_put(old);
+	} else if (error) {
 		PRINTK("(%s): could not append to dir: %p \"%s\"\n",
 				buf, dir, dir->name);
 		devfs_put(old);
