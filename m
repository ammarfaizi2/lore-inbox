Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314381AbSGCAeQ>; Tue, 2 Jul 2002 20:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314395AbSGCAeP>; Tue, 2 Jul 2002 20:34:15 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:43012 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S314381AbSGCAeO>; Tue, 2 Jul 2002 20:34:14 -0400
Date: Tue, 2 Jul 2002 17:36:36 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] CMOV emulation for 2.4.19-rc1
Message-ID: <20020702173636.A13790@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20020701130327.38962.qmail@web20506.mail.yahoo.com> <200207011316.g61DGxT18808@Port.imtp.ilyichevsk.odessa.ua> <20020702200005.GA29557@pcw.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020702200005.GA29557@pcw.home.local>; from willy@w.ods.org on Tue, Jul 02, 2002 at 10:00:05PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 10:00:05PM +0200, Willy TARREAU wrote:
> > Can you code up a "dummy" emulator (which just ignores
> > any invalid opcode by doing eip+=3) and compare trap times
> > of your emulator and dummy one for, say, CMOVC AL,AL?
> > (with carry flag cleared)
> 
> The dummy emulator costs exactly 296 cycles (stable) on my
> k6-2/450. It only adds 3 to eip then returns.
> 
> To check this, I compared 1 million iteriations of 10
> consecutive cmove %eax,%eax with as much lea 0(%eax),%eax
> (1 cycle, RAW dependancy, not parallelizable), and the
> difference was exactly 660 ns/inst (297 cycles).
> 
> That said, I agree with you that it's worth optimizing a
> bit, at least to stay closer to 300 cycles than to 450.
> But that won't make emulated machines fast anyway.
> 
> One interesting note: I tested the prog on a VIA C3/533
> Mhz. One native cmove %eax,%eax costs 56 cycles here ! (at
> first, I even thought it was emulated). It's a shame to see
> how these instructions have been implemented. May be they
> flush the pipelines, write-backs, ... before the instruction.
> BTW, cmov isn't reported in cpu_flags, perhaps to discourage
> progs from using it ;-)
> 
> I will recode the stuff, and add two preventive messages:
>  - at boot time : "warning: this kernel may emulate unsupported instructions. If you
>    find it slow, please do dmesg."
>  - at first emulation : "trap caught for instruction XXX, program XXX."

Too often the "it seems slow" complaint comes after weeks or
even months of uptime.  How about the message every n times
an emulation is required.

	  if(!(emulation_count++ & 0xHHHH))
		printk(...);

wouldn't add too much more overhead than

	if (!emulation_notice)
	{
		emulation_notice = 1;
		printk(...);
	}

after all this is only supposed to happen under rescue
situations.  That way it will be sure to be in the logs and
maybe even on the console and we won't have to hunt for it.

Also, the message should say you are doing instruction
emulation.  "wrong model cpu, emulating instruction XXX" I
doubt indicating the program is helpful unless the tracking
is done per task or the printk every time you emulate.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
