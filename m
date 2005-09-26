Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbVIZCku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbVIZCku (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 22:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbVIZCku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 22:40:50 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:59340 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1751602AbVIZCku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 22:40:50 -0400
Message-ID: <43375E71.4040408@austin.rr.com>
Date: Sun, 25 Sep 2005 21:35:29 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve French <smfrench@austin.rr.com>
CC: linux-cifs-client@lists.samba.org, linux-kernel@vger.kernel.org
Subject: Re: cifs writepages patch
References: <433713CD.5050607@austin.rr.com>
In-Reply-To: <433713CD.5050607@austin.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French wrote:

> I have been looking at and testing Shaggy's cifs writepages patches, 
> and they look promising.
>
> From my fastest test client to a laptop running Windows XP as a test 
> server (unfortunately this means running against a relatively slow 
> disk, but the file size should fit in cache on the server) here are 
> some initial results (at least three runs at each size).  Doing large 
> file copy (dd if=/dev/zero bs=16K count=4K of =/mnt/testfile) of 64Mbytes
>
> Over 100Mbit Ethernet
> w/o the patch (writes will go 4K):   6.1 MB/sec
> w/patch and wsize 16K (default)  8.8MB/sec
> w/patch and wsize reduced to 4K 6.3MB/sec
> w/patch and wsize 8K 8.5 MB/sec
> w/patch and wsize increased to 32K  9.8 MB/sec
>
>
>
>
So over 100Mbit interface, increasing the write size on the wire, is 
more than a 60% improvement, getting to about 3/4 of the maximum speed 
the interface could sustain.

Over Gigabit (same machines)
    w/o the patch (writes 4K):  11.7 MB/sec
    w/patch and wsize 16K (default):  24MB/sec average (best run 38.8 
MB/sec)
    w/patch and wsize 32K: 41 MB/sec average (best run 52 MB/sec)
    w/patch and wsize 36K: 38 MB/sec (best run 43.5)
    w/patch and wsize 40K was somewhat slower than 36K
    w/patch and wsize 53K performance was catostrophically slower 
(1/10th the performance or less)

The wsize is limited to 13 pages at the moment due to the size of kvecs 
(13 + 1 for the header = 14) used on sock_sendmsg

To get wsize of 32K to performan better than 16K wsize, the sk->sndbuf 
for the socket had to be set above the default (16K) - my experiments 
had sndbuf at just over 100K but sndbuf probably only needs to be 
slightly more than twice the wsize (as nfs sunrpc does).    I was 
surprised that performance collapsed at relatively small wsize, 
especially since Windows typically uses a write size of 60K.   I did 
some experiments over loopback interface to Samba server on the same 
host, which showed problems with large write sizes as well.  More 
investigation is needed.

These initial results are promising, but it is still puzzling why write 
sizes over 32K performed worse, and over 40K performed much worse.
