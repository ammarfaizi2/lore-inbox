Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbSLTSS3>; Fri, 20 Dec 2002 13:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264907AbSLTSS2>; Fri, 20 Dec 2002 13:18:28 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:38120 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S264790AbSLTSS1>;
	Fri, 20 Dec 2002 13:18:27 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15875.24790.221094.202859@napali.hpl.hp.com>
Date: Fri, 20 Dec 2002 10:26:30 -0800
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.x disable BAR when sizing
In-Reply-To: <Pine.LNX.4.44.0212200849090.2035-100000@home.transmeta.com>
References: <15874.58889.846488.868570@napali.hpl.hp.com>
	<Pine.LNX.4.44.0212200849090.2035-100000@home.transmeta.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 20 Dec 2002 09:05:53 -0800 (PST), Linus Torvalds <torvalds@transmeta.com> said:

  Linus> On Fri, 20 Dec 2002, David Mosberger wrote:
  >>  Could you please stop this ia64 paranoia and instead explain to
  >> me why it's OK to relocate a PCI device to
  >> (0x100000000-PCI_dev_size) temporarily?  That just seems horribly
  >> unsafe to me.

  Linus> No. It's not horribly unsafe at all. It's very safe, for one
  Linus> simple reason: it's how PCI probing has _always_ been
  Linus> done. Exactly because the alternatives simply do not work.

  Linus> I can also tell you why it does work, and why it's supposed
  Linus> to work: by writing 0xffffffff to the BAR register, you
  Linus> basically move the BAR to high PCI memory - even if it was
  Linus> enabled before. Which is fine, as long as nobody else is in
  Linus> that high memory. So the secondary rule to "don't turn off
  Linus> MEM or IO accesses" is "never allocate real PCI BAR resources
  Linus> at the top of memory".

A 32-bit PCI device can decode up to 2GB of memory.  I doubt any PC
firmware is reserving the top 2GB for BAR-sizing.  Without a
reasonably small a-priori limit on the address window size of device,
this method isn't safe.

  Linus> Let me re-iterate the "turn power off at the master switch in
  Linus> a house when switching a light bulb" analogy. Yes, it's a
  Linus> good idea if you are nervous, but you do that only when you
  Linus> _know_ who is in the house and you know what they are doing
  Linus> and it's ok by them.

That's a poor analogy.  What you're suggesting is more like replacing
the light bulb while it's powered on.  Yes, it can be done, but people
do get burned and electrocuted that way.

  Linus> One solution in the long term may be to not even probe the
  Linus> BAR's at all in generic code, and only do it in the
  Linus> pci_enable_dev() stuff. That way it would literally only be
  Linus> done by the driver, who can hopefully make sure that the
  Linus> device is ok with it.

Yes, I see now that the method in the PCI spec isn't really safe
either, so BAR-sizing probably shouldn't be done in generic code at
all.

	--david
