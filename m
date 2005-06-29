Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262731AbVF2Xeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbVF2Xeu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 19:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbVF2Xeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 19:34:50 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:23199 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262731AbVF2Xep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 19:34:45 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Date: Thu, 30 Jun 2005 01:36:00 +0200
User-Agent: KMail/1.8.1
Cc: William Weston <weston@sysex.net>, linux-kernel@vger.kernel.org
References: <200506281927.43959.annabellesgarden@yahoo.de> <200506291648.16601.annabellesgarden@yahoo.de> <20050629193804.GA6256@elte.hu>
In-Reply-To: <20050629193804.GA6256@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200506300136.01061.annabellesgarden@yahoo.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 29. Juni 2005 21:38 schrieb Ingo Molnar:
> 
> * Karsten Wiese <annabellesgarden@yahoo.de> wrote:
> 
> > attached patch for io_apic.c lets
> > 1. gcc 3.4.3 optimize io_apic access a little better.
> > 2. CONFIG_X86_UP_IOAPIC_FAST work here.
> >    Didn't check, if it really speeds up things.
> 
> which change made CONFIG_X86_UP_IOAPIC_FAST work on your box? It seems 
> you've changed the per-register frontside read-cache to something else - 
> was that on purpose?
> 
CONFIG_X86_UP_IOAPIC_FAST started working here, when I made io_apic_modify()
look like that:

void io_apic_modify(unsigned int apic, unsigned int reg, unsigned int val)
{
#ifdef IOAPIC_CACHE
	io_apic_cache[apic][reg] = val;
#endif
//	if (unlikely(sis_apic_bug))
commented this ^^ out 

		*IO_APIC_BASE(apic) = reg;
	*(IO_APIC_BASE(apic)+4) = val;
#ifndef IOAPIC_POSTFLUSH
	if (unlikely(sis_apic_bug))
#endif
		/*
		 * Force POST flush by reading:
 		 */
		val = *(IO_APIC_BASE(apic)+4);
}

This change does it, 'cause when we read a cached value instead of from the ioapic,
the ioapic's address register isn't set and thus the following write in io_apic_modify
might not scratch the right ioapic register.

On top of the above the patch adds
	unsigned int reg;
to io_apic_cache.
with that "reg" struct member a mark -1 can be set, when we read from cache,
or the reg-number, when we read from the ioapic.
Then by comparing parameter reg with io_apic_cache[apic].reg
the patched io_apic_modify() knows, if it has to set the address register or not.
The register caching in the patch should be the same as before,
only the cache changed from a 2 dimensional array
to an array holding structs, which contain an array:
io_apic_cache[apic][reg] should be equivalent to io_apic_cache[apic].val[reg], no?

Karsten




	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
