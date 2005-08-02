Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVHBEZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVHBEZY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 00:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVHBEZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 00:25:24 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:34151 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261362AbVHBEZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 00:25:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=rJ5bY3rPSdiWpVZxs6CiJ0nlLoZw89xGwPno/ZFTU6KqMdjdjs97y4ZOrhjqTX/zJ22efPG1vD3pwdLOOaIV5rEZaGzm2NOTd58bZp/YzZHlTtHFZorDXgFXddYUnLTYSbSBekcZVighyW5ph4oOLXyw1Ku2+RYi3DoQB4BztrQ=  ;
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Robin Holt <holt@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Roland McGrath <roland@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0508012039120.3341@g5.osdl.org>
References: <20050801032258.A465C180EC0@magilla.sf.frob.com>
	 <42EDDB82.1040900@yahoo.com.au>
	 <Pine.LNX.4.58.0508010833250.14342@g5.osdl.org>
	 <42EECC1F.9000902@yahoo.com.au>
	 <Pine.LNX.4.58.0508012039120.3341@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 14:25:13 +1000
Message-Id: <1122956713.6338.19.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 20:45 -0700, Linus Torvalds wrote:
> 
> On Tue, 2 Aug 2005, Nick Piggin wrote:
> > 
> > Surely this introduces integrity problems when `force` is not set?
> 
> "force" changes how we test the vma->vm_flags, that was always the 
> meaning from a security standpoint (and that hasn't changed).
> 

Of course, this test catches the problem I had in mind.

> The old code had this "lookup_write = write && !force;" thing because
> there it used "force" to _clear_ the write bit test, and that was what
> caused the race in the first place - next time around we would accept a
> non-writable page, even if it hadn't actually gotten COW'ed.
> 
> So no, the patch doesn't introduce integrity problems by ignoring "force".  
> Quite the reverse - it _removes_ the integrity problems by ignoring it
> there. That's kind of the whole point.
> 

OK, I'm convinced. One last thing - your fix might have a non
trivial overhead in terms of spin locks and simply entering the
high level page fault handler when dealing with clean, writeable
ptes for write.

Any chance you can change the __follow_page test to account for
writeable clean ptes? Something like

	if (write && !pte_dirty(pte) && !pte_write(pte))
		goto out;

And then you would re-add the set_page_dirty logic further on.

Not that I know what Robin's customer is doing exactly, but it
seems like something you can optimise easily enough.

Nick

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
