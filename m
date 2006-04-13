Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWDMGFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWDMGFV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 02:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWDMGFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 02:05:21 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:63960 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932410AbWDMGFU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 02:05:20 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Dave Dillow <dave@thedillows.org>
Subject: Re: [PATCH] deinline a few large functions in vlan code v2
Date: Thu, 13 Apr 2006 09:04:56 +0300
User-Agent: KMail/1.8.2
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com
References: <200604071628.30486.vda@ilport.com.ua> <200604121155.55561.vda@ilport.com.ua> <1144862325.18319.32.camel@dillow.idleaire.com>
In-Reply-To: <1144862325.18319.32.camel@dillow.idleaire.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604130904.57054.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 April 2006 20:18, Dave Dillow wrote:
> > > or loaded. And even if it saves 200 bytes in one 
> > > module, unless that module text was already less than 200 bytes into a
> > > page, you've saved no memory -- a 4300 byte module takes 2 pages on x86,
> > > as does a 4100 byte module.
> > 
> > Sometimes, those 200 bytes can bring module size just under 4096.
> > Thus on the average, on many modules you get the same size savings
> > as on built-in code. (Not that we have THAT many network modules...)
> 
> You're making a bogus leap from "sometimes" to "average".

It's not bogus. See below.

> Assuming an even distribution of lengths mod 4096, less than 5% of the
> time will 200 bytes save any memory on a module.

Ok, imagine perfect module size distribution, and suppose we shave 204
bytes off each module. 5% of the modules will have their size reduced
so that they occupy one 4k page less.

Those 5% of modules will have their RAM footprint reduced not
by just 204 bytes, but by 4096 bytes.

Total RAM footprint of all modules, in kb (N=number of modules):
before: sum_of_orig_module_size
after, modular: sum_of_orig_module_size - 0.05*N * 4096
after, builtin: sum_of_orig_module_size - N * 204

0.05*4096 = 204.53

> I don't like "VLAN_ENABLED" as a global define -- it looks too much like
> something local. The CONFIG_VLAN... defines were more descriptive.

That will require Kconfig changes. Maybe you would like "VLAN_ENABLED_KERNER"
name? It doesn't sound local...

> I didn't think about this before, but I'm pretty sure you're taking away
> functionality. When I wrote the typhoon driver, ISTR that I looked
> through the vlan implantation, and determined that all the #ifdefs on
> CONFIG_VLAN_8021Q were not really needed, since all the hooks were
> there. You could just load the 8021q module (even perhaps building it at
> a later date), and it would work if you had filled in the hooks in
> struct net_device. So I didn't #ifdef out code in my driver to let the
> user have the option.

IOW: currently most of VLAN code is already in kernel.
Then why do we have VLAN as a config option? Let's make it unconditional
(will add only 10k to core kernel)?

# size net/8021q/8021q.o
   text    data     bss     dec     hex filename
   9379     484     136    9999    270f net/8021q/8021q.o

> You're taking that away in the name of a total of 5K, which most users
> won't actually get back?

It started as a kernel-wide audit for huge inlines, I was not aiming
at VLAN particularly. But yes, when I saw other (not related to inlines)
opportunities to make code smaller, I decided to do it.

You know, people say that even Linux is getting fat these days.
--
vda
