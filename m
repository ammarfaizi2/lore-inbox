Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317856AbSGRKkV>; Thu, 18 Jul 2002 06:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317857AbSGRKkV>; Thu, 18 Jul 2002 06:40:21 -0400
Received: from holomorphy.com ([66.224.33.161]:41098 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317856AbSGRKkT>;
	Thu, 18 Jul 2002 06:40:19 -0400
Date: Thu, 18 Jul 2002 03:43:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dipankar Sarma <dipankar@in.ibm.com>, Matthew Wilcox <willy@debian.org>,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] BH removal text
Message-ID: <20020718104302.GA1022@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	Matthew Wilcox <willy@debian.org>,
	Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <20020701050555.F29045@parcelfarce.linux.theplanet.co.uk> <20020714010506.GW23693@holomorphy.com> <20020714102219.A9412@in.ibm.com> <20020718082238.GO1096@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020718082238.GO1096@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 10:22:19AM +0530, Dipankar Sarma wrote:
>> Even if you replace timemr_bh() with a tasklet, you still need
>> to take the global_bh_lock to ensure that timers don't race with
>> single-threaded BH processing in drivers. I wrote this patch [included]
>> to get rid of timer_bh in Ingo's smptimers, but it acquires
>> global_bh_lock as well as net_bh_lock, the latter to ensure
>> that some older protocol code that expected serialization of
>> NET_BH and timers work correctly (see deliver_to_old_ones()).
>> They need to be cleaned up too.
>> My patch of course was experimental to see what is needed to
>> get rid of timer_bh. It needs some cleanup itself ;-)

On Thu, Jul 18, 2002 at 01:22:38AM -0700, William Lee Irwin III wrote:
> It turns out those profiling results are total garbage. oprofile
> hit counts during the tbench 1024 run with smptimers-X1 on the 16-way
> 16GB NUMA-Q follow:

Oh yes, bandwidth was increased from 23MB/s to 37MB/s.

And the rundown on .text.lock.dev:

c020249d 43051806 73.9493     .text.lock.dev
 c02024f9 10357    0.0240571
 c02024fc 121387   0.281956
 c02024fe 10282    0.0238829
 c0202515 5777619  13.4202
 c0202518 31534891 73.2487
 c020251a 5596759  13.0001
 c020251c 10       2.32278e-05
 c0202521 11       2.55506e-05
 c0202522 158      0.000367
 c0202523 34       7.89746e-05
 c0202524 34       7.89746e-05
 c0202529 61       0.00014169
 c020252a 125      0.000290348
 c020252b 36       8.36202e-05
 c020252c 42       9.75569e-05


c0202518:       f3 90                   repz nop 
c020251a:       7e f9                   jle    c0202515 <.text.lock.dev+0x78>
c020251c:       e9 83 e1 ff ff          jmp    c02006a4 <dev_queue_xmit+0x224>

[...]

c0200694:       e8 eb 78 f1 ff          call   c0117f84 <printk>
c0200699:       0f 0b                   ud2a   
c020069b:       7b 00                   jnp    c020069d <dev_queue_xmit+0x21d>
c020069d:       40                      inc    %eax
c020069e:       5c                      pop    %esp
c020069f:       29 c0                   sub    %eax,%eax
c02006a1:       83 c4 08                add    $0x8,%esp
c02006a4:       f0 fe 0f                lock decb (%edi)
c02006a7:       0f 88 68 1e 00 00       js     c0202515 <.text.lock.dev+0x78>
c02006ad:       8b 44 24 10             mov    0x10(%esp,1),%eax
c02006b1:       89 86 e8 00 00 00       mov    %eax,0xe8(%esi)
c02006b7:       8b 46 24                mov    0x24(%esi),%eax
c02006ba:       a8 01                   test   $0x1,%al
c02006bc:       0f 85 a1 00 00 00       jne    c0200763 <dev_queue_xmit+0x2e3>
c02006c2:       83 3d 60 5f 3b c0 00    cmpl   $0x0,0xc03b5f60
c02006c9:       74 0a                   je     c02006d5 <dev_queue_xmit+0x255>
c02006cb:       56                      push   %esi
c02006cc:       55                      push   %ebp
c02006cd:       e8 42 fc ff ff          call   c0200314 <dev_queue_xmit_nit>


This leads me to believe it's the dev->xmit_lock as that's protects the
critical section in which dev_queue_xmit_nit() is called.


Cheers,
Bill
