Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317141AbSFFTvX>; Thu, 6 Jun 2002 15:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317123AbSFFTvV>; Thu, 6 Jun 2002 15:51:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19729 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317157AbSFFTuW>;
	Thu, 6 Jun 2002 15:50:22 -0400
Message-ID: <3CFFBCA9.843C40F0@zip.com.au>
Date: Thu, 06 Jun 2002 12:48:57 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] CONFIG_NR_CPUS
In-Reply-To: <20020606.031520.08940800.davem@redhat.com> <1023377213.13787.2.camel@sinai>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Thu, 2002-06-06 at 03:15, David S. Miller wrote:
> 
> > Nice.  While you're at it can you fix the value on 64-bit
> > platforms when CONFIG_NR_CPUS is not specified?  (it should
> > be 64, not 32)
> 
> I agree, this is good.  I often am toying with some debugging aid that
> is an array of NR_CPUS and waste a lot of memory with NR_CPUS stuck at
> 32... no reason my kernels should not be set to 2 or whatever I need.
> 
> I have attached a patch that is Andrew's + your request, Dave.  Since
> what really determines the maximum number of CPUs is the size of
> unsigned long, I used that.  Cool?
> 
> ...
> +#define NR_CPUS        (sizeof(unsigned long) * 8)

OK.  What I'll do is:

#ifdef CONFIG_SMP
#define NR_CPUS CONFIG_NR_CPUS
#else
#define NR_CPUS 1
#endif

and then go edit every SMP-capable arch's config.in/Config.help
files.  But the arch maintainers should test one case please - x86
was locking up at boot on quad CPU with NR_CPUS=2.  Others may do
the same.

About a quarter of the bloat is runqueues.  If we could dynamically
allocate those in sched_init() it would be good, because presumably
vendor kernels will be configured for the maximum number of CPUs.

-
