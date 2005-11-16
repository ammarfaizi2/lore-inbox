Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030519AbVKPVwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030519AbVKPVwn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 16:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030521AbVKPVwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 16:52:42 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:1496 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030519AbVKPVwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 16:52:41 -0500
Subject: Re: 2.6.14 X spinning in the kernel
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       hugh@veritas.com, Dave Airlie <airlied@linux.ie>
In-Reply-To: <437B9FAC.4090809@qualcomm.com>
References: <1132012281.24066.36.camel@localhost.localdomain>
	 <20051114161704.5b918e67.akpm@osdl.org>
	 <1132015952.24066.45.camel@localhost.localdomain>
	 <20051114173037.286db0d4.akpm@osdl.org> <437A6609.4050803@us.ibm.com>
	 <437B9FAC.4090809@qualcomm.com>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 13:52:33 -0800
Message-Id: <1132177953.24066.80.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 13:07 -0800, Max Krasnyansky wrote:
> Badari Pulavarty wrote:
> >> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >>
> >>> On Mon, 2005-11-14 at 16:17 -0800, Andrew Morton wrote:
> >>>
> >>>> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >>>>
> >>>>> My 2-cpu EM64T machine started showing this problem again on 2.6.14.
> >>>>> On some reboots, X seems to spin in the kernel forever.
> >>>>>
> >>>>> sysrq-t output shows nothing.
> >>>>>
> >>>>> X             R  running task       0  3607   3589          3903
> >>>>> (L-TLB)
> >>>>>
> >>>>> top shows:
> >>>>> 3607 root      25   0     0    0    0 R 99.1  0.0 262:04.69 X
> >>>>>
> >>>>>
> >>>>> So, I wrote a module to do smp_call_function() on all CPUs
> >>>>> to show stacks on them. CPU0 seems to be spinning in exit_mmap().
> >>>>> I did this multiple times to collect stacks few times.
> >>>>>
> >>>>> Is this a known issue ?
> 
> I've seen similar problems on dual Opteron HP xw9300/Radeon 7000 PCI box with 2.6.11.12
> and latest X from Fedora x86-64 YUM repos.
> I haven't done any traces but it sounds like the same problem (ie X server is spinning).
> Disabling DRI in xorg.conf fixed it for me.

Okay. Thank you.

I traced it little further.

It looks like radeon_freelist_get() is always returning NULL.
Which seem to have 2 loops 
	- top loop is for for 10000 times (usec_timeout).
	- second one for length of the list ?

	for (t = 0; t < dev_priv->usec_timeout; t++)
		..
		for (i = start; i < dma->buf_count; i++) {

		..
		}
	}

Which is making it even worse. 

And also, radeon_cp_get_buffers() is getting called repeatedly.

Thanks,
Badari

