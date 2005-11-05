Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbVKEAMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVKEAMJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 19:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVKEAMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 19:12:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23261 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751181AbVKEAMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 19:12:08 -0500
Date: Fri, 4 Nov 2005 16:08:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
       aherrman@de.ibm.com, dm-devel@redhat.com
Subject: Re: [PATCH resubmit] do_mount: reduce stack consumption
Message-Id: <20051104160851.3a7463ff.akpm@osdl.org>
In-Reply-To: <20051104235500.GE5368@stusta.de>
References: <20051104105026.GA12476@osiris.boeblingen.de.ibm.com>
	<20051104084829.714c5dbb.akpm@osdl.org>
	<20051104212742.GC9222@osiris.ibm.com>
	<20051104235500.GE5368@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> On Fri, Nov 04, 2005 at 10:27:42PM +0100, Heiko Carstens wrote:
> > > > See original stack back trace below and Andreas' patch and analysis
> > > > here:
> > > > http://www.ussg.iu.edu/hypermail/linux/kernel/0410.3/1844.html
> > 
> > I probably should add that with "original" stack back trace a trace of
> > a 2.6.10 kernel was meant, if that wasn't clear, but the DM code is
> > still the same in 2.6.14.
> > 
> > > >     <4>Call Trace:
> > ...
> > > >     <4> [<0000000010831380>] __map_bio+0x70/0x160 [dm_mod]
> > > >     <4> [<000000001083173e>] __split_bio+0x1e6/0x538 [dm_mod]
> > > >     <4> [<0000000010831ba8>] dm_request+0x118/0x25c [dm_mod]
> > > >     <4> [<0000000000241074>] generic_make_request+0xf0/0x21c
> > > >     <4> [<0000000010831380>] __map_bio+0x70/0x160 [dm_mod]
> > > >     <4> [<000000001083173e>] __split_bio+0x1e6/0x538 [dm_mod]
> > > >     <4> [<0000000010831ba8>] dm_request+0x118/0x25c [dm_mod]
> > > >     <4> [<0000000000241074>] generic_make_request+0xf0/0x21c
> > > >     <4> [<0000000010831380>] __map_bio+0x70/0x160 [dm_mod]
> > > >     <4> [<000000001083173e>] __split_bio+0x1e6/0x538 [dm_mod]
> > > >     <4> [<0000000010831ba8>] dm_request+0x118/0x25c [dm_mod]
> > > >     <4> [<0000000000241074>] generic_make_request+0xf0/0x21c
> > ...
> > 
> > This part of the call trace is actually good for >1500 bytes of stack
> > usage and is what kills us and should be fixed.
> > I'm surprised that there are no other bug reports regarding DM and
> > stack overflow with 4k stacks.
> >...
> 
> There were some reports of dm+xfs overflows with 4k stacks on i386.
> 
> The xfs side was sorted out, but I son't know the state of the dm part.
> 

The state is Very Bad, IMO.  At the very least, DM should struggle to the
utmost to reduce the stack utilisation around that recursion point.
