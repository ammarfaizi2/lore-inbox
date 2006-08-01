Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWHAIMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWHAIMn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 04:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbWHAIMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 04:12:43 -0400
Received: from rzcomm12.rz.tu-bs.de ([134.169.9.59]:60414 "EHLO
	rzcomm12.rz.tu-bs.de") by vger.kernel.org with ESMTP
	id S1751327AbWHAIMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 04:12:42 -0400
Message-ID: <44CF0CDE.2080500@l4x.org>
Date: Tue, 01 Aug 2006 10:12:14 +0200
From: Jan Dittmer <jdi@l4x.org>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Joe Jin <lkmaillist@gmail.com>
CC: kernel <linux@idccenter.cn>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: XFS Bug null pointer dereference in xfs_free_ag_extent
References: <44BF29CD.1000809@l4x.org> <44CB0BF7.6030204@idccenter.cn>	 <44CB1303.7010303@l4x.org>	 <20060731094424.E2280998@wobbly.melbourne.sgi.com>	 <44CDA156.6000105@idccenter.cn>	 <20060731165522.K2280998@wobbly.melbourne.sgi.com>	 <44CDB135.8080401@idccenter.cn>	 <20060731194310.A2301615@wobbly.melbourne.sgi.com>	 <44CDD5B9.8020608@idccenter.cn> <215036450607311849o43b1555br13ea2f3f20fb3b82@mail.gmail.com>
In-Reply-To: <215036450607311849o43b1555br13ea2f3f20fb3b82@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Jin schrieb:
>  From the information, I think it caused by (args.agbp == NULL).
> get rid of, we'll find the call trace should panic:
> xfs_free_extent
> |_   xfs_free_ag_extent  => here args.agbp= NULL;
>         |_ xfs_btree_init_cursor()
>               |_ agf = XFS_BUF_TO_AGF(agbp);  => (xfs_agf_t 
> *)XFS_BUF_PTR(arbp)
>                              |_ (xfs_caddr_t)((agbp)->b_addr) : but 
> here, agbp is NULL
> so it caused the oops.
> Non debug option, and the oops occured at xfs_btree_init_cursor().
> 

Probably caused by this part of the diff from Nathan's earlier mail:

--- 8558226281c45a61d7a0bc056505246e705a372b
+++ 22af489d3f346c7bb4488cdcf1ee91e59e48ddf3
--- fs/xfs/xfs_alloc.c
+++ fs/xfs/xfs_alloc.c

@@ -1951,8 +1951,14 @@ xfs_alloc_fix_freelist(
  		 * the restrictions correctly.  Can happen for free calls
  		 * on a completely full ag.
  		 */
-		if (targs.agbno == NULLAGBLOCK)
+		if (targs.agbno == NULLAGBLOCK) {
+			if (!(flags & XFS_ALLOC_FLAG_FREEING)) {
+				xfs_trans_brelse(tp, agflbp);
+				args->agbp = NULL;
+				return 0;
+			}
  			break;
+		}
  		/*
  		 * Put each allocated block on the list.
  		 */

Jan
