Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263368AbVCEAgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263368AbVCEAgj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbVCEAK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:10:28 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:63701 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263377AbVCDXUO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 18:20:14 -0500
Subject: Re: [Ext2-devel] [RFC] ext3/jbd race: releasing in-use
	journal_heads
From: Badari Pulavarty <pbadari@us.ibm.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk>
References: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1109978252.7236.14.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Mar 2005 15:17:32 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,


I looked at few journalling bugs recently on RHEL4 testing here.
I am wondering if your patch fixes this following BUG also ?
I never got to bottom of some of these journal panics -
since they are not easily reproducible + I don't understand
journal code well enough :(

Assertion failure in journal_commit_transaction() at fs/jbd/commit.c:790: "jh->b_next_transaction == ((void *)0)"
kernel BUG in journal_commit_transaction at fs/jbd/commit.c:790!
cpu 0x8: Vector: 700 (Program Check) at [c00000001fcc3870]
    pc: d0000000000a7cd4: .journal_commit_transaction+0x1378/0x155c [jbd]
    lr: d0000000000a7cd0: .journal_commit_transaction+0x1374/0x155c [jbd]
    sp: c00000001fcc3af0
   msr: 8000000000029032
  current = 0xc00000002fd86b30
  paca    = 0xc0000000003de000
    pid   = 272, comm = kjournald
enter ? for help

Thanks,
Badari


On Fri, 2005-03-04 at 11:54, Stephen C. Tweedie wrote:
> Hi all,
> 
> For the past few months there has been a slow but steady trickle of
> reports of oopses in kjournald.  Recently I got a couple of reports that
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
> 
> I _think_ that the attached patch deals with this, but I'm still
> awaiting further testing to be sure.  I thought I might as well get some
> other ext3 eyes on it while I wait for that -- I'll let you know as soon
> as I hear back from the other testing.
> 
> The patch works by making sure that the various exits from
> journal_unmap_buffer() always call journal_put_journal_head() *before*
> unlocking the j_list_lock.  This is correct according to the documented
> lock ranking, and it also matches the order in the existing main exit
> path at the end of the function.
> 
> Cheers,
>   Stephen
> 
> 
> ______________________________________________________________________
> 
> --- linux-2.6-ext3/fs/jbd/transaction.c.=K0000=.orig
> +++ linux-2.6-ext3/fs/jbd/transaction.c
> @@ -1775,10 +1775,10 @@ static int journal_unmap_buffer(journal_
>  			JBUFFER_TRACE(jh, "checkpointed: add to BJ_Forget");
>  			ret = __dispose_buffer(jh,
>  					journal->j_running_transaction);
> +			journal_put_journal_head(jh);
>  			spin_unlock(&journal->j_list_lock);
>  			jbd_unlock_bh_state(bh);
>  			spin_unlock(&journal->j_state_lock);
> -			journal_put_journal_head(jh);
>  			return ret;
>  		} else {
>  			/* There is no currently-running transaction. So the
> @@ -1789,10 +1789,10 @@ static int journal_unmap_buffer(journal_
>  				JBUFFER_TRACE(jh, "give to committing trans");
>  				ret = __dispose_buffer(jh,
>  					journal->j_committing_transaction);
> +				journal_put_journal_head(jh);
>  				spin_unlock(&journal->j_list_lock);
>  				jbd_unlock_bh_state(bh);
>  				spin_unlock(&journal->j_state_lock);
> -				journal_put_journal_head(jh);
>  				return ret;
>  			} else {
>  				/* The orphan record's transaction has
> @@ -1813,10 +1813,10 @@ static int journal_unmap_buffer(journal_
>  					journal->j_running_transaction);
>  			jh->b_next_transaction = NULL;
>  		}
> +		journal_put_journal_head(jh);
>  		spin_unlock(&journal->j_list_lock);
>  		jbd_unlock_bh_state(bh);
>  		spin_unlock(&journal->j_state_lock);
> -		journal_put_journal_head(jh);
>  		return 0;
>  	} else {
>  		/* Good, the buffer belongs to the running transaction.

