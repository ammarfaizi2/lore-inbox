Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbTIJMtJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 08:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbTIJMtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 08:49:09 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:33930 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262887AbTIJMs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 08:48:58 -0400
Subject: Re: Efficient IPC mechanism on Linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luca Veraldi <luca.veraldi@katamail.com>
Cc: arjanv@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <01c601c3777f$97c92680$5aaf7450@wssupremo>
References: <00f201c376f8$231d5e00$beae7450@wssupremo>
	 <20030909175821.GL16080@Synopsys.COM>
	 <001d01c37703$8edc10e0$36af7450@wssupremo>
	 <20030910064508.GA25795@Synopsys.COM>
	 <015601c3777c$8c63b2e0$5aaf7450@wssupremo>
	 <1063185795.5021.4.camel@laptop.fenrus.com>
	 <01c601c3777f$97c92680$5aaf7450@wssupremo>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063198060.32726.32.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Wed, 10 Sep 2003 13:47:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-10 at 10:40, Luca Veraldi wrote:
> To set the accessed or dirty bit you use
> 
> 38         __asm__ __volatile__( LOCK_PREFIX
> 39                 "btsl %1,%0"
> 40                 :"=m" (ADDR)
> 41                 :"Ir" (nr));
> 
> which is a ***SINGLE CLOCK CYCLE*** of cpu.

Its a _lot_ more than that in the normal case. Upwards of 60 clocks on 
a PIV. You then need to reload cr3 if you touched permissions which
means every cached TLB in the system is lost, and you may need to do
a cross CPU IPI on SMP (which takes a long time)

> You say "tlb's and internal cpu state will need to be flushed".
> The other cpus in an SMP environment can continue to work, indipendently.
> TLBs and cpu state registers are ***PER-CPU*** resorces.

Think of a threaded app passing a message to another app. You have to do
the cross CPU flush in order to prevent races where another thread can
scribble on data it doesnt own. Assuming a reasonable TLB reuse rate
thats 120 plus TLB reloads. The newer CPU's cache TLB's in L1/L2 so
thats not too bad but it all adds up. On SMP its a real pain

> Probably, it is worse the case of copying a memory page,
> because you have to hold some global lock all the time.
> This is deadly in an SMP environment, 

You don't need a global lock to copy memory. 

One thing I do agree with you on is the API aspect - and that is
problematic. The current API leaves data also owned by the source.
If I write "fred" down a pipe I still own the "fred" bits. The 
method you propose was added long ago go to Solaris (see "doors") and
its not exactly the most used interface even there.


