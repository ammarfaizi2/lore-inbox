Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbTKNUXb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 15:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264145AbTKNUXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 15:23:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33154 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263923AbTKNUXa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 15:23:30 -0500
Date: Fri, 14 Nov 2003 20:23:27 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Harald Welte <laforge@netfilter.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: seq_file API strangeness
Message-ID: <20031114202327.GK24159@parcelfarce.linux.theplanet.co.uk>
References: <20031114200642.GG6937@obroa-skai.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031114200642.GG6937@obroa-skai.de.gnumonks.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 09:06:43PM +0100, Harald Welte wrote:
> Hi!
> 
> While porting /proc/net/ip_conntrack over to seq_file, I stumbled across
> the following problem:

> Now let's say I'm allocating some chunk of memory in ->start(), and
> later on an error occurs.  Now I return ERR_PTR(something).  Later on, 
> ->stop() is called with that ERR_PTR(something) as parameter, and I try
> to kfree() the chunk of memory that was allocated.  boom.  It's neither
> NULL nor a valid pointer.
> 
> Also, I am wondering why the ->stop() function is called at all, when
> ->start() fails.  Initially, I was grabbing a lock, but only at the end
> of ->start(), after all potential errors would already result in
> returning ERR_PTR(something).  ->stop() however is then called
> unconditionally, resulting in an unconditional unlock of my lock. boom.
> 
> Was this by intention?  I think it is unusual to call a  stop() function
> even if start() didn't succeed.

It is intentional.  In 99% of cases it ends up with cleaner methods and
in the rest you can trivially check the ->stop() argument.

Note that you *can* have failing ->next() do cleanup if you want to do
so.  In other words, instances that want such behaviour can get it easily.
And in common case you don't have to bother at all.

With "we call ->stop() only if..." you would still have to do the same amount
of work for hard cases *AND* get extra PITA for normal ones.  IOW, clear loss.
