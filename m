Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131498AbRBJOsy>; Sat, 10 Feb 2001 09:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131469AbRBJOsl>; Sat, 10 Feb 2001 09:48:41 -0500
Received: from colorfullife.com ([216.156.138.34]:10245 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131498AbRBJOsY>;
	Sat, 10 Feb 2001 09:48:24 -0500
Message-ID: <3A8554D1.96ED1238@colorfullife.com>
Date: Sat, 10 Feb 2001 15:48:49 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jes Sorensen <jes@linuxcare.com>
CC: Ion Badulescu <ionut@cs.columbia.edu>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, Alan Cox <alan@redhat.com>,
        linux-kernel@vger.kernel.org, Donald Becker <becker@scyld.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <Pine.LNX.4.30.0102081259090.31024-100000@age.cs.columbia.edu> <3A831313.A23EE2A1@colorfullife.com> <d38znfwmzq.fsf@lxplus015.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jes,

I read through your acenic driver and noticed that you replaced
spinlocks with bitops.

Is that a good idea? I always avoid bitops and replace them with
spinlocks:

* On uniprocessor they are obviously slower.
* on SMP i386 spin_lock() / spin_unlock() is faster than
test_and_set_bit()/clear_bit(): the spinlock operations have a
direction, and thus no memory barrier is required in spin_unlock,
Intel's default memory ordering is sufficient. clear_bit() doesn't know
that it will be used to end a protected area, thus it needs a full
memory barrier.

* on ia64 spinlocks are probably faster, and it seems that clear_bit()
instead of spin_unlock() might even cause races:
spin_unlock() needs a 'release' memory barrier, but clear_bit() contains
an 'acquire' memory barrier.

I only see 2 advantages for bitops:
* you can avoid disabling local interrupts in hard_tx_xmit() or other
bottom half handlers, but often you only need the disabled interrupts
for a few instructions.
* you won't spin - but spinning should be rare, or you can use
spin_trylock().

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
