Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265503AbTGHHjl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 03:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265514AbTGHHjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 03:39:41 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:16770 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265503AbTGHHjj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 03:39:39 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 8 Jul 2003 00:46:34 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Szonyi Calin <sony@etc.utt.ro>
cc: kernel@kolivas.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O3int interactivity for 2.5.74-mm2
In-Reply-To: <26071.194.138.39.55.1057648284.squirrel@webmail.etc.utt.ro>
Message-ID: <Pine.LNX.4.55.0307080007200.3648@bigblue.dev.mcafeelabs.com>
References: <200307070317.11246.kernel@kolivas.org>       
 <1057516609.818.4.camel@teapot.felipe-alfaro.com>       
 <200307071319.57511.kernel@kolivas.org> <26071.194.138.39.55.1057648284.squirrel@webmail.etc.utt.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003, Szonyi Calin wrote:

> In the weekend i did some experiments with the defines in kernel/sched.c
> It seems that changing in MAX_TIMESLICE the "200" to "100" or even "50"
> helps a little bit. (i was able to do a make bzImage and watch a movie
> without noticing that is a kernel compile in background)

I bet it helps. Something around 100-120 should be fine. Now we need an
exponential function of the priority to assign timeslices to try to
maintain interactivity. This should work :

#define TSDELTA (MAX_TIMESLICE - MIN_TIMESLICE)
#define KTSNORM (TSDELTA * TSDELTA * TSDELTA)

time_slice = MIN_TIMESLICE + (TSDELTA * prio * prio * prio) / KTSNORM;

Or something like :

static const short tsmap[] = {
        10,     10,     10,     10,     10,     10,     10,     10,     10,     11,
        11,     12,     13,     14,     15,     16,     17,     19,     20,     22,
        24,     27,     29,     32,     35,     38,     42,     46,     50,     55,
        60,     65,     70,     76,     82,     89,     96,     103,    111,    120,
};

This is a simple cubic, while a quadratic map looks like :

static const short tsmap[] = {
        10,     10,     10,     10,     11,     11,     12,     13,     14,     15,
        17,     18,     20,     22,     24,     26,     28,     30,     33,     36,
        38,     41,     45,     48,     51,     55,     58,     62,     66,     70,
        75,     79,     84,     88,     93,     98,     103,    109,    114,    120,
};




- Davide

