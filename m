Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVDDIhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVDDIhe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 04:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVDDIhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 04:37:31 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28094 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261175AbVDDIhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 04:37:05 -0400
Date: Mon, 4 Apr 2005 10:36:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: kus Kusche Klaus <kus@keba.com>
Cc: stern@rowland.harvard.edu, linux-usb-users@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11, USB: High latency?
Message-ID: <20050404083652.GA29525@elte.hu>
References: <AAD6DA242BC63C488511C611BD51F3673231DD@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AAD6DA242BC63C488511C611BD51F3673231DD@MAILIT.keba.co.at>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* kus Kusche Klaus <kus@keba.com> wrote:

> Moreover, we know from experience that the "WBINDV" instruction (Write 
> back and invalidate CPU cache) can cause such latencies.
> 
> Does this instruction occur anywhere in Linux?

yes, they rarely occur when MTRR's are set (and some drivers like video 
uses it too), but then they'd also show up in the trace. The only other 
possibility would be if a driver used wbinvd in a preemptible section - 
that would not be traced. OTOH, it could still show up in wakeup-latency 
tracing.

To make sure, could you remove all relevant wbinvd's from your kernel 
tree? You can just comment out those lines from all relevant 'grep -rl 
wbinvd . | grep -v x86_64' files. (and in assembly defines, just replace 
the "wbinvd" with "nop") The kernel will most likely still work most of 
the time.

Or if you want to be safe: change all wbinvd occurances to: 
preempt_disable(); <wbinvd>; preempt_enable() sections, for tracing to 
pick them up.

	Ingo
