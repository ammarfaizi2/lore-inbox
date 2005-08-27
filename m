Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbVH0OPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbVH0OPH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 10:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbVH0OPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 10:15:06 -0400
Received: from [81.2.110.250] ([81.2.110.250]:31137 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751618AbVH0OPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 10:15:05 -0400
Subject: Re: Linux 2.6 context switching and posix threads performance
	question
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mateusz Berezecki <mateuszb@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050827121158.GA18406@oepkgtn.mshome.net>
References: <20050827121158.GA18406@oepkgtn.mshome.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 27 Aug 2005 15:43:16 +0100
Message-Id: <1125153796.24593.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-08-27 at 14:11 +0200, Mateusz Berezecki wrote:
> switching contexts ? I'm asking for some kind of an authoritative answer
> quite urgently. What is the optimum thread amount on 2 CPU SMP system
> running Linux ?

For doing what ? How often is a given thread woken up, do you need
latency or throughput.

A good rule of thumb is about 1.5 to 2 threads per core. But it is only
that and without context it is hard to assess the real needs. As you add
more threads you generally decrease cache effectiveness and that rather
than switching cost may well be the biggest hurt you experience. The
memory usage may also hurt.

Now if you have 25,000 threads and 24995 of them wake once every few
minutes that will have no real impact but if you are randomly flipping
between 25,000 threads all with different stacks and data areas at high
speed your cache utilisation will go down.

Equally if you have a lot of shared objects being written you avoid that
but can get into contention of cached memory. That however is more a
problem of number of processors than threads - ie a 25000 thread app
with a lot of shared objects may run *horribly* on a 64 CPU system and
really well on a dual.

So in essence you are asking "how long is a piece of string". Linux
2.6.x with NPTL will handle large numbers of threads. 25,000 is
excessive for most situations but how it behaves is more a question of
the application than the OS here.

