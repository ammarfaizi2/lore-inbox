Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292396AbSBBVp1>; Sat, 2 Feb 2002 16:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292397AbSBBVpR>; Sat, 2 Feb 2002 16:45:17 -0500
Received: from holomorphy.com ([216.36.33.161]:20620 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S292396AbSBBVpH>;
	Sat, 2 Feb 2002 16:45:07 -0500
Date: Sat, 2 Feb 2002 13:44:50 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "W. Michael Petullo" <mike@flyn.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP Pentium III, GA-6VXDC7 MoBo. -- 2.4.18-pre7 SMP not working
Message-ID: <20020202214450.GF834@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"W. Michael Petullo" <mike@flyn.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020127172150.A1407@dragon.flyn.org> <20020202151241.A1417@dragon.flyn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020202151241.A1417@dragon.flyn.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2002 at 03:12:41PM +0100, W. Michael Petullo wrote:
> I'm having a lot of trouble debugging this one.  Prinks are not being
> displayed on the screen, though I know they are being executed.  I have
> even tried William Lee Irwin's early_printk patch to try and get printks
> to display.  Apparently the prink buffer is not being flushed this early
> in the kernel code?

printk() flushes the buffers on the exit path, or otherwise the console
code in printk.c is refusing to do anything that early to get around
the bootstrap ordering issues encountered on IA64 (which are truly
arch-generic, though some things coincidentally just work).

I should probably update this so it actually uses the CON_EARLY design
and applies against more recent kernels, and also does not register
things you don't code in explicitly (because of course it's just not
possible to get the bootstrap ordering vs. console output without some
more drivers and registration and unregistration and this logic is not
ever going to be portable).

On Sat, Feb 02, 2002 at 03:12:41PM +0100, W. Michael Petullo wrote:
> The only debugging technique I have found is to insert return statements
> in order to avoid different sections of code.  I find, for example,
> that if I make the first statement of the smpboot.c:do_boot_cpu a return,
> the kernel will boot (without SMP on, of course).

I've got a few other tricks up my sleeve -- the output drivers in the
patch are supposed to help some, but there is still more that can be done
to get debugging output out of a machine. I believe that for one reason
or another the console code is refusing to print that early. The driver
defines some callbacks for use by the console code which can be made
non-static and then called directly -- they should simply dump things to
the VGA text buffer with very little interference. They won't provide
convenient string formatting, but sprintf() can be used to help it along.
This is of course not the end of the line either but it may help some.

On Sat, Feb 02, 2002 at 03:12:41PM +0100, W. Michael Petullo wrote:
> Obviously, this is not the best technique.  I have been able to narrow
> the location of the bug down a little with it, but I feel I will be able
> to discover little more with this technique.
> I'm not sure what else to do without printks.
> I would appreciate any tips on debugging smpboot.c.
> Thank you.

Let me know if the VGA text buffer stuff I just mentioned helps at all.
I'm also on #kernelnewbies fairly often so flag me down there any time.
And, of course, I'll read the follow-ups. =)


Cheers,
Bill
