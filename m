Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274986AbTHQB0i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 21:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274992AbTHQB0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 21:26:38 -0400
Received: from are.twiddle.net ([64.81.246.98]:34193 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S274986AbTHQB0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 21:26:37 -0400
Date: Sat, 16 Aug 2003 18:25:51 -0700
From: Richard Henderson <rth@twiddle.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jakub@redhat.com,
       szepe@pinerecords.com, jamagallon@able.es, kwall@kurtwerks.com,
       lcapitulino@prefeitura.sp.gov.br, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: 2.6-test2: gcc-3.3.1 warning.
Message-ID: <20030817012551.GB22022@twiddle.net>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, jakub@redhat.com,
	szepe@pinerecords.com, jamagallon@able.es, kwall@kurtwerks.com,
	lcapitulino@prefeitura.sp.gov.br, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <20030729002221.GD263@kurtwerks.com> <20030729045512.GM32673@louise.pinerecords.com> <20030729092857.GA28348@werewolf.able.es> <20030729093521.GA1286@louise.pinerecords.com> <20030729094820.GC28348@werewolf.able.es> <20030729095858.GB1286@louise.pinerecords.com> <20030729101126.GC29124@werewolf.able.es> <20030729102007.GC1286@louise.pinerecords.com> <1059479661.3118.5.camel@dhcp22.swansea.linux.org.uk> <20030729083507.3dd20485.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729083507.3dd20485.rddunlap@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 08:35:07AM -0700, Randy.Dunlap wrote:
> I really hate to get this back to the original problem, but is
> the reported warning a gcc 3.3.x problem?  I don't see the assembly
> problem here.
> 
> | arch/i386/kernel/reboot.c: In function `machine_restart':
> | arch/i386/kernel/reboot.c:261: warning: use of memory input without
> | lvalue in asm operand 0 is deprecated


	static long no_idt[2];
	...
	__asm__ __volatile__("lidt %0": :"m" (no_idt));

Notice that no_idt is an array.  Therefore its identifier decays
into a pointer.  Therefore, what this statement is really asking
for is

	{
	  long *tmp = no_idt;
	  asm volatile ("lidt %0" : : "m" (*&tmp));
	}

which is clearly not what was intended.

Fixed by doing

	__asm__ __volatile__("lidt %0": :"m" (*no_idt));



r~
