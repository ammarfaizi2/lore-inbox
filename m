Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129446AbRCPJx3>; Fri, 16 Mar 2001 04:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbRCPJxU>; Fri, 16 Mar 2001 04:53:20 -0500
Received: from zeus.kernel.org ([209.10.41.242]:47336 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129446AbRCPJxH>;
	Fri, 16 Mar 2001 04:53:07 -0500
Date: Fri, 16 Mar 2001 09:49:18 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: george anzinger <george@mvista.com>, Alexander Viro <viro@math.psu.edu>,
        linux-mm@kvack.org, bcrl@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: changing mm->mmap_sem  (was: Re: system call for process information?)
Message-ID: <20010316094918.F30889@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0103141618320.21132-100000@duckman.distro.conectiva> <Pine.LNX.4.21.0103150919260.4165-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0103150919260.4165-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Thu, Mar 15, 2001 at 09:24:59AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 15, 2001 at 09:24:59AM -0300, Rik van Riel wrote:
> On Wed, 14 Mar 2001, Rik van Riel wrote:

> The mmap_sem is used in procfs to prevent the list of VMAs
> from changing. In the page fault code it seems to be used
> to prevent other page faults to happen at the same time with
> the current page fault (and to prevent VMAs from changing
> while a page fault is underway).

The page table spinlock should be quite sufficient to let us avoid
races in the page fault code.  We've had to deal with this before
there was ever a mmap_sem anyway: in ancient times, every page fault
had to do things like check to see if the pte had changed after IO was
complete and once the BKL had been retaken.  We can do the same with
the page fault spinlock without much pain.

> Maybe we should change the mmap_sem into a R/W semaphore ?

Definitely.

> Write locks would be used in the code where we actually want
> to change the VMA list and page faults would use an extra lock
> to protect against each other (possibly a per-pagetable lock

Why do we need another lock?  The critical section where we do the
final update on the pte _already_ takes the page table spinlock to
avoid races against the swapper.

Cheers,
 Stephen
