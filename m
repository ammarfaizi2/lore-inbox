Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265774AbUGDVGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265774AbUGDVGs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 17:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265775AbUGDVGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 17:06:48 -0400
Received: from [213.146.154.40] ([213.146.154.40]:20436 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265774AbUGDVGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 17:06:46 -0400
Date: Sun, 4 Jul 2004 22:06:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Osterlund <petero2@telia.com>, greg@kroah.com,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: [PATCH] CDRW packet writing support for 2.6.7-bk13
Message-ID: <20040704210642.GA8396@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Peter Osterlund <petero2@telia.com>,
	greg@kroah.com, viro@parcelfarce.linux.theplanet.co.uk,
	linux-kernel@vger.kernel.org, axboe@suse.de
References: <m2lli36ec9.fsf@telia.com> <m2u0wqqdpl.fsf@telia.com> <20040702150819.646b6103.akpm@osdl.org> <20040702224720.GA7969@kroah.com> <20040702155945.5c375bd2.akpm@osdl.org> <m27jtm0z7q.fsf@telia.com> <20040702165132.575cba5b.akpm@osdl.org> <m2fz88ugrw.fsf@telia.com> <20040704135842.48a32219.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704135842.48a32219.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 01:58:42PM -0700, Andrew Morton wrote:
> Peter Osterlund <petero2@telia.com> wrote:
> >
> > But anyway, if __bdevname() leaks a module reference it should get
> >  fixed, right?
> 
> Yes.  The questions is, where's the bug?

in __bdevname.  It shouldn't try the get_gendisk.  I introduced that long
ago, but it's wrong.  Use bdevname where you can, else we can't do much
else than printing the namjor/minor sanely.

The packet writing code should always use bdevname() (see my previous
mail on how to get there), and here's a patch to fix __bdevname:


--- 1.124/fs/partitions/check.c	2004-06-18 08:43:53 +02:00
+++ edited/fs/partitions/check.c	2004-07-05 01:04:11 +02:00
@@ -137,25 +137,14 @@
 EXPORT_SYMBOL(bdevname);
 
 /*
- * NOTE: this cannot be called from interrupt context.
- *
- * But in interrupt context you should really have a struct
- * block_device anyway and use bdevname() above.
+ * There's very little reason to use this, you should really
+ * have a struct block_device just about everywhere and use
+ * bdevname() instead.
  */
 const char *__bdevname(dev_t dev, char *buffer)
 {
-	struct gendisk *disk;
-	int part;
-
-	disk = get_gendisk(dev, &part);
-	if (disk) {
-		buffer = disk_name(disk, part, buffer);
-		put_disk(disk);
-	} else {
-		snprintf(buffer, BDEVNAME_SIZE, "unknown-block(%u,%u)",
+	snprintf(buffer, BDEVNAME_SIZE, "unknown-block(%u,%u)",
 				MAJOR(dev), MINOR(dev));
-	}
-
 	return buffer;
 }
 
