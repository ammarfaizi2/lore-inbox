Return-Path: <linux-kernel-owner+w=401wt.eu-S1751422AbXAKUVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbXAKUVw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 15:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbXAKUVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 15:21:52 -0500
Received: from smtp.osdl.org ([65.172.181.24]:60357 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422AbXAKUVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 15:21:51 -0500
Date: Thu, 11 Jan 2007 12:21:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: dean gaudet <dean@arctic.org>
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH - RFC] allow setting vm_dirty below 1% for large memory
 machines
Message-Id: <20070111122127.5bcc0b0f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701110245300.22043@twinlark.arctic.org>
References: <17827.22798.625018.673326@notabene.brown>
	<Pine.LNX.4.64.0701110245300.22043@twinlark.arctic.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007 03:04:00 -0800 (PST)
dean gaudet <dean@arctic.org> wrote:

> On Tue, 9 Jan 2007, Neil Brown wrote:
> 
> > Imagine a machine with lots of memory - say 100Gig.
> 
> i've had these problems on machines as "small" as 8GiB.  the real problem 
> is that the kernel will let millions of potential (write) IO ops stack up 
> for a device which can handle only mere 100s of IOs per second.  (and i'm 
> not convinced it does the IOs in a sane order when it has millions to 
> choose from)
> 
> replacing the percentage based dirty_ratio / dirty_background_ratio with 
> sane kibibyte units is a good fix... but i'm not sure it's sufficient.
> 
> it seems like the "flow control" mechanism (i.e. dirty_ratio) should be on 
> a device basis...
> 
> try running doug ledford'd memtest.sh on an 8GiB box with a single disk, 
> let it go a few minutes then ^C and type "sync".  i've had to wait 10 
> minutes (2.6.18 with default vm settings).
> 
> it makes it hard to guarantee a box can shutdown quickly -- nasty for 
> setting up UPS on-battery timeouts for example.
> 

Increasing the request queue size should help there
(/sys/block/sda/queue/nr_requests).  Maybe 25% or more benefit with that
test, at a guess.

Probably initscripts should do that rather than leaving the kernel defaults
in place.  It's a bit tricky for the kernel to do because the decision
depends upon the number of disks in the system, as well as the amount of
memory.

Or perhaps the kernel should implement a system-wide limit on the number of
requests in flight.  While avoiding per-device starvation.  Tricky.
