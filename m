Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263441AbVCEAgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbVCEAgr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263428AbVCEATh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:19:37 -0500
Received: from fire.osdl.org ([65.172.181.4]:23230 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263430AbVCEAFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:05:03 -0500
Date: Fri, 4 Mar 2005 16:04:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: ext2-devel@lists.sourceforge.net, sct@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] ext3/jbd race: releasing in-use journal_heads
Message-Id: <20050304160451.4c33919c.akpm@osdl.org>
In-Reply-To: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk>
References: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" <sct@redhat.com> wrote:
>
> For the past few months there has been a slow but steady trickle of
> reports of oopses in kjournald.

Yes, really tenuous stuff.  Very glad if this is the fix!

>  Recently I got a couple of reports that
> were repeatable enough to rerun with extra debugging code.
> 
> It turns out that we're releasing a journal_head while it is still
> linked onto the transaction's t_locked_list.  The exact location is in
> journal_unmap_buffer().  On several exit paths, that does:
> 
> 		spin_unlock(&journal->j_list_lock); 
> 		jbd_unlock_bh_state(bh);
> 		spin_unlock(&journal->j_state_lock);
> 		journal_put_journal_head(jh);
> 
> releasing the jh *after* dropping the j_list_lock and j_state_lock.
> 
> kjournald can then be doing journal_commit_transaction():
> 
> 	spin_lock(&journal->j_list_lock);
> ...
> 		if (buffer_locked(bh)) {
> 			BUFFER_TRACE(bh, "locked");
> 			if (!inverted_lock(journal, bh))
> 				goto write_out_data;
> 			__journal_unfile_buffer(jh);
> 			__journal_file_buffer(jh, commit_transaction,
> 						BJ_Locked);
> 			jbd_unlock_bh_state(bh);
> 
> The problem happens if journal_unmap_buffer()'s own put_journal_head()
> manages to get in between kjournald's *unfile_buffer and the following
> *file_buffer.  Because journal_unmap_buffer() has dropped its bh_state
> lock by this point, there's nothing to prevent this, leading to a
> variety of unpleasant situations.  In particular, the jh is unfiled at
> this point, so there's nothing to stop the put_journal_head() from
> freeing the memory we're just about to link onto the BJ_Locked list.

Right.  I don't know why journal_put_journal_head() looks at
->b_transaction, really.  Should have made presence on a list contribute to
b_jcount.  Oh well, it's been that way since 2.5.0 or older..

Don't we have the same race anywhere where we're doing a
journal_refile_buffer() (or equiv) in parallel with a
journal_put_journal_head() outside locks?  There seem to be many such.

Perhaps we could also fix this by elevating b_jcount whenever the jh is
being moved between lists?

