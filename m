Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbVKVMnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbVKVMnb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 07:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbVKVMnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 07:43:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2338 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964930AbVKVMna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 07:43:30 -0500
Date: Tue, 22 Nov 2005 13:44:41 +0100
From: Jens Axboe <axboe@suse.de>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, linux-kernel@vger.kernel.org
Subject: Re: ioscheduler and 2.6 kernels
Message-ID: <20051122124441.GP15804@suse.de>
References: <20051122115225.GA2529@mail.muni.cz> <4383078A.5010204@stud.feec.vutbr.cz> <20051122121801.GB2529@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122121801.GB2529@mail.muni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22 2005, Lukas Hejtmanek wrote:
> On Tue, Nov 22, 2005 at 12:56:58PM +0100, Michal Schmidt wrote:
> > >I have a question about ioschedulers in current 2.6 kernels. Is there an 
> > >option
> > >to build iorequest queues per process? I would like to have the queue for 
> > >each
> > >process and pick up request in round robin manner, which results in more
> > >interactive environment. 
> > 
> > Isn't this exactly what the CFQ scheduler does?
> 
> Friend of me tried all the schedulers and he thinks, that all behave basicaly
> the same. His testbed is to extract tar archive with lots small files and in
> parallel to run xterm, which takes serious time. He wonder why.

Your friend has to realize that writeout doesn't typically happen in the
context of the process dirtying the data. CFQ will set aside a special
queue(s) for async writeout, though.

But another major interactivity problem he may see is that if you are
dirtying a lot of memory, other processes doing reads may get stuck in
page reclaim when allocating memory (eg getting a new page cache page,
either directly or perhaps through readahead). Then processes X has to
wait for async queue Z to flush out memory, thus becoming dependent on
each other for interactiveness. The io scheduler knows nothing about
this, so it can't really prevent it from happening.

-- 
Jens Axboe

