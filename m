Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264986AbTAJMed>; Fri, 10 Jan 2003 07:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbTAJMec>; Fri, 10 Jan 2003 07:34:32 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62865
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264986AbTAJMe0>; Fri, 10 Jan 2003 07:34:26 -0500
Subject: Re: spin_locks without smp.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.51.0301101238560.6124@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0301101238560.6124@dns.toxicfilms.tv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042205356.28469.84.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 13:29:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 11:42, Maciej Soltysiak wrote:
> Hi,
> 
> while browsing through the network drivers about the etherleak issue i
> found that some drivers have:
> 
> #ifdef CONFIG_SMP
> 	spin_lock_irqsave(...)
> #endif
> 
> and some just:
> 
> 	spin_lock_irqsave(...)
> 
> or similar.
> Which version should be practiced? i thought spinlocks are irrelevant
> without SMP so we should use #ifdef to shorten the execution path.

Long answer: The network driver authors are doing some fairly clever
things to make old ISA adapters usable in Linux 2.4 and later. Linux
lacks the functionality to do 
	
	spin_lock_disable_irqmask(lock, flags, mask)

Implementing it is rather expensive and hard to do well. In general
those code paths need reviewing and probably to change to

	preempt_disable()
#ifdef CONFIG_SMP
	spin_lock_irqsave(..)
#endif
..


Please ensure that if you change these drivers you 
a) Have the hardware and test it uniprocessor and SMP
b) Verify that with your change a serial modem port still works
c) Understand the game the author is playing

(Also d) ensure the author understands the games she/he is playing too!)

If you've been looking at the etherleak stuff btw, the -ac tree has what
is theoretically a full set of fixes. I'd love someone who is looking
at this into 2.5 to review them and merge them into the 2.5 tree. I 
doubt I have them all right so more eyes is most welcome.

Alan

