Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVAYOhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVAYOhx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 09:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVAYOhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 09:37:47 -0500
Received: from [83.102.214.158] ([83.102.214.158]:40910 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S261962AbVAYOhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 09:37:23 -0500
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Alex Tomas <alex@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
Subject: Re: [Ext2-devel] [PATCH] JBD: journal_release_buffer()
References: <m3wtu9v3il.fsf@bzzz.home.net>
	<1106604342.2103.395.camel@sisko.sctweedie.blueyonder.co.uk>
	<m3brbebh43.fsf@bzzz.home.net>
	<1106609725.2103.616.camel@sisko.sctweedie.blueyonder.co.uk>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Tue, 25 Jan 2005 17:36:08 +0300
In-Reply-To: <1106609725.2103.616.camel@sisko.sctweedie.blueyonder.co.uk> (Stephen
 C. Tweedie's message of "Mon, 24 Jan 2005 23:35:26 +0000")
Message-ID: <m3sm4p8tk7.fsf@bzzz.home.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, could you review the following solution?


 t_outstanding_credits - number of _modified_ blocks in the transaction
 t_reserved - number of blocks all running handle reserved

 transaction size = t_outstanding_credits + t_reserved;

 



#define TSIZE(t)	((t)->t_outstanding_credits + (t)->t_reserved)

journal_start(blocks)
{
	if (TSIZE(transaction) + blocks > MAX)
		wait_for_space(journal);
		
	transaction->t_reserved += blocks;
	handle->h_buffer_credits = blocks;
}


journal_get_write_access(handle, bh)
{
	if (jh->b_tcount >= 0)
		jh->b_tcount++;
}

journal_dirty_metadata(handle, bh)
{
	transaction->t_reserved--;
	handle->h_buffer_credits--;
	if (jh->b_tcount > 0) {
                /* modifed, no need to track it any more */
		transaction->t_outstanding_credits++;
		jh->b_tcount = -1;
	}
}

journal_release_buffer(handle, bh)
{
	if (jh->b_tcount > 0) {
                /* it's not modified yet */
		jh->b_tcount--;
                if (jh->b_tcount == 0) {
                       /* remove from the transaction */
                }
        }
}

journal_stop(handle)
{
	transaction->t_outstanding_credits -= handle->h_buffer_credits;
}


thanks, Alex


