Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWDMKDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWDMKDE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 06:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWDMKDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 06:03:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43935 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964867AbWDMKDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 06:03:02 -0400
To: "Magnus Damm" <magnus.damm@gmail.com>
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       "Magnus Damm" <magnus@valinux.co.jp>
Subject: Re: [Fastboot] Re: [PATCH] Kexec: Remove order
References: <20060413030040.20516.9231.sendpatchset@cherry.local>
	<m164le6rcg.fsf@ebiederm.dsl.xmission.com>
	<aec7e5c30604122321p2bedb370l945009ccdb725bac@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 13 Apr 2006 04:01:37 -0600
In-Reply-To: <aec7e5c30604122321p2bedb370l945009ccdb725bac@mail.gmail.com> (Magnus
 Damm's message of "Thu, 13 Apr 2006 15:21:51 +0900")
Message-ID: <m1wtdt6bge.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Magnus Damm" <magnus.damm@gmail.com> writes:

> On 4/13/06, Eric W. Biederman <ebiederm@xmission.com> wrote:

>> Feel free to fix x86_64, to use only page sized allocates.
>
> I will. But first - questions:
>
> Should KEXEC_CONTROL_CODE_SIZE be left in even if it's always 4096?

So far I don't see a compelling case to remove it.  To a certain
extent I am happily surprised to see that everyone's code
across several architectures has managed to fit in 4KB.

> Do you like how I added image->arch_private?

At a quick glance I couldn't make sense of the interactions.
So I totally missed that.

So you actually did 3 things at once. That makes a very hard
to digest patch.

>> Until I see a reasonable argument that none of the architectures
>> currently supported by the linux kernel would need a multi order
>> allocation for a kexec port am I interested in removing support.
>
> I argue that it is quite pointless to have code to support N-order
> allocations that no one is using. Especially since the code is more
> complex and it may be harder for the buddy allocator to fulfill
> N-order allocations compared to 0-order allocations.

The complexity as your patch shows is currently is 2 for loops.
Refactoring the entire code base to save 2 for loops when
using N-order allocations are totally voluntary is over kill.

Most of the complexity in the code actually comes from having
to use 0-order allocations.

> And on top of the reasons above I'd like to stay away from N-order
> allocations because Xen doesn't guarantee that (pseudo-)physical pages
> handled out by the buddy allocator are contiguous.

Yes. Xen doesn't have enough sense to use 4MB pages so kernels can
execute efficiently.  That may be overly harsh.  But given the
efficiency that you can get from using large pages in the kernel
not guaranteeing large page allocations seems quite foolish.

>> As I recall the alpha had an architectural need for a 32KB
>> allocation or something like that.
>
> Oh. So if someone is working on kexec for alpha I guess we need
> N-order allocations, right?

To be clear.  Until some one shows me that on no architecture
that the linux kernel supports there are no data structures
that the cpus use directly that exceed 1 page there is the potential
to need > 0 order allocations.

My investigation into the basic problem says the are occasions
when order-N allocations are needed.

I am overjoyed that currently there are multiple architectures
supported by kexec but the porting work has yet to slow
down as your Xen work shows.

kexec currently does not have the volume of development and the number
of people who understand it to handle being refactored very often.
For preparation phase we are likely ok.  For later when it gets into
very tricky arch specific assembly things are much worse.  Unless the
basic skeleton gets it the way please use what is provided has been 
debugged.

Eric
