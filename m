Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263305AbTDCHFK>; Thu, 3 Apr 2003 02:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263307AbTDCHFK>; Thu, 3 Apr 2003 02:05:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20884 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263305AbTDCHFK>;
	Thu, 3 Apr 2003 02:05:10 -0500
Date: Thu, 3 Apr 2003 09:16:20 +0200
From: Jens Axboe <axboe@suse.de>
To: "rain.wang" <rain.wang@mic.com.tw>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
Subject: Re: PATCH:ide_do_reset() fix for 2.5.66
Message-ID: <20030403071620.GJ2072@suse.de>
References: <Pine.LNX.4.21.0303241129420.855-100000@mars.zaxl.net> <1048514373.25136.4.camel@irongate.swansea.linux.org.uk> <20030324180125.2606b046.alex@ssi.bg> <1048527607.25655.18.camel@irongate.swansea.linux.org.uk> <3E8BDC10.D0195D71@mic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E8BDC10.D0195D71@mic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03 2003, rain.wang wrote:
> Hi Alan,
>     I found just changing ide_do_reset() to wait till completion can
> handle the handler race. can this be enough?

This is buggy for a number of reasons. Firstly, how do you make sure
that someone else doesn't race with your hwif_data manipulation? This
looks very suspect. By far the worst problem is that you are assuming
that ide_do_reset() can sleep, when in fact it cannot (just follow the
various paths into ide_do_request()). You even grab the ide_lock _and_
disable interrupts yourself prior calling wait_for_completion(), this is
incredibly broken.

-- 
Jens Axboe

