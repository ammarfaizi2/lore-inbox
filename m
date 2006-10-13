Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWJMRp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWJMRp6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 13:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWJMRp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 13:45:58 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:29163 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751401AbWJMRp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 13:45:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Yr+ZWAJq+IPhbX4Tjm5v8g2AnExE8FartSG7OfT7KQmkJEwKEWbL5ezn73mhd94TAXTHCHQ4PpEZS/31XjZwZlAiWU/79ChMY8pWWmQYKdTHmO5lhxKoQoCQ98zIksyWz79crYDPhkbbb1gut/2J/XFLjFaZ9bkrOvPVgfBqYq8=
Date: Sat, 14 Oct 2006 02:46:24 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, Don Mullis <dwm@meer.net>
Subject: Re: [patch 0/7] fault-injection capabilities (v5)
Message-ID: <20061013174623.GA29079@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	ak@suse.de, Don Mullis <dwm@meer.net>
References: <452df20e.025ef312.44f0.7578@mx.google.com> <20061012142625.520d3d87.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012142625.520d3d87.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 02:26:25PM -0700, Andrew Morton wrote:

> You've presumably run a kernel with these various things enabled.  What
> happens?  Does the kernel run really slowly?  Does userspace collapse in a
> heap?  Does it oops and die?

I don't feel much slowness with STACKTRACE & FRAME_POINTER and
enabling stacktrace filter. But with enabling STACK_UNWIND I feel
big latency on X. (There are two type of implementation of stacktrace
filter in it [1] using STACKTRACE with FRAME_POINTER, and [2] STACK_UNWIND)

I don't know why there is quite difference between simple STACKTRACE and
STACK_UNWIND. I'm about to try to use rb tree rather than linked list in
unwind.

In order to prevent from breaking other userspace programs and to
inject failures into only a specific code or process, process filter and
stacktrace filter are available. Without using them the system would be
almost unusable.

Now I'm stuck on the script in fault-injection.txt with random 700
modules. This script just tries to load/unload for all available kernel
modules. It usually get several oopses or CPU soft lockup now.  It
seems that relatively large number of them involved around driver model
(drivers/base/*). (I hope recent large number of error handle fixes
especially by Jeff Garzik fix them)

> Also, one place where this infrastructure could be of benefit is in device
> drivers: simulate a bad sector on the disk, a pulled cable, a timeout
> reading from a status register, etc.  If that works well and is useful then
> I can see us encouraging driver developers to wire up fault-injection in
> the major drivers.
> 
> Hence it would be useful at some stage to go in and to actually do all this
> for a particular driver.  As an example implementation for others to
> emulate and as a test for the fault-injection infrastructure itself - we
> may discover that new capabilities are needed as this work is done.
> 
> I wouldn't say this is an urgent thing to be doing, but it is a logical
> next step..

Yes. I'm learning from md/faulty and scsi-debug module what they are
doing and how to integrate such kind of features in general form.

