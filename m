Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbUASWEy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 17:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbUASWEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 17:04:53 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:18356 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262040AbUASWEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 17:04:47 -0500
Subject: Re: Help port swsusp to ppc.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ncunningham@users.sourceforge.net
Cc: Hugang <hugang@soulinfo.com>, ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
In-Reply-To: <1074534964.2505.6.camel@laptop-linux>
References: <20040119105237.62a43f65@localhost>
	 <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux>
	 <1074490463.10595.16.camel@gaston>  <1074534964.2505.6.camel@laptop-linux>
Content-Type: text/plain
Message-Id: <1074549790.10595.55.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 20 Jan 2004 09:03:11 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-20 at 04:56, Nigel Cunningham wrote:
> Hi.
> 
> On Tue, 2004-01-20 at 00:39, Benjamin Herrenschmidt wrote:
> > I see no reason why this would be needed on ppc, only the last step,
> > that is the actual CPU state save, should matter.
> 
> Besides saving the CPU state, the code copies the original kernel back.
> It sort of defeats the purpose to remove that code :>

Ok, you mean copying the memory pages back down ? That should be done
with hand-made assembly or C code located specifically elsewhere then.
I do not want to see any kind of this ugly C-generated assembly in
arch/ppc.
 
> Well, the whole things is pretty hairy :> But I don't think there's
> anything wrong with assuming the boot and restored kernels are
> identical. After all, we're calling it suspending and resuming, not
> kexec. It does sound nice to do it all from the bootloader without
> kernel help.

I think that's a wrong assumption. I see personally _NO_ reason to
assume the boot and restored kernel are the same. They absolutely
don't need to do at all.

> It is a well defined interface: a section of memory marked nosave, with
> variables given the matching attribute. Not my idea, by the way. If you
> have a problem, you should be taking it up with Pavel or Linus. We
> should also note that the interface can't be too well defined - there
> has to be room for development over time.

Still... That makes assumptions about how it's located and organised
that plain wrong (c). Please get rid of that, at least I won't let a PPC
version do that. Depending on how much time I can spare, I'll try to
work on that PPC port later this week. If you need something like clock
calibration data down to the loaded kernel, then either re-calculate it
in the wakeup code path, or pass it via some _sane_ interface (at
_least_ a versioned data structure, better, a tagged list of values like
some bootloaders do).

> Yes. we device_suspend. Regarding the similarities with kexec, I fully
> agree. In fact, there is also LKCD to think off. There should be a
> synergy here.

device_suspend is, imho, hairy too. We have some semantics that need
cleanup here, I'll have to talk to Patrick about them. Putting devices
to an idle state is what you need and what kexec need, and doesn't mean
putting them to _sleep_. Or maybe we could pass a specific state to
device_suspend for that. For example, it makes little sense to spin down
the hard disk at this stage, or to power off the video chip...

Ben.
 

