Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289471AbSAOKBJ>; Tue, 15 Jan 2002 05:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289467AbSAOKBC>; Tue, 15 Jan 2002 05:01:02 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:19217 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289461AbSAOKAt>; Tue, 15 Jan 2002 05:00:49 -0500
Date: Tue, 15 Jan 2002 10:00:41 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Defining new section for bus driver init
Message-ID: <20020115100041.A994@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0201141746000.827-100000@segfault.osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201141746000.827-100000@segfault.osdlab.org>; from mochel@osdl.org on Mon, Jan 14, 2002 at 05:47:15PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 05:47:15PM -0800, Patrick Mochel wrote:
> Attached is a patch that creates a new section for device subsystem init
> calls. With it, the root bus init calls are handled just like init calls
> - the section consists of a table of function pointers.
> device_driver_init() iterates over that table and calls each one.
> (device_driver_init() currently happens just before that pci_init() call
> above).

I've been thinking about this, and would like to suggest something that'd
reduce the code size, but is dependent on the ordering of stuff in
do_basic_setup.  So first some questions.  Currently, we do:

	device_driver_init()
	random bus driver init...
	sock_init()
	start_context_thread()
	do_initcalls()

Is there any ordering dependency between sock_init(), start_context_thread()
and the bus driver init calls?  From a brief look at the code, it would
appear that start_context_thread() is rather safe, but sock_init() is
questionable.  If they are both safe, then we could move these two calls
before, or even just after device_driver_init():

	device_driver_init()
	sock_init()
	start_context_thread()
	random bus driver init...
	do_initcalls()

Now we have the bus driver initialisation and the initcall initialisation
next to each other.  We can then pull this trick with the linker file:

	__initcall_start = .;
	.initcall : {
		*(.devsubsys.init)
		*(.initcall.init)
	}
	__initcall_end = .;

All the magic then happens within do_initcalls() without any extra code
needing to be added.  The really funky thing about this approach is
that you can add other sections to handle network protocol modules
and such like with virtually zero code.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

