Return-Path: <linux-kernel-owner+w=401wt.eu-S932315AbXAISBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbXAISBu (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 13:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbXAISBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 13:01:50 -0500
Received: from smtp.osdl.org ([65.172.181.24]:57672 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932315AbXAISBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 13:01:48 -0500
Date: Tue, 9 Jan 2007 09:58:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       =?ISO-8859-1?Q?Malte_Schr=F6der?= <MalteSch@gmx.de>,
       reiserfs-dev@namesys.com
Subject: Re: 2.6.20-rc4: known unfixed regressions (v2)
In-Reply-To: <20070109052510.GG25007@stusta.de>
Message-ID: <Pine.LNX.4.64.0701090944070.3594@woody.osdl.org>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
 <20070109052510.GG25007@stusta.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-559746376-1168365499=:3594"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-559746376-1168365499=:3594
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Tue, 9 Jan 2007, Adrian Bunk wrote:
> 
> Subject : BUG: at mm/truncate.c:60 cancel_dirty_page()  (reiserfs) 
> References : http://lkml.org/lkml/2007/1/7/117
> Submitter : Malte Schröder <MalteSch@gmx.de>
> Status : unknown

Adrian, this is also available as

	http://lkml.org/lkml/2007/1/5/308

But, at worst, I don't think this is a show-stopper (oh, well: I actually 
liked it better when "WARN_ON()" said _warning_, not BUG, since it 
separates out the two cases visually much better, but others disagreed. 
Crud).

It does show that something is wrong in reiserfs-land, although probably 
not any worse than it ever was before, so in that sense this is not a 
"regression", it's actually an _improvement_. Now it warns about reiserfs 
trying to clear the dirty bit on a page cache that is still mapped (and 
that _may_ be dirty in the page tables, although it almost certainly isn't 
in practice).

That warning just didn't exist before.

Now, that said, the call stack is interestign:

	BUG: at mm/truncate.c:60 cancel_dirty_page()
	  [<c0137371>] cancel_dirty_page+0x45/0x7b
	  [<df944b18>] reiserfs_cut_from_item+0x7cc/0x7fd [reiserfs]
	  [<c01e5eba>] __kfree_skb+0x9b/0xf7
	  [<df9316a0>] make_cpu_key+0x3f/0x46 [reiserfs]
	  [<df944efa>] reiserfs_do_truncate+0x3b1/0x515 [reiserfs]
	  [<df949901>] journal_begin+0x3f/0xd0 [reiserfs]
	  [<df9322fc>] reiserfs_truncate_file+0x1c1/0x2ad [reiserfs]
	  [<df938172>] reiserfs_file_release+0x35f/0x379 [reiserfs]
	  [<c013be42>] free_pgtables+0x70/0x7c
	  [<c01491f1>] __fput+0xa5/0x14d
	  [<c0146e7a>] filp_close+0x51/0x58
	  [<c0147de8>] sys_close+0x55/0x8a
	  [<c0102ab2>] sysenter_past_esp+0x5f/0x85

in that a final "sys_close()" that releases the file and causes it to be 
truncated (which is apparently what is going on) should NOT have any 
mappings of that file active any more!

If there are mappings active, the reiserfs_truncate_file() thing should 
have been delayed until the mappins are gone!

So something interesting is definitely going on, but I don't know exactly 
what it is. Why does reiserfs do the truncate as part of a close, if the 
same inode is actually mapped somewhere else? And if it's a race with two 
different CPU's (one doing a "munmap()" and the other doing a "close()", 
then the unmap should _still_ have actually unmapped the pages before it 
actually did _its_ "release()" call.

In general, a filesystem should never do a truncate at "release()" time 
_anyway_. It should do it at "drop_inode" time.

So I think this does show some confusion in reiserfs, but it's not 
anything new. The only new thing is that the _message_ happens.

So I don't personally consider this a regression. Just a sign of old and 
preexisting confusion that is now uncovered by new code (and it will print 
out the scary message at most four times, and then stop complaining about 
it. So apart from the scary message, nothing new and bad has really 
happened).

		Linus
---1463790079-559746376-1168365499=:3594--
