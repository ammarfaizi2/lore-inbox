Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbTDPNKP (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 09:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbTDPNKO 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 09:10:14 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:1780 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264340AbTDPNKN (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 09:10:13 -0400
Date: Wed, 16 Apr 2003 09:22:03 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@muc.de, akpm@digeo.com, linux-kernel@vger.kernel.org, anton@samba.org,
       schwidefsky@de.ibm.com, davidm@hpl.hp.com, matthew@wil.cx,
       ralf@linux-mips.org, rth@redhat.com
Subject: Re: Reduce struct page by 8 bytes on 64bit
Message-ID: <20030416092203.R13397@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20030415112430.GA21072@averell> <20030416.054521.26525548.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030416.054521.26525548.davem@redhat.com>; from davem@redhat.com on Wed, Apr 16, 2003 at 05:45:21AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 05:45:21AM -0700, David S. Miller wrote:
>    From: Andi Kleen <ak@muc.de>
>    Date: Tue, 15 Apr 2003 13:24:30 +0200
>    
>    I worked around this by declaring a new data type atomic_bitmask32
>    with matching set_bit32/clear_bit32 etc. interfaces. Currently only 
>    on x86-64 aomitc_bitmask32 is defined to unsigned, everybody else
>    still uses unsigned long. The other 64bit architectures can define it to
>    unsigned too if they can confirm that it's ok to do.
> 
> I have no problem with this.
> 
> If you are clever, you can define a generic version even for the
> "unsigned long" 64-bit platforms.  It's left as an exercise to
> the reader :-)

Why is any new macro needed?

struct page
{
#if BITS_PER_LONG == 64 && defined __BIG_ENDIAN
  union {
    unsigned long flags;
    atomic_t count;
  };
#elif BITS_PER_LONG == 64 && defined __LITTLE_ENDIAN
  union {
    unsigned long flags;
    struct {
      int : 32;
      atomic_t count;
    };
  };
#else
  unsigned long flags;
  atomic_t count;
#endif
...
};

should do the job.

	Jakub
