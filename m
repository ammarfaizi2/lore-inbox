Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267720AbUHJUgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267720AbUHJUgw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267725AbUHJUgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:36:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21708 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267720AbUHJUg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:36:26 -0400
Date: Tue, 10 Aug 2004 13:36:09 -0700
From: "David S. Miller" <davem@redhat.com>
To: hpa@zytor.com (H. Peter Anvin)
Cc: linux-kernel@vger.kernel.org
Subject: Re: AES assembler optimizations
Message-Id: <20040810133609.4f1ca352.davem@redhat.com>
In-Reply-To: <cfb901$ctg$1@terminus.zytor.com>
References: <2riR3-7U5-3@gated-at.bofh.it>
	<m3d620v11e.fsf@averell.firstfloor.org>
	<1092067328.4332.40.camel@orion>
	<20040809171231.GG2716@mea-ext.zmailer.org>
	<cfb901$ctg$1@terminus.zytor.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004 19:51:29 +0000 (UTC)
hpa@zytor.com (H. Peter Anvin) wrote:

> It's not really that hard, you just have to have enough work to
> amortize it over.  The two metrics are: how much work do you get per
> call, and how much work do you get before the next schedule().

Someone might want to investigate using sparc64's FPU saving
scheme on x86, if possible.  It might make the cut-off point
smaller.

On sparc64, we:

1) Always save the full FPU state at context switch time if it
   is active.

2) On entry to a FPU-using kernel routine, we save the FPU if
   it is active.

3) On exit from a FPU-using kernel routine, we do nothing
   except mark the FPU as inactive.

4) FPU-disabled traps by the user restore the state saved
   by #1 or #2

Not that this means FPU state can be recursively saved.
For example, if a FPU memcpy take an interrupt, and the interrupt
handler invokes a FPU memcpy, it works just fine.

This works extremely well for cases such as:

   The user made the FPU active, but it is not going to
   use the FPU for quite some time.  The kernel can use
   the FPU multiple times, and only need to save state once.

It's worked extremely well in practice.  We store the stack
of FPU states at the end of the thread_struct area.  This
provides better cache behavior than storing it on the local
kernel stack each time the kernel wants to use the FPU (Solaris
on UltraSPARC chooses this method BTW).
