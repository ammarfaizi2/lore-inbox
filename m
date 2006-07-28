Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751991AbWG1O43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbWG1O43 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 10:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbWG1O43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 10:56:29 -0400
Received: from thunk.org ([69.25.196.29]:26756 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751991AbWG1O43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 10:56:29 -0400
Date: Fri, 28 Jul 2006 10:52:10 -0400
From: Theodore Tso <tytso@mit.edu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Neil Horman <nhorman@tuxdriver.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: A better interface, perhaps: a timed signal flag
Message-ID: <20060728145210.GA3566@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Neil Horman <nhorman@tuxdriver.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	a.zummo@towertech.it, jg@freedesktop.org
References: <44C67E1A.7050105@zytor.com> <20060725204736.GK4608@hmsreliant.homelinux.net> <44C6842C.8020501@zytor.com> <20060725222547.GA3973@localhost.localdomain> <70FED39F-E2DF-48C8-B401-97F8813B988E@kernel.crashing.org> <20060725235644.GA5147@localhost.localdomain> <44C6B117.80300@zytor.com> <20060726002043.GA5192@localhost.localdomain> <20060726144536.GA28597@thunk.org> <1154093606.19722.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154093606.19722.11.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 09:33:26AM -0400, Steven Rostedt wrote:
> What you could have is this:
> 
>   volatile int *flag;
> 
>   register_timeout(&time_val, &flag);
>   while (work_to_do()) {
> 	do_a_bit_of_work();
> 	if (*flag)
> 		break;
>   }
> 
> Where the kernel would register a location to set a timeout with, and
> the kernel would setup a flag for you and then map it into userspace.
> Perhaps only allow one flag per task and place it as a field of the task
> structure.  There's no reason that the tasks own task sturct cant be
> mapped read only to user space, is there?

Good point, and limiting this facility to one such timeout per
task_struct seems like a reasonable restriction.  The downsides I can
see about about mapping the tasks' own task struct would be (a) a
potential security leak either now or in the future if some field in
the task_struct shouldn't be visible to a non-privileged userspace
program, and (b) exposing the task_struct might cause some (stupid)
programs to depend on the task_struct layout.  Allocating an otherwise
empty 4k page just for this purpose wouldn't be all that horrible,
though, and would avoid these potential problems.

							- Ted
