Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVDEQor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVDEQor (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 12:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVDEQor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 12:44:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21182 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261466AbVDEQon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 12:44:43 -0400
Subject: Re: OOM problems on 2.6.12-rc1 with many fsx tests
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Mingming Cao <cmm@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       mjbligh@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050403183544.7c31f85c.akpm@osdl.org>
References: <20050315204413.GF20253@csail.mit.edu>
	 <20050316003134.GY7699@opteron.random>
	 <20050316040435.39533675.akpm@osdl.org>
	 <20050316183701.GB21597@opteron.random>
	 <1111607584.5786.55.camel@localhost.localdomain>
	 <20050403183544.7c31f85c.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1112719458.4148.106.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 05 Apr 2005 17:44:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-04-04 at 02:35, Andrew Morton wrote:

> Without the below patch it's possible to make ext3 leak at around a
> megabyte per minute by arranging for the fs to run a commit every 50
> milliseconds, btw.

Ouch! 
> (Stephen, please review...)

Doing so now. 

> The patch teaches journal_unmap_buffer() about buffers which are on the
> committing transaction's t_locked_list.  These buffers have been written and
> I/O has completed.  

Agreed.  The key here is that the buffer is locked before
journal_unmap_buffer() is called, so we can indeed rely on it being
safely on disk.  

> We can take them off the transaction and undirty them
> within the context of journal_invalidatepage()->journal_unmap_buffer().

Right - the committing transaction can't be doing any more writes, and
the current transaction has explicitly told us to throw away its own
writes if we get here.  Unfiling the buffer should be safe.

> +		if (jh->b_jlist == BJ_Locked) {
> +			/*
> +			 * The buffer is on the committing transaction's locked
> +			 * list.  We have the buffer locked, so I/O has
> +			 * completed.  So we can nail the buffer now.
> +			 */
> +			may_free = __dispose_buffer(jh, transaction);
> +			goto zap_buffer;
> +		}

ACK.

--Stephen

