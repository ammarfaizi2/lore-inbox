Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278215AbRJRXoq>; Thu, 18 Oct 2001 19:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278216AbRJRXoh>; Thu, 18 Oct 2001 19:44:37 -0400
Received: from smtp-rt-9.wanadoo.fr ([193.252.19.55]:59109 "EHLO
	alisier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S278215AbRJRXoU>; Thu, 18 Oct 2001 19:44:20 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Fri, 19 Oct 2001 01:44:25 +0200
Message-Id: <20011018234425.8883@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.33.0110181601250.9099-100000@osdlab.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.33.0110181601250.9099-100000@osdlab.pdx.osdl.net>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Ok, so we need another walk before we go to sleep.
>
>But, first a question - does the swap device need to absolutely be the
>last thing to stop taking requests? Or, can it stop after everything is
>done allocating memory?

The problem with VM is that you don't really have one swap device.

You can have swap on files from several devices, you can have mmap'ed
files from any mounted filesystem on any block device, you can have
NFS, etc...

That's why we must completely separate allocation from blocking of
activity. If we do so, we don't need to care about any ordering rule
between drivers (at least not because of this problem, other issues
may require ordering rules, but it's an arch matter).

>> The actual state save can be in step 2 or 3, we don't really care,
>> it depends mostly on what is more convenient for the driver writer.
>
>For most devices, it seems it could happen in the first, as well. They
>should be fine with stopping I/O requests early on. It's only special
>cases like swap and maybe one or two others that need an extra step,
>right?

Well, you may think it's ok to do it, let's say, for a serial port, in
step 1. But... what about NFS over PPP over that serial port ? :)

If a device don't need to allocate memory and can do the save_state
and shutdown in one step, then it only need to respond to step 2. It
will skip step 1 and step 3.

Ben.


