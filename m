Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTE1VoB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 17:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbTE1VoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 17:44:01 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:60014 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261188AbTE1VoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 17:44:00 -0400
Date: Wed, 28 May 2003 14:54:51 -0700
From: Andrew Morton <akpm@digeo.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [BUGS] 2.5.69 syncppp
Message-Id: <20030528145451.5f13ebab.akpm@digeo.com>
In-Reply-To: <1054157063.2279.2.camel@diemos>
References: <OPENKONOOJPFMJFAJLHAKEPCCBAA.paulkf@microgate.com>
	<1053970962.16694.17.camel@dhcp22.swansea.linux.org.uk>
	<1054157063.2279.2.camel@diemos>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2003 21:57:16.0693 (UTC) FILETIME=[1A6EC450:01C32564]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> wrote:
>
> Was it really the intention of the change to kernel/softirq.c:105
> (source of the warning) that callers to dev_queue_xmit()
> not be allowed to use spinlocks? If so, then what other
> synchronization techniques are appropriate for use in
> an interrupt and timer context?

That warning is there because local_bh_enable will unconditionally enable
interrupts, to run softirqs.

Hence, if someone is calling local_bh_enable() with interrupts disabled
then local_bh_enable() is about to break their locking scheme in subtle
ways.  So the warning is there to tell you about this.

And we don't want to be running softirqs with interrupts disabled, for
latency reasons.
