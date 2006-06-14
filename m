Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWFNRc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWFNRc0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 13:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWFNRcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 13:32:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10477 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751045AbWFNRcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 13:32:25 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: The i386 and x86_64 genirq patches are wrong!
References: <m1r71t2ew8.fsf@ebiederm.dsl.xmission.com>
	<20060614070353.GA11896@elte.hu>
Date: Wed, 14 Jun 2006 11:31:59 -0600
In-Reply-To: <20060614070353.GA11896@elte.hu> (Ingo Molnar's message of "Wed,
	14 Jun 2006 09:03:53 +0200")
Message-ID: <m1y7vzzlrk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> here too it's hard for me to give an answer without seeing your specific 
> changes (against whatever base is most convenient to you). MSI certainly 
> works fine on current -mm. (at least on my box)

Ok.  Looking closer.  I have found a clear functional bug.

When CONFIG_PCI_MSI is not set.
  move_irq expands to move_native_irq.

  ack_ioapic_vector
    move_native_irq
    ack_ioapic_irq
      move_irq
        move_native_irq

  ack_ioapic_quirk_vector
    move_native_irq
    ack_ioapic_quirk_irq
      move_irq
        move_native_irq

So we wind up calling move_native_irq twice when MSI is disabled where
before your conversion we only ever called it once.  Luckily in
the case where we have the double call vector_to_irq is a noop so
we only migration the same irq twice.

Eric
