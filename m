Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbUB0XN2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 18:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263194AbUB0XN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 18:13:27 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:33769 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S263201AbUB0XLc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 18:11:32 -0500
Date: Fri, 27 Feb 2004 16:11:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, amit@gate.crashing.org,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [KGDB PATCH][2/7] Serial updates, take 2
Message-ID: <20040227231128.GN1052@smtp.west.cox.net>
References: <20040227212301.GC1052@smtp.west.cox.net> <20040227212548.GD1052@smtp.west.cox.net> <403FC851.70103@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403FC851.70103@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 02:44:33PM -0800, George Anzinger wrote:

> Couple of comments below...
> 
> Tom Rini wrote:
[snip]
> >-	spin_unlock(&uart_interrupt_lock);
> >-	local_irq_restore(flags);
> >-
> I think you need at least this (especially in SMP, but works in all):
> 	char iir = serial_inb(kgdb8250_port + (UART_IIR << reg_shift));
>         if(iir & UART_IIR_RDI){
> >+		kgdb_schedule_breakpoint();
> 	}
> > 	return IRQ_HANDLED;

Would this be to ensure that we only schedule one breakpoint not 2?

[snip]
> >+		/* If we get the start of another packet, this means
> >+		 * that GDB is attempting to reconnect.  We will NAK
> >+		 * the packet being sent, and stop trying to send this
> >+		 * packet. */
> >+		if (ch == '$') {
> >+			kgdb_serial->write_char('-');
> > 			if (kgdb_serial->flush)
> > 				kgdb_serial->flush();
> >-			breakpoint();
> 
> Flags go up in my mind here about recursion...  What if we are already 
> handling a breakpoint???  This may all be cool, but, as I said, alarms are 
> ringing.

There's two cases here, IMHO.  If GDB is connected, the only time we'll
get a '$' when we're sending a packet is if we're out-of-sync (in
regular gdb/kgdb communication) or we're prempting a console message
(i.e. we're trying to send something while gdb wants to break in).  In
the latter case, it's OK to give up on the console packet (it's not
critical) and trying to send a console message during a breakpoint is
asking for trouble.  If things get out-of-sync in normal gdb/kgdb
communication, what will happen w/o this change is that we get stuck in
a "Packet instead of ACK" loop on gdb, and we get stuck trying to
transmit that same packet on the kgdb side.   I think that if we call
breakpoint() here we can try and start over...

The other case is what the comment describes, and in that case we quite
quickly get to the ponit of acting like gdb is connected again.

-- 
Tom Rini
http://gate.crashing.org/~trini/
