Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932738AbVKDPJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932738AbVKDPJz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932737AbVKDPJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:09:55 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:38439 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932738AbVKDPJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:09:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=G9L4ld3hsARCd6iUPloqAAakurkvdK/pXvNx5sAKE0VHhxHonKeVM3iSm9X9U4Hu7kf5LJ41bRSiGltilrAnQQ0g7Ins9qBR+R7JAKPrYAIDsKN+k/Owc1mjkdsKfpI/GHNRBNU2nKqRbFDIteEOG6glhxnPA7TYYASl4d5qREg=
Message-ID: <436B79BA.6070300@gmail.com>
Date: Sat, 05 Nov 2005 00:09:46 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: nickpiggin@yahoo.com.au, ntl@pobox.com, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] big reader semaphore take#2
References: <20051028104437.GA17461@htj.dyndns.org>
In-Reply-To: <20051028104437.GA17461@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
>  Hello guys,
> 
> This is the second take of brsem (big reader semaphore).
> 
> Nick, unfortunately, simple array of rwsem's does not work as lock
> holders are not pinned down to cpus and may release locks on other
> cpus.
> 
> This is a compeletely new implementation and much simpler than the
> first one.  Each brsem is consisted of shared part and two per-cpu
> counters.  Read fast path involves only one atomic_add_return and
> following conditional jump just as in rwsem.
> 
> The patch is against 2.6.14-rc4 and only implements brsem.  It does
> not apply it to anywhere.  My simple concurrent dd benchmark shows
> clear improvement over regular rwsem but it seems that there are too
> many factors affecting the bench.  I'll soon create another micro
> bench which concentrates only on synchronization and post the result.
> 
> I've written a document to describe how brsem works.  The document
> seems a bit too long for direct posting.  It can be accessed at the
> following page.
> 
>  http://home-tj.org/wiki/index.php/Brsem
> 
> Any comments are welcomed.
> 

brsem is updated to use custom wait mechanism as rwsem does such that it 
isn't affected by wakeup's from other sources.  Also there are some 
minor fixes like exporting interface functions to modules.

Also, a module named test-brsem is written to perform simple 
micro-benchmarking with correctness verification.  I did reader 
performance test and the result is appended to brsem.txt.

The test is basically.... (taken from brsem.txt)

 > For each of NOSYNC, RWSEM and BRSEM cases, the following test is
 > repeated with 1, 2, 4 and 8 concurrent readers.
 >
 > - there are 32768 16-byte blocks allocated using vmalloc.
 > - the following actions are repeated 10000000 times.
 >   - reader performs the following action 0-2 times.
 >     - select a random block and calculate SHA1 of the block.
 >   - reader does nothing or down_read rwsem or down_read brsem
 >   - reader performs the following action 0-2 times.
 >     - select a random block and calculate SHA1 of the block.
 >   - reader does nothing or up_read rwsem or up_read brsem
 >
 > Used system times are collected from all readers.  Each test is run 6
 > times and averaged.  All results are in milliseconds.

And the result and conclusion is... (taken from brsem.txt)

 > RATIO AGAINST NOSYNC each #thr
 >              NOSYNC           RWSEM            BRSEM
 > #thr |    /thr   ratio     /thr   ratio     /thr   ratio
 > --------------------------------------------------------
 >   1  |   12356  1.0000    12478  1.0098    12654  1.0241
 >   2  |   12423  1.0000    13747  1.1065    12710  1.0231
 >   4  |   12471  1.0000    14364  1.1517    12759  1.0230
 >   8  |   12483  1.0000    14344  1.1490    12772  1.0231
 >
 > The last table shows how much more cpu cycles each thread has used in
 > RWSEM and BRSEM cases compared against NOSYNC case of the same
 > concurrency.  RWSEM's ratio against NOSYNC increases as concurrency
 > increases (upto four) but BRSEM's ratio stays virtually constant.
 > i.e. BRSEM's overhead stays constant regardless of the number of
 > processors participating in synchronization.

Please visit the following URL for further information and sources.

http://home-tj.org/wiki/index.php/Brsem

Thanks.

(Nick, what do you think about the new implementation?)

-- 
tejun
