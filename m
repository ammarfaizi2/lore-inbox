Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVCGQDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVCGQDY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 11:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVCGQDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 11:03:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24001 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261806AbVCGQDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 11:03:20 -0500
Subject: Re: [RFC] ext3/jbd race: releasing in-use journal_heads
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050307145007.GB27051@atrey.karlin.mff.cuni.cz>
References: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050304160451.4c33919c.akpm@osdl.org>
	 <20050307145007.GB27051@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110211318.15117.129.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 07 Mar 2005 16:01:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-03-07 at 14:50, Jan Kara wrote:

>   I believe the other places should be safe (mostly by luck) as the
> caller has made sure that __journal_remove_journal_head() won't do
> anything (e.g. set b_transaction, b_next_transaction or such).

Right; I've been looking through all the journal_put_journal_head()
callers and most of the instances are places like journal_get_*_access,
which imply that the jh is still on a list.  The problem is races
against places like journal_unmap_buffer() where we can be removing the
bh from those lists as soon as we've lost the journal lock.  

> Anyway it doesn't seem too safe to me...

Quite.

I think I agree with Andrew here --- the only real solution is to make
sure that whenever anybody is clearing jh->b_transaction, they protect
themselves against journal_put_journal_head() by either elevating
j_count, or taking the jbd_lock_bh_journal_head() lock.

The current stop-gap may actually work, but I'd be more comfortable with
a robust scheme in place.

--Stephen

