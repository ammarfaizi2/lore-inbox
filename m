Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130487AbREFCDR>; Sat, 5 May 2001 22:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130820AbREFCDI>; Sat, 5 May 2001 22:03:08 -0400
Received: from [203.167.188.69] ([203.167.188.69]:21446 "HELO tapu")
	by vger.kernel.org with SMTP id <S130487AbREFCC7>;
	Sat, 5 May 2001 22:02:59 -0400
Date: Sun, 6 May 2001 14:02:54 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Peter Rival <frival@zk3.dec.com>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CPU hot swap for 2.4.3 + s390 support
Message-ID: <20010506140254.C11201@tapu.f00f.org>
In-Reply-To: <20010505063726.A32232@va.samba.org> <3AF4118F.330C3E86@zk3.dec.com> <20010506033746.A30690@metastasis.f00f.org> <3AF4961B.F23C9948@zk3.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3AF4961B.F23C9948@zk3.dec.com>; from frival@zk3.dec.com on Sat, May 05, 2001 at 08:08:59PM -0400
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2001 at 08:08:59PM -0400, Peter Rival wrote:

    Hrmm...  I agree this is a hard problem.  I know people smarter
    than I have been thinking about this type of problem at Compaq.

It's hard with current memory allocation and management paradigms, if
we wanted to abstract things more and make (break) certain rules, I'm
sure it can me made to work -- the only thing is, we would loose
_MUCH_ speed and efficiency (and waste much more space), so much so I
doubt anyone would serious want to know about it.

We would also have to violate certain assumptions of RT applications.

    While I haven't talked to them directly, my only guess would be
    that we'd have to hand-rewrite some page tables after copying the
    page contents to a new area.

That in itself isn't too bad, except if the pages are mlocked this is
nasty, you have to block all access to the page during copy, very bad
for RT stuff.

Not only that, what if the pages themselves have kernel allocations in
them? We cannot find these (at present) let alone have _any_ idea how
to move them. I guess it could be fidged to work using the MMU if we
were allowed to _COMPLETELY_ lock the system duing the removal phase
from all interrupts and such like... seems pretty horrible to me.

    It's late Saturday and I really haven't thought this through
    fully, so I'm not even sure that would work, but it's something
    like how we support replicated text segments on our GS
    series...don't know why it wouldn't work here.  *shrug*

There have been demonstrations in the past of this sort of thing. I
think HP may have done one. Not with a commodity OS though.



Actually, I just thought of a kill, what about platforms that have
physically mapped page-tables? This makes like even harder as you have
to move them :(

    It's the IBM technology that works around bad memory by detecting
    single-bit errors and removing the chip that caused it from use.

I think Solaris claims to do this right now... no idea if it works, I
know of at least one Solaris 7 machine with a dicky memory bit and it
keeps moaning about parity corrections so I guess it doesn't lock it
out. Maybe later versions (8) do?

    I'd think of this as a big hammer version of that in software.

It's much easier to do in hardware with current OS design I should
think.

    Besides, eventually you'll want to replace the DIMM that has the
    bad chip, and what better way then while the system is still
    running (as long as it's stable, of course ;) I'm just thinking
    out loud, so someone can correct me if I'm being loopy...

Again, you could do this is hardware... have the hardware route writes
to the memory elsewhere and only take reads from the old memory until
the 'refresh' cycles have copied all the data over. Hmm, when I think
about this, doing this in the memory controller chipset seems much
easier I wonder if someone hasn't actually done it...



  --cw
