Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275880AbSIURET>; Sat, 21 Sep 2002 13:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275887AbSIURET>; Sat, 21 Sep 2002 13:04:19 -0400
Received: from holomorphy.com ([66.224.33.161]:20877 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S275880AbSIURES>;
	Sat, 21 Sep 2002 13:04:18 -0400
Date: Sat, 21 Sep 2002 10:02:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: quadratic behaviour
Message-ID: <20020921170240.GP3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
References: <3D8C7EEE.7030500@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D8C7EEE.7030500@colorfullife.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Andries Brouwer wrote:
>> Let me repeat this, and call it an observation instead of a question,
>> so that you do not think I am in doubt.
>> If you have 20000 processes, and do ps, then get_pid_list() will be
>> called 1000 times, and the for_each_process() loop will examine
>> 10000000 processes.
>> Unlike the get_pid() situation, which was actually amortized linear with a 
>> very
>> small coefficient, here we have a bad quadratic behaviour, still in 2.5.37.

On Sat, Sep 21, 2002 at 04:15:10PM +0200, Manfred Spraul wrote:
> One solution would be to replace the idtag hash with an idtag tree.
> Then get_pid_list() could return an array of sorted pids, and finding 
> the next pid after unlocking the task_lock would be just a tree lookup 
> (find first pid larger than x).
> And a sorted tree would make it possible find the next safe range for 
> get_pid() with O(N) instead of O(N^2).

There are incremental / O(1) methods for filling the directory as well.

Also, a tree does not preclude additional hashing. Personally, I'd
consider O(N) catastrophic as well, especially when done on multiple
cpus simultaneously. In fact, a large chunk of this is obtaining hard
bounds on the hold time of the tasklist_lock so writers have a remote
chance of getting into critical sections.

Another very important aspect of it is that the tasklist cachelines
aren't incessantly pounded, which is important even for UP.

At any rate, if you care to send something to me I will doublecheck
whether it NMI oopses on my machines.


Cheers,
Bill
