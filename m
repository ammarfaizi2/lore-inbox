Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVAXRmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVAXRmz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 12:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVAXRmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 12:42:55 -0500
Received: from aun.it.uu.se ([130.238.12.36]:28826 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261532AbVAXRmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 12:42:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16885.13185.849070.479328@alkaid.it.uu.se>
Date: Mon, 24 Jan 2005 18:42:25 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BUG: 2.6.11-rc2 and -rc1 hang during boot on PowerMacs
In-Reply-To: <1106529935.5587.9.camel@gaston>
References: <200501221723.j0MHN6eD000684@harpo.it.uu.se>
	<1106441036.5387.41.camel@gaston>
	<1106529935.5587.9.camel@gaston>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt writes:
 > On Sun, 2005-01-23 at 11:43 +1100, Benjamin Herrenschmidt wrote:
 > 
 > > I know about this problem, I'm working on a proper fix. Thanks for your
 > > report.
 > 
 > Can you send me the PVR value for both of these CPUs
 > (cat /proc/cpuinfo) ? I can't find right now why they would lock up
 > unless the default idle loop is _not_ run properly, that is for some
 > reason, NAP or DOZE mode end up not beeing enabled. Can you send me
 > your .config as well ?

=== cpuinfo.emac ===
processor	: 0
cpu		: 7447/7457, altivec supported
clock		: 1249MHz
revision	: 1.1 (pvr 8002 0101)
bogomips	: 830.66
machine		: PowerMac6,4
motherboard	: PowerMac6,4 MacRISC3 Power Macintosh 
detected as	: 287 (Unknown Intrepid-based)
pmac flags	: 00000000
L2 cache	: 512K unified
memory		: 256MB
pmac-generation	: NewWorld

=== cpuinfo.beige-g3 ===
processor	: 0
cpu		: 7455, altivec supported (a Sonnet G4 upgrade processor)
clock		: 66MHz <-- bogus, is 1.0GHz in reality
revision	: 2.1 (pvr 8001 0201)
bogomips	: 999.42
machine		: Power Macintosh
motherboard	: AAPL,Gossamer MacRISC
detected as	: 48 (PowerMac G3 (Gossamer))
pmac flags	: 00000000
memory		: 768MB
pmac-generation	: OldWorld

The .config files are a bit big, I'm sending them off-list.

 > Finally, try that patch and tell me if it makes a difference. It makes
 > sure we re-enable interrupts in cpu_idle, and thus should only be a
 > workaround. I found _one_ actual code path where we fail to re-enable
 > them, and this is when neither DOZE nor NAP mode is enabled, which
 > should not happen on any G3 (they should all support DOZE mode), and
 > might happe non some G4s if the chipset doesn't support NAP or
 > powersave_nap is set to 0 in proc, but that shouldn't be the case of an
 > eMac neither...
 > 
 > --- linux-work.orig/arch/ppc/kernel/idle.c	2005-01-24 11:42:35.000000000 +1100
 > +++ linux-work/arch/ppc/kernel/idle.c	2005-01-24 12:19:41.114353760 +1100
 > @@ -39,17 +39,15 @@
 >  	powersave = ppc_md.power_save;
 >  
 >  	if (!need_resched()) {
 > +		local_irq_enable();
 >  		if (powersave != NULL)
 >  			powersave();
 >  		else {
 >  #ifdef CONFIG_SMP
 >  			set_thread_flag(TIF_POLLING_NRFLAG);
 > -			local_irq_enable();
 >  			while (!need_resched())
 >  				barrier();
 >  			clear_thread_flag(TIF_POLLING_NRFLAG);
 > -#else
 > -			local_irq_enable();
 >  #endif
 >  		}
 >  	}

Yes, this patch made the eMac boot Ok -- I can't test the Beige G3 until Friday.

/Mikael
