Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261648AbSI0ICy>; Fri, 27 Sep 2002 04:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261652AbSI0ICx>; Fri, 27 Sep 2002 04:02:53 -0400
Received: from n13.sp.op.dlr.de ([129.247.25.4]:40601 "EHLO n13.sp.op.dlr.de")
	by vger.kernel.org with ESMTP id <S261648AbSI0ICw>;
	Fri, 27 Sep 2002 04:02:52 -0400
Message-ID: <3D941150.8060409@dlr.de>
Date: Fri, 27 Sep 2002 10:05:36 +0200
From: Martin Wirth <Martin.Wirth@dlr.de>
Reply-To: Martin.Wirth@dlr.de
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.0.0) Gecko/20020611
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] 'sticky pages' support in the VM, futex-2.5.38-C5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar  <mingo@elte.hu> wrote:
 > sigh. And we cannot even properly detect which unpin_page() was the last
 > unpinning of the page - there can be so many other reasons a page's count
 > is elevated. And keeping a page sticky forever is no solution either, the
 > number of sticky pages would increase significantly, causing real fork()
 > problems.

Maybe you can resurrect your approach by using a sticky counter instead of a flag.
If there are really that many unused fields in struct page for the case considered
here this should be possible.

But another point: what happens if  get_user_pages (and the sticky-setting)
is called after the fork completed? If there was no write access to the
page between the fork and the futex call you may get the same race.

More general this seems not be a futex problem, but a general inconsistancy
between COW and page pinning by get_user_pages. You may get similar races if
you pin pages to do zero copy DMA on COWed pages. The bus-master device then
maybe transfers data to a child's page instead of a parent page (if someone write
touched the page between the call to get_user_pages and DMA completion).

One solution would be to force get_user_pages and copy_page_range
to replace a page marked for COW before handling it (of couse only on demand).

Martin

