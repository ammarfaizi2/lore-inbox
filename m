Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131254AbRCUKFN>; Wed, 21 Mar 2001 05:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131260AbRCUKFD>; Wed, 21 Mar 2001 05:05:03 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:38605 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131254AbRCUKEq>; Wed, 21 Mar 2001 05:04:46 -0500
Message-ID: <3AB87CE3.2DB0DA14@uow.edu.au>
Date: Wed, 21 Mar 2001 21:05:23 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Keith Owens <kaos@ocs.com.au>, nigel@nrg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <22991.985166394@ocs3.ocs-net>,
		<Pine.LNX.4.05.10103201920410.26853-100000@cosmic.nrg.org>
		<22991.985166394@ocs3.ocs-net> <15032.30533.638717.696704@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Keith Owens writes:
>  > Or have I missed something?
> 
> Nope, it is a fundamental problem with such kernel pre-emption
> schemes.  As a result, it would also break our big-reader locks
> (see include/linux/brlock.h).
> 
> Basically, anything which uses smp_processor_id() would need to
> be holding some lock so as to not get pre-empted.
> 

It's a problem for uniprocessors as well.

Example:

#define current_cpu_data boot_cpu_data
#define pgd_quicklist (current_cpu_data.pgd_quick)

extern __inline__ void free_pgd_fast(pgd_t *pgd)
{
        *(unsigned long *)pgd = (unsigned long) pgd_quicklist;
        pgd_quicklist = (unsigned long *) pgd;
        pgtable_cache_size++;
}

Preemption could corrupt this list.

-
