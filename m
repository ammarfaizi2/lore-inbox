Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUDBBB6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUDBBB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:01:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:11748 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263015AbUDBBBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:01:54 -0500
Date: Thu, 1 Apr 2004 17:04:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: Properly stop kernel threads on aic7xxx
Message-Id: <20040401170403.76d86432.akpm@osdl.org>
In-Reply-To: <20040402003520.GH18585@dualathlon.random>
References: <20040401170808.GA696@elf.ucw.cz>
	<20040402003520.GH18585@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> I'm also unsure why _all_ multipage allocations really need this
> compound thing setup and why can't the owner of the page take care of
> the refcounting itself by always using the head page. I may actually
> add a GFP bitflag asking for a multipage but w/o a compound setup. There
> are million ways to fix this, none of which is obvious.

For direct-io into higher-order pages.  When doing direct-io into a hugetlb
page we need to make sure that get_user_pages() pins the correct pageframe.

Possibly we need to turn it on regardless of CONFIG_HUGETLBPAGE for people
who want to do direct-io or PEEKTEXT/POKETEXT into mmapped soundcard
buffers, for example.  Perhaps there's a race which could permit direct-io
to write to a freed page via this route..

Davem had some reason why he might want to turn on the compound logic
permanently - related to TCP access to/from higher-order pages, I think.
