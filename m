Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263213AbUB0XyG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 18:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263209AbUB0XyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 18:54:05 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:31228 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263207AbUB0XxX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 18:53:23 -0500
Message-ID: <403FD868.4090007@mvista.com>
Date: Fri, 27 Feb 2004 15:53:12 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, amit@gate.crashing.org,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [KGDB PATCH][2/7] Serial updates, take 2
References: <20040227212301.GC1052@smtp.west.cox.net> <20040227212548.GD1052@smtp.west.cox.net> <403FC851.70103@mvista.com> <20040227231128.GN1052@smtp.west.cox.net>
In-Reply-To: <20040227231128.GN1052@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Fri, Feb 27, 2004 at 02:44:33PM -0800, George Anzinger wrote:
> 
> 
>>Couple of comments below...
>>
>>Tom Rini wrote:
> 
> [snip]
> 
>>>-	spin_unlock(&uart_interrupt_lock);
>>>-	local_irq_restore(flags);
>>>-
>>
>>I think you need at least this (especially in SMP, but works in all):
>>	char iir = serial_inb(kgdb8250_port + (UART_IIR << reg_shift));
>>        if(iir & UART_IIR_RDI){
>>
>>>+		kgdb_schedule_breakpoint();
>>
>>	}
>>
>>>	return IRQ_HANDLED;
> 
> 
> Would this be to ensure that we only schedule one breakpoint not 2?
Well, that too, but the notion is to take care of an interrupt on cpu 1 while 
doing console output on cpu 0.  If cpu 0 doesn't grab the '+' fast enough to 
prevent the interrupt cpu 1 may get an interrupt with no characters in the fifo. 
  This code just ignores that.
> 
> [snip]
> 
>>>+		/* If we get the start of another packet, this means
>>>+		 * that GDB is attempting to reconnect.  We will NAK
>>>+		 * the packet being sent, and stop trying to send this
>>>+		 * packet. */
>>>+		if (ch == '$') {
>>>+			kgdb_serial->write_char('-');
>>>			if (kgdb_serial->flush)
>>>				kgdb_serial->flush();
>>>-			breakpoint();
>>
>>Flags go up in my mind here about recursion...  What if we are already 
>>handling a breakpoint???  This may all be cool, but, as I said, alarms are 
>>ringing.
> 
> 
> There's two cases here, IMHO.  If GDB is connected, the only time we'll
> get a '$' when we're sending a packet is if we're out-of-sync (in
> regular gdb/kgdb communication) or we're prempting a console message
> (i.e. we're trying to send something while gdb wants to break in). 


I am a little unclear about this.  Assuming that the user has not been so dumb 
as to put a breakpoint in kgdb's console handling code, I suspect that the entry 
code should allow the console message to complete prior to sending the first 
message to gdb.  I made a rather lame attempt to do this in the -mm kgdb.  What 
I think should happen is that, on entry kgdb should send an nmi to all but self. 
  The kgdb nmi code (at in_kgdb() in the -mm patch) should check to see if the 
CURRENT cpu is in the kgdb console code and, if so, set a flag for the console 
code that a kgdb entry is pending and then return.  The console code should 
check this flag on exit, after clearing the "i am in console" flag and if set, 
do a send nmi self.  This would allow the console code to complete prior to the 
kgdb entry while still rounding up all the other cpus with the nmi.

In
> the latter case, it's OK to give up on the console packet (it's not
> critical) and trying to send a console message during a breakpoint is
> asking for trouble.  

Not only that, it is forbidden by the protocol (dam :(.

If things get out-of-sync in normal gdb/kgdb
> communication, what will happen w/o this change is that we get stuck in
> a "Packet instead of ACK" loop on gdb, and we get stuck trying to
> transmit that same packet on the kgdb side.   I think that if we call
> breakpoint() here we can try and start over...

The problem is that you are now doing a breakpoint from inside kgdb while 
handling a prior breakpoint.  At the very least you would need to consider very 
carefully what happens after the breakpoint.  It is not clear that you can 
recover from this condition... but you may be able to look around.
> 
> The other case is what the comment describes, and in that case we quite
> quickly get to the ponit of acting like gdb is connected again.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

