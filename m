Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161281AbWG1U1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161281AbWG1U1s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161284AbWG1U1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:27:48 -0400
Received: from styx.suse.cz ([82.119.242.94]:27039 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1161285AbWG1U1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:27:47 -0400
Date: Fri, 28 Jul 2006 22:27:37 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
Subject: Re: [RFC/RFT] Remove polling timer from i8042
Message-ID: <20060728202737.GC5313@suse.cz>
References: <200607270029.05066.dtor@insightbb.com> <20060727234423.GC4907@suse.cz> <d120d5000607280557w2aa476b2y45d8cfc866296adf@mail.gmail.com> <20060728133223.GB29217@suse.cz> <d120d5000607280720u3db9b7dmb7f05cb7e9424934@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000607280720u3db9b7dmb7f05cb7e9424934@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 10:20:00AM -0400, Dmitry Torokhov wrote:
> On 7/28/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> >On Fri, Jul 28, 2006 at 08:57:31AM -0400, Dmitry Torokhov wrote:
> >
> >> On 7/27/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> >> >On Thu, Jul 27, 2006 at 12:29:04AM -0400, Dmitry Torokhov wrote:
> >> >> Hi,
> >> >>
> >> >> OK, I had it in works for quite some time and Dave's talk in Ottawa
> >> >> made me finish it ;)
> >> >
> >> >Good work.
> >> >
> >> >However I believe you need to test the AUX IRQ in this case before you
> >> >use it, otherwise you'll have a lot of people with non-working keyboards
> >> >(the input queue is shared), and probably also non-working PCI cards
> >> >(BIOSes like to assign IRQ12 to PCI if no mouse is detected by the
> >> >BIOS).
> >> >
> >>
> >> What do you mean by testing AUX IRQ? Use I8042_CMD_AUX_LOOP to see if
> >> interrupt fires off? The new code releases IRQ if it can't find a
> >> working AUX port...
> >
> >Exactly. Not that a character arrives and can be polled for, but that
> >the interrupt actually gets raised. It can be routed to nowhere and
> >we'll never know, our buffers will be full and keyboard will be stuck.
> >
> 
> Riiiight. OK, I'll add this check - should be simple enough if we just
> have interrupt handler set a flag when it sees AUX irq and have
> probing code sleep for a 1/4 of a second in 50 msec intervals to see
> if the flag was set. Don't want to use completion in main IRQ
> handler... Or do you think it is better to initially register
> i8042_aux_test_irq() that would signal completion and after successful
> testing for IRQ delivery free_irq/request_irq with normal handler?
> Tooo bad we don't have replace_irq...
 
I would go for the second option. Regarding the missing replace_irq(),
it's not a big deal for us - if the second request_irq() fails, we want
to bail out anyway.

-- 
Vojtech Pavlik
Director SuSE Labs
