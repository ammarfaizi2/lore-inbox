Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132655AbRDQUnL>; Tue, 17 Apr 2001 16:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132678AbRDQUnB>; Tue, 17 Apr 2001 16:43:01 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:27677 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S132655AbRDQUmx>; Tue, 17 Apr 2001 16:42:53 -0400
Date: Tue, 17 Apr 2001 21:23:52 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Rik van Riel <riel@conectiva.com.br>, Christoph Rohland <cr@sap.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [NEED TESTERS] remove swapin_readahead Re: shmem_getpage_locked() / swapin_readahead() race in 2.4.4-pre3
Message-ID: <20010417212352.D2505@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0104141625200.9455-100000@duckman.distro.conectiva> <Pine.LNX.4.21.0104142007320.1866-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0104142007320.1866-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Sat, Apr 14, 2001 at 08:31:07PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Apr 14, 2001 at 08:31:07PM -0300, Marcelo Tosatti wrote:
> On Sat, 14 Apr 2001, Rik van Riel wrote:
> > On Sat, 14 Apr 2001, Marcelo Tosatti wrote:
> > 
> > > There is a nasty race between shmem_getpage_locked() and
> > > swapin_readahead() with the new shmem code (introduced in
> > > 2.4.3-ac3 and merged in the main tree in 2.4.4-pre3):

> Test (multiple shm-stress) runs fine without swapin_readahead(), as
> expected.

> Stephen/Linus? 

I don't see the problem.  shmem_getpage_locked appears to back off
correctly if it encounters a swap-cached page already existing if
swapin_readahead has installed the page first, at least with the code
in 2.4.3-ac5.

There *does* appear to be a race, but it's swapin_readahead racing
with shmem_writepage.  That code does not search for an existing entry
in the swap cache when it decides to move a shmem page to swap, so we
can install the page twice and end up doing a lookup on the wrong
physical page if there is swap readahead going on.

To fix that, shmem_writepage needs to do a swap cache lookup and lock
before installing the new page --- it should probably just copy the
new page into the old one if it finds one already there.

--Stephen
