Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUKVQr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUKVQr7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbUKVQpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:45:49 -0500
Received: from holomorphy.com ([207.189.100.168]:35482 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262138AbUKVQfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 11:35:12 -0500
Date: Mon, 22 Nov 2004 08:34:56 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Compound page overhaul
Message-ID: <20041122163456.GH2714@holomorphy.com>
References: <20041122144127.GE2714@holomorphy.com> <11948.1101130077@redhat.com> <14391.1101139626@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14391.1101139626@redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> There are a lot of ways to do these things. Most of it is bitpacking
>> and dodging assumptions in other code about various fields always being
>> something or other they expect (e.g. bh's vs. page->private).

On Mon, Nov 22, 2004 at 04:07:06PM +0000, David Howells wrote:
> I want to avoid putting magic numbers in page->private. What goes in there
> could be anything, as it's up to the filesystem.
> Do you have any preferences? I'd prefer to use page->mapping, I think, except
> that's used for the destructor.
> I should probably make a set-destructor function for hugetlbfs to call.

That would help. I didn't look closely at the interaction with hugetlbfs
owing to limited attention.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> A generally innocuous rearrangement. Some explanation of the advantage
>> of these new bitpacking and field arrangements over the current
>> arrangement may be good to have.

On Mon, Nov 22, 2004 at 04:07:06PM +0000, David Howells wrote:
> The only differences are:
>  (1) PG_compound_slave now exists.
>  (2) I'm permitting the owner of the page to do do what it will with
>      page->private on the first page.

Freeing up page->private is helpful, true.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> Also, there's a commonly-used term in the superpage literature, ``head of
>> the superpage'', that may be more easily recognizable for readers familiar
>> with that but not Linux specifics, but that's just nomenclature and not
>> particularly pressing or any kind of requirement, just a non-Linux
>> precedent.

On Mon, Nov 22, 2004 at 04:07:06PM +0000, David Howells wrote:
> I couldn't think of a good name for it, so I settled on it being the first
> page.
> How about page_head()?

I held up the precedent because I sensed an afterthought. It would
handle the underscores, too. =)


William Lee Irwin III <wli@holomorphy.com> wrote:
>> __GFP_COMP was introduced because several unusual drivers allocate
>> higher-order pages and then move on to free fragments of them. There's
>> a small danger some others may allocate higher-order pages and then
>> treat each piece as a separate entity (particularly in the freeing pass).
>> Sweeping affected drivers to use a fragmenting primitive may help here.

On Mon, Nov 22, 2004 at 04:07:06PM +0000, David Howells wrote:
> I wasn't aware of that. Looking at the mm code, doing a fragmentary release
> would cause bad_page() to be invoked. Presumably these drivers modify the
> various struct pages involved directly to keep the allocator happy.
> It would be better, I think, to provide a page splitter function. Thus
> allowing pages to be cut in half, and then have the two halves made into the
> equivalent allocated pages.
> Do you know which drivers?

I seem to remember something like acornfb, but I don't not the others.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> Possible, but it's likely a micro-optimization to cache the order in
>> registers across function calls. The allocator is something of a ``hot
>> path'' and small alterations can have noticeable effects.

On Mon, Nov 22, 2004 at 04:07:06PM +0000, David Howells wrote:
> Yes... but the order gets examined anyway in the free page checker, and the
> second plus page structs get modified too, so I don't think it'll make much of
> a difference. Plus the filesystem or driver that owned the page won't need to
> keep track of the size, nor will it need to calculate it.

Bringing in something like that as proof it removes instructions etc.
should do the trick.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> I like this quite a bit. =)

On Mon, Nov 22, 2004 at 04:07:06PM +0000, David Howells wrote:
> 	(defun trim ()
> 	  "Delete trailing whitespace in buffer"
> 	  (interactive)
> 	  (save-excursion
> 	    (goto-char (point-min))
> 	    (replace-regexp "[ \t\r]+$" "")
> 	    (goto-char (point-max))
> 	    (skip-chars-backward "\n")
> 	    (if (not (eobp))
> 		(delete-region (1+ (point)) (point-max)))))

I'm not much of an EMACS fan. I can do similar things with other tools.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> Clearly it could merely scan the bitmap for the largest properly-sized,
>> properly-aligned leading run of free bits beyond even that, though I
>> wouldn't expect you to pursue that as it's far beyond the scope of the
>> patch. I was hit up to deal with bootmem.c issues, and will be looking
>> into that and more after the current set of bootmem changes has settled
>> down and ia64 bootstrap has been stable for a while.

On Mon, Nov 22, 2004 at 04:07:06PM +0000, David Howells wrote:
> I may look at doing this after this patch (or similar) goes in. If
> so, I'll send you the patch.

By all means.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> (2) The physaddr alignment comment in bootmem.c is mangled. It's not
>> 	O(LOG2(BITS_PER_LONG)) -aligned, it's exactly LOG2(BITS_PER_LONG)
>> 	aligned. But we don't have a LOG2(...) macro, we have fls()/ffs().

On Mon, Nov 22, 2004 at 04:07:06PM +0000, David Howells wrote:
> I suspect that's meant to be mathematical notation, not strictly compilable
> code, though I think there may be a missing "if" in it.

The specific choice of mathematical notation actually makes the whole
thing meaningless. It really is meant to denote a specific value.

http://planetmath.org/encyclopedia/LandauNotation.html
http://mathworld.wolfram.com/LandauSymbols.html
http://www.nist.gov/dads/HTML/bigOnotation.html
http://en.wikipedia.org/wiki/Big_O_notation
http://encyclopedia.thefreedictionary.com/Landau%20symbol


William Lee Irwin III <wli@holomorphy.com> wrote:
>> (3) page_count() probably deserves the %0*lx treatment in __bad_page().
>> 	Conserving screenspace when possible helps some, though that's
>> 	offset a bit against predictable field alignment. Maybe putting
>> 	variable-length fields at the end of the line would help.

On Mon, Nov 22, 2004 at 04:07:06PM +0000, David Howells wrote:
> I don't think that matters too much. This message should never be
> seen, after all...
> That said, I think I should probably provide a 64-bit version too... some of
> the fields will have 16-char widths there.

It does matter when people are trying to debug; I recently sent in an
adjustment to widen the fields so useful bugreports wouldn't be mangled.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> (4) I wonder if anyone's run with CONFIG_DEBUG_PAGEALLOC recently.
>> 	bootmem.c seems a bit early for kernel_map_pages() et al.
>> 	It could be okay depending.

On Mon, Nov 22, 2004 at 04:07:06PM +0000, David Howells wrote:
> I can try it. BTW, should the free page checking be contingent on
> this option? Or maybe it should have its own option.

I'd be pretty hesitant to make the more basic integrity checks optional.
Errors in this area are among the most common of all bugs in the kernel.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> (5) This patch does a fair number of different things and it takes a
>> 	bit of effort to wade through some of the longer rearrangements
>> 	as they overflow 80x24. It would be helpful for reviewers if you
>> 	could break this down into a somewhat more easily-digestible
>> 	series of smaller patches.

On Mon, Nov 22, 2004 at 04:07:06PM +0000, David Howells wrote:
> It's a little tricky to break it up logically since it's mostly incredibly
> interrelated.
> I could separate out some of the cleanups: rearrangement between files,
> trailing space splatting.

Anything to lighten up the load on reviewers would help, really. At
least for me, who has several urgent bughunts going on simultaneously.


-- wli
