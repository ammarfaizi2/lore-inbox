Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278180AbRJRWZ2>; Thu, 18 Oct 2001 18:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278181AbRJRWZS>; Thu, 18 Oct 2001 18:25:18 -0400
Received: from toad.com ([140.174.2.1]:1299 "EHLO toad.com")
	by vger.kernel.org with ESMTP id <S278180AbRJRWZL>;
	Thu, 18 Oct 2001 18:25:11 -0400
Message-ID: <3BCF56FF.A38755AC@mandrakesoft.com>
Date: Thu, 18 Oct 2001 18:26:07 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Alvord <jalvo@mbay.net>
CC: Patrick Mochel <mochelp@infinity.powertie.org>,
        Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <p05100309b7f4cd5976f7@[10.128.7.49]> <Pine.LNX.4.21.0110181237360.17191-100000@marty.infinity.powertie.org> <pbiust45nr5rtsl7d8qlf6gu8p8er91gtj@4ax.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Alvord wrote:
> 
> On Thu, 18 Oct 2001 12:49:01 -0700 (PDT), Patrick Mochel
> <mochelp@infinity.powertie.org> wrote:
> 
> >
> >> The "state of all the devices in the system". Presumably, while you
> >> walk the tree the first time (to save state) interrupts are enabled,
> >> and devices are active. Operations (including interrupts) on the
> >> device can, presumably, change the state of the device after its
> >> state has been saved.
> >
> >Ya, I'm an idiot sometimes. I relized this just as I was leaving for
> >lunch. I almost turned around to come back and answer..
> >
> >This is what I had in mind; If someone could give me a thumbs-up or
> >thumbs-down on whether or not this would work:
> >
> >When the driver gets a save_state request, that is its notification that
> >it is going to sleep. It should then stop/finish all I/O requests. It
> >should then prevent itself from taking any more - by setting a flag or
> >whatever. Then, device save state.
> >
> >>From that point in, it should know not to take any requests, theoretically
> >preserving state.
> >
> >When it gets the restore_state() call, it should first restore device
> >state. Once it does that, it knows that it can take I/O requests again.
> >
> >That should work, right?
> >
> >The only thing that that won't work for is the device to which we're
> >saving state, like the disk. At some point, though we have to accept that
> >the state that we saved was some checkpoint in the past, and it won't
> >reflect the state that changed in the process of writing the system state.
> 
> Maybe each driver could pass back a value indicating
> 
> 1) all done
> 2) N milliseconds more, please

It seems far less complex to simply let the driver do what it needs to
do, in the time it needs to do it.  The probe step in current drivers
for example could take anywhere from less than a second to several
seconds, depending on what needs to be done.

Though like I mentioned in a previous mail, if you have a two-stage
save-state step, a lot of those delays can be parallelized:  in the
first save-state the driver stops the hardware from accepting further
transaction, and initiates I/O request completion (where possible).  The
second save-state cleans up any outstanding transactions and shuts the
rest of the hardware down.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
