Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933362AbWFXJQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933362AbWFXJQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 05:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933363AbWFXJQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 05:16:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18585 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933360AbWFXJQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 05:16:54 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <17564.52290.338084.934211@cse.unsw.edu.au> 
References: <17564.52290.338084.934211@cse.unsw.edu.au>  <15603.1150978967@warthog.cambridge.redhat.com> 
To: Neil Brown <neilb@suse.de>
Cc: David Howells <dhowells@redhat.com>, balbir@in.ibm.com, akpm@osdl.org,
       aviro@redhat.com, jblunck@suse.de, dev@openvz.org, olh@suse.de,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Fix dcache race during umount 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Sat, 24 Jun 2006 10:16:34 +0100
Message-ID: <27097.1151140594@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> wrote:

> > In my patch, generic_shutdown_super() is made to call shrink_dcache_sb()
> > instead of shrink_dcache_anon(), and the latter function is discarded
> > completely since it's no longer used.
> 
> Is that a good idea?

It depends on how often you expect unmounts to be happening, I suppose.

> Do you not have easy access to the roots of all trees in your
> super-block-sharing situation so that shrink_dcache_parent can be
> called on them all?

Well, all the roots are on the anon list, it's just that shrink_dcache_anon()
can't get rid of any root that's got children.

For unmounting specifically, we can do better as we can consume the dentry
trees directly.  That's not too difficult when we can unconditionally destroy
them from the leaves inwards.  That way we could probably avoid calling
shrink_dcache_parent() also - stick the tree at s_root on to the anon list
during unmount and have a single algorithm to wipe away the whole lot from
there.

David
