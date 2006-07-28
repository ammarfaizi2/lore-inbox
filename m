Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161177AbWG1OUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161177AbWG1OUF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 10:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161176AbWG1OUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 10:20:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:50256 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161170AbWG1OUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 10:20:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C+WkdKmMTeyx9qtZD357fdpyT3fO/Mu954V/A/V6P//3QQxwCq9kCKbdXvy5RVIyqwU765K03Q8n0ysVyakl4ObjPjFZcIikSwC7SxN7Q2Xpq4qXtyGbl8hL0utcIPsK+Ifs5vZ5oPOBHssOJNQiYEOMFQYyOTaJp6rB6vf+ywA=
Message-ID: <d120d5000607280720u3db9b7dmb7f05cb7e9424934@mail.gmail.com>
Date: Fri, 28 Jul 2006 10:20:00 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: [RFC/RFT] Remove polling timer from i8042
Cc: linux-kernel@vger.kernel.org, "Dave Jones" <davej@redhat.com>
In-Reply-To: <20060728133223.GB29217@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607270029.05066.dtor@insightbb.com>
	 <20060727234423.GC4907@suse.cz>
	 <d120d5000607280557w2aa476b2y45d8cfc866296adf@mail.gmail.com>
	 <20060728133223.GB29217@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Fri, Jul 28, 2006 at 08:57:31AM -0400, Dmitry Torokhov wrote:
>
> > On 7/27/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > >On Thu, Jul 27, 2006 at 12:29:04AM -0400, Dmitry Torokhov wrote:
> > >> Hi,
> > >>
> > >> OK, I had it in works for quite some time and Dave's talk in Ottawa
> > >> made me finish it ;)
> > >
> > >Good work.
> > >
> > >However I believe you need to test the AUX IRQ in this case before you
> > >use it, otherwise you'll have a lot of people with non-working keyboards
> > >(the input queue is shared), and probably also non-working PCI cards
> > >(BIOSes like to assign IRQ12 to PCI if no mouse is detected by the
> > >BIOS).
> > >
> >
> > What do you mean by testing AUX IRQ? Use I8042_CMD_AUX_LOOP to see if
> > interrupt fires off? The new code releases IRQ if it can't find a
> > working AUX port...
>
> Exactly. Not that a character arrives and can be polled for, but that
> the interrupt actually gets raised. It can be routed to nowhere and
> we'll never know, our buffers will be full and keyboard will be stuck.
>

Riiiight. OK, I'll add this check - should be simple enough if we just
have interrupt handler set a flag when it sees AUX irq and have
probing code sleep for a 1/4 of a second in 50 msec intervals to see
if the flag was set. Don't want to use completion in main IRQ
handler... Or do you think it is better to initially register
i8042_aux_test_irq() that would signal completion and after successful
testing for IRQ delivery free_irq/request_irq with normal handler?
Tooo bad we don't have replace_irq...

-- 
Dmitry
