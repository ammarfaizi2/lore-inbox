Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVCGQlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVCGQlc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 11:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVCGQlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 11:41:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57304 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261849AbVCGQlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 11:41:10 -0500
Subject: Re: [RFC] ext3/jbd race: releasing in-use journal_heads
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050304160451.4c33919c.akpm@osdl.org>
References: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050304160451.4c33919c.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110213656.15117.193.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 07 Mar 2005 16:40:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2005-03-05 at 00:04, Andrew Morton wrote:

> Perhaps we could also fix this by elevating b_jcount whenever the jh is
> being moved between lists?

Possible.  But jcount isn't atomic, and it requires the bh_journal_head
lock to modify.  Taking and dropping the lock twice around the
__unfile/__refile pair, once to inc jcount and once again to drop it, is
probably unnecessarily expensive.  We can probably do with just holding
the bh_journal_head lock alone in most cases.

The specific case we're stumbling on here is the t_locked_list.  The
problem manifests itself when we walk that list, but we think it is
actually caused when we first add it to the list:

			__journal_unfile_buffer(jh);
			__journal_file_buffer(jh, commit_transaction,
						BJ_Locked);

__journal_unfile_buffer does no locking of its own.  We're calling this
point with the buffer locked, j_list_lock held and the bh_state lock
held.

Trouble is, that's not enough; journal_put_journal_head() can nuke the
buffer with merely the bh_journal_head lock held.  In the code above it
would be enough to take the journal_head_lock over the unfile/file pair.

Andrew, can you remember why we ended up with both of those locks in the
first place?  If we can do it, the efficient way out here is to abandon
the journal_head_lock and use the bh_state_lock for both.  We already
hold that over many of the key refile spots, and this would avoid the
need to take yet another lock in those paths.

--Stephen

