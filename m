Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbWI0LiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWI0LiT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 07:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030182AbWI0LiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 07:38:19 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:13802 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030181AbWI0LiQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 07:38:16 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Aubrey <aubreylee@gmail.com>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Date: Wed, 27 Sep 2006 13:37:52 +0200
User-Agent: KMail/1.9.4
Cc: "Luke Yang" <luke.adi@gmail.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>, "Getz, Robin" <Robin.Getz@analog.com>
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com> <200609251905.22224.arnd@arndb.de> <6d6a94c50609270304o79947064y3019dd5f82eb8373@mail.gmail.com>
In-Reply-To: <6d6a94c50609270304o79947064y3019dd5f82eb8373@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609271337.53485.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 September 2006 12:04, Aubrey wrote:
> inline static void default_idle(void)
> {
>        int flag;
> 
>        while (!need_resched()) {
>                leds_switch(LED_OFF);
>                local_irq_save(flag);
>                if ( likely(!need_resched()) {
> #if defined (ANOMALY_05000244) && defined (CONFIG_BLKFIN_CACHE)
>                      __asm__("nop; nop;\n");
> #endif
>                      __asm__(".align 64;\n STI %0; IDLE;\n"
>                              : %0 (flag): :"cc");
>                }
>                local_irq_restore(flag);
>                leds_switch(LED_ON);
>        }
> }======================================
> 
> Here, according to design, it's not possible that interrupt occurs
> between "STI %0"(enable interrupt) and "IDLE".
> 
> __asm__(".align 64; STI %0; IDLE;" : %0 (x):  :"cc");
> 
> Robin can explain more details.

Ok, looks good now. Just a few details that don't impact the 
functionality:

- Always use 'static inline', not 'inline static', because of C99
- In the kernel, it's more common to use 'asm' than '__asm__'.
- It should probably be 'asm volatile', since gcc might notice
  that the output (flag) is not used anywhere and it can therefore
  eliminate the asm.
- Usually, I recommend using local_irq_disable() instead of
  local_irq_save(flags) when you know that interrupts are enabled
  before. It uses one less local variable, which makes it more
  efficient on some architectures.
- I'd insert the two NOPs unconditionally here for better
  readability.

	Arnd <><
