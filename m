Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268677AbTBZHuN>; Wed, 26 Feb 2003 02:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268678AbTBZHuN>; Wed, 26 Feb 2003 02:50:13 -0500
Received: from gold.muskoka.com ([216.123.107.5]:62730 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S268677AbTBZHuM>;
	Wed, 26 Feb 2003 02:50:12 -0500
Message-ID: <3E5BFF3B.3A84B78A@yahoo.com>
Date: Tue, 25 Feb 2003 18:41:47 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 146818 RTC set-time curious...
References: <Pine.LNX.4.44.0302222311560.7720-100000@poirot.grange>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski wrote:
> 
> Not a bug report, nothing critical (hopefully), just a question - in rtc.c
> driver on time-set ioctl() the following is done:
>         save_freq_select = CMOS_READ(RTC_FREQ_SELECT);
>         CMOS_WRITE((save_freq_select|RTC_DIV_RESET2), RTC_FREQ_SELECT);
> which writes 0x7X to rtc regs=ister 0xA... Why? I read a few documents and
> all agree on, what's expressed in one of them as "bits 4-6 should be 0x2,
> other values don't do anything useful on PCs, really..." VERY curious...

This code predates the rtc driver (and linux-1.0 in general) since it first
appeared in kernel/time.c: set_rtc_mmss().  [now arch/*/kernel/time.c]

I've seen that "..don't do anything useful..." before and it is incorrect.
The RESET and RESET2 values (functionally equivalent, IIRC) stop the
internal xtal input divider and once cleared back to normal operating state 
(6-4 are 010) the next rtc update will take place precisely 0.5 seconds later.

This is a documented feature of the original mc146818 to allow for precise 
setting of the clock, but I wouldn't be surprised if some el-cheapo chipset 
implementations don't honour it.  Might be amusing to write a little test 
program and run it on a few different machines to see what happens...  

Paul.


