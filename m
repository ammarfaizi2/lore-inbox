Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316672AbSG3Vgp>; Tue, 30 Jul 2002 17:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316673AbSG3Vgp>; Tue, 30 Jul 2002 17:36:45 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:18192 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316672AbSG3Vgl>; Tue, 30 Jul 2002 17:36:41 -0400
Date: Tue, 30 Jul 2002 23:41:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: async-io API registration for 2.5.29
Message-ID: <20020730214116.GN1181@dualathlon.random>
References: <20020730054111.GA1159@dualathlon.random> <20020730084939.A8978@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020730084939.A8978@redhat.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 08:49:39AM -0400, Benjamin LaHaise wrote:
> On Tue, Jul 30, 2002 at 07:41:11AM +0200, Andrea Arcangeli wrote:
> > instead of separate syscalls for the various async_io
> > PREAD/PREADX/PWRITE/FSYNC/POLL operations there is just a single entry
> > point and a parameters specify the operation. But this is what the
> > current userspace expects and I wouldn't have too much time to change it
> > anyways because then I would break all the userspace libs too (I just
> > break them because of the true syscalls instead of passing through the
> > /proc/libredhat that calls into the dynamic syscall, but that's not
> > too painful to adapt). And after all even the io_submit isn't too bad
> > besides the above slowdown in the multiplexing (at least it's sharing
> > some icache for top/bottom of the functionality).
> 
> What would you suggest as an alternative API?  The main point of multiplexing 
> is that ios can be submitted in batches, which can't be done if the ios are 
> submitted via individual syscalls, not to mention the overlap with the posix 
> aio api.

yes, sys_io_sumbit has the advantage you can mix read/write/fsync etc..
in the same array of iocb. But by the same argument we could as well
have a submit_io instead of sys_read/sys_write/sys_fsync. It's a matter
of dropping such big if else if else if else loop and to scale with the
syscall table lookup instead. So I'd still prefer to nuke sys_io_submit
and iocb.aio_lio_opcode, and to replace them with
sys_aio_read/sys_aio_readx/sys_aio_write/sys_aio_fsync/sys_aio_poll but
as you said if it's very common to generate huge array of iocb with
mixed commands the current API would pay off thanks to the reduced
number of enter/exit kernel at the expense of the cheaper if else if
else checks. So I'm pretty much fine either ways and that's why I didn't
proposed a modified api since the first place.

> > checked that it still compiles fine on x86 (all other archs should keep
> > compiling too). available also from here:
> > 
> > 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.5/2.5.29/aio-api-1
> > 
> > Comments are welcome, many thanks.
> 
> That's the old cancellation API.  Anyways, the core is pretty much ready, so 
> don't bother with this patch.

Can you point me out to a patch with the new cancellation API that you
agree with for merging in 2.5 so I can synchronize? I'm reading your
very latest patch loaded on some site in June. that will be really
helpful, many thanks!

Andrea
