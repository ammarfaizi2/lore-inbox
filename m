Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbTIVW4M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 18:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTIVW4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 18:56:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:10978 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261758AbTIVWzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 18:55:40 -0400
Date: Mon, 22 Sep 2003 15:54:56 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Yu Chen <dychen@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu,
       James.Bottomley@steeleye.com
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030922155456.E18606@osdlab.pdx.osdl.net>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>; from dychen@stanford.edu on Mon, Sep 15, 2003 at 09:35:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Yu Chen (dychen@stanford.edu) wrote:
> [FILE:  2.6.0-test5/drivers/scsi/NCR_Q720.c]
> START -->
>  153:	p = kmalloc(sizeof(*p), GFP_KERNEL);
>  154:	if (!p)
>  155:		return -ENOMEM;
<snip>
>  180:	if(i != NCR_Q720_MCA_ID) {
>  181:		printk(KERN_ERR "NCR_Q720, adapter failed to I/O map registers correctly at 0x%x(0x%x)\n", io_base, i);
> END -->
>  182:		return -ENODEV;

Yes, looks like a valid bug.  Patch below.  James, look ok?
thanks,
-chris

===== drivers/scsi/NCR_Q720.c 1.4 vs edited =====
--- 1.4/drivers/scsi/NCR_Q720.c	Sun Aug 17 13:10:45 2003
+++ edited/drivers/scsi/NCR_Q720.c	Mon Sep 22 15:05:02 2003
@@ -179,7 +179,7 @@
 	i = inb(io_base) | (inb(io_base+1)<<8);
 	if(i != NCR_Q720_MCA_ID) {
 		printk(KERN_ERR "NCR_Q720, adapter failed to I/O map registers correctly at 0x%x(0x%x)\n", io_base, i);
-		return -ENODEV;
+		goto out_free;
 	}
 
 	/* Phase II, find the ram base and memory map the board register */
