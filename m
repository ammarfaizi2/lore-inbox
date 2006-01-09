Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWAIChx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWAIChx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 21:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWAIChx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 21:37:53 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:25998 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750819AbWAIChx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 21:37:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UHrUGkM1bvPHEXKREomx4JSxbw6RGMbvqJ0SGfo859SSYrvtGYLtlJe0NS3hOt0cae3oNSbnvvCAl8pnitk3DwgVyw+fCy/D6tPssAxVCc3BLeZHCbUnLwDxcujne8tPZtzP4e5q8SxCryJnoNDnM2/pSEngbWj7oEeu7fLpkAI=
Message-ID: <4807377b0601081837u2c1d50b3w218d5ef9e3dc662@mail.gmail.com>
Date: Sun, 8 Jan 2006 18:37:52 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: gcoady@gmail.com
Subject: Re: Why is 2.4.32 four times faster than 2.6.14.6??
Cc: Bernd Eckenfels <be-news06@lina.inka.de>, linux-kernel@vger.kernel.org
In-Reply-To: <igs1s1lje7b7kkbmb9t6d06n8425i1b1i4@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060108095741.GH7142@w.ods.org>
	 <E1EvXi5-0000kv-00@calista.inka.de>
	 <igs1s1lje7b7kkbmb9t6d06n8425i1b1i4@4ax.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/06, Grant Coady <gcoady@gmail.com> wrote:
> On Sun, 08 Jan 2006 11:23:37 +0100, be-news06@lina.inka.de (Bernd Eckenfels) wrote:
>
> >Willy Tarreau <willy@w.ods.org> wrote:
> >> It's rather strange that 2.6 *eats* CPU apparently doing nothing !
> >
> >it eats it in high interrupt load. And it is caused by the pty-ssh-tcp
> >output, so most likely those are eepro100 interrupts.
>
> That would be true for either 2.4 or 2.6, no?  Also it runs e100
> driver, but...
>
> 2.4 dmesg:
> Intel(R) PRO/100 Network Driver - version 2.3.43-k1
> Copyright (c) 2004 Intel Corporation
>
> e100: selftest OK.
> e100: eth0: Intel(R) PRO/100 Network Connection
>   Hardware receive checksums enabled
>   cpu cycle saver enabled
>
> 2.6 dmesg:
> [   31.977945] e100: Intel(R) PRO/100 Network Driver, 3.4.14-k2-NAPI
> [   31.978007] e100: Copyright(c) 1999-2005 Intel Corporation
> [   32.002928] e100: eth0: e100_probe: addr 0xfd201000, irq 11, MAC addr 00:90:27:42:AA:77
> [   32.026992] e100: eth1: e100_probe: addr 0xfd200000, irq 12, MAC addr 00:90:27:58:32:D4
> [   32.186941] e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
>
> Are rx checksums not turned on in 2.6' e100 driver?
> CPU is only pentium/mmx 233

Hey Grant, to answer your question, checksums are not offloaded with
the current e100 driver but that really shouldn't make that much of a
difference.  I'm actually going to go with interrupt load due to e100
being at least related to the problem.

BTW I get access denied when hitting
http://bugsplatter.mine.nu/test/boxen/deltree/

The netdev-2.6 git tree currently has a driver that supports microcode
loading for your rev 8 PRO/100 and that microcode may help your
interrupt load due to e100.  however, it may already be loading. 
Also, what do you have HZ set to? (250 is default in 2.6, 1000 in 2.4)
so you could try running your 2.6 kernel with HZ=1000

while you're running your test you could try (if you have sysstat)
sar -I <e100 interrupt> 1 10

or a simpler version, 10 loops of cat /proc/interrupts; sleep 1;

Lets see if its e100,
  Jesse
