Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVCGVZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVCGVZh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 16:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVCGVYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 16:24:47 -0500
Received: from fire.osdl.org ([65.172.181.4]:65257 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261249AbVCGUcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:32:01 -0500
Date: Mon, 7 Mar 2005 12:31:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       sct@redhat.com
Subject: Re: [RFC] ext3/jbd race: releasing in-use journal_heads
Message-Id: <20050307123118.3a946bc8.akpm@osdl.org>
In-Reply-To: <1110213656.15117.193.camel@sisko.sctweedie.blueyonder.co.uk>
References: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk>
	<20050304160451.4c33919c.akpm@osdl.org>
	<1110213656.15117.193.camel@sisko.sctweedie.blueyonder.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" <sct@redhat.com> wrote:
>
> Trouble is, that's not enough; journal_put_journal_head() can nuke the
>  buffer with merely the bh_journal_head lock held.  In the code above it
>  would be enough to take the journal_head_lock over the unfile/file pair.
> 
>  Andrew, can you remember why we ended up with both of those locks in the
>  first place?  If we can do it, the efficient way out here is to abandon
>  the journal_head_lock and use the bh_state_lock for both.  We already
>  hold that over many of the key refile spots, and this would avoid the
>  need to take yet another lock in those paths.

Oh gosh.  It was a transformation from the global journal_datalist_lock and
jh_splice_lock locks.  jbd_lock_bh_journal_head() is supposed to be a
finegrained innermost lock whose mandate is purely for atomicity of adding
and removing the journal_head and the b_jcount refcounting.  I don't recall
there being any deeper meaning than that.

The original changelog says:

  buffer_heads and journal_heads are joined at the hip.  We need a lock to
  protect the joint and its refcounts.
  
  JBD is currently using a global spinlock for that.  Change it to use one bit
  in bh->b_state.

It could be that we can optimise jbd_lock_bh_journal_head() away, as you
mention.  If we have an assertion in there to check that
jbd_lock_bh_state() is held...
