Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263402AbTL2MuG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 07:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbTL2MuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 07:50:06 -0500
Received: from holomorphy.com ([199.26.172.102]:47550 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263402AbTL2Mtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 07:49:51 -0500
Date: Mon, 29 Dec 2003 04:49:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, mfedyk@matchmail.com,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Anton Ertl <anton@mips.complang.tuwien.ac.at>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, phillips@arcor.de
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
Message-ID: <20031229124927.GZ22443@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
	mfedyk@matchmail.com, "Eric W. Biederman" <ebiederm@xmission.com>,
	Anton Ertl <anton@mips.complang.tuwien.ac.at>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	phillips@arcor.de
References: <Pine.LNX.4.58.0312271245370.2274@home.osdl.org> <m1smj596t1.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0312272046400.2274@home.osdl.org> <20031228163952.GQ22443@holomorphy.com> <20031229003631.GE1882@matchmail.com> <20031229025507.GT22443@holomorphy.com> <Pine.LNX.4.58.0312282000390.11299@home.osdl.org> <20031229065240.GU22443@holomorphy.com> <20031229084304.GA31630@elte.hu> <20031229120930.GA31941@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031229120930.GA31941@elte.hu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* William Lee Irwin III <wli@holomorphy.com> wrote:
> > I did get a positive reaction from you at KS, and I've also been
>> slaving away at keeping this thing current and improving it when I can
>> for a year. Would you mind telling me what the Hell is going on here?
>> I guess I already know I'm screwed beyond all hope of recovery, but I
>> might as well get official confirmation.

On Mon, Dec 29, 2003 at 01:09:30PM +0100, Ingo Molnar wrote:
> i've been following your code (pgcl) and it looks pretty good. (it needs
> finishing touches as always, but that's fine.) I tried to backport it to
> 2.4 before doing 4G/4G but the maintainance overhead skyrocketed and so
> it not practical for 2.4-based distribution purposes - but it would be
> the perfect kind of thing to start 2.7.0 with. I've not seen any other
> code but yours in this area.

That's a rather kind assessment; I suppose I hold flaws not critical at
the design level as fatal where those who look primarily at design don't.


On Mon, Dec 29, 2003 at 01:09:30PM +0100, Ingo Molnar wrote:
> i believe the right approach to the 'tons of RAM' problem is to simplify
> it as much as possible, ie. go for larger pages (and wrap the MMU format
> in the most trivial way) and to deal with 4K pages as a filesystem (and
> ELF format) compatibility thing only. Your patch does precisely this.
> How much we'll have to 'mix' the two page sizes, only practice will
> tell, but the less mixing, the easier it will get. Filesystems on such
> systems will match the pagesize anyway.

Well, that's more or less consistent with what I'm I'm doing. In
actuality it's Hugh's design and original implementation, but I'm going
to have to claim _some_ credit for the work I've put into this at some
point, though it be grunt work after a fashion.

The nontrivial point is largely ABI compatibility. A tremendous amount
of diff could be eliminated without ABI compatibility; however, the
concern is rather critical as long as legacy binaries are involved.


On Mon, Dec 29, 2003 at 01:09:30PM +0100, Ingo Molnar wrote:
> i'd even suggest to not overdo the fractured-page logic too much - ie.
> just 'waste' a full page on a misaligned or single 4K-sized vma -
> concentrate on the common case: linearly mapped files and anonymous
> mappings. Prefault both of them at PAGE_SIZE granularity and 'waste' the
> final partial page. The VM swapout logic should only deal with full
> pages. Same for the pagecache: just fill in full pages and dont worry
> about granularity.
> Your patch already does more than this. But i think if someone does 4K
> vmas on a pgcl system or runs it on a 128 MB box and expects perfect
> swapping, then it's his damn fault.

My reasoning here has actually been dominated by performance. Exchanging
the logic for this task is actually a difficult enough operation with
respect to programming that very few a priori concerns can be allowed
any influence at all.

The algorithm now used for fault handling, recently ported by brute
force from Hugh's rather ancient sources, effectively does as you say
(though there is a lot of latitude in the criterion you've stated).
One risk I've taken is updating some API's to return pfn's instead of
pages. In the case of get_user_pages() this is likely essential. But
kmap_atomic_to_page() (to_pfn() in my sources) and some others might
be able to be avoided entirely with some moderately traumatic rework
(traumatic as far as work I have to do is concerned; in all honesty,
the issue is stupid, but as a problem it makes up for the lack of
difficulty owing to quality with that owed to vast quantities of
debugging and intolerance to dumb C mistakes.) The methods you're
suggesting suggest removing these changes in exchange for some
potential inefficiencies with virtualspace consumption, though these
are not entirely out of the question, as ia32 is effectively deprecated.


-- wli
