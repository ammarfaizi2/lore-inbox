Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbUCJXgt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 18:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbUCJXgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 18:36:49 -0500
Received: from outgoingmail.adic.com ([63.81.117.28]:24668 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262266AbUCJXgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 18:36:48 -0500
Message-ID: <404FA575.1090907@xfs.org>
Date: Wed, 10 Mar 2004 17:32:05 -0600
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       kenneth.w.chen@intel.com, Andrew Morton <akpm@osdl.org>,
       thornber@redhat.com, linux-xfs@oss.sgi.com
Subject: Re: [PATCH] backing dev unplugging
References: <20040310124507.GU4949@suse.de> <20040310222247.GA713@frodo>
In-Reply-To: <20040310222247.GA713@frodo>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:
> 
> For this second one, we probably just want to ditch the flush_cnt
> there (this change is doing blk_run_address_space on every 32nd
> buffer target, and not the intervening ones).  We will be doing a
> bunch more blk_run_address_space calls than we probably need to,
> not sure if thats going to become an issue or not, let me prod
> some of the other XFS folks for more insight there...
> 
> thanks.
> 

The concept there was that we were just pushing things down into the
elevator in a batch, then unplugging it afterwards. The do it every
32 I/O's was added to avoid some request starvation issues - which are
probably historical now.

I was lazy and did not look at the context on the code, but there
are two paths in here. One is unmount flushing all the entries for
a specific filesystem, the other is background flushing. I think the
background flush activity can live without the blk_run_address_space
call being there at all. If we need to grab the lock on the metadata
later we will make the call then. The unmount case needs to call it,
but since that specifies a specific target, it can just make one
call.

Steve
