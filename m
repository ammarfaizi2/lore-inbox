Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263563AbUEKT5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263563AbUEKT5F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 15:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbUEKT5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 15:57:04 -0400
Received: from mx1.elte.hu ([157.181.1.137]:47827 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263563AbUEKT44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 15:56:56 -0400
Date: Tue, 11 May 2004 21:58:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Geoff Gustafson <geoff@linux.jf.intel.com>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: [RFC] [PATCH] Performance of del_timer_sync
Message-ID: <20040511195856.GA4958@elte.hu>
References: <409FFF3B.3090506@linux.intel.com> <20040511004551.7c7af44d.akpm@osdl.org> <00c001c43786$f1805000$ff0da8c0@amr.corp.intel.com> <20040511121126.73f5fdeb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040511121126.73f5fdeb.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Ingo, why is this not sufficient?
> 
> @@ -331,6 +331,8 @@ int del_timer_sync(struct timer_list *ti
>  
>  del_again:
>  	ret += del_timer(timer);
> +	if (!ret)
> +		return 0;
>  
>  	for_each_cpu(i) {
>  		base = &per_cpu(tvec_bases, i);

it's not sufficient because a timer might be running on another CPU even
if it has not been deleted. We delete a timer prior running it (so that
the timer fn can re-activate the timer). So del_timer_sync() has to
synchronize independently of whether the timer was removed or not.

	Ingo
