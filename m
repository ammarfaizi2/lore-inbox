Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264571AbRFOXvj>; Fri, 15 Jun 2001 19:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264572AbRFOXva>; Fri, 15 Jun 2001 19:51:30 -0400
Received: from [212.1.33.3] ([212.1.33.3]:38520 "EHLO borg4.zapnet.de")
	by vger.kernel.org with ESMTP id <S264571AbRFOXvS>;
	Fri, 15 Jun 2001 19:51:18 -0400
Message-Id: <200106152351.BAA12360@borg4.zapnet.de>
Date: Sat, 16 Jun 2001 01:51:15 +0200
From: Ivan Schreter <is@zapwerk.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: john@deater.net, linux-kernel@vger.kernel.org
Subject: Re: Buffer management - interesting idea
In-Reply-To: <Pine.LNX.4.33.0106151550010.2262-100000@duckman.distro.conectiva>
In-Reply-To: <200106151705.TAA07359@borg4.zapnet.de>
	<Pine.LNX.4.33.0106151550010.2262-100000@duckman.distro.conectiva>
X-Mailer: stuphead ver. 0.5.3 (Wiskas) (GTK+ 1.2.8; Linux 2.2.16; i686)
Organization: zapwerk AG
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

please CC: replies to me, since I'm not subscribed to the list.

On Fri, 15 Jun 2001 15:50:33 -0300 (BRST)
Rik van Riel <riel@conectiva.com.br> wrote:

> On Fri, 15 Jun 2001, Ivan Schreter wrote:
>> In 2Q, when a page is present in LRU queue, you move it to the front of
>> [...]

> This description has me horribly confused. Do you have
> any pointers to state diagrams of this thing? ;)

Well, I posted an URL where is complete paper about 2Q, here it is again:

	http://citeseer.nj.nec.com/63909.html

(click there in top right corner on download PS or PDF).

In general, it is like LRU, but the pages make it into LRU only after
going through FIFO. So a page which is requested only once (or few times
in a row) will pass through this FIFO and be swapped out. When a page is
actively used, it will pass through FIFO and on a new request for this
page it will not be loaded into FIFO, but into LRU.

Since FIFO is small relative to LRU (10% or so), you don't waste buffer
space for long time for once (or few times) used pages which are not
needed anymore (like big find, cat, dd, etc.).

The trick is how to determine whether the page should be loaded into FIFO
or into LRU at swap-in. And here comes another queue - they call it A1out
in original paper. This queue (or cyclic buffer or whatever) is another
FIFO queue, which stores INDICES of physical pages, which were swapped out
of FIFO queue (and lived only shortly). When a page is found in this A1out
queue, it is put into LRU (it is a "hot" page) and will live longer in LRU
list. A1out queue size is up to experiments, I used 50% of memory buffer
count and it performed well.

And yes, look into the program I posted last time, look into functions
r2q_page(), which loads a page into buffer and r2q_reclaim() which swaps
out a page to make space.

I was also doing some experiments with not swapping out hot pages out of
FIFO queue (USE_FASTPAGE conditional), but they didn't bring any
reasonable improvement (few tenths of percent up or down from original
performance), so it's probably not worth it.

BTW, this 2Q algorithm can be well used for madvise() syscall
implementation, like this:

	- NORMAL - no change
	- RANDOM - no change
	- SEQUENTIAL - load pages in FIFO and DON'T put them in A1out
	  after expiry
	- WILLNEED - load pages directly in LRU
	- DONTNEED - move pages to FRONT of FIFO (or TAIL of LRU)

(see BSD madvise() syscall, but I believe you know what I'm talking about
;-)

BTW2, I'm quite happy that people care about new ideas :-) I would be
happy to hack the kernel full-time and implement them myself, but
unfortunately I need to make money out of something, so no time :-)

--
Ivan Schreter
is@zapwerk.com
