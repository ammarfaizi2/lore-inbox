Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261484AbTCJVfN>; Mon, 10 Mar 2003 16:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbTCJVfM>; Mon, 10 Mar 2003 16:35:12 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:50193 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S261484AbTCJVfL>; Mon, 10 Mar 2003 16:35:11 -0500
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EISA aic7770 broken
References: <wrp65qscwxx.fsf@hina.wild-wind.fr.eu.org>
	<229560000.1047229710@aslan.scsiguy.com>
	<wrp1y1gcv96.fsf@hina.wild-wind.fr.eu.org>
	<301080000.1047244547@aslan.scsiguy.com>
	<wrpptozbqsr.fsf@hina.wild-wind.fr.eu.org>
	<600340000.1047310779@aslan.scsiguy.com>
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 10 Mar 2003 22:43:48 +0100
Message-ID: <wrpheaac2y3.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <600340000.1047310779@aslan.scsiguy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Justin" == Justin T Gibbs <gibbs@scsiguy.com> writes:

Justin> This is so close to the beginning of the function, that it
Justin> only makes sense that "ahc" is NULL.  Can you instrument both
Justin> ahc_runq_tasklet() and ahc_platform_alloc() to see if it is
Justin> indeed the case that "ahc" is NULL, and to verify that "ahc"
Justin> was valid when we registered the tasklet?

It's a little bit more complicated...

The thing crashes in the TAILQ_REMOVE macro, in ahc_runq_tasklet :

		TAILQ_REMOVE(&ahc->platform_data->device_runq, dev, links);

I tracked it down to the last line of TAILQ_REMOVE :

#define	TAILQ_REMOVE(head, elm, field) do {				\
	if ((TAILQ_NEXT((elm), field)) != NULL)				\
		TAILQ_NEXT((elm), field)->field.tqe_prev = 		\
		    (elm)->field.tqe_prev;				\
	else								\
		(head)->tqh_last = (elm)->field.tqe_prev;		\
	*(elm)->field.tqe_prev = TAILQ_NEXT((elm), field);		\
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            \ It crashes here
} while (0)

The thing is, if I put enough printks before the macro, it slows the
thing down (9600 bauds serial console effet, maybe), and the machine
comes up.

So it looks like a race of some sort... Concurent tasklets effect ?

Any idea ?

        M.
-- 
Places change, faces change. Life is so very strange.
