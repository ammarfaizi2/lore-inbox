Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUFGJEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUFGJEV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 05:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbUFGJEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 05:04:21 -0400
Received: from mail014.syd.optusnet.com.au ([211.29.132.160]:10441 "EHLO
	mail014.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264246AbUFGJES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 05:04:18 -0400
From: Con Kolivas <kernel@kolivas.org>
To: bert hubert <ahu@ds9a.nl>
Subject: Re: BUG in ht-aware scheduler/nice in 2.6.7-rc2 on dual xeon
Date: Mon, 7 Jun 2004 19:03:57 +1000
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <20040607085625.GA11276@outpost.ds9a.nl>
In-Reply-To: <20040607085625.GA11276@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406071903.57648.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2004 18:56, bert hubert wrote:
> Con, Ingo, List,
>
> I'm overjoyed with decent ht-aware scheduling in 2.6.7-rc2 and it does
> mostly the right thing. However, the 'nice' work by Con shows some slight
> problems.
>
> Please find attached program 'eat-time.cc'. Make sure not to compile it
> with -O which might confuse things as this program basically does nothing.
>
> Run it without arguments to determine the speed of 1 cpu, it outputs a
> number (megaloops/second). Then start it with that number as a parameter:
>
> Sample:
>
> $ ./eat-time
> 592
> $ ./eat-time 592
> 99%
> 99%
> 100%
> etc
>
> Now starting four of these at the same time gives the desired result:
>
> $ ./eat-time 592 & ./eat-time 592 & ./eat-time 592 & ./eat-time 592
> 50%
> 50%
> 50%
> 50%
> etc
>
> This however:
>
> $ ./eat-time 592 & ./eat-time 592 &
> 100%
> 99%
> In another xterm:
> $ nice -n +19 ./eat-time 592 & nice -n +19 ./eat-time 592
> 5%
> 5%
> 5%
>
> Fails sometimes, with all processes getting 50%. The above 'screenshot' is
> from the working and expected situation, which happens most of the time.
>
> When it goes wrong, top shows me that Cpu0 and Cpu1 are 100% user, while
> Cpu2 and Cpu3 are both 100% nice.  The niced processes show up in top as
> PRiority 39, the unniced ones (NI = 0) as PR 25.

This is just because the scheduler balancing is not aware of nice and when two 
same niceness tasks are on the same physical core they get equal shares. The 
ht-aware nice only works at keeping different nice values on the same 
physical core fair. There is no more that can be done using the current ht 
aware mechanism; a far more complicated balancing algorithm that takes nice 
into account would be required.

Con
