Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWCHDbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWCHDbK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 22:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWCHDbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 22:31:10 -0500
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:15504 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932426AbWCHDbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 22:31:09 -0500
Date: Tue, 7 Mar 2006 22:29:03 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Fw: Re: oops in choose_configuration()
To: Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Message-ID: <200603072230_MC3-1-BA18-21AC@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060308005455.GA23921@kroah.com>

On Tue, 7 Mar 2006 16:54:55 -0800, Greg KH wrote:

> On Tue, Mar 07, 2006 at 04:54:24PM -0500, Chuck Ebbert wrote:
> > At least one susbsystem rolls its own method of adding env vars to the
> > uevent buffer, and it's so broken it triggers the WARN_ON() in
> > lib/vsprintf.c::vsnprintf() by passing a negative length to that function.
> > Start at drivers/input/input.c::input_dev_uevent() and watch the fun.
> 
> All of the INPUT_ADD_HOTPLUG_VAR() calls do use add_uevent_var(), so we
> should be safe there.  The other calls also look safe, if not a bit
> wierd...  So I don't see how we could change this to be any safer, do
> you?

input.c line 747+ was recently added and caused the error message:

[1]=>   envp[i++] = buffer + len;
[2]=>   len += snprintf(buffer + len, buffer_size - len, "MODALIAS=");
[2]=>   len += print_modalias(buffer + len, buffer_size - len, dev) + 1;

[1]=>   envp[i] = NULL;
        return 0;

[1] What is checking for enough space here?  This didn't overflow AFAICT
but it could.

[2] The snprintf() and print_modalias() calls don't check for errors and
thus don't return -ENOMEM when the buffer does fill up.  Shouldn't they
do that instead of returning a truncated env string?  Only the final
sanity test in snprintf() keeps them from overrunning the buffer.
(It was print_modalias_bits() that actually caused the overflow.)

> Are you still seeing problems now?

Wasn't me, it was Horst Schirmeier <horst@schirmeier.com>

-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"
