Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbVL3SqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbVL3SqL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 13:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbVL3SqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 13:46:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61654 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751279AbVL3SqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 13:46:10 -0500
Date: Fri, 30 Dec 2005 10:46:06 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 10 of 20] ipath - core driver, part 3 of 4
In-Reply-To: <c37b118ef80698acc4eb.1135816289@eng-12.pathscale.com>
Message-ID: <Pine.LNX.4.64.0512301043290.3249@g5.osdl.org>
References: <c37b118ef80698acc4eb.1135816289@eng-12.pathscale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



All your user page lookup/pinning code is terminally broken.

You can't do it that way. You have serveral major conceptual bugs, like 
keeping track of pages without incrementing their page count, and just 
expecting that they are magically "pinned" even you do nothing at all to 
pin them. The process exits or does an munmap, and the page will be used 
for something else, and you'll just corrupt totally random memory.

Similarly, you do page_address() on the page, which just can't work on 
highmem pages.

Crap like this must not be merged. Drivers aren't supposed to play VM 
tricks in the first place - even if they were to get it right (which they 
never do). Don't do it.

		Linus
