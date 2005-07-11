Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVGKPXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVGKPXh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVGKPVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:21:30 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:19914 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S261967AbVGKPUO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:20:14 -0400
Message-ID: <42D28E2B.7050707@cosmosbay.com>
Date: Mon, 11 Jul 2005 17:20:11 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] eventpoll : Suppress a short lived lock from struct file
References: <4263275A.2020405@lab.ntt.co.jp>  <20050418040718.GA31163@taniwha.stupidest.org>  <4263356D.9080007@lab.ntt.co.jp>  <20050418044223.GB15002@nevyn.them.org>  <1113800136.355.1.camel@localhost.localdomain>  <Pine.LNX.4.58.0504172159120.28447@bigblue.dev.mdolabs.com>  <42D21D43.3060300@cosmosbay.com> <1121070867.24086.6.camel@localhost.localdomain> <42D23BDF.8020701@cosmosbay.com> <Pine.LNX.4.63.0507110642550.7209@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.63.0507110642550.7209@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 11 Jul 2005 17:20:12 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi a écrit :

> Eric, I can't really say I like this one. Not at least after extensive 
> tests run on top of it.

fair enough :)

> You are asking to add a bottleneck to save 8 
> bytes on an entity that taken alone in more than 120 bytes. Consider 
> that when you have a "struct file" allocated, the cost on the system is 
> not only the struct itself, but all the allocations associated with it. 
> For example, if you consider that a case where you might feel a "struct 
> file" pressure is when you have hundreds of thousands of network 
> connections, the 8 bytes saved compared to all the buffers associated 
> with those sockets boils down to basically nothing.

Well, the filp_cachep slab is created with SLAB_HWCACHE_ALIGN, enforcing a alignment of 64 bytes or even 128 bytes.

So it can be usefull to let the size of struct file goes from 0x84 to 0x80, because we can gain 64 or 128 bytes per file (0x80 bytes really 
allocated instead of 0xc0 or even 0x100 on Pentium 4).

In my case, I use other patches outside the scope of eventpoll (like declaring f_security only #ifdef CONFIG_SECURITY_SELINUX), and really 
gain 128 bytes of low memory per file. It reduces cache pressure for a given workload, and reduce lowmem pressure.

Before :

# grep filp /proc/slabinfo
filp               66633  66750    256   15    1 : tunables  120   60    8 : slabdata   4450   4450     60


After :

# grep filp /proc/slabinfo
filp               82712  82987    128   31    1 : tunables  120   60    8 : slabdata   2677   2677     20


It may appears to you as a penalty, but at least for me it is a noticeable gain.

Another candidate to "file struct" size reduction is the big struct file_ra_state that is included in all files, even sockets that dont use 
it, but that's a different story :)

Eric
