Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264697AbUGBRAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264697AbUGBRAX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 13:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264734AbUGBRAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 13:00:23 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:9606 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S264697AbUGBRAW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 13:00:22 -0400
Date: Fri, 2 Jul 2004 13:00:19 -0400
To: Yichen Xie <yxie@cs.stanford.edu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: [BUGS] [CHECKER] 99 synchronization bugs and a lock summary database
Message-ID: <20040702170019.GA32756@fieldses.org>
References: <20040702011903.6360d43b.akpm@osdl.org> <Pine.LNX.4.44.0407020933300.23611-100000@kaki.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407020933300.23611-100000@kaki.stanford.edu>
User-Agent: Mutt/1.5.6+20040523i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 09:39:40AM -0700, Yichen Xie wrote:
> indeed, the code looks different in 2.6.7. definitely not a double unlock
> any more, but it seems the new version exit w/ client_sema unheld at line
> 1616, and w/ the lock held at line 1625. is there a correlation between
> the return value with the lock state? -yichen

Yes.  The unlock happens at either nfs4xdr.c:1280 (ENCODE_SEQID_OP_TAIL)
or nfs4xdr.c:2534 (nfsd4_encode_replay()), and in the former case the
unlock is conditional on the value of the oc_stateowner field that's set
before the nfs4_lock_state() in nfsd4_open_confirm().

So while I believe the code as it stands is correct, it's not just your
checker that's going to find this confusing!  I'll work on a fix....--b.
