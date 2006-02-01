Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWBABFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWBABFy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 20:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWBABFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 20:05:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45524 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751319AbWBABFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 20:05:53 -0500
Date: Tue, 31 Jan 2006 16:55:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: jgarzik@pobox.com, herbert@gondor.apana.org.au, mingo@elte.hu,
       linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [PATCH] 8139too: fix a TX timeout watchdog thread against NAPI
 softirq race
Message-Id: <20060131165525.3e741285.akpm@osdl.org>
In-Reply-To: <20060131002418.GA917@electric-eye.fr.zoreil.com>
References: <E1F2JFb-0007MW-00@gondolin.me.apana.org.au>
	<43D98915.6040004@pobox.com>
	<20060131002418.GA917@electric-eye.fr.zoreil.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@fr.zoreil.com> wrote:
>
> +	unsigned int watchdog_fired : 1;
>  	unsigned int default_port : 4;	/* Last dev->if_port value. */
>  	unsigned int have_thread : 1;

Bear in mind that the compiler will put these three fields into the same
word and will use non-atomic RMWs when they are modified.

In this particualr case it's hard to see how an SMP or IRQ race can occur,
but it's a trap.   Which won't show up on x86.


struct x {
	unsigned int a:1;
	unsigned int b:1;
};

void foo(struct x *a)
{
	a->a = 1;
}

void bar(struct x *a)
{
	a->b = 1;
}


On ppc:


foo:
        lwz 0,0(3)
        oris 0,0,0x8000
        stw 0,0(3)
        blr
        .size   foo, .-foo
        .align 2
        .globl bar
        .type   bar, @function
bar:
        lwz 0,0(3)
        oris 0,0,0x4000
        stw 0,0(3)
        blr
