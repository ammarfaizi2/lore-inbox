Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUBZOmB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 09:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbUBZOmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 09:42:01 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:32926 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S261597AbUBZOl4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 09:41:56 -0500
Date: Thu, 26 Feb 2004 07:41:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [PATCH][3/3] Update CVS KGDB's wrt connect / detach
Message-ID: <20040226144155.GQ1052@smtp.west.cox.net>
References: <20040225213626.GF1052@smtp.west.cox.net> <20040225214343.GG1052@smtp.west.cox.net> <20040225215309.GI1052@smtp.west.cox.net> <200402261344.49261.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402261344.49261.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 01:44:49PM +0530, Amit S. Kale wrote:

> On Thursday 26 Feb 2004 3:23 am, Tom Rini wrote:
> > The following patch fixes a number of little issues here and there, and
> > ends up making things more robust.
> > - We don't need kgdb_might_be_resumed or kgdb_killed_or_detached.
> >   GDB attaching is GDB attaching, we haven't preserved any of the
> >   previous context anyhow.
> 
> If gdb is restarted, kgdb has to remove all breakpoints. Present kgdb does 
> that in the code this patch removes:
> 
> -		if (remcom_in_buffer[0] == 'H' && remcom_in_buffer[1] == 'c') {
> -			remove_all_break();
> -			atomic_set(&kgdb_killed_or_detached, 0);
> -			ok_packet(remcom_out_buffer);
> 
> If we don't remove breakpoints, they stay in kgdb without gdb not knowing it 
> and causes consistency problems.

Er, what do you mean 'restarted' ?  If gdb somehow disconnects 'detach'
or ^D^D, remove_all_break() gets called.  Is there another way for gdb
to somehow disconnect that I don't know of?

> > - Don't try and look for a connection in put_packet, after we've tried
> >   to put a packet.  Instead, when we receive a packet, GDB has
> >   connected.
> 
> We have to check for gdb connection in putpacket or else following problem 
> occurs.
> 
> 1. kgdb console messages are to be put.
> 2. gdb dies

As in doesn't cleanly remove itself?

> 3. putpacket writes the packet and waits for a '+'
> 4. new gdb sends a protocol initialization packet
> 5. putpacket reads characters in that packet hoping for an incoming '+' 
> sending out console message packet on each incoming character
> 6. gdb receives and rejects each console message packet
> 
> > - Remove ok_packet(), excessive, IMHO.
> 
> ok_packet is better than littering "OK" all over the place.

I disagree.  If ok_packet was anything more than
strcpy(remcom_out_buffer, "OK") you'd be right.

-- 
Tom Rini
http://gate.crashing.org/~trini/
