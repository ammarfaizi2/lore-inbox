Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbVCGRFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVCGRFb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 12:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVCGRFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 12:05:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15592 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261893AbVCGRFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 12:05:25 -0500
Subject: Re: [RFC] ext3/jbd race: releasing in-use journal_heads
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1110213656.15117.193.camel@sisko.sctweedie.blueyonder.co.uk>
References: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050304160451.4c33919c.akpm@osdl.org>
	 <1110213656.15117.193.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110215114.15117.234.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 07 Mar 2005 17:05:14 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-03-07 at 16:40, Stephen C. Tweedie wrote:

> Andrew, can you remember why we ended up with both of those locks in the
> first place?  If we can do it, the efficient way out here is to abandon
> the journal_head_lock and use the bh_state_lock for both.  We already
> hold that over many of the key refile spots, and this would avoid the
> need to take yet another lock in those paths.

Actually, I realised there's an easier way: provide a variant of
__journal_unfile_buffer() which doesn't clear jh->b_transaction.

That's a subtle change in the logic, but everywhere that is calling
this, we already hold various locks --- except for that elusive
bh_journal_head lock.

But since everywhere else is using _other_ locks, the transient state
where we're on the transaction but not on a list won't be visible ---
we'll have refiled before we drop the lock.

I think things should work just fine with this change.
__journal_unfile_buffer() already handles the case where we're called
with b_transaction set but no b_jlist, for example.

--Stephen


