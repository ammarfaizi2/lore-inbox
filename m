Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbWG1FWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbWG1FWM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 01:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbWG1FWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 01:22:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:35165 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751773AbWG1FWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 01:22:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=JQcDjZ2qLcSQXS3xdFEGbL7MA1gL4rV7whiaz9uBhhna64nDelJ9IU12KWC3M6dthfNdUh738AwkJFS8ml8Psg/STA48RTcYXyS5YaumnxdD+RQDhNsl09t4pgKgLdYn9F6OCPJ+qkdWDin/Nu/nf1R5Z7hDqKSlSxU6MBF5Y6g=
Message-ID: <84144f020607272222o7b1d0270p997b8e3bf07e39e7@mail.gmail.com>
Date: Fri, 28 Jul 2006 08:22:10 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: tglx@linutronix.de
Subject: Re: [BUG] Lockdep recursive locking in kmem_cache_free
Cc: LKML <linux-kernel@vger.kernel.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Christoph Lameter" <clameter@sgi.com>
In-Reply-To: <1154044607.27297.101.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1154044607.27297.101.camel@localhost.localdomain>
X-Google-Sender-Auth: cf1554221071d3e0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 7/28/06, Thomas Gleixner <tglx@linutronix.de> wrote:
> x86_64, latest git
>
>         tglx
>
> [   57.971202] =============================================
> [   57.973118] [ INFO: possible recursive locking detected ]
> [   57.973231] ---------------------------------------------
> [   57.973343] events/0/5 is trying to acquire lock:
> [   57.973452]  (&nc->lock){.+..}, at: [<ffffffff8028f201>] kmem_cache_free+0x141/0x210
> [   57.973839]
> [   57.973840] but task is already holding lock:
> [   57.974040]  (&nc->lock){.+..}, at: [<ffffffff80290501>] cache_reap+0xd1/0x290
> [   57.974420]
> [   57.974421] other info that might help us debug this:
> [   57.974625] 3 locks held by events/0/5:
> [   57.974729]  #0:  (cache_chain_mutex){--..}, at: [<ffffffff80290458>] cache_reap+0x28/0x290
> [   57.975171]  #1:  (&nc->lock){.+..}, at: [<ffffffff80290501>] cache_reap+0xd1/0x290
> [   57.975610]  #2:  (&parent->list_lock){.+..}, at: [<ffffffff8028f572>] __drain_alien_cache+0x42/0x90
> [   57.976056]
> [   57.976057] stack backtrace:
> [   57.976250]
> [   57.976251] Call Trace:
> [   57.976447]  [<ffffffff802542fc>] __lock_acquire+0x8cc/0xcb0
> [   57.976562]  [<ffffffff80254a02>] lock_acquire+0x52/0x70
> [   57.976675]  [<ffffffff8028f201>] kmem_cache_free+0x141/0x210
> [   57.976790]  [<ffffffff804a6b74>] _spin_lock+0x34/0x50
> [   57.976903]  [<ffffffff8028f201>] kmem_cache_free+0x141/0x210
> [   57.977018]  [<ffffffff8028f388>] slab_destroy+0xb8/0xf0
> [   57.977131]  [<ffffffff8028f4c8>] free_block+0x108/0x170
> [   57.977245]  [<ffffffff8028f598>] __drain_alien_cache+0x68/0x90
> [   57.977360]  [<ffffffff80290501>] cache_reap+0xd1/0x290
> [   57.977473]  [<ffffffff8029069f>] cache_reap+0x26f/0x290
> [   57.977588]  [<ffffffff80249a13>] run_workqueue+0xc3/0x120
> [   57.977701]  [<ffffffff80290430>] cache_reap+0x0/0x290
> [   57.977814]  [<ffffffff80249c91>] worker_thread+0x121/0x160
> [   57.977928]  [<ffffffff802305d0>] default_wake_function+0x0/0x10
> [   57.978045]  [<ffffffff80249b70>] worker_thread+0x0/0x160
> [   57.978158]  [<ffffffff8024d7ba>] kthread+0xda/0x110
> [   57.978270]  [<ffffffff8020af2a>] child_rip+0x8/0x12
> [   57.978381]  [<ffffffff804a725b>] _spin_unlock_irq+0x2b/0x60
> [   57.978496]  [<ffffffff8020a53b>] restore_args+0x0/0x30
> [   57.978609]  [<ffffffff8024d6e0>] kthread+0x0/0x110
> [   57.978719]  [<ffffffff8020af22>] child_rip+0x0/0x12

Looks bad.

  cache_reap
  reap_alien	(grabs l3->alien[node]->lock)
  __drain_alien_cache
  free_block
  slab_destroy	(slab management off slab)
  kmem_cache_free
  __cache_free
  cache_free_alien (recursive attempt on l3->alien[node] lock)

Christoph?

                                        Pekka
