Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129164AbRCPMeu>; Fri, 16 Mar 2001 07:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129282AbRCPMel>; Fri, 16 Mar 2001 07:34:41 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:29715 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129164AbRCPMe0>; Fri, 16 Mar 2001 07:34:26 -0500
Date: Fri, 16 Mar 2001 08:50:25 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: george anzinger <george@mvista.com>, Alexander Viro <viro@math.psu.edu>,
        linux-mm@kvack.org, bcrl@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: changing mm->mmap_sem  (was: Re: system call for process
 information?)
In-Reply-To: <20010316094918.F30889@redhat.com>
Message-ID: <Pine.LNX.4.21.0103160844300.5790-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2001, Stephen C. Tweedie wrote:
> On Thu, Mar 15, 2001 at 09:24:59AM -0300, Rik van Riel wrote:
> > On Wed, 14 Mar 2001, Rik van Riel wrote:
> 
> > The mmap_sem is used in procfs to prevent the list of VMAs
> > from changing. In the page fault code it seems to be used
> > to prevent other page faults to happen at the same time with
> > the current page fault (and to prevent VMAs from changing
> > while a page fault is underway).
> 
> The page table spinlock should be quite sufficient to let us avoid
> races in the page fault code.

> > Write locks would be used in the code where we actually want
> > to change the VMA list and page faults would use an extra lock
> > to protect against each other (possibly a per-pagetable lock
> 
> Why do we need another lock?  The critical section where we do the
> final update on the pte _already_ takes the page table spinlock to
> avoid races against the swapper.

The problem is that mmap_sem seems to be protecting the list
of VMAs, so taking _only_ the page_table_lock could let a VMA
change under us while a page fault is underway ...

Then again, I guess just making mmap_sem a R/W lock should fix
our problems ... and maybe even make it possible (in 2.5?) to
let multithreaded programs have pagefaults at the same time,
instead of having all threads queue up behind mmap_sem.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

