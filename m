Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbULBUaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbULBUaC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 15:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbULBUaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 15:30:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:29846 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261753AbULBU3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 15:29:52 -0500
Date: Thu, 2 Dec 2004 12:34:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: Time sliced CFQ io scheduler
Message-Id: <20041202123407.5f8ba355.akpm@osdl.org>
In-Reply-To: <20041202201904.GD26695@suse.de>
References: <20041202130457.GC10458@suse.de>
	<20041202134801.GE10458@suse.de>
	<20041202114836.6b2e8d3f.akpm@osdl.org>
	<20041202195232.GA26695@suse.de>
	<20041202121938.12a9e5e0.akpm@osdl.org>
	<20041202201904.GD26695@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> > So what are you doing different?
> 
> Doing sync io, most likely. My results above are 64k O_DIRECT reads and
> writes, see the mention of the test cases in the first mail.

OK.

Writer:

	while true
	do
	write-and-fsync -o -m 100 -c 65536 foo 
	done

Reader:

	time-read -o -b 65536 -n 256 x      (This is O_DIRECT)
or:	time-read -b 65536 -n 256 x	    (This is buffered)

`vmstat 1':

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  1   1032 137412   4276  84388   32    0 15456 25344 1659  1538  0  3 50 47
 0  1   1032 137468   4276  84388    0    0     0 32128 1521  1027  0  2 51 48
 0  1   1032 137476   4276  84388    0    0     0 32064 1519  1026  0  1 50 49
 0  1   1032 137476   4276  84388    0    0     0 33920 1556  1102  0  2 50 49
 0  1   1032 137476   4276  84388    0    0     0 33088 1541  1074  0  1 50 49
 0  2   1032 135676   4284  85944    0    0  1656 29732 1868  2506  0  3 49 47
 1  1   1032  96532   4292 125172    0    0 39220   128 10813 39313  0 31 35 34
 0  2   1032  57724   4332 163892    0    0 38828   128 10716 38907  0 28 38 35
 0  2   1032  18860   4368 202684    0    0 38768   128 10701 38845  1 28 38 35
 0  2   1032   3672   4248 217764    0    0 39188   128 10803 39327  0 28 37 34
 0  1   1032   2832   4260 218840    0    0 16812 17932 5504 17457  0 14 46 40
 0  1   1032   2832   4260 218840    0    0     0 30876 1501   974  0  1 50 49
 0  1   1032   2944   4260 218840    0    0     0 33472 1537  1068  0  2 50 48
 0  1   1032   2944   4260 218840    0    0     0 33216 1533  1046  0  2 50 48
 
Ugly.

(write-and-fsync and time-read are from
http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz)
