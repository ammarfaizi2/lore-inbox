Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTFPI6p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 04:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTFPI6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 04:58:45 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:25761 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263632AbTFPI6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 04:58:44 -0400
Date: Mon, 16 Jun 2003 11:12:15 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make cramfs look less hostile
Message-ID: <20030616091215.GA17446@wohnheim.fh-wedel.de>
References: <20030615160524.GD1063@wohnheim.fh-wedel.de> <20030615182642.A19479@infradead.org> <20030615173926.GH1063@wohnheim.fh-wedel.de> <20030615184417.A19712@infradead.org> <20030615175815.GI1063@wohnheim.fh-wedel.de> <20030615190349.A21931@infradead.org> <20030615181424.GJ1063@wohnheim.fh-wedel.de> <20030615191853.A22150@infradead.org> <20030615234909.A11481@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030615234909.A11481@pclin040.win.tue.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 June 2003 23:49:09 +0200, Andries Brouwer wrote:
> On Sun, Jun 15, 2003 at 07:18:53PM +0100, Christoph Hellwig wrote:
> > 
> > The only places where this should happen is mounting the rootfs.
> > mount(8) has it's own filesystem type detection code and doesn't
> > call mount(2) unless it found a matching filesystem type.
> 
> Too optimistic a description.
> Any person who likes reliable results will give mount a -t option.
> If someone likes to gamble, and doesnt mind system crashes, he'll
> omit the -t and let mount guess what the type should have been.
> Mount has a battery of heuristics for a handful of filesystems.
> If any of these succeeds mount will try that type.
> If none succeeds, mount will try consecutively all types listed
> in /proc/filesystems for which no heuristic is present.

Actually, I have one example of reality matching Christoph's
description, so he wins this fight as well.

Patch below is trivial and does what I need.  Any further complaints?

Jörn

-- 
With a PC, I always felt limited by the software available. On Unix, 
I am limited only by my knowledge.
-- Peter J. Schoenster

--- linux-2.5.71/fs/cramfs/inode.c~cramfs_message	2003-06-16 11:05:04.000000000 +0200
+++ linux-2.5.71/fs/cramfs/inode.c	2003-06-16 11:05:56.000000000 +0200
@@ -218,7 +218,8 @@
 		/* check at 512 byte offset */
 		memcpy(&super, cramfs_read(sb, 512, sizeof(super)), sizeof(super));
 		if (super.magic != CRAMFS_MAGIC) {
-			printk(KERN_ERR "cramfs: wrong magic\n");
+			if (!silent)
+				printk(KERN_ERR "cramfs: wrong magic\n");
 			goto out;
 		}
 	}
