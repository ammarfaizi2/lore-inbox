Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133034AbRDLB0x>; Wed, 11 Apr 2001 21:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133037AbRDLB0o>; Wed, 11 Apr 2001 21:26:44 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:45352 "EHLO
	golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S133034AbRDLB0k>; Wed, 11 Apr 2001 21:26:40 -0400
Date: Wed, 11 Apr 2001 21:28:04 -0400
From: esr@thyrsus.com
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net,
        "Eric S. Raymond" <esr@snark.thyrsus.com>
Subject: Re: CML2 1.0.0 release announcement
Message-ID: <20010411212804.F9081@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: esr@thyrsus.com, Jeff Garzik <jgarzik@mandrakesoft.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net,
	"Eric S. Raymond" <esr@snark.thyrsus.com>
In-Reply-To: <20010411191940.A9081@thyrsus.com> <E14nU6n-0007po-00@the-village.bc.nu> <20010411204523.C9081@thyrsus.com> <3AD4FC54.C86AACBE@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AD4FC54.C86AACBE@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Apr 11, 2001 at 08:52:36PM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com>:
> esr@thyrsus.com wrote:
> > But, as a separate issue, the CML2 design *could* be reworked to support
> > a multiple-apex tree, if there were any advantage to doing so.  I don't
> > see one.  Do you?
> 
> Yes, because the current system is directed not by a central file, but
> by an architecture-specific config.in.  Compartmentalized Config.in
> files are easy to include and even easier to exclude selectively.  It's
> pretty pointless for S/390 arch to parse a ton of driver config entries
> it will never present to the user; that wastes memory and slows down the
> configuration system.

The low-level answer is that the configurator doesn't pay the
parse-time cost; the CML2 compiler does all that and presents the
configurator with a rulebase object that is not large enough for the
incremental I/O or memory cost of the "useless" information to be
significant.  (I'm not handwaving here, I've actually profiled this;
the rulebase object for 2.4.3 is only 342K on disk and less than that
in core.)

BTW, CML2 only has a "central file" in a rather trivial sense.  Here's
what the code to include the port-specific rules looks like:

source "arch/i386/rules.cml"
source "arch/alpha/rules.cml"
source "arch/sparc/rules.cml"
source "arch/mips/rules.cml"
source "arch/ppc/rules.cml"
source "arch/m68k/rules.cml"
source "arch/arm/rules.cml"
source "arch/sh/rules.cml"
source "arch/ia64/rules.cml"
source "arch/parisc/rules.cml"
source "arch/s390/rules.cml"
source "arch/cris/rules.cml"

The real issue isn't that they're "centralized", it's that they're 
siblings under a top-level architecture menu (which most users won't
see because normal invocations of the configurator supply that answer
from the command line, just as in CML1).  Which brings me neatly 
to my next point...

The higher-level answer is that you're confusing an implementation
issue with a design issue.  Beware of such premature optimization, for
as the hierophant Knuth hath revealed unto us, it is the root of all
evil.  To persuade me to go back to a multiple-apex tree you'd have to
show that there is a *design* or complexity-control advantage to
compartmentalizing the configuration information in that way.  Maybe
there is one, but nobody's shown it to me yet.

(In truth I don't dismiss implementation concerns quite as cavalierly
as it might sound from the above.  But buying a linear speedup wouldn't
be good enough to make me change the design.  A quadratic speedup might
be, but none of CML2's algorithms are quadratic in the number of symbols
in the rulebase.)
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The men and women who founded our country knew, by experience, that there
are times when the free person's answer to oppressive government has to be
delivered with a bullet.  Thus, the right to bear arms is not just *a*
freedom; it's the mother of all freedoms.  Don't let them disarm you!
