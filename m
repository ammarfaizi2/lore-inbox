Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVAXXg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVAXXg6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 18:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVAXXgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:36:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8939 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261731AbVAXXfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 18:35:38 -0500
Subject: Re: [Ext2-devel] [PATCH] JBD: journal_release_buffer()
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alex Tomas <alex@clusterfs.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <m3brbebh43.fsf@bzzz.home.net>
References: <m3wtu9v3il.fsf@bzzz.home.net>
	 <1106604342.2103.395.camel@sisko.sctweedie.blueyonder.co.uk>
	 <m3brbebh43.fsf@bzzz.home.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106609725.2103.616.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 24 Jan 2005 23:35:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-01-24 at 22:24, Alex Tomas wrote:
> hmmm. that's a good catch. so, with this patch A increments h_buffer_credits
> and this one will go to the t_outstanding_credits while the buffer is still
> part of the transaction. indeed, an imbalance.
> 
> probably something like the following would be enough?
> 
>  +	/* return credit back to the handle if it was really spent */
>  +	if (credits) {
>  +		handle->h_buffer_credits++; 
>  +              spin_lock(&handle->h_transaction->t_handle_lock);
>  +              handle->h_transaction->t_outstanding_credits++;
>  +              spin_lock(&handle->h_transaction->t_handle_lock);
>  +      }

That returns the credit to A (satisfying ext3), but you just grew
t_outstanding_credits, thus growing the journal commitments without
checking if it's safe to do so or being able to handle failure.  So it
just reintroduces the original bug.

--Stephen

