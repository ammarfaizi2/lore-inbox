Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbWFNN3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWFNN3F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 09:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWFNN3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 09:29:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19418 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964913AbWFNN3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 09:29:04 -0400
Date: Wed, 14 Jun 2006 09:28:56 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Sebastien Dugue <sebastien.dugue@bull.net>
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
       Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org,
       Pierre PEIFFER <pierre.peiffer@bull.net>
Subject: Re: NPTL mutex and the scheduling priority
Message-ID: <20060614132856.GA3115@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20060612.171035.108739746.nemoto@toshiba-tops.co.jp> <1150115008.3131.106.camel@laptopd505.fenrus.org> <20060612124406.GZ3115@devserv.devel.redhat.com> <1150125869.3835.12.camel@frecb000686> <20060613084819.GL3115@devserv.devel.redhat.com> <1150200272.3835.33.camel@frecb000686> <20060613125603.GQ3115@devserv.devel.redhat.com> <1150291180.3835.59.camel@frecb000686>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150291180.3835.59.camel@frecb000686>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2006 at 03:19:40PM +0200, S?bastien Dugu? wrote:
> > FUTEX_REQUEUE is used by pthread_cond_signal to requeue the __data.__futex
> > onto __data.__lock.
> 
>   You meant FUTEX_WAKE_OP, I guess. I could not find any place still 
> using FUTEX_REQUEUE in glibc 2.4.

glibc 2.4 uses FUTEX_CMP_REQUEUE, true, but both FUTEX_REQUEUE and
FUTEX_CMP_REQUEUE should behave the same in this regard (after all, they are
implemented using the same futex_requeue routine in the kernel).
FUTEX_CMP_REQUEUE is used in pthread_cond_broadcast, FUTEX_WAKE_OP is used in
pthread_cond_signal.  E.g. nptl/sysdeps/pthread/pthread_cond_broadcast.c:
...
      /* Wake everybody.  */
      pthread_mutex_t *mut = (pthread_mutex_t *) cond->__data.__mutex;
      /* lll_futex_requeue returns 0 for success and non-zero
         for errors.  */
      if (__builtin_expect (lll_futex_requeue (&cond->__data.__futex, 1,
                                               INT_MAX, &mut->__data.__lock,
                                               futex_val), 0))
        {
          /* The requeue functionality is not available.  */
        wake_all:
          lll_futex_wake (&cond->__data.__futex, INT_MAX);
        }
and nptl/sysdeps/pthread/pthread_cond_signal.c:
...
      /* Wake one.  */
      if (! __builtin_expect (lll_futex_wake_unlock (&cond->__data.__futex, 1,
                                                     1, &cond->__data.__lock),
                                                     0))
        return 0;

      lll_futex_wake (&cond->__data.__futex, 1);
    }

  /* We are done.  */
  lll_mutex_unlock (cond->__data.__lock);

	Jakub
