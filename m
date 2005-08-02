Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVHBVzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVHBVzU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 17:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVHBVxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 17:53:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46228 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261874AbVHBVvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 17:51:11 -0400
Date: Tue, 2 Aug 2005 22:51:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bruce Allan <bwa@us.ibm.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       linux-nfs <nfs@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: cache_register can use wrong module reference
Message-ID: <20050802215100.GA19079@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bruce Allan <bwa@us.ibm.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Neil Brown <neilb@cse.unsw.edu.au>,
	linux-nfs <nfs@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1123018176.3954.118.camel@w-bwa3.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123018176.3954.118.camel@w-bwa3.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 02:29:36PM -0700, Bruce Allan wrote:
> [resending to Neil, Trond and linux-nfs list; initial copy to lkml]
> 
> When registering an RPC cache, cache_register() always sets the owner as
> the sunrpc module.  However, there are RPC caches owned by other modules. 
> With the incorrect owner setting, the real owning module can be removed
> potentially with an open reference to the cache from userspace.
> 
> For example, if one were to stop the nfs server and unmount the nfsd
> filesystem, the nfsd module could be removed eventhough rpc.idmapd had
> references to the idtoname and nametoid caches (i.e.
> /proc/net/rpc/nfs4.<cachename>/channel is still open).  This resulted in
> a system panic on one of our machines when attempting to restart the nfs
> services after reloading the nfsd module.
> 
> The following patch fixes this by passing the address of the owning
> struct module to cache_register().  In addition, printk's were added to
> functions calling cache_unregister() to dump an error message on
> failure.
> 
> Signed-off-by: Bruce Allan <bwa@us.ibm.com>

Please put a

	struct module	*owner;

field into struct cache_detail instead, that's how it works for other
methods tables like that.

And while we're at it, cache_detail is an awfully generic name for a sunrpc
data structure.

