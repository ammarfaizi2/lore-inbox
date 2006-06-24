Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932827AbWFXFXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827AbWFXFXi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 01:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932825AbWFXFXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 01:23:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:14256 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932821AbWFXFXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 01:23:37 -0400
From: Neil Brown <neilb@suse.de>
To: David Howells <dhowells@redhat.com>
Date: Sat, 24 Jun 2006 15:23:14 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17564.52290.338084.934211@cse.unsw.edu.au>
Cc: balbir@in.ibm.com, akpm@osdl.org, aviro@redhat.com, jblunck@suse.de,
       dev@openvz.org, olh@suse.de, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Fix dcache race during umount
In-Reply-To: message from David Howells on Thursday June 22
References: <15603.1150978967@warthog.cambridge.redhat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday June 22, dhowells@redhat.com wrote:
> 
> Hi Neil,
> 
> I'd like to propose an alternative to your patch to fix the dcache race
> between unmounting a filesystem and the memory shrinker.
> 
> In my patch, generic_shutdown_super() is made to call shrink_dcache_sb()
> instead of shrink_dcache_anon(), and the latter function is discarded
> completely since it's no longer used.

Is that a good idea?
I was under the impression that on large machines, the shear size of
the dentry_unused list makes scanning all of it under the dcache_lock
an unpleasant thing to do.

Do you not have easy access to the roots of all trees in your
super-block-sharing situation so that shrink_dcache_parent can be
called on them all?

I would have thought that we want to get rid of shrink_dcache_sb rather
than create more users of it ??

> 
> I feel that prune_dcache() should probably at some point be merged into its
> two callers, since shrink_dcache_parent() and select_parent() can probably
> then do a better job of eating a dentry subtree from the leaves inwards, but I
> haven't attempted that with this patch.
> 

I think this is true, prune_dcache is serving two masters and is
overly complex as a result.

NeilBrown
