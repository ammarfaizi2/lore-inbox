Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132780AbQK3KUL>; Thu, 30 Nov 2000 05:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132794AbQK3KUB>; Thu, 30 Nov 2000 05:20:01 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:1809 "HELO
        note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
        id <S132780AbQK3KTo>; Thu, 30 Nov 2000 05:19:44 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Russell King <rmk@arm.linux.org.uk>
Date: Thu, 30 Nov 2000 20:49:03 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14886.8847.933172.241464@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@torque.net
Subject: Re: PATCH  - kbuild documentation.
In-Reply-To: message from Russell King on Thursday November 30
In-Reply-To: <14885.37565.611695.816426@notabene.cse.unsw.edu.au>
        <200011300036.eAU0aTc05028@flint.arm.linux.org.uk>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
        LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
        8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 30, rmk@arm.linux.org.uk wrote:
> Neil Brown writes:
> > +	An example for libraries from drivers/acorn/scsi/Makefile:
> 
> This is no longer true; you'll have to find another example.
> 
> > +	As ordering is not so important in libraries, this still uses
> > +	LX_OBJS and MX_OBJS, though (presumably) it could be changed to
> > +	use MIX_OBJS as follows:
> > +
> > +		active-objs	:= $(sort $(obj-y) $(obj-m))
> > +		L_OBJS		:= $(obj-y)
> > +		M_OBJS		:= $(obj-m)
> > +		MIX_OBJS	:= $(filter $(export-objs), $(active-objs))
> > +
> > +	which is clearly shorted and arguably clearer.
> 
> What if you have
> 
> obj-$(CONFIG_FOO) += foo.o foobar.o
> obj-$(CONFIG_BAR) += bar.o foobar.o
> 
> and CONFIG_FOO=y and CONFIG_BAR=m?  What about CONFIG_FOO=y and
> CONFIG_BAR=y?  Do we still support this method?  If not, what is the
> recommended way of doing this sort of stuff?

The first case (y and m) would be satisifed by

   M_OBJS := $(filter-out $(O_OBJS) $(L_OBJS), $(obj-m))

but the second (y and y) wouldn't.  If you want to be allowed to
mention a .o file twice, and still maintain ordering, you are asking a lot.
You could try:

obj-$(CONFIG_FOO)$(CONFIG_BAR) += foobar.o
obj-$(CONFIG_FOO) += foo.o foobar.o
obj-$(CONFIG_BAR) += bar.o foobar.o

O_OBJS := $(obj-y) $(obj-ym) $(obj-my)
M_OBJS := $(obj-m) $(obj-mm)

But that it starting to look ugly.

Maybe:
O_OBJS := $(shell echo $(obj-y) | tr ' ' '\n' | cat -n | sort -u +1 | sort -n | cut -f2)

But I don't think that is much better.

There is room for other good ideas here if this is a real need.

NeilBrown

(I love Unix pipelines)

>    _____
>   |_____| ------------------------------------------------- ---+---+-
>   |   |         Russell King        rmk@arm.linux.org.uk      --- ---
>   | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
>   | +-+-+                                                     --- -+-
>   /   |               THE developer of ARM Linux              |+| /|\
>  /  | | |                                                     ---  |
>     +-+-+ -------------------------------------------------  /\\\  |
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
