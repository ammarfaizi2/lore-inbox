Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVCGVn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVCGVn4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 16:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVCGV2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 16:28:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44433 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261582AbVCGVI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:08:29 -0500
Subject: Re: [RFC] ext3/jbd race: releasing in-use journal_heads
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050307123118.3a946bc8.akpm@osdl.org>
References: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050304160451.4c33919c.akpm@osdl.org>
	 <1110213656.15117.193.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050307123118.3a946bc8.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110229687.15117.612.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 07 Mar 2005 21:08:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-03-07 at 20:31, Andrew Morton wrote:

> jbd_lock_bh_journal_head() is supposed to be a
> finegrained innermost lock whose mandate is purely for atomicity of adding
> and removing the journal_head and the b_jcount refcounting.  I don't recall
> there being any deeper meaning than that.

> It could be that we can optimise jbd_lock_bh_journal_head() away, as you
> mention.  If we have an assertion in there to check that
> jbd_lock_bh_state() is held...

Right, that was what I was thinking might be possible.  But for now I've
just done the simple patch --- make sure we don't clear
jh->b_transaction when we're just refiling buffers from one list to
another.  That should have the desired effect here without dangerous
messing around with locks.

I'm having trouble testing it, though --- I seem to be getting livelocks
in O_DIRECT running 400 fsstress processes in parallel; ring any bells? 
I get it with today's bk tree without any ext3 changes too, so at least
it's not a regression.

--Stephen

