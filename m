Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVBKVkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVBKVkN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 16:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVBKVkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 16:40:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37510 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262353AbVBKVjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 16:39:53 -0500
Subject: Re: Ext2/3 32-bit stat() wrap for ~2TB files
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       "Theodore Ts'o" <tytso@mit.edu>, Alex Tomas <alex@clusterfs.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050211212736.GD16520@schnapps.adilger.int>
References: <1108155135.1944.196.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050211212736.GD16520@schnapps.adilger.int>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1108157964.1944.209.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Fri, 11 Feb 2005 21:39:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2005-02-11 at 21:27, Andreas Dilger wrote:

> > Trouble is, that limit *should* be an i_blocks limit, because i_blocks
> > is still 32-bits, and (more importantly) is multiplied by the fs
> > blocksize / 512 in stat(2) to return st_blocks in 512-byte chunks. 
> > Overflow 2^32 sectors in i_blocks and stat(2) wraps.
> 
> I agree.  The problem AFAIR is that the i_blocks accounting is done in
> the quota code, so it was a challenge to get it right, and the i_size
> limit was easier to do.

The i_size limit is also wrong for dense files; I'd be satisfied with
just getting it right!  i_blocks handling through the quota calls is
cleaner these days, but I don't think that's a particularly satisfactory
solution --- reaching maximum file size has all sorts of specific
semantics such as sending SIGXFSZ which you don't really want to have to
replicate.

>   Until now I don't think anyone has created
> dense 2TB files, so the sparse limit was enough.

Yep.

> Note also that there was a patch to extend i_blocks floating around
> (pretty small hack to use one of the reserved fields), and it might make
> sense to get this into the kernel before we actually need it.

True, but it's not really a problem right now --- i_blocks is counted in
fs blocksize units, so we're nowhere near overflowing that.  It's only
when stat() converts it to st_blocks' 512-byte units that we get into
trouble within the kernel.

> > 	if (res > (512LL << 32) - (1 << bits))
> > 		res = (512LL << 32) - (1 << bits);
> 
> So, for the quick fix we could reduce this by the number of expected
> [td]indirect blocks and submit that to 2.4 also.

Agreed.

--Stephen

