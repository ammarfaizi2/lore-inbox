Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289817AbSCHWaS>; Fri, 8 Mar 2002 17:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290333AbSCHWaJ>; Fri, 8 Mar 2002 17:30:09 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:39176 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S289817AbSCHWaE>; Fri, 8 Mar 2002 17:30:04 -0500
Date: Fri, 8 Mar 2002 23:30:01 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Danek Duvall <duvall@emufarm.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: root-owned /proc/pid files for threaded apps?
Message-ID: <20020308233001.B7163@devcon.net>
Mail-Followup-To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
	Danek Duvall <duvall@emufarm.org>, linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20020307060110.GA303@lorien.emufarm.org> <E16iyBW-0002HP-00@the-village.bc.nu> <20020308100632.GA192@lorien.emufarm.org> <20020308195939.A6295@devcon.net> <20020308203157.GA457@lorien.emufarm.org> <20020308222942.A7163@devcon.net> <20020308214148.GA750@lorien.emufarm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020308214148.GA750@lorien.emufarm.org>; from duvall@emufarm.org on Fri, Mar 08, 2002 at 01:41:49PM -0800
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 01:41:49PM -0800, Danek Duvall wrote:
> > 
> > > So it also turns out that either by changing that argument to 0 or
> > > just reverting that hunk of the patch, xmms starts skipping whenever
> > > mozilla loads a page, even a really simple one.
> > ie. always when mozilla tries to do a socket(PF_INET6, ...), which
> > ends up requesting the ipv6 module. 
> I don't think so -- modprobe logs its attempts in /var/log/ksymoops/ and
> there aren't nearly as many attempts to load net-pf-10 logged there as
> pages I reloaded.

Hmm, right. Actually, it should only try to open an IPv6 socket if
you stomp on a webserver which runs IPv6 already.

> > Maybe it's related to the wmb() done by set_user() if dumpclear is
> > set? (although it's actually a nop on most x86 (which arch are you
> > using?))
> AMD K6-III, just to be specific.

OK, if you didn't compile your kernel for an IDT WinChip, wmb() only
affects the compilers optimizer (it stops the compiler from reordering
memory writes across it, so it's effect is not changed by the if
around it in this case).

> > Just for testing, can you try moving the wmb() in set_user()
> > (kernel/sys.c, line 512 in 2.4.19-pre2-ac3) out of the if statement?
> I'd expect to see the skipping regardless, then, right?

Nope, the other way round. At the moment, the wmb() in set_user() is
only done if dumpclear is set, ie. with set_user(0, 1).

But as stated above, moving the wmb() should not change anything on an
x86 (non-WinChip) machine. I think your problem is buried somewhere
else ...

> I'll give it a
> shot tonight and report back.

... but really testing it doesn't hurt, so please proceed :-)

What you can also try is making the kernel do those module requests
without the rest of mozilla around it. Try running the following test
program a few times while you are listening to music.

---------- snip ----------
/*
 * Save as ipv6test.c and compile with "gcc -o ipv6test ipv6test.c". 
 * Run with "./ipv6test".
 */

#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>

int main(void)
{
        int s;

        printf("Creating IPv6 socket...");
        if ((s = socket(PF_INET6, SOCK_STREAM, 0)) != -1) {
                printf(" succeeded.\n");
                close(s);
        }
        else
                printf("failed.\nsocket: %m\n");
        return 0;
}
---------- snip ----------

If this doesn't cause skips, it seems very unlikely to me that your
skips are related to request_module() or the functions called by it.

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
