Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266631AbSKZUd7>; Tue, 26 Nov 2002 15:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266652AbSKZUd7>; Tue, 26 Nov 2002 15:33:59 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:9711
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266631AbSKZUd6>; Tue, 26 Nov 2002 15:33:58 -0500
Date: Tue, 26 Nov 2002 15:43:41 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: chrisl@vmware.com
cc: USB Devel <linux-usb-users@lists.sourceforge.net>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: EHCI Kernel panic on current BK 2.5
In-Reply-To: <20021126184536.GB1519@vmware.com>
Message-ID: <Pine.LNX.4.50.0211261532020.1462-100000@montezuma.mastecende.com>
References: <20021126184536.GB1519@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2002 chrisl@vmware.com wrote:

> I try to setup the usb 2.0 hard disk on my desktop in 2.5.
> It works great with uhci driver. (2.4 and 2.5).
>
> When I try modprobe ehci-hcd in 2.5. Kernel panic. It seems
> that kernel OOPS inside the panic handle code again.
>
> I can't get the full OOPS from the serial console either.
>
> I am typing it here. I can only see the last screen.
> It might have some typo and emotion.
>
> EIP is at scheduler_tick+0x92/0x360
> eax: 00000000 ebx: 00000000 ecx: 00000001  edx: 00000003
> esi: dd5e3000 edi: 00000001 ebp: dd5b9ed0  esp: dd5b9ec0
> ds: 0068   es: 0068  ss:068
> Process (pid:26, threadinfo=dd5b8000 task=dd5e3000)
> Stack: 0000002 000000 0000001 000000 dd5b9f80

Possibly it could be this?

/* Task might have expired already, but not scheduled off yet */
if (p->array != rq->active) {
	set_tsk_need_resched(p); <-- [1]
	return;
}

static inline void set_ti_thread_flag(struct thread_info *ti, int flag)
{
	set_bit(flag,&ti->flags); <-- [2]
}

static __inline__ void set_bit(int nr, volatile unsigned long * addr)
{
	__asm__ __volatile__( LOCK_PREFIX
		"btsl %1,%0"
		:"=m" (ADDR)
		:"Ir" (nr));
}

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f ab 50 08               bts    %edx,0x8(%eax)
Code;  00000004 Before first symbol
   4:   8d 65 f4                  lea    0xfffffff4(%ebp),%esp

So addr was NULL it seems, perhaps we're not supposed to be in here in the
first place ?

-- 
function.linuxpower.ca
