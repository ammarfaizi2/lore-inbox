Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261942AbTCQWFJ>; Mon, 17 Mar 2003 17:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261943AbTCQWFJ>; Mon, 17 Mar 2003 17:05:09 -0500
Received: from packet.digeo.com ([12.110.80.53]:39356 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261942AbTCQWFI>;
	Mon, 17 Mar 2003 17:05:08 -0500
Date: Mon, 17 Mar 2003 14:05:06 -0800
From: Andrew Morton <akpm@digeo.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: wind@cocodriloo.com, riel@surriel.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4 vm, program load, page faulting, ...
Message-Id: <20030317140506.686282a5.akpm@digeo.com>
In-Reply-To: <m3hea2gcoz.fsf@lexa.home.net>
References: <20030317151004.GR20188@holomorphy.com>
	<Pine.LNX.4.44.0303171100300.2571-100000@chimarrao.boston.redhat.com>
	<20030317165223.GA11526@wind.cocodriloo.com>
	<m3hea2gcoz.fsf@lexa.home.net>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Mar 2003 22:10:53.0986 (UTC) FILETIME=[13D5C820:01C2ECD2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> wrote:
>
>  w> You should ask Andrew about his patch to do exactly that: he
>  w> forced all PROC_EXEC mmaps to be nonlinear-mapped and this forced
>  w> all programs to suck entire binaries into memory...  I recall he
>  w> saw at least 25% improvement at launching gnome.
> 
> they talked about pages _already present_ in pagecache.

2.5.64-mm8 does that too.  At mmap-time it will, for a PROT_EXEC mapping,
pull every affected page off disk and it will instantiate pte's against
them all via install_page().

So there should be zero major and minor faults against that mmap region
during application startup.

The improved IO layout appears to halve startup time for big things.  I
haven't attempted to instrument the effects of the reduced minor fault rate. 
If indeed the rate _has_ decreased.  If it hasn't, it's a bug...



This is all a bit dubious for several reasons.  Most particularly, the
up-front instantiation of the pages in pagetables makes unneeded pages harder
to reclaim.  It would be really neat if someone could try putting the
madvise(MADV_WILLNEED) into glibc and test that.  Maybe on a 2.4 kernel.


