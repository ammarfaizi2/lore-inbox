Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268370AbUJMFog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268370AbUJMFog (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 01:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268392AbUJMFoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 01:44:34 -0400
Received: from mx1.elte.hu ([157.181.1.137]:1767 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268370AbUJMFoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 01:44:06 -0400
Date: Wed, 13 Oct 2004 07:45:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T8
Message-ID: <20041013054532.GB31811@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <416C452E.4080006@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416C452E.4080006@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> Booted part way this time but then soft locked. [...]

the soft lock it seems was due to a mutex assert in the TCP code. Now i
see that you have the ipv6 module loaded. Would it be possible to
disable ipv6 briefly, to see whether there are other issues?

> Mouse was still working but not KB. Any idea why the KB is not working
> with these? I am rebuilding with all of the pwr managment off because
> I am still getting acpi messages in the boot :-/ [...]

hm, the keyboard should be working - i have not seen any specific
keyboard problems with PREEMPT_REALTIME enabled (except in the very
early stages of this feature). So it must be something else. Is this a
PS2 or an USB keyboard?

> Oct 12 15:33:39 swdev14 kernel: NET: Registered protocol family 10
> Oct 12 15:33:39 swdev14 kernel: IPv6 over IPv4 tunneling driver
> Oct 12 15:33:40 swdev14 kernel: ------------[ cut here ]------------
> Oct 12 15:33:40 swdev14 kernel: kernel BUG at kernel/mutex.c:185!

> Oct 12 15:33:40 swdev14 kernel: EIP is at _rw_mutex_write_unlock+0x25/0x2f

> Oct 12 15:33:40 swdev14 kernel: Call Trace:
> Oct 12 15:33:40 swdev14 kernel:  [<c0253738>] tcp_listen_start+0x175/0x1d1
> Oct 12 15:33:40 swdev14 kernel:  [<c029a33a>] _spin_unlock_bh+0x1a/0x34
> Oct 12 15:33:40 swdev14 kernel:  [<c0275a8c>] inet_listen+0x65/0x7a
> Oct 12 15:33:40 swdev14 kernel:  [<c02287ea>] sys_listen+0x5c/0x74
> Oct 12 15:33:40 swdev14 kernel:  [<c02294a4>] sys_socketcall+0xb1/0x239
> Oct 12 15:33:40 swdev14 kernel:  [<c015ae81>] sys_close+0x75/0x91

this assert says that a write_unlock() was done before the mutex was
initialized - which is a no-no. Note that the stock kernel does not do
this checking and there's a chance that it has a true bug here which it
ignores silently. The more likely scenario is that the kernel mutex code
somewhere changed an assumption which broke the code. I'll try to
reproduce this.

	Ingo
