Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262785AbTDATf0>; Tue, 1 Apr 2003 14:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbTDATf0>; Tue, 1 Apr 2003 14:35:26 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51210 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262785AbTDATfY>; Tue, 1 Apr 2003 14:35:24 -0500
Date: Tue, 1 Apr 2003 20:46:45 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.66-mm2-1 freezes solid after init PCMCIA
Message-ID: <20030401204645.B7936@flint.arm.linux.org.uk>
Mail-Followup-To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <1049196020.789.8.camel@teapot> <20030401125328.B30470@flint.arm.linux.org.uk> <1049202135.612.4.camel@teapot>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1049202135.612.4.camel@teapot>; from felipe_alfaro@linuxmail.org on Tue, Apr 01, 2003 at 03:02:16PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 03:02:16PM +0200, Felipe Alfaro Solana wrote:
> OK, here we go...

I was thinking that it could be due to the pci changes - that's one of
the areas I've been working in recently which could have caused this.

However, I believe it is to do with the recent PCMCIA changes to use
the device model, and deadlock within the device model itself.

What basically seems to be happening is this:

- the ds module is inserted
- ds registers a driver model interface for pcmcia socket drivers,
  which takes the global devclass_sem.
- ds causes the pcmcia core to evaluate the status of the sockets, and
  perform "card insertion" processing if cards are present.
- this processing detects a cardbus card, and calls the cardbus code to
  scan pci devices, and add them to the device tree.
- each device gets passed to the device model's class layer, which tries
  to take devclass_sem.  But wait!  We've locked it while initialising
  the ds module -> deadlock.

I'm currently working on the card insertion/removal code which hopefully
should fix this.  However, it's not going to be immediately available,
so please be patient.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

