Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269352AbUI3RGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269352AbUI3RGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 13:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269357AbUI3RGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 13:06:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30898 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269352AbUI3RFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 13:05:01 -0400
Subject: Re: [Patch 0/10]: Cleanup online reservations for 2.6.9-rc2-mm4.
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <415C2DA4.5080102@colorfullife.com>
References: <415C2DA4.5080102@colorfullife.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1096563886.1977.262.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Sep 2004 18:04:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2004-09-30 at 17:00, Manfred Spraul wrote:

> >Locking
> >is minimised: the impact on the hot path consists of nothing more than
> >an smp_rmb() before we test sb->s_groups_count.  That's a noop on x86,
> >
> No, wrong way around:
> wmb() is empty. rmb() is either lfence or a locked dummy instruction.

Hmm.  But I'm still not sure we can get away with anything
lighter-weight.

The basic construct we need to worry about is:

	new_group_table = kmalloc(...);
	memcpy(new_group_table, old_group_table);
	new_group_table[new_group] = foo;
	sbi->s_group_desc = new_group_table;
	/* SMP WRITE BARRIER */
	sbi->s_group_count = new_group_count;

on the writer side, and

	ngroups = sbi->s_group_count;
	/* SMP READ BARRIER */
	for (i = 0; i < ngroups; i++)
		gdp = sbi->s_group_desc[i];

The latter is the worry --- we're doing a read that depends immediately
on "i" and s_group_desc, but not on sbi->s_group_count.  There *IS* a
comparison between i and s_group_count, though, so the dependency is
implicit.  

I'm just not familiar enough with the architecture of weakly-ordered
platforms to know if we can get away with smp_read_barrier_depends() in
this particular case.  If so, we can use that and be done with the extra
locked op on x86.

--Stephen

