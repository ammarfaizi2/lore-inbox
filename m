Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVAXW3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVAXW3K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVAXW2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:28:36 -0500
Received: from [83.102.214.158] ([83.102.214.158]:16025 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S261668AbVAXWZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:25:44 -0500
X-Comment-To: "Stephen C. Tweedie"
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Alex Tomas <alex@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
Subject: Re: [Ext2-devel] [PATCH] JBD: journal_release_buffer()
References: <m3wtu9v3il.fsf@bzzz.home.net>
	<1106604342.2103.395.camel@sisko.sctweedie.blueyonder.co.uk>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Tue, 25 Jan 2005 01:24:28 +0300
In-Reply-To: <1106604342.2103.395.camel@sisko.sctweedie.blueyonder.co.uk> (Stephen
 C. Tweedie's message of "Mon, 24 Jan 2005 22:05:42 +0000")
Message-ID: <m3brbebh43.fsf@bzzz.home.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Stephen C Tweedie (SCT) writes:

 >> +	/* return credit back to the handle if it was really spent */
 >> +	if (credits)
 >> +		handle->h_buffer_credits++; 

 >> +	jh->b_tcount--;
 >> +	if (jh->b_tcount == 0) {
 >> +		/* 
 >> +		 * this was last reference to the block from the current
 >> +		 * transaction and we'd like to return credit to the
 >> +		 * whole transaction -bzzz
 >> +		 */
 >> +		if (!credits)
 >> +			handle->h_buffer_credits++; 

 SCT> I think there's a problem here.

 SCT> What if:
 SCT>   Process A gets write access, and is the first to do so (*credits=1)
 SCT>   Processes B gets write access (*credits=0)
 SCT>   B modifies the buffer and finishes
 SCT>   A looks again, sees B's modifications, and releases the buffer because
 SCT> it's no use any more.

 SCT> Now, B's release didn't return credits.  The bh is part of the
 SCT> transaction and was not released.

hmmm. that's a good catch. so, with this patch A increments h_buffer_credits
and this one will go to the t_outstanding_credits while the buffer is still
part of the transaction. indeed, an imbalance.

probably something like the following would be enough?

 +	/* return credit back to the handle if it was really spent */
 +	if (credits) {
 +		handle->h_buffer_credits++; 
 +              spin_lock(&handle->h_transaction->t_handle_lock);
 +              handle->h_transaction->t_outstanding_credits++;
 +              spin_lock(&handle->h_transaction->t_handle_lock);
 +      }

thanks, Alex


