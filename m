Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161090AbWG1NeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161090AbWG1NeP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 09:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbWG1NeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 09:34:14 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:64443 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161090AbWG1NeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 09:34:14 -0400
Subject: Re: A better interface, perhaps: a timed signal flag
From: Steven Rostedt <rostedt@goodmis.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Neil Horman <nhorman@tuxdriver.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org
In-Reply-To: <20060726144536.GA28597@thunk.org>
References: <20060725194733.GJ4608@hmsreliant.homelinux.net>
	 <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com>
	 <44C67E1A.7050105@zytor.com>
	 <20060725204736.GK4608@hmsreliant.homelinux.net>
	 <44C6842C.8020501@zytor.com> <20060725222547.GA3973@localhost.localdomain>
	 <70FED39F-E2DF-48C8-B401-97F8813B988E@kernel.crashing.org>
	 <20060725235644.GA5147@localhost.localdomain> <44C6B117.80300@zytor.com>
	 <20060726002043.GA5192@localhost.localdomain>
	 <20060726144536.GA28597@thunk.org>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 09:33:26 -0400
Message-Id: <1154093606.19722.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-26 at 10:45 -0400, Theodore Tso wrote:

> If we had such an interface, then the application would look like
> this:
> 
> 	volatile int	flag = 0;
> 
> 	register_timout(&time_val, &flag);
> 	while (work to do) {
> 		do_a_bit_of_work();
> 		if (flag)
> 			break;
> 	}

This wouldn't work simply because the timeout would most likely be
implemented with an interrupt, and the address of flag is in userspace,
so the interrupt handler couldn't modify it (without doing some sort of
single handling, and thus slow down what you want).

What you could have is this:

  volatile int *flag;

  register_timeout(&time_val, &flag);
  while (work_to_do()) {
	do_a_bit_of_work();
	if (*flag)
		break;
  }

Where the kernel would register a location to set a timeout with, and
the kernel would setup a flag for you and then map it into userspace.
Perhaps only allow one flag per task and place it as a field of the task
structure.  There's no reason that the tasks own task sturct cant be
mapped read only to user space, is there?

-- Steve


