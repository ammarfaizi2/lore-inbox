Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbTJXJ1C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 05:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbTJXJ1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 05:27:02 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:786 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262114AbTJXJ07
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 05:26:59 -0400
Date: Fri, 24 Oct 2003 11:36:35 +0200
To: Daniel Phillips <phillips@arcor.de>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide write barrier support
Message-ID: <20031024093635.GA22894@hh.idb.hist.no>
References: <20031013140858.GU1107@suse.de> <200310231822.36023.phillips@arcor.de> <20031023162310.GQ6461@suse.de> <200310231920.39888.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310231920.39888.phillips@arcor.de>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23, 2003 at 07:20:39PM +0200, Daniel Phillips wrote:
> These are essentially the same, they both rely on draining the downstream 
> queues.  But if we could keep the downstream queues full, bus transfers for 
> post-barrier writes will overlap the media transfers for pre-barrier writes, 
> which would seem to be worth some extra effort.
> 
> To keep the downstream queues full, we must submit write barriers to all the 
> downstream devices and not wait for completion.  That is, as soon as a 
> barrier is issued to a given downstream device we can start passing through 
> post-barrier writes to it.
> 
This approach may fail:

a. Some pre-barrier writes go to all devices
b. barrier is sent to all devices
c. Post-barrier writes go to all devices
d. drive 1 commits all its pre-barrier writes, then
   commits its post-barrier writes.
e. drive 2 is slow and havent done the pre-barrier writes yet
f. power is lost - leaving inconsistent devices.

The problem is that drive 1 don't know wether drive 2
did the barrier yet.

Helge Hafting
