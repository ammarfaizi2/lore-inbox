Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbUA3TlA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 14:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbUA3TlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 14:41:00 -0500
Received: from web60506.mail.yahoo.com ([216.109.116.127]:36992 "HELO
	web60506.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263310AbUA3Tk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 14:40:58 -0500
Message-ID: <20040130194057.358.qmail@web60506.mail.yahoo.com>
Date: Fri, 30 Jan 2004 11:40:57 -0800 (PST)
From: ioana alexandrescu <ioanamitu@yahoo.com>
Subject: Redundant uses of might_sleep_if()
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel 2.6.1 it appears that the only necessary
uses of might_sleep_if()are in __alloc_pages(), and
perhaps, in cache_alloc_debugcheck_before() (see
notes).

Other uses of might_sleep_if() appear to be redundant:

Pte_chain_alloc()-->might_sleep_if(), but also
Pte_chain_alloc-->kmem_cache_alloc
  -->__cache_alloc  -->__cache_alloc()
  -->cache_alloc_debugcheck_before()
  -->might_sleep_if()

skb_share_check()-->might_sleep_if(), but also
skb_share_check()-->skb_clone()
  -->kmem_cache_alloc()[as above]

skb_unshare()-->might_sleep_if(), but also
skb_unshare()-->skb_copy()
  -->kmem_cache_alloc()[as above]

Other paths through skb_unshare, same result.


QUERY: Should these redundant uses be patched out?


Note 1: all present uses of might_sleep_if(cond)
resolve to the equivalent of might_sleep_if(gfp_mask
 & __GFP_WAIT) - which suggests an encapsulating
macro:

#define might_sleep_if_wait(flags) might_sleep_if\
(flags & __GFP_WAIT)

Note 2: preliminary analysis suggests that even
  cache_alloc_debugcheck_before()-->might_sleep_if()
is, strictly speaking, unnecessary since the same
check in performed in __alloc_pages().  Of course the
duplicated check doesn't cost much.

Carl Spalletta
--
See New Jersey and die!


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free web site building tool. Try it!
http://webhosting.yahoo.com/ps/sb/
