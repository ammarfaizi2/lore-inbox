Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVEPHni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVEPHni (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 03:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVEPHni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 03:43:38 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7577 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261431AbVEPHQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 03:16:08 -0400
To: Andi Kleen <ak@muc.de>
Cc: Andy Isaacson <adi@hexapodia.org>, "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>, linux-kernel@vger.kernel.org,
       mpm@selenic.com, tytso@mit.edu
Subject: Re: Hyper-Threading Vulnerability
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de>
	<1116009483.4689.803.camel@rebel.corp.whenu.com>
	<20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org>
	<20050515094352.GB68736@muc.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 May 2005 01:10:28 -0600
In-Reply-To: <20050515094352.GB68736@muc.de>
Message-ID: <m1oebbwsrf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

> On Fri, May 13, 2005 at 02:26:20PM -0700, Andy Isaacson wrote:
> > On Fri, May 13, 2005 at 09:05:49PM +0200, Andi Kleen wrote:
> > > On Fri, May 13, 2005 at 02:38:03PM -0400, Richard F. Rebel wrote:
> > > > Why?  It's certainly reasonable to disable it for the time being and
> > > > even prudent to do so.
> > > 
> > > No, i strongly disagree on that. The reasonable thing to do is
> > > to fix the crypto code which has this vulnerability, not break
> > > a useful performance enhancement for everybody else.
> > 
> > Pardon me for saying so, but that's bullshit.  You're asking the crypto
> > guys to give up a 5x performance gain (that's my wild guess) by giving
> > up all their data-dependent algorithms and contorting their code wildly,
> > to avoid a microarchitectural problem with Intel's HT implementation.
> 
> And what you're doing is to ask all the non crypto guys to give
> up an useful optimization just to fix a problem in the crypto guy's
> code. The cache line information leak is just a information leak
> bug in the crypto code, not a general problem.

It is not a problem in the crypto code, it is a mis-feature of
the hardware/kernel combination.  As such you must know be intimate
about each and every flavor of the hardware to attempt to avoid
it in the software, and that way lies madness.

First this is a reminder that prefect security requires an audit
of the hardware as well as the software.  As we are neither
auditing the hardware not locking it down we obviously will not
achieve perfection.  The question then becomes what can be done
to decrease the likely hood that an application will inadvertently
and unavoidably leak information from timing attacks due to unknown
hardware optimizations?  Attacks that do not result from hardware
micro-architecture are another problem and one an application can
anticipate and avoid.

Ideally a solution will be proposed that will allow this problem
to be avoided using the existing POSIX API or at least the current
linux kernel API.  But that problem may not be the case.

The only solution I have seen proposed so far that seems to work
is to not schedule untrusted processes simultaneously with 
the security code.  With the current API that sounds like
a root process killing off, or at least stopping all non-root
processes until the critical process has finished.

Potentially the scheduler can be modified to do this at a finer
grain but I don't know if this would impact the scheduler fast
path.  Given the rarity and uncertainty of this it should probably
be something that the process that is worried about security should
asks for instead of simply getting by default.

So it looks to me like the sanest way to handle this is to
allocate a pool of threads/processes one per cpu.  Set the
affinity of each process to a particular cpu.  And set priority
of the threads to run at the highest priority.  And during the
critical time ensure none of the threads are sleeping.

Can someone see a better way to prevent an accidental information
leak to do to hardware architecture details?   

I wish there was a better way to ensure all of the threads were
running simultaneously and other then giving them the highest priority 
in the system but I don't currently see an alternative.

> There is much more non crypto code than crypto code around - you
> are proposing to screw the majority of codes to solve a relatively
> obscure problem of only a few functions, which seems like the totally
> wrong approach to me.
> 
> BTW the crypto guys are always free to check for hyperthreading
> themselves and use different functions.  However there is a catch
> there - the modern dual core processors which actually have
> separated L1 and L2 caches set these too to stay compatible
> with old code and license managers.

And those same processors will have the same problem if the share
significant cpu resources.  Ideally the entire problem set
would fit in the cache and the cpu designers would allow cache
blocks to be locked but that is not currently the case.  So a shared
L3 cache with dual core processors will have the same problem.

In addition a flavor of this attack may be made by repeatedly doing
multiplies or other activities that access functional units and seeing
how long they have to be waited for.  So even hyperthreading without
sharing a L2 cache may see this problem.

Eric
