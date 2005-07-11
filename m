Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVGKSr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVGKSr4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 14:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVGKSpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 14:45:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54484 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261308AbVGKSpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 14:45:07 -0400
Subject: Re: [PATCH] Fix JBD race in t_forget list handling
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050711153415.GP12428@atrey.karlin.mff.cuni.cz>
References: <20050711153415.GP12428@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1121107489.1871.226.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 11 Jul 2005 19:44:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-07-11 at 16:34, Jan Kara wrote:

>   attached patch should close the possible race between
> journal_commit_transaction() and journal_unmap_buffer() (which adds
> buffers to committing transaction's t_forget list) that could leave
> some buffers on transaction's t_forget list (hence leading to an
> assertion failure later when transaction is dropped). The patch is
> against 2.6.13-rc2 kernel.  The race was really happening to David Wilk
> <davidwilk@gmail.com> (thanks for testing) so please apply if you find
> the patch correct.

Indeed we can be adding to the committing transaction's t_forget list
here.  The fix looks correct: we're taking the j_list_lock anyway in
that loop for the checkpoint processing, so we're not taking it any more
frequently by grabbing it for the loop condition itself too --- just
holding it a little longer.

--Stephen

