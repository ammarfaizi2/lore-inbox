Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbUCAIQO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 03:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUCAIQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 03:16:14 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:47045 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262271AbUCAIQH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 03:16:07 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [Kgdb-bugreport] [PATCH][3/3] Update CVS KGDB's wrt connect / detach
Date: Mon, 1 Mar 2004 13:45:54 +0530
User-Agent: KMail/1.5
Cc: kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       kgdb-bugreport@lists.sourceforge.net
References: <20040225213626.GF1052@smtp.west.cox.net> <200402261344.49261.amitkale@emsyssoft.com> <20040226180818.GU1052@smtp.west.cox.net>
In-Reply-To: <20040226180818.GU1052@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403011345.54546.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 Feb 2004 11:38 pm, Tom Rini wrote:
> On Thu, Feb 26, 2004 at 01:44:49PM +0530, Amit S. Kale wrote:
> > On Thursday 26 Feb 2004 3:23 am, Tom Rini wrote:
> > > The following patch fixes a number of little issues here and there, and
> > > ends up making things more robust.
> > > - We don't need kgdb_might_be_resumed or kgdb_killed_or_detached.
> > >   GDB attaching is GDB attaching, we haven't preserved any of the
> > >   previous context anyhow.
> >
> > If gdb is restarted, kgdb has to remove all breakpoints. Present kgdb
> > does that in the code this patch removes:
>
> OK.  After talking with Daniel Jacobowitz abit about this, the '?'
> packet will only be sent once per session.  So this is how we have to
> deal with disconnect / gdb dying.  I'll re-work the patch a bit to
> reflect this.
>

Sounds good.

> > > - Don't try and look for a connection in put_packet, after we've tried
> > >   to put a packet.  Instead, when we receive a packet, GDB has
> > >   connected.
> >
> > We have to check for gdb connection in putpacket or else following
> > problem occurs.
> >
> > 1. kgdb console messages are to be put.
> > 2. gdb dies
> > 3. putpacket writes the packet and waits for a '+'
> > 4. new gdb sends a protocol initialization packet
> > 5. putpacket reads characters in that packet hoping for an incoming '+'
> > sending out console message packet on each incoming character
> > 6. gdb receives and rejects each console message packet
>
> How about something like the following:
> putpacket(msg)
> {
>  if (!kgdb_connected)
>   return; /* No one wants this */
>
>  do {
>    /* Write out $pack#checksum */
>    ch = kgdb_get_debug_char();
>    if (ch == '+' /* ACK */ || ch == '$' /* Packet before an ACK?
>                                            must be a reattach. */ )
>     return;
>  }
> }
>
> With the suggested change for the ? packet, we quickly get to the point
> where we're back in kgdb_handle_exception() and will know this is a
> restart shortly.

We want a breakpoint (or call to kgdb_handle_exception) instead, if putpacket 
was called from kgdb console printing.

-Amit

