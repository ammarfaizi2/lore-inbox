Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVAYArS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVAYArS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVAYAo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:44:57 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:56257 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261763AbVAYAnu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:43:50 -0500
Subject: Re: [PATCH] BUG in io_destroy (fs/aio.c:1248)
From: "Darrick J. Wong" <djwong@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-aio@kvack.org
In-Reply-To: <20050124155613.3a741825.akpm@osdl.org>
References: <41F04D73.20800@us.ibm.com> <20050124085805.GA4462@in.ibm.com>
	 <20050124155613.3a741825.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 24 Jan 2005 16:43:21 -0800
Message-Id: <1106613801.11633.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> So...  Will someone be sending a new patch?

Here's a cheesy patch that simply marks the ioctx as dead before
destroying it.  Though I'd like to simply mark the ioctx as dead until
it actually gets used, I don't know enough about the code to make that
sort of invasive change.

--D

-----------------
Signed-off-by: Darrick Wong <djwong@us.ibm.com>

--- linux-2.6.10/fs/aio.c.old	2005-01-24 16:12:46.000000000 -0800
+++ linux-2.6.10/fs/aio.c	2005-01-24 16:30:53.000000000 -0800
@@ -1285,6 +1285,10 @@
 		if (!ret)
 			return 0;
 
+		spin_lock_irq(&ctx->ctx_lock);
+		ctx->dead = 1;
+		spin_unlock_irq(&ctx->ctx_lock);
+
 		io_destroy(ioctx);
 	}

