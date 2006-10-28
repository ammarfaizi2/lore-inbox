Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWJ1Vn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWJ1Vn6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 17:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWJ1Vn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 17:43:58 -0400
Received: from imladris.surriel.com ([66.92.77.98]:53966 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S964876AbWJ1Vn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 17:43:58 -0400
Message-ID: <4543CF1C.7070604@surriel.com>
Date: Sat, 28 Oct 2006 17:43:56 -0400
From: Rik van Riel <riel@surriel.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] kswapd: Kernel Swapper performance
References: <200610282031.17451.a1426z@gawab.com>
In-Reply-To: <200610282031.17451.a1426z@gawab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> One thing that has improved in 2.6, wrt 2.4, is swapper performance.  And the 
> difference isn't small either: ~5 fold increase in swapin performance.
> 
> But swapin performance still lags swapout performance by 50%, which is a bit 
> odd, considering swapin to be a read from disk, usually faster, and swapout 
> to be a write to disk, usually slower.

Ahhhhhh, but there's a catch...

You can queue up multiple writes, because the data you want
to write to disk is already in memory.

However, at swapin time you need to read the first bit of
data from disk, after which the program can continue, and
only when the next page fault happens you know what data
to read in next.

Linux does some swapin clustering, but there simply is no
way to know which data will be needed next.

This means reads are serialized and synchronous wrt. program
execution, while writes can overlap and be done asynchronously.

It's a miracle reads are going at 50% of the speed of writes...

> Improving this ratio could possibly yield a dramatic improvement in system 
> performance under memory load (think tmpfs/swsusp/...).

Let me know when you figure out how to look into the future.

Actually, Keir Fraser and Fay Chang came up with a cool trick.

    "Operating System I/O Speculation:
   How Two Invocations Are Faster Than One"

http://www.usenix.org/publications/library/proceedings/usenix03/tech/fraser.html

It is somewhat complex though...

-- 
Who do you trust?
The people with all the right answers?
Or the people with the right questions?
