Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265863AbUFTJq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265863AbUFTJq4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 05:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265865AbUFTJq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 05:46:56 -0400
Received: from mail.aknet.ru ([217.67.122.194]:267 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S265863AbUFTJqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 05:46:53 -0400
Message-ID: <40D55D13.20803@aknet.ru>
Date: Sun, 20 Jun 2004 13:46:59 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Rohland <cr@sap.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch][rfc] expandable anonymous shared mappings
References: <Pine.LNX.4.44.0406200048490.29576-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0406200048490.29576-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Hugh Dickins wrote:
>> I disagree with this. The way I am using it may look horrible,
>> but yes, I do use it without the fork().
> Then I think you have no reason to use MAP_SHARED: use MAP_PRIVATE
> and you should get the behaviour you require, without kernel change.
Hugh, I think you misunderstood me because
once again I wrote something, said nothing -
happens to me sometimes.
The trick is that I am setting the old_len arg
of mremap() to 0. This means that the new mapping
is created while the old one is *not* being
destroyed. So I get multiple virtual memory
areas referencing the same shared memory region,
lets call them "aliases".
You propose to share the same backing-store
across the multiple processes. Instead, I am
sharing it across the multiple memory areas
of a single process. I can't use MAP_PRIVATE
for that, really.
Then I want to expand my initial pool of shared
mem while preserving the already created "aliases",
and there seems to be no way of doing that:
creating the larger pool and mremap'ing old
one to the beginning of the new one, leaves the
VMAs unmerged; creating the larger pool and
mamcpy() the content of the old one to it,
doesn't preserve the already created "aliases".
The only thing I can do, is to expand the
initial pool with mremap(), which doesn't work.
So I have to resort to the more heavyweight
things like shm_open(), while otherwise the
expandable anonymous shared mapping can suit
very well for my needs.

> Shared anonymous is peculiar: although mapping is anonymous (nothing
> shared with unrelated mms), modifications are shared between parent
> and children.  It's half-way between anonymous and file-backed.
> We agree that it might be nice to let the object used to support that
> be extended if mremap extends the mapping.  But it might instead just
> be needless feature creep. 
But then I beleive the entire idea of anonymous
shared mapping is also a crap. But since it is
already there, I would like to have it fully
functional, so that I can avoid the things like
shm_open() when possible. I just don't see the
reason of keeping something partially implemented.

> Sorry, your case does not persuade me yet.
Well, I beleive perhaps you missed the fact
that I was setting the old_len to 0 in mremap(),
which doesn't work as I want to, when you use
MAP_PRIVATE.
You'll probably call it a horrible hack, but
here's where that technique comes from:
http://www.ussg.iu.edu/hypermail/linux/kernel/0401.1/1351.html
And since it comes from here, I beleive it
must be fully supported.

