Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136058AbREJC6l>; Wed, 9 May 2001 22:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136047AbREJC6d>; Wed, 9 May 2001 22:58:33 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:22795 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S136049AbREJC6W>; Wed, 9 May 2001 22:58:22 -0400
Date: Wed, 9 May 2001 22:19:56 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] writepage method changes
In-Reply-To: <3AF9F7F2.AC47F7AC@uow.edu.au>
Message-ID: <Pine.LNX.4.21.0105092134230.16052-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 May 2001, Andrew Morton wrote:

> Marcelo Tosatti wrote:
> > 
> > Well,
> > 
> > Here is the updated version of the patch to add the "priority" argument to
> > writepage().
> 
> It appears that a -EIO return from block_write_full_page() will
> result in an unlock of an unlocked page in page_launder(). Splat.

Right. Will fix the filesystems.

> What does the new writepage() argument do, and why does
> it exist?

The immediate reason for the "priority" argument is to avoid special
casing for the removal of dead dirty swap cache pages inside the VM.

With the new argument, page_launder() will call writepage() _even_ if it
does not want to do IO (in this case priority will be 0), so:

  - swap_writepage() can remove dirty swap pages
  - other filesystems are warned that the VM will probably want to
    write the page out soon.

Positive values of "priority" means "write this page out".

In the future higher positive values for writepage() can indicate the
level of VM pressure. Example: fs's which do delayed allocation may want
to return zero for priority 1 in case the page can be written out at a
"better time", but for priority's > 1 they should write the page
unconditionally. 

> What is the meaning of the writepage return value for
> the respective values of `priority'?

They should always return zero if they wrote (or freed) the page.

Otherwise return non-zero.

This way the VM can account for the amount of queue pages for IO. (which
we don't do right now, but we definately want to)

> When should writepage return with the page locked,
> and when not?

Locked for the "not wrote out case" (I will fix my patch now, thanks)

For the "wrote out" case there its undetermined.


