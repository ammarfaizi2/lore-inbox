Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWBPQYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWBPQYw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 11:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWBPQYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 11:24:52 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:18069
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932315AbWBPQYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 11:24:51 -0500
Message-ID: <43F4A757.4000709@microgate.com>
Date: Thu, 16 Feb 2006 10:24:55 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kouji Toriatama <toriatama@inter7.jp>
CC: linux-kernel@vger.kernel.org
Subject: Re: PPP with PCMCIA modem stalls on 2.6.10 or later
References: <1139937159.3189.4.camel@amdx2.microgate.com>	<20060215.221135.121135595.toriatama@inter7.jp>	<1140019368.3119.12.camel@amdx2.microgate.com> <20060217.010919.121148551.toriatama@inter7.jp>
In-Reply-To: <20060217.010919.121148551.toriatama@inter7.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kouji Toriatama wrote:
> ------------------------------------------------------------------
> Feb 16 23:52:40 moka kernel: receive_chars:flip full:low_latency=0
> Feb 16 23:52:40 moka kernel: receive_chars:flip full:discard char
> ------------------------------------------------------------------
> I have got this pair of two lines many times while running the
> wget command.
...
> With 'low_latency' option in 2.6.15 with your patch, the problem
> did not occur and no output from syslog.

Good, the problem is identified:
The old flip buffer code can't keep up unless
it processes received data directly in
the ISR (2.6.9 or 2.6.10+ with low_latency)
instead of in scheduled work (2.6.10+ without low_latency).

The discarded receive chars causes dropped frames
in ppp_async and stalls in data transfer.

I don't remember the details, but I think it is
safe to run low_latency on a uniprocessor.

> I have tried 2.6.16-rc3.  With or without 'low_latency' option,
> the problem did not occur.  It seems to work fine!  I will use
> 2.6.16-rc3 or later.

Alan's new tty buffering code safely handles
high receive rates without data loss, so the
low_latency flag is not necessary.

> If you have any additional plan to pin down this problem, I will
> try your patch.

The fix is already present in 2.6.16 series, so there
is nothing to patch. If you wish to run 2.6.10-2.6.15
you should be able to safely use low_latency on
a uniprocessor machine.

-- 
Paul Fulghum
Microgate Systems, Ltd.
