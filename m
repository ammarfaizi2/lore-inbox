Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267650AbUIJQ6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267650AbUIJQ6B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 12:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267646AbUIJQyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 12:54:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45706 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267666AbUIJQxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 12:53:48 -0400
Subject: ext2/3: Incomplete/buggy use of s_debts in Orlov
From: "Stephen C. Tweedie" <sct@redhat.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Stephen Tweedie <sct@redhat.com>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1094834989.2047.171.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Sep 2004 17:49:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've been tidying up the online resize code for -mm and come across one
nasty item.  The s_debts array is the only dynamic, fs-sized array in
the entirety of ext2/3, so it's the only dynamic array we need to grow
when we resize.

But to get the locking for that right, we need to know what the locking
for s_debts is in the first place.  Looking at that I found two rather
odd things:

On ext2, s_debts is modified with only the per-group lock:

	spin_lock(sb_bgl_lock(sbi, group));
	if (S_ISDIR(mode)) {
		if (sbi->s_debts[group] < 255)
			sbi->s_debts[group]++;

where s_debts is defined as

	u8 *s_debts;

in the superblock.  That was OK when we had a global lock_super(sb)
round every allocation, but it's extremely dangerous to perform byte
accesses like this when the rest of the memory word is shared with other
CPUs.  It certainly risks word-tearing on machines like Alpha; I think
it's theoretically unsafe even on x86.

On ext3, the situation is actually much simpler:

s_debts is never modified at all.

Ever.

It's allocated, carefully checked, then freed.  But never modified.  

Now, that's fine with me --- it makes the locking for s_debts *really*
easy to get right. :-)   And in my current resize patches, I just nuke
s_debts entirely.  

But if anybody thinks it really needs to stay, then a Plan B is
required, and we probably need to start off by fixing the locking in
ext2 itself.

--Stephen

