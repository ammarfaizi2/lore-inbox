Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbTHaP7T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 11:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbTHaP7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 11:59:19 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58322
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262614AbTHaP7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 11:59:17 -0400
Date: Sun, 31 Aug 2003 17:59:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Mike Fedyk <mfedyk@matchmail.com>, Antonio Vargas <wind@cocodriloo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: Andrea VM changes
Message-ID: <20030831155940.GX24409@dualathlon.random>
References: <Pine.LNX.4.55L.0308301248380.31588@freak.distro.conectiva> <Pine.LNX.4.55L.0308301607540.31588@freak.distro.conectiva> <Pine.LNX.4.55L.0308301618500.31588@freak.distro.conectiva> <20030830231904.GL24409@dualathlon.random> <1062339003.10208.1.camel@dhcp23.swansea.linux.org.uk> <20030831145932.GU24409@dualathlon.random> <1062343789.10208.9.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062343789.10208.9.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 04:29:49PM +0100, Alan Cox wrote:
> On Sul, 2003-08-31 at 15:59, Andrea Arcangeli wrote:
> > And I don't see how you can avoid oom killing to ever happen if the apps
> > recurse on the stack and growsdown some hundred megs. In such case
> > you've to oom kill, since there's no synchronous failure path during the
> > stack growsdown walk.
> 
> The stack grow fails and you get a signal. Its up to you to have a
> language that handles this or in C enjoy the delights of sigaltstack. In

the synchronous signal sending looks fine.

the brainer part here is what happens after sending the signal: how to
eventually fallback to sigkill. how do you fallback from a graceful
signal (one that can be handled in userspace) to an "hard" one like
sigkill that guarantees the stability of the system? I mean, you could
set a timer, and then try to kill the task with sigkill later if it's
still there after a few seconds you sent the graceful signal. There may
be different solutions to this.

But we need a fallback like the above because we can't trust userspace,
if the task doesn't go away, we've to sigkill it eventually.

Even sending sigkill immediatly would be acceptable (despite it would
prevent userspace to exit gracefully).

> practice the settings are such that this case basically "doesnt happen"
> for all normal use.

yes, stack usage is normally very limited.

> 
> > I just don't think it solves or hides the other issues, it seems
> > completely orthogonal to me, because you can still run oom during stack
> > growsdown.
> 
> Agreed - and there will always be corner cases, people who don't want
> strict overcommit etc. Thats why I said "as well". Its not a replacement
> for OOM handling of some form.

agreed.

Andrea
