Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTIVW6J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 18:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbTIVW4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 18:56:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:13794 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261768AbTIVW4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 18:56:06 -0400
Date: Mon, 22 Sep 2003 15:55:41 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Yu Chen <dychen@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030922155541.G18606@osdlab.pdx.osdl.net>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>; from dychen@stanford.edu on Mon, Sep 15, 2003 at 09:35:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Yu Chen (dychen@stanford.edu) wrote:
> [FILE:  2.6.0-test5/drivers/telephony/ixj_pcmcia.c]
> [FUNC:  ixj_attach]
> [LINES: 53-64]
> [VAR:   link]
>   48:	client_reg_t client_reg;
>   49:	dev_link_t *link;
>   50:	int ret;
>   51:	DEBUG(0, "ixj_attach()\n");
>   52:	/* Create new ixj device */
> START -->
>   53:	link = kmalloc(sizeof(struct dev_link_t), GFP_KERNEL);
>   54:	if (!link)
>   55:		return NULL;
>   56:	memset(link, 0, sizeof(struct dev_link_t));
>   57:	link->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
>   58:	link->io.Attributes2 = IO_DATA_PATH_WIDTH_8;
>   59:	link->io.IOAddrLines = 3;
>   60:	link->conf.Vcc = 50;
>   61:	link->conf.IntType = INT_MEMORY_AND_IO;
>   62:	link->priv = kmalloc(sizeof(struct ixj_info_t), GFP_KERNEL);
>   63:	if (!link->priv)
> END -->
>   64:		return NULL;

Yes, this is a bug.  Patch below.

thanks,
-chris

===== drivers/telephony/ixj_pcmcia.c 1.6 vs edited =====
--- 1.6/drivers/telephony/ixj_pcmcia.c	Sat Aug 16 13:22:52 2003
+++ edited/drivers/telephony/ixj_pcmcia.c	Mon Sep 22 15:38:40 2003
@@ -60,8 +60,10 @@
 	link->conf.Vcc = 50;
 	link->conf.IntType = INT_MEMORY_AND_IO;
 	link->priv = kmalloc(sizeof(struct ixj_info_t), GFP_KERNEL);
-	if (!link->priv)
+	if (!link->priv) {
+		kfree(link);
 		return NULL;
+	}
 	memset(link->priv, 0, sizeof(struct ixj_info_t));
 	/* Register with Card Services */
 	link->next = dev_list;
