Return-Path: <linux-kernel-owner+w=401wt.eu-S964913AbWLMCbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWLMCbX (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 21:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWLMCbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 21:31:22 -0500
Received: from pat.uio.no ([129.240.10.15]:60136 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964907AbWLMCbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 21:31:21 -0500
Subject: Re: Status of buffered write path (deadlock fixes)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Mark Fasheh <mark.fasheh@oracle.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@google.com>
In-Reply-To: <457F5DD8.3090909@yahoo.com.au>
References: <45751712.80301@yahoo.com.au>
	 <20061207195518.GG4497@ca-server1.us.oracle.com>
	 <4578DBCA.30604@yahoo.com.au>
	 <20061208234852.GI4497@ca-server1.us.oracle.com>
	 <457D20AE.6040107@yahoo.com.au> <457D7EBA.7070005@yahoo.com.au>
	 <20061212223109.GG6831@ca-server1.us.oracle.com>
	 <457F4EEE.9000601@yahoo.com.au>
	 <1165974458.5695.17.camel@lade.trondhjem.org>
	 <457F5DD8.3090909@yahoo.com.au>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 21:31:04 -0500
Message-Id: <1165977064.5695.38.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.431, required 12,
	autolearn=disabled, AWL 2.43, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 12:56 +1100, Nick Piggin wrote:
> Note that these pages should be *really* rare. Definitely even for normal
> filesystems I think RMW would use too much bandwidth if it were required
> for any significant number of writes.

If file "foo" exists on the server, and contains data, then something
like

fd = open("foo", O_WRONLY);
write(fd, "1", 1);

should never need to trigger a read. That's a fairly common workload
when you think about it (happens all the time in apps that do random
write).

> I don't want to mandate anything just yet, so I'm just going through our
> options. The first two options (remove, and RMW) are probably trickier
> than they need to be, given the 3rd option available (temp buffer). Given
> your input, I'm increasingly thinking that the best course of action would
> be to fix this with the temp buffer and look at improving that later if it
> causes a noticable slowdown.

What is the generic problem you are trying to resolve? I saw something
fly by about a reader filling the !uptodate page while the writer is
updating it: how is that going to happen if the writer has the page
locked?
AFAIK the only thing that can modify the page if it is locked (aside
from the process that has locked it) is a process that has the page
mmapped(). However mmapped pages are always uptodate, right?

Trond

