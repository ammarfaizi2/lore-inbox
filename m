Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbUCAP2Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 10:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbUCAP2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 10:28:16 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:52664 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S261330AbUCAP2J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 10:28:09 -0500
Date: Mon, 1 Mar 2004 08:28:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, amit@gate.crashing.org,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [KGDB PATCH][2/7] Serial updates, take 2
Message-ID: <20040301152807.GQ1052@smtp.west.cox.net>
References: <20040227212301.GC1052@smtp.west.cox.net> <20040227212548.GD1052@smtp.west.cox.net> <403FC851.70103@mvista.com> <20040227231128.GN1052@smtp.west.cox.net> <403FD868.4090007@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403FD868.4090007@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 03:53:12PM -0800, George Anzinger wrote:
> Tom Rini wrote:
> >On Fri, Feb 27, 2004 at 02:44:33PM -0800, George Anzinger wrote:
> >
> >
> >>Couple of comments below...
> >>
> >>Tom Rini wrote:
> >
> >[snip]
> >
> >>>-	spin_unlock(&uart_interrupt_lock);
> >>>-	local_irq_restore(flags);
> >>>-
> >>
> >>I think you need at least this (especially in SMP, but works in all):
> >>	char iir = serial_inb(kgdb8250_port + (UART_IIR << reg_shift));
> >>       if(iir & UART_IIR_RDI){
> >>
> >>>+		kgdb_schedule_breakpoint();
> >>
> >>	}
> >>
> >>>	return IRQ_HANDLED;
> >
> >
> >Would this be to ensure that we only schedule one breakpoint not 2?
> Well, that too, but the notion is to take care of an interrupt on cpu 1 
> while doing console output on cpu 0.  If cpu 0 doesn't grab the '+' fast 
> enough to prevent the interrupt cpu 1 may get an interrupt with no 
> characters in the fifo. This code just ignores that.

OK, done.

> >[snip]
> >
> >>>+		/* If we get the start of another packet, this means
> >>>+		 * that GDB is attempting to reconnect.  We will NAK
> >>>+		 * the packet being sent, and stop trying to send this
> >>>+		 * packet. */
> >>>+		if (ch == '$') {
> >>>+			kgdb_serial->write_char('-');
> >>>			if (kgdb_serial->flush)
> >>>				kgdb_serial->flush();
> >>>-			breakpoint();
> >>
> >>Flags go up in my mind here about recursion...  What if we are already 
> >>handling a breakpoint???  This may all be cool, but, as I said, alarms 
> >>are ringing.
> >
> >
> >There's two cases here, IMHO.  If GDB is connected, the only time we'll
> >get a '$' when we're sending a packet is if we're out-of-sync (in
> >regular gdb/kgdb communication) or we're prempting a console message
> >(i.e. we're trying to send something while gdb wants to break in). 
> 
> 
> I am a little unclear about this.  Assuming that the user has not been so 
> dumb as to put a breakpoint in kgdb's console handling code, I suspect that 
> the entry code should allow the console message to complete prior to 
> sending the first message to gdb.

I don't think so.  If you don't break out of put_packet(), kgdb will
try to send the packet (console or for a previous, now dead, session)
forever.  And gdb will keep trying to send it's first packet, timing out
and moving on.

> I made a rather lame attempt to do this 
> in the -mm kgdb.  What I think should happen is that, on entry kgdb should 
> send an nmi to all but self. The kgdb nmi code (at in_kgdb() in the -mm 
>  patch) should check to see if the CURRENT cpu is in the kgdb console code 
> and, if so, set a flag for the console code that a kgdb entry is pending 
> and then return.  The console code should check this flag on exit, after 
> clearing the "i am in console" flag and if set, do a send nmi self.  This 
> would allow the console code to complete prior to the kgdb entry while 
> still rounding up all the other cpus with the nmi.

IMHO, that's awfully complex for something we can just not skip out on.

> >If things get out-of-sync in normal gdb/kgdb
> >communication, what will happen w/o this change is that we get stuck in
> >a "Packet instead of ACK" loop on gdb, and we get stuck trying to
> >transmit that same packet on the kgdb side.   I think that if we call
> >breakpoint() here we can try and start over...
> 
> The problem is that you are now doing a breakpoint from inside kgdb while 
> handling a prior breakpoint.

Only in the case where we aren't out-of-sync, but gdb died /
disconnected and we then hit a breakpoint.

> At the very least you would need to consider 
> very carefully what happens after the breakpoint.  It is not clear that you 
> can recover from this condition... but you may be able to look around.

I don't follow you here.  I agree that in the case of hitting a
breakpoint while gdb isn't connected isn't necessarily clean, but since
gdb didn't go away cleanly, and there isn't a way for it to tell us it's
trying to recover, I'm not sure what we can do aside from clear out the
existing breakpoints (just like we could have done, if gdb was still
connected) and keep going.  We should document that this particular
behavior might not be a good thing, but it's just that one corner case
of things (disconnect is fine, detach/reattach is fine, heck even gdb
dying and not hitting a breakpoint is fine).

-- 
Tom Rini
http://gate.crashing.org/~trini/
