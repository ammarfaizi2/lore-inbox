Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVAYTdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVAYTdD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVAYTdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:33:02 -0500
Received: from [83.102.214.158] ([83.102.214.158]:20947 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S262084AbVAYTcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 14:32:20 -0500
X-Comment-To: "Stephen C. Tweedie"
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Alex Tomas <alex@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
Subject: Re: [Ext2-devel] [PATCH] JBD: journal_release_buffer()
References: <m3wtu9v3il.fsf@bzzz.home.net>
	<1106604342.2103.395.camel@sisko.sctweedie.blueyonder.co.uk>
	<m3brbebh43.fsf@bzzz.home.net>
	<1106609725.2103.616.camel@sisko.sctweedie.blueyonder.co.uk>
	<m3sm4p8tk7.fsf@bzzz.home.net>
	<1106670089.1985.766.camel@sisko.sctweedie.blueyonder.co.uk>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Tue, 25 Jan 2005 22:30:58 +0300
In-Reply-To: <1106670089.1985.766.camel@sisko.sctweedie.blueyonder.co.uk> (Stephen
 C. Tweedie's message of "Tue, 25 Jan 2005 16:21:30 +0000")
Message-ID: <m3k6q18fwt.fsf@bzzz.home.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Stephen C Tweedie (SCT) writes:

 >> journal_dirty_metadata(handle, bh)
 >> {
 >>     transaction->t_reserved--;
 >>     handle->h_buffer_credits--;
 >>     if (jh->b_tcount > 0) {
 >>         /* modifed, no need to track it any more */
 >>          transaction-> t_outstanding_credits++;
 >>        jh-> b_tcount = -1;
 >>      }
 >> }

 SCT> Actually, the whole thing can be wrapped in if (jh->b_tcount > 0) {}, I
 SCT> think.  If we have already charged the transaction for this buffer, then
 SCT> there's no need to charge the handle for it again.  That's going to be
 SCT> particularly important for truncate(), where we are continually updating
 SCT> the same blocks (eg. bitmap, indirect blocks), so we want to make sure
 SCT> that after the first journal_dirty_metadata() call, no further charge is
 SCT> made.

the idea is:
1) the sooner we drop reservation, the higher probability to cover many
   changes by single transaction
1) having h_buffer_credits being decremented for each modification
   could help us to debug handle overflow situations

 SCT> If we do that, do we in fact need t_reserved at all?

hmm. if t_outstanding_credits holds number of modified buffers,
then we need sum of all running h_buffer_credits to protect
from transaction overflow. t_reserved is sum of h_buffer_credits.


thanks, Alex

