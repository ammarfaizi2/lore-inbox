Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270066AbTHBSiM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 14:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270081AbTHBSiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 14:38:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:1427 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270066AbTHBSiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 14:38:10 -0400
Date: Sat, 2 Aug 2003 11:39:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: oxymoron@waste.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [1/2] random: SMP locking
Message-Id: <20030802113907.30e1d001.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0308020832520.3473@montezuma.mastecende.com>
References: <20030802042445.GD22824@waste.org>
	<20030802040015.0fcafda2.akpm@osdl.org>
	<Pine.LNX.4.53.0308020832520.3473@montezuma.mastecende.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>
> Perhaps might_sleep() in *_user, copy_* etc is in order?

Probably, with a little care.

A userspace copy while in an atomic region is actually legal, on behalf of
the read() and write() pagecache copy functions: if we take a fault while
holding an atomic kmap, the fault handler bales and the usercopy returns a
short copy.

In other words: if you stick a might_sleep() in __copy_from_user() and
__copy_to_user() you get a false positive on every read() and write().

We could probably add it to copy_to_user() and copy_from_user() though.
