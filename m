Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289085AbSA1BqH>; Sun, 27 Jan 2002 20:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289089AbSA1Bp6>; Sun, 27 Jan 2002 20:45:58 -0500
Received: from p0025.as-l042.contactel.cz ([194.108.237.25]:42112 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S289085AbSA1Bpt>;
	Sun, 27 Jan 2002 20:45:49 -0500
Date: Mon, 28 Jan 2002 02:44:29 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: "W. Michael Petullo" <mike@flyn.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP Pentium III, GA-6VXDC7 MoBo. -- 2.4.18-pre7 SMP not working
Message-ID: <20020128014429.GF3684@ppc.vc.cvut.cz>
In-Reply-To: <20020127172150.A1407@dragon.flyn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020127172150.A1407@dragon.flyn.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2002 at 05:21:50PM +0100, W. Michael Petullo wrote:
> I have a home-built dual Pentium III computer which does not seem to
> want to run recent SMP kernels.  The computer is built on a Gigabyte
> GA-6VXDC7 motherboard, which is in turn based on a VIA Apollo Pro chip-set.
> It is an exclusively SCSI system -- I do not compile any IDE drivers
> into my kernel.

Can you open arch/i386/kernel/smpboot.c in your favorite text
editor, locate wakeup_secondary_via_INIT (it has this name
in 2.5.3-pre5), and in this function locate

apic_write_around(APIC_ICR, APIC_DM_STARTUP | (start_eip >> 12));
/* Give the other CPU some time to accept the IPI */
udelay(300);

and try increasing 300 to some bigger value (and make sure that
you are using pristine sources, there must be no printk() between
apic_write_around and udelay()). When I was getting Linux SMP 
to work on GA-6VXD7 (it still boots, even with 2.5.3-pre5), I had to
ensure that no bus accesses (and especially PCI write) happen 
until secondary CPU is alive. By trial and error I found 
that 150us is needed on my motherboard, so I put 300us here.
Maybe 300us is not enough for you, so try increasing this value.

On 6VXD7 if you are not silent after you send startup IPI, 
secondary CPU will not execute even first two instructions,
and first CPU will die about 50ms after it sends this
startup IPI.
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz

