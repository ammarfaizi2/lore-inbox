Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261494AbSIWWAz>; Mon, 23 Sep 2002 18:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261503AbSIWWAz>; Mon, 23 Sep 2002 18:00:55 -0400
Received: from packet.digeo.com ([12.110.80.53]:52624 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261494AbSIWWAy>;
	Mon, 23 Sep 2002 18:00:54 -0400
Message-ID: <3D8F9047.B464ABD4@digeo.com>
Date: Mon, 23 Sep 2002 15:05:59 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38bk2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Larson <plars@linuxtestproject.org>,
       Badari Pulavarty <pbadari@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, lse-tech@lists.sourceforge.net
Subject: Re: Bug in last night's bk test
References: <1032817002.24372.138.camel@plars.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2002 22:05:59.0806 (UTC) FILETIME=[663339E0:01C2634D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson wrote:
> 
> The automated nightly testing turned up a bug on one of the test
> machines last night.  The system that had the problem was running ltp
> and was a 2-way PII-550, 2GB ram, ext2.  Here is the ksymoops dump:
> 
> ksymoops 2.4.5 on i686 2.4.18.  Options used
>      -V (default)
>      -K (specified)
>      -L (specified)
>      -O (specified)
>      -m System.map (specified)
> 
> kernel BUG at ll_rw_blk.c:1802!

Ah, yes.

The direct-io code will build requests which are larger than
the ips driver is prepared to accept, and the BIO layer correctly
BUGs out over it.

We need to convert direct-io to use the bio_add_page() facility
which Jens has recently added.

Until that's done you'll need to set BIO_MAX_PAGES to 16 in
include/linux/bio.h
