Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbTIPG4X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 02:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbTIPG4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 02:56:23 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:23219 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261779AbTIPG4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 02:56:19 -0400
Date: Tue, 16 Sep 2003 08:55:53 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Yu Chen <dychen@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu,
       David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030916065553.GA12329@wohnheim.fh-wedel.de>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 September 2003 21:35:46 -0700, David Yu Chen wrote:
> 
> [FILE:  2.6.0-test5/drivers/mtd/chips/cfi_cmdset_0020.c]
> [FUNC:  cfi_staa_setup]
> [LINES: 191-211]
> [VAR:   mtd]
>  186:	struct mtd_info *mtd;
>  187:	unsigned long offset = 0;
>  188:	int i,j;
>  189:	unsigned long devsize = (1<<cfi->cfiq->DevSize) * cfi->interleave;
>  190:
> START -->
>  191:	mtd = kmalloc(sizeof(*mtd), GFP_KERNEL);
>  192:	//printk(KERN_DEBUG "number of CFI chips: %d\n", cfi->numchips);
>  193:
>  194:	if (!mtd) {
>  195:		printk(KERN_ERR "Failed to allocate memory for MTD device\n");
>  196:		kfree(cfi->cmdset_priv);
>         ... DELETED 9 lines ...
>  206:	mtd->eraseregions = kmalloc(sizeof(struct mtd_erase_region_info) 
>  207:			* mtd->numeraseregions, GFP_KERNEL);
>  208:	if (!mtd->eraseregions) { 
>  209:		printk(KERN_ERR "Failed to allocate memory for MTD erase region info\n");
>  210:		kfree(cfi->cmdset_priv);
> END -->
>  211:		return NULL;
>  212:	}
>  213:	
>  214:	for (i=0; i<cfi->cfiq->NumEraseRegions; i++) {
>  215:		unsigned long ernum, ersize;
>  216:		ersize = ((cfi->cfiq->EraseRegionInfo[i] >> 8) & ~0xff) * cfi->interleave;

Valid.

> [FILE:  2.6.0-test5/drivers/mtd/chips/cfi_cmdset_0020.c]
> [FUNC:  cfi_staa_setup]
> [LINES: 191-235]
> [VAR:   mtd]
>  186:	struct mtd_info *mtd;
>  187:	unsigned long offset = 0;
>  188:	int i,j;
>  189:	unsigned long devsize = (1<<cfi->cfiq->DevSize) * cfi->interleave;
>  190:
> START -->
>  191:	mtd = kmalloc(sizeof(*mtd), GFP_KERNEL);
>  192:	//printk(KERN_DEBUG "number of CFI chips: %d\n", cfi->numchips);
>  193:
>  194:	if (!mtd) {
>  195:		printk(KERN_ERR "Failed to allocate memory for MTD device\n");
>  196:		kfree(cfi->cmdset_priv);
>         ... DELETED 33 lines ...
>  230:		if (offset != devsize) {
>  231:			/* Argh */
>  232:			printk(KERN_WARNING "Sum of regions (%lx) != total size of set of interleaved chips (%lx)\n", offset, devsize);
>  233:			kfree(mtd->eraseregions);
>  234:			kfree(cfi->cmdset_priv);
> END -->
>  235:			return NULL;
>  236:		}
>  237:
>  238:		for (i=0; i<mtd->numeraseregions;i++){
>  239:			printk(KERN_DEBUG "%d: offset=0x%x,size=0x%x,blocks=%d\n",
>  240:			       i,mtd->eraseregions[i].offset,

Also valid.

> looks like checking for mtdblks instead of mtdblk
> [FILE:  2.6.0-test5/drivers/mtd/mtdblock.c]
> [FUNC:  mtdblock_open]
> [LINES: 277-279]
> [VAR:   mtdblk]
>  272:		mtdblks[dev]->count++;
>  273:		return 0;
>  274:	}
>  275:	
>  276:	/* OK, it's not open. Create cache info for it */
> START -->
>  277:	mtdblk = kmalloc(sizeof(struct mtdblk_dev), GFP_KERNEL);
>  278:	if (!mtdblks)
> END -->
>  279:		return -ENOMEM;
>  280:
>  281:	memset(mtdblk, 0, sizeof(*mtdblk));
>  282:	mtdblk->count = 1;
>  283:	mtdblk->mtd = mtd;
>  284:

Invalid.  This is quite an obvious false positive, at least if your
algorithm checks for possible value ranges.

> [FILE:  2.6.0-test5/fs/jffs2/scan.c]
> [FUNC:  jffs2_scan_medium]
> [LINES: 98-109]
> [VAR:   flashbuf]
>   93:			buf_size = c->sector_size;
>   94:		else
>   95:			buf_size = PAGE_SIZE;
>   96:
>   97:		D1(printk(KERN_DEBUG "Allocating readbuf of %d bytes\n", buf_size));
> START -->
>   98:		flashbuf = kmalloc(buf_size, GFP_KERNEL);
>   99:		if (!flashbuf)
>  100:			return -ENOMEM;
>  101:	}
>  102:
>  103:	for (i=0; i<c->nr_blocks; i++) {
>  104:		struct jffs2_eraseblock *jeb = &c->blocks[i];
>  105:
>  106:		ret = jffs2_scan_eraseblock(c, jeb, buf_size?flashbuf:(flashbuf+jeb->offset), buf_size);
>  107:
>  108:		if (ret < 0)
> END -->
>  109:			return ret;
>  110:
>  111:		ACCT_PARANOIA_CHECK(jeb);
>  112:
>  113:		/* Now decide which list to put it on */
>  114:		switch(ret) {

Valid.  And not trivial to fix.

> [FILE:  2.6.0-test5/fs/jffs2/scan.c]
> [FUNC:  jffs2_scan_medium]
> [LINES: 98-233]
> [VAR:   flashbuf]
>   93:			buf_size = c->sector_size;
>   94:		else
>   95:			buf_size = PAGE_SIZE;
>   96:
>   97:		D1(printk(KERN_DEBUG "Allocating readbuf of %d bytes\n", buf_size));
> START -->
>   98:		flashbuf = kmalloc(buf_size, GFP_KERNEL);
>   99:		if (!flashbuf)
>  100:			return -ENOMEM;
>  101:	}
>  102:
>  103:	for (i=0; i<c->nr_blocks; i++) {
>         ... DELETED 124 lines ...
>  228:	}
>  229:	if (c->nr_erasing_blocks) {
>  230:		if ( !c->used_size && ((empty_blocks+bad_blocks)!= c->nr_blocks || bad_blocks == c->nr_blocks) ) {
>  231:			printk(KERN_NOTICE "Cowardly refusing to erase blocks on filesystem with no valid JFFS2 nodes\n");
>  232:			printk(KERN_NOTICE "empty_blocks %d, bad_blocks %d, c->nr_blocks %d\n",empty_blocks,bad_blocks,c->nr_blocks);
> END -->
>  233:			return -EIO;
>  234:		}
>  235:		jffs2_erase_pending_trigger(c);
>  236:	}
>  237:	if (buf_size)
>  238:		kfree(flashbuf);

Same one, basically.

Jörn

-- 
Geld macht nicht glücklich.
Glück macht nicht satt.
