Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWFXEQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWFXEQE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 00:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWFXEQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 00:16:04 -0400
Received: from dsl-202-45-110-141-static.VIC.netspace.net.au ([202.45.110.141]:27588
	"EHLO firewall.reed.wattle.id.au") by vger.kernel.org with ESMTP
	id S932160AbWFXEQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 00:16:03 -0400
From: Darren Reed <darrenr@reed.wattle.id.au>
Message-Id: <200606240247.k5O2lU3C009083@firewall.reed.wattle.id.au>
Subject: Re: 2.6.11: spinlock problem
In-Reply-To: <Pine.LNX.4.61.0606231331310.16810@chaos.analogic.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Date: Sat, 24 Jun 2006 12:47:30 +1000 (EST)
CC: Darren Reed <darrenr@reed.wattle.id.au>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL107a (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Charset ISO-8859-1 unsupported, converting... ]
> On Fri, 23 Jun 2006, Darren Reed wrote:
> 
> > Hi,
> >
> > I'm seeing a spinlock held panic with a kernel stack like this:
> >
> > spinlock - panic, lock already held
> > ..
> > __do_softirq
> > do_softirq
> > =========
> > do_IRQ
> > common_interrupt
> > spinlock/spinunlock
> > ..
> >
> > when I load up the system in testing.
> > The code protected by the spinlock is quite small - counter increment.
> >
> > I'm using 2.6.11-1.1369_FC4 #1, installed inside of vmware,
> > running as a guest on a Windows XP box.
> >
> > Is this
> > (a) linux allowing the IRQ too early
> > (b) vmware not doing something right
> > (c) enivitable
> > (d) somehow my fault
> > (e) something else?
> >
> > Thanks,
> > Darren
> 
> Where's the code? Also, did you initialize the spin-lock variable
> before use?

locks are intialised...code runs for a minute or so before panic'ing

I write my own wrappers to read/write_lock/unlock.

The call stack for the panic is:
panic
ipf_read_enter
..
do_softirq
=====
do_IRQ
common_interrupt
ipf_rw_exit

ipf_read_enter and ipf_rw_exit are being called for different locks.
The panic is occuring in the spin_lock() for the counter increment.
The counter incrememnt/decrement uses the same lock, regardless of
the counter being used.

I believe I'm hitting a race condition of sorts...I just don't know
who owns it yet - vmware or linux and I cant test running linux
natively at present because I only have one computer.

Darren

INLINE void ipf_rw_exit(rwlk)
ipfrwlock_t *rwlk;
{
        if (rwlk->ipf_isw > 0) {
                rwlk->ipf_isw = 0;
                write_unlock(&rwlk->ipf_lk);
        } else if (rwlk->ipf_isr > 0) {
                ATOMIC_DEC32(rwlk->ipf_isr);
                read_unlock(&rwlk->ipf_lk);
        } else {
                panic("rwlk->ipf_isw %d isr %d rwlk %p name [%s]\n",
                      rwlk->ipf_isw, rwlk->ipf_isr, rwlk, rwlk->ipf_lname);
        }
}

INLINE void ipf_read_enter(rwlk)
ipfrwlock_t *rwlk;
{
        read_lock(&rwlk->ipf_lk);
        ATOMIC_INC32(rwlk->ipf_isr);
}

#  define       ATOMIC_INC32(x)         MUTEX_ENTER(&ipf_rw); (x)++; \
                                        MUTEX_EXIT(&ipf_rw)
#  define       ATOMIC_DEC32(x)         MUTEX_ENTER(&ipf_rw); (x)--; \
                                        MUTEX_EXIT(&ipf_rw)
#  define       MUTEX_ENTER(x)          spin_lock(&(x)->ipf_lk)
#  define       MUTEX_EXIT(x)           spin_unlock(&(x)->ipf_lk)

