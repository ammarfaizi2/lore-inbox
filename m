Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317375AbSGOPUd>; Mon, 15 Jul 2002 11:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317378AbSGOPUc>; Mon, 15 Jul 2002 11:20:32 -0400
Received: from ns.suse.de ([213.95.15.193]:8204 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317375AbSGOPUa>;
	Mon, 15 Jul 2002 11:20:30 -0400
Date: Mon, 15 Jul 2002 17:23:22 +0200
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       mingo@redhat.com, Linus Torvalds <torvalds@transmeta.com>,
       davidm@hpl.hp.com, ralf@gnu.org, paulus@samba.org, anton@samba.org,
       schwidefsky@de.ibm.com, ak@suse.de, davem@redhat.com
Subject: Re: [PATCH] 2.5.25 Hotplug CPU boot changes
Message-ID: <20020715172322.B13036@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	mingo@redhat.com, Linus Torvalds <torvalds@transmeta.com>,
	davidm@hpl.hp.com, ralf@gnu.org, paulus@samba.org, anton@samba.org,
	schwidefsky@de.ibm.com, ak@suse.de, davem@redhat.com
References: <20020715090336.19E604130@lists.samba.org> <1026736141.13885.105.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026736141.13885.105.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 01:29:01PM +0100, Alan Cox wrote:

 > Q: What prevents a CPU coming up -during- an MTRR change once the rest
 > of the cpu hot plugging is present ?

"The force". The more I think about mtrr.c and hotplug, the more I
regret having eaten lunch today.  I'm not convinced it will do the right
thing at all with hotplug. init_secondary_cpu() does no frobbing of
the MSRs. For this we relied upon that IPI from cpu #0, which we never
saw. Ugh. horrid.

So possible issues are..

1. cpu #0 sets MSRs, then sets off an IPI. cpu #n isn't 'plugged' yet,
   so we miss the IPI and new processors don't get the MSRs poked,
   but get their 'state' set so it appears to be ok, but isn't.
2. init on secondary cpu's probably needs to wait until the boot CPU mtrr
   code is in a 'known safe' state before it does the magickal
   'sync based on whats in cpu #0'
3. What happens when cpu #0 has finished poking registers, and then sets
   off an IPI to resync the others, when cpu #n hasn't gotten as far in the
   boot sequence to handle that IPI correctly yet ?

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
