Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267186AbUFZQqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbUFZQqM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 12:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267188AbUFZQqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 12:46:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:52879 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267186AbUFZQqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 12:46:11 -0400
Date: Sat, 26 Jun 2004 09:44:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       PARISC list <parisc-linux@lists.parisc-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix the cpumask rewrite
In-Reply-To: <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0406260934310.14449@ppc970.osdl.org>
References: <1088266111.1943.15.camel@mulgrave> <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Jun 2004, Linus Torvalds wrote:
> 
> Why not? The thing is, the bitmap operators are supposed to work on 
> volatile data, ie people are literally using them for things like
> 
> 	while (test_bit(TASKLET_STATE_SCHED, &t->state));

Ahh. That one is part of a "do while ()" loop, and grep mis-identifies it. 
So parisc gets it right, because the whole loop is

	do
		yield();
	while (test_bit(TASKLET_STATE_SCHED, &t->state));

so at least the compiler didn't get to optimize it away.

Hopefully we don't have any other busy loops either - even if it is a busy
loop, we should have a "cpu_relax()" or something there just to keep power
levels down, and that should also tell the compiler not to do anything
silly. But the conceptual point stands.

		Linus
