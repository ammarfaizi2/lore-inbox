Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030362AbWGFRmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbWGFRmF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 13:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWGFRmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 13:42:05 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:40118 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1030362AbWGFRmD
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 13:42:03 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17581.19022.234542.958272@gargle.gargle.HOWL>
Date: Thu, 6 Jul 2006 21:37:18 +0400
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: "Bret Towe" <magnade@gmail.com>,
       "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC06D26C@mssmsx411>
References: <B41635854730A14CA71C92B36EC22AAC06D26C@mssmsx411>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
X-SystemSpamProbe: GOOD 0.0000010 0254e3319141efedff39fb60e61e0743
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ananiev, Leonid I writes:
 > Nikita Danilov writes:
 > >> by introducing MAX_PDFLUSH_THREADS=8. Why just 8?
 > > Sorry, I don't understand. pdflush.c appeared in 2.5.8 and
 > Thanks for explanation. Why just 8? Answer: it was introduced in 2.5.8.

No, no, I was commenting on your (incorrect) statement that kernel "was
patched up by introducing MAX_PDFLUSH_THREADS=8". It never was: this
limit is part of the original design, not some "patch".

 > Why the constant MAX_PDFLUSH_THREADS is needed? Is it because current
 > kernel may create huge number of pdflush threads and overload the
 > system? Why we can not set MAX_PDFLUSH_THREADS=512? 1000?

Because this is not needed for current pdflush usage patterns. pdflush
is used for light background write-out, and small number of pdflush
threads is able to achieve necessary IO concurrency level, because they
are mostly non-blocking, thanks to the current_is_pdflush() checks. If
asynchronous write-out cannot cope with the rate of dirtying,
synchronous write-out starts.

You, on the other hand, are trying to use pdflush for the goal it wasn't
designed for. No wonder it doesn't work.

 > 
 > >> Why 48?
 > > This is explained in comment just above sync_writeback_pages()
 > > definition. Basically, ratelimit_pages pages might be dirtied between
 > > calls to balance_dirty_pages(), and the latter tries to write out
 > *more*
 > > pages to keep number of dirty pages under control: negative feedback
 > > control loop, of sorts.
 > 
 > I had asked "why 48?" is hard coded for any configuration. I do not see
 > "48" in your explanation.

You didn't look carefully enough. :-)

/*
 * When balance_dirty_pages decides that the caller needs to perform some
 * non-background writeback, this is how many pages it will attempt to write.
 * It should be somewhat larger than RATELIMIT_PAGES to ensure that reasonably
 * large amounts of I/O are submitted.
 */
static inline long sync_writeback_pages(void)
{
	return ratelimit_pages + ratelimit_pages / 2;
}

ratelimit_pages = 32, hence, sync_writeback_pages() returns 48. It could
be different, of course, if ratelimit_pages were.

 > 
 > You do not recommend to use hard coded constants but
 > MAX_PDFLUSH_THREADS=8 and write_chunk=48 are sacred according you mind. 

No, I think the fewer hard-coded constants are here---the better. I'd
happily eliminate MAX_PDFLUSH_THREADS, but just dropping this constraint
is a non-solution in search of a problem, obviously.

But this discussion is degenerating, so I shall participate in it no
longer.

 > 
 > Leonid

Nikita.

