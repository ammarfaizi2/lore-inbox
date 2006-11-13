Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932818AbWKMT0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932818AbWKMT0F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932831AbWKMT0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:26:05 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:43415 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932818AbWKMT0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:26:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=TxT4eivH7BMXZcC+ZXakSe7R8n1RYxMGaBA8HBvJSEzlpttk8jTzpuHY6J3r3dep1dyg1erG3e4G9Y5JxjTg9MAKzf6DEc6DLNt13gmWyVuzi7zBn939PupfKE5EeljCUjjE6Np8C6iUEOZ/0SWjABGohqM2EVcYOQjTjNSZ+iA=  ;
From: David Brownell <david-b@pacbell.net>
To: "Thiago Galesi" <thiagogalesi@gmail.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Date: Mon, 13 Nov 2006 11:25:52 -0800
User-Agent: KMail/1.7.1
Cc: "Paul Mundt" <lethal@linux-sh.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Andrew Victor" <andrew@sanpeople.com>,
       "Bill Gatliff" <bgat@billgatliff.com>,
       "Haavard Skinnemoen" <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       "Kevin Hilman" <khilman@mvista.com>, "Nicolas Pitre" <nico@cam.org>,
       "Russell King" <rmk@arm.linux.org.uk>,
       "Tony Lindgren" <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <20061113173800.GA19553@linux-sh.org> <82ecf08e0611130956m9f30bf0t2a7b62307d5f70ca@mail.gmail.com>
In-Reply-To: <82ecf08e0611130956m9f30bf0t2a7b62307d5f70ca@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611131125.52984.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 November 2006 9:56 am, Thiago Galesi wrote:
> I guess that a kind of "name addressing" would be the way to go, we
> need to get to it by "location" (I'm thinking PortA 20, PortB 5 rather
> than pin number or some other arbitrary convention; we need a way to
> not need to look up what 'Port X pin B' should be called.

That's highly platform-specific.  AT91 and AVR32 use that style of
addressing ... most others just talk about GPIO numbers.  In all cases,
the platform can assign _some_ number to each GPIO signal.


> Another thing that may be considered is the ability to get 'pointers'
> for GPIOs.

The GPIO identifiers are unsigned integers.  If you really crave pointers,
you can cast those integers to pointers, and back.  But why bother?  :)


> And, of course, protecting GPIOs from concurrent accesses 

Did you read the proposal?  There are *already* two mechanisms for that:

 - gpio_request()/gpio_free() ... protecting from concurrent access
   between drivers, also known as bugs.

 - gpio_set_value() ... implementations can lock internally, as needed.
   ditto gpio_get_value(), but only bizarre hardware would need it.

Re that last, consider two different types of GPIO controller:

  * One of them has just one register with the output values, and a
    RISC CPU without bit set/clear instructions to use on it.  So a
    spinlock is needed to cover reading the register, modifying that
    value, then rewriting the value.

  * Better GPIO controller designs (normal ones) have separate registers
    for "write mask to set" and "write mask to clear" ... no spinlock
    needed, the hardware sorts everything out.

I did update the docs to make clear that gpio get/set calls are atomic;
hard to imagine single bit operations that aren't, but it's worth
removing potential confusion.

- Dave

