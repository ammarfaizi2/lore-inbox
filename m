Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbTEUQcW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 12:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTEUQcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 12:32:22 -0400
Received: from tmi.comex.ru ([217.10.33.92]:54441 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S262138AbTEUQcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 12:32:20 -0400
X-Comment-To: Andrew Morton
To: Andrew Morton <akpm@digeo.com>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, sct@redhat.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] probably bug in current ext3/jbd
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: Wed, 21 May 2003 20:45:33 +0000
In-Reply-To: <20030521093848.59ada625.akpm@digeo.com> (Andrew Morton's
 message of "Wed, 21 May 2003 09:38:48 -0700")
Message-ID: <87smr8c9le.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <87d6igmarf.fsf@gw.home.net>
	<1053376482.11943.15.camel@sisko.scot.redhat.com>
	<87he7qe979.fsf@gw.home.net>
	<1053377493.11943.32.camel@sisko.scot.redhat.com>
	<87addhd2mc.fsf@gw.home.net> <20030521093848.59ada625.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andrew Morton (AM) writes:

 AM> Alex Tomas <bzzz@tmi.comex.ru> wrote:
 >> 
 >> looks Andrew Morton should return BKL in ext3_get_block_handle() in -mm tree?
 >> this BKL protects ext3_alloc_branch() -> ext3_alloc_block() -> ext3_new_block()
 >> call chain. or we may implement new protection schema where each jh has some
 >> reference alike 'used by transaction N'

 AM> Can this be solved by spinlocking the relevant buffer_head, in a similar
 AM> way to your recent changes to journal_add_journal_head()?

yes, we may protect it by such lock, but this lock have to be held all time
ext3_new_block() uses some b_committed_data because last one may be freed
during current ext3_new_block(). I don't think it's good.

probably, another solution is do not free b_committed_data if it's referenced
by new transaction and make copy from b_frozen instead of freeing it.

