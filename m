Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVCNHDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVCNHDM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 02:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVCNHDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 02:03:12 -0500
Received: from mx1.elte.hu ([157.181.1.137]:18130 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262007AbVCNHCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 02:02:47 -0500
Date: Mon, 14 Mar 2005 08:02:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] break_lock forever broken
Message-ID: <20050314070230.GA24860@elte.hu>
References: <Pine.LNX.4.61.0503111847450.9320@goblin.wat.veritas.com> <20050311203427.052f2b1b.akpm@osdl.org> <Pine.LNX.4.61.0503122311160.13909@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503122311160.13909@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Hugh Dickins <hugh@veritas.com> wrote:

> @@ -187,6 +187,8 @@ void __lockfunc _##op##_lock(locktype##_
>  			cpu_relax();					\
>  		preempt_disable();					\
>  	}								\
> +	if ((lock)->break_lock)						\
> +		(lock)->break_lock = 0;					\

while writing the ->break_lock feature i intentionally avoided overhead
in the spinlock fastpath. A better solution for the bug you noticed is
to clear the break_lock flag in places that use need_lock_break()
explicitly.

One robust way for that seems to be to make the need_lock_break() macro
clear the flag if it sees it set, and to make all the other (internal)
users use __need_lock_break() that doesnt clear the flag. I'll cook up a
patch for this.

	Ingo
