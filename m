Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTL2MJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 07:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbTL2MJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 07:09:13 -0500
Received: from mx2.elte.hu ([157.181.151.9]:37325 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263376AbTL2MJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 07:09:07 -0500
Date: Mon, 29 Dec 2003 13:09:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@osdl.org>, mfedyk@matchmail.com,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Anton Ertl <anton@mips.complang.tuwien.ac.at>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, phillips@arcor.de
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
Message-ID: <20031229120930.GA31941@elte.hu>
References: <2003Dec27.212103@a0.complang.tuwien.ac.at> <Pine.LNX.4.58.0312271245370.2274@home.osdl.org> <m1smj596t1.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0312272046400.2274@home.osdl.org> <20031228163952.GQ22443@holomorphy.com> <20031229003631.GE1882@matchmail.com> <20031229025507.GT22443@holomorphy.com> <Pine.LNX.4.58.0312282000390.11299@home.osdl.org> <20031229065240.GU22443@holomorphy.com> <20031229084304.GA31630@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031229084304.GA31630@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin ELTE 1.0
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Lee Irwin III <wli@holomorphy.com> wrote:

> I also heard something about this from daniel. The description I was
> given implied rather different functionality, and raised rather
> serious questions about the implementation he didn't have adequate
> answers for. I also never saw code, despite months of occasional
> discussions about it.
> 
> I did get a positive reaction from you at KS, and I've also been
> slaving away at keeping this thing current and improving it when I can
> for a year. Would you mind telling me what the Hell is going on here?
> 
> I guess I already know I'm screwed beyond all hope of recovery, but I
> might as well get official confirmation.

i've been following your code (pgcl) and it looks pretty good. (it needs
finishing touches as always, but that's fine.) I tried to backport it to
2.4 before doing 4G/4G but the maintainance overhead skyrocketed and so
it not practical for 2.4-based distribution purposes - but it would be
the perfect kind of thing to start 2.7.0 with. I've not seen any other
code but yours in this area.

i believe the right approach to the 'tons of RAM' problem is to simplify
it as much as possible, ie. go for larger pages (and wrap the MMU format
in the most trivial way) and to deal with 4K pages as a filesystem (and
ELF format) compatibility thing only. Your patch does precisely this.
How much we'll have to 'mix' the two page sizes, only practice will
tell, but the less mixing, the easier it will get. Filesystems on such
systems will match the pagesize anyway.

i'd even suggest to not overdo the fractured-page logic too much - ie.
just 'waste' a full page on a misaligned or single 4K-sized vma -
concentrate on the common case: linearly mapped files and anonymous
mappings. Prefault both of them at PAGE_SIZE granularity and 'waste' the
final partial page. The VM swapout logic should only deal with full
pages. Same for the pagecache: just fill in full pages and dont worry
about granularity.

Your patch already does more than this. But i think if someone does 4K
vmas on a pgcl system or runs it on a 128 MB box and expects perfect
swapping, then it's his damn fault.

	Ingo
