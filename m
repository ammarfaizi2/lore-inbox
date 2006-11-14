Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965816AbWKNNuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965816AbWKNNuM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 08:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965818AbWKNNuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 08:50:12 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:29584 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S965816AbWKNNuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 08:50:10 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.19-rc5-mm2
Date: Tue, 14 Nov 2006 14:50:07 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de
References: <20061114014125.dd315fff.akpm@osdl.org>
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611141450.07906.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 November 2006 10:41, Andrew Morton wrote:
> Presently at
>
> http://userweb.kernel.org/~akpm/2.6.19-rc5-mm2/
>
> and will appear later at
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.
>6.19-rc5-mm2/

Hi all

I noticed a slowdown (3%) on a io micro-benchmark on my machine with 
2.6.19-rc5-mm2

It appears time-uninline-jiffiesh.patch is sub-optimal at least for current 
compilers (tested gcc-4.0.4 here)

May I suggest :

1) make sure jiffies_to_usecs() is defined before being used in 
timespec_trunc() : Compiler will just optimize away not *needed* code.

OR :

2) Revert to inline versions of four functions jiffies_to_msecs(), 
jiffies_to_usecs(), msecs_to_jiffies() and usecs_to_jiffies() .

IMHO there is litle gain to call a function just to perform so basic 
arithmetics, that sometime compiler can perform at compilation time.

OR 

3) replace
	(jiffies_to_usecs(1) * 1000)
by
	(NSEC_PER_SEC / HZ)

With current patch, timespec_trunc() is not anymore a tail function.

struct timespec timespec_trunc(struct timespec t, unsigned gran)
{
        if (gran <= jiffies_to_usecs(1) * 1000) {

Much better here to have :

	if (gran < SOME_CONSTANT) 


Thank you
Eric
