Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131123AbQLLU2B>; Tue, 12 Dec 2000 15:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131956AbQLLU1m>; Tue, 12 Dec 2000 15:27:42 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:58887 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S131123AbQLLU11>; Tue, 12 Dec 2000 15:27:27 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Wed, 13 Dec 2000 06:56:22 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14902.33510.300257.269105@notabene.cse.unsw.edu.au>
Cc: Jasper Spaans <jasper@spaans.ds9a.nl>, Neil Brown <neilb@cse.unsw.edu.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] raid5 crash with 2.4.0-test12 [Was: Linux-2.4.0-test12]
In-Reply-To: message from Linus Torvalds on Tuesday December 12
In-Reply-To: <20001212160605.A1835@spaans.ds9a.nl>
	<Pine.LNX.4.10.10012121047140.2239-100000@penguin.transmeta.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday December 12, torvalds@transmeta.com wrote:
> 
> 
> On Tue, 12 Dec 2000, Jasper Spaans wrote:
> 
> > On Mon, Dec 11, 2000 at 06:52:55PM -0800, Linus Torvalds wrote:
> > > 
> > > Ok, there it is. Noticeable changes from pre8 are mainly (a) new tq list
> > > compile fixes and (b) the NetApp snapshot thing.
> > 
> > >  - final:
> > >     - Neil Brown: raid and md cleanups
> > 
> > Hmm, while doing some not-so-heavy things with a mysql-db on a raid5-device
> > this kernel Oopsed on me; ksymoops output [which went through klogd,
> > shouldn't matter that much, klogd was using the right System.map]:
> > 
> > Dec 12 14:04:50 spaans kernel: invalid operand: 0000
> > Dec 12 14:04:50 spaans kernel: CPU:    1
> > Dec 12 14:04:50 spaans kernel: EIP:    0010:[end_buffer_io_bad+85/92]
> >
> > Dec 12 14:04:50 spaans kernel: Call Trace:
> >			[raid5_end_buffer_io+68/128]
> >			[complete_stripe+151/272]
> >			[handle_stripe+331/1092]
> >			[raid5d+173/260]
> >			[md_thread+299/508]
> 
> Looks like somebody didn't initialize the "b_end_io" pointer - the code
> defaults to it being "end_buffer_io_bad" (which oopses unconditionally on
> purpose exactly to find places where it wasn't initialized).
> 
> And it obviously looks like it's the raid5 code that does it.

Guilt by association :-)

What this bit of code (complete_stripe/raid5_end_buffer_io) is doing
is observing that it as completed some I/O request that was made of
the raid5 device and is calling the b_end_io on the buffer_head that
is was passed.  So it is not one of raid5's buffers that has the bad
b_end_io, but someone else's buffer that raid5 was asked to service.

You say "things with a mysql-db on a raid5-device".  Can I interpret
this to mean that mysql was talking driectly to /dev/md0, or is there
some filesystem in-between?
Either way, I expect Linus' suggestion will provide the answer.

NeilBrown


> 
> It _looks_ like the raid5 code does a "generic_make_request()" without
> setting b_end_io anywhere, but I don't know the raid5 code well enough.
> 
> To get better debug output, could you please do something for me? 
> 
> In fs/buffer.c, get rid of "end_buffer_io_bad" completely, and replace all
> users of it with NULL.
> 
> Then, in drivers/block/ll_rw_block.c: generic_make_request(), add a test
> like
> 
> 	if (!bh->b_end_io) BUG();
> 
> to the top of that function.
> 
> You'll still get a oops, but the difference is that you'll get the oops
> when the request is queued, rather than when the requst is finished, which
> will make it easier to figure out what the thing is that leads up to this.
> 
> In the meantime I'm sure Neil can figure out where in the raid5 code we
> don't initialize the buffer head properly even without that, but it's
> worth doing the above anyway.
> 
> 	Thanks,
> 
> 		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
