Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751503AbWGaJyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbWGaJyY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 05:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWGaJyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 05:54:24 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13988 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751503AbWGaJyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 05:54:24 -0400
Date: Mon, 31 Jul 2006 19:53:54 +1000
From: Nathan Scott <nathans@sgi.com>
To: Joe Jin <lkmaillist@gmail.com>
Cc: kernel <linux@idccenter.cn>, jdi@l4x.org, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net, wim.coekaerts@oracle.com
Subject: Re: XFS Bug null pointer dereference in xfs_free_ag_extent
Message-ID: <20060731195354.B2301615@wobbly.melbourne.sgi.com>
References: <44BF29CD.1000809@l4x.org> <44CB0BF7.6030204@idccenter.cn> <44CB1303.7010303@l4x.org> <20060731094424.E2280998@wobbly.melbourne.sgi.com> <44CDA156.6000105@idccenter.cn> <20060731165522.K2280998@wobbly.melbourne.sgi.com> <44CDB135.8080401@idccenter.cn> <215036450607310141j4649c048t25ae45f2b7ed75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <215036450607310141j4649c048t25ae45f2b7ed75@mail.gmail.com>; from lkmaillist@gmail.com on Mon, Jul 31, 2006 at 04:41:28PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 04:41:28PM +0800, Joe Jin wrote:
> At XFS have a debug option, but I wonder why why it was not opened,
> and you may open the option with follow patch, rebuild kernel, you
> maybe get more information of it.
> And when I trace the code, I also found at some function should check
> the return value, it also include the patch.

Hmmm.  If you want to enable debug, theres an "official" patch in
the XFS CVS tree for doing so ... this patch has one or two minor
issues:

+config XFS_DEBUG
+	bool "XFS debugging"
+	depends on XFS_FS
+	help
+	  If you are experiencing any problems with the XFS filesystem, say
+	  Y here.  This will result in additional debugging messages to be
+	  written to the system log.

Thats not really what it does - it actually mostly enables asserts
all over the code, which cause the system to panic if something bad
is detected.

I don't expect the XFS debug code to help in this particular situation
in fact it may well hide the problem.

+  Under normal circumstances, this
+	  results in very little overhead.

Its actually quite expensive.  This is one of the reasons the enabling
patch isn't in mainline, as people switch it on and wonder what happened
to their performance numbers (also it is more useful with kdb).

 	cur = kmem_zone_zalloc(xfs_btree_cur_zone, KM_SLEEP);
+	if(!cur)
+		return NULL;

This can never happen due to the alloc flags argument.

--- linux-2.6.18-rc3/fs/xfs/xfs_alloc.c	2006-07-30 14:15:36.000000000 +0800
+++ linux.new/fs/xfs/xfs_alloc.c	2006-07-31 16:09:04.000000000 +0800
@@ -649,6 +649,9 @@
 	 */
 	bno_cur = xfs_btree_init_cursor(args->mp, args->tp, args->agbp,
 		args->agno, XFS_BTNUM_BNO, NULL, 0);
+	if(!bno_cur)
+		return XFS_ERROR(ENOMEM);

This also should never happen.  From my reading of the oops report,
the problem is inside xfs_btree_init_cursor, I think from one of the
buffer pointers being null when it shouldn't be, but I'd like to get
it reproduced locally to be sure.

cheers.

-- 
Nathan
