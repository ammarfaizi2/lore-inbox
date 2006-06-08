Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWFHOiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWFHOiP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 10:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWFHOiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 10:38:15 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:10770 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964843AbWFHOiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 10:38:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CalliC32wIx3xuXpaPgHJXSfn5UdmhfWzXh06ywnn5DqUTNVh9iMkijvKqR1vmugOz2lQQVejYBKPR3jYbQ9GCRuMDgbM0z6e04376/m4yh8MRdfgiE22TlujYS22n0pe4pGqf1md6+u/XreY7iLFhmbxrWkuPlNvV1K9gyr/Ts=
Message-ID: <9e4733910606080738xd44aab3o5ac0d4bda920575d@mail.gmail.com>
Date: Thu, 8 Jun 2006 10:38:13 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: Interrupts disabled for too long in printk
Cc: "Mathieu Desnoyers" <compudj@krystal.dyndns.org>,
       linux-kernel@vger.kernel.org, ltt-dev@shafik.org
In-Reply-To: <Pine.LNX.4.61.0606080618520.29263@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060603111934.GA14581@Krystal>
	 <9e4733910606071837l4e81c975t8d531ed9810af60f@mail.gmail.com>
	 <20060608023102.GA22022@Krystal>
	 <9e4733910606071935o5f42f581g6392d5a23897fb09@mail.gmail.com>
	 <Pine.LNX.4.61.0606080618520.29263@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/06, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
>
> On Wed, 7 Jun 2006, Jon Smirl wrote:
>
> > On 6/7/06, Mathieu Desnoyers <compudj@krystal.dyndns.org> wrote:
> >> * Jon Smirl (jonsmirl@gmail.com) wrote:
> >>> You can look at this problem from the other direction too. Why is it
> >>> taking 15ms to get between the two points? If IRQs are off how is the
> >>> serial driver getting interrupts to be able to display the message? It
> >>> is probably worthwhile to take a look and see what the serial console
> >>> driver is doing.
> >>
> >> Hi John,
> >>
> >> The serial port is configured at 38000 bauds. It can therefore transmit 4800
> >> bytes per seconds, for 72 characters in 15 ms. So the console driver would be
> >> simply busy sending characters to the serial port during that interrupt
> >> disabling period.
> >
> > Why can't the serial console driver record the message in a buffer at
> > the point where it is being called with interrupts off, and then let
> > the serial port slowly print it via interupts? It sounds to me like
> > the serial port is being driven in polling mode.
> >
> >>
> >> Mathieu
> >>
> >> OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
> >> Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
>
> Probably because there is no buffer that is big enough! If the character
> source (a call to printk()) can generate N characters per second, but
> the UART can only send out N-1, then the buffer will fill up at which
> time software will wait until the UART is ready for the next character,
> effectively becoming poll-mode with a buffer full of characters as
> backlog.

That sounds like a reasonable explanation if that is what is actually
happening.  Does the serial console driver revert to a polling
behavior when interrupts are off?

What should the console do in this situation? If called to printk with
interrupts off, and the backlog buffer is full, should it suspend the
system like it is doing, or should it toss the printk and return an
error?

-- 
Jon Smirl
jonsmirl@gmail.com
