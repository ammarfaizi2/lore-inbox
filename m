Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936183AbWLDMQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936183AbWLDMQd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936178AbWLDMQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:16:33 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:9997 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S936183AbWLDMQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:16:32 -0500
Date: Mon, 4 Dec 2006 12:16:18 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Roman Zippel <zippel@linux-m68k.org>,
       Al Viro <viro@ftp.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] timers, pointers to functions and type safety
Message-ID: <20061204121618.GB17507@flint.arm.linux.org.uk>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, Roman Zippel <zippel@linux-m68k.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20061201172149.GC3078@ftp.linux.org.uk> <1165084076.24604.56.camel@localhost.localdomain> <20061202184035.GL3078@ftp.linux.org.uk> <200612022243.58348.zippel@linux-m68k.org> <20061202215941.GN3078@ftp.linux.org.uk> <Pine.LNX.4.64.0612022306360.1867@scrub.home> <20061202224018.GO3078@ftp.linux.org.uk> <Pine.LNX.4.64.0612022345520.1867@scrub.home> <20061203102108.GA1724@elf.ucw.cz> <26864.1165230869@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26864.1165230869@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 11:14:29AM +0000, David Howells wrote:
> All it generally takes is two instances of a timer_list struct that use one
> common handler function for the removal of the data member from the timer_list
> to be a win on pretty much every platform.
> 
> Consider: you replace:
> 
> 	struct timer_list {
> 		void (*func)(unsigned long data);
> 		unsigned long data;
> 	};
> 
> 	void handler(unsigned long data)
> 	{
> 		struct *foo = (struct foo *) data;
> 		...
> 	}
> 
> with:
> 
> 	struct timer_list {
> 		void (*func)(struct timer_list *timer);
> 		unsigned long data;

I assume you wanted to delete "data" ?

> 	};
> 
> 	void handler(struct timer_list *timer)
> 	{
> 		struct *foo = container_of(timer, struct foo, mytimer);
> 		...
> 	}

Your premise is two timer_lists which use one common handler.

	struct foo {
		struct timer_list timer1;
		strucr timer_list timer2;
	};

would preclude using a common handler for both timers.  You need two
separate handlers, one which knows the offset of timer1 and the other
the offset of timer2.

In this case, you are removing 2 * sizeof(unsigned long) from struct
foo, but you're adding a two add/sub instructions to each handler,
but worse than that, this would force two veneer handlers to call the
common handler.

The point here is that we can all dream up cases where some particular
way is a win or not.  Whether it really _is_ a win depends on the uses
in the kernel.

The only real way to find that out is to try it.  Generate a patch.
Build it.  See what happens to the kernel code and data sizes.

I strongly suggest that we do that rather than speculating. 8)  Words
(and emails) are cheap but in the end are not really constructive.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
