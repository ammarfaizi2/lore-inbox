Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154224AbPGKMGO>; Sun, 11 Jul 1999 08:06:14 -0400
Received: by vger.rutgers.edu id <S154203AbPGKMFz>; Sun, 11 Jul 1999 08:05:55 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:4116 "EHLO smtp1.cern.ch") by vger.rutgers.edu with ESMTP id <S154172AbPGKMEb>; Sun, 11 Jul 1999 08:04:31 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Klaus Nielsen <jimbo@zorland.dk>, Linux Kernel list <linux-kernel@vger.rutgers.edu>
Subject: Re: Unable to read memory mapped PCI memory the second time == freezeup..
References: <Pine.GSO.3.96.990710104147.7017A-100000@ext1>
From: Jes Sorensen <Jes.Sorensen@cern.ch>
Date: 11 Jul 1999 14:03:51 +0200
In-Reply-To: Jeff Garzik's message of "Sat, 10 Jul 1999 10:44:15 -0400 (EDT)"
Message-ID: <d3emifs89k.fsf@dxplus05.cern.ch>
X-Mailer: Gnus v5.6.45/Emacs 20.2
Sender: owner-linux-kernel@vger.rutgers.edu

>>>>> "Jeff" == Jeff Garzik <jgarzik@pobox.com> writes:

Jeff> Read linux/Documentation/IO-mapping.txt, and then use read?()
Jeff> and write?() for MMIO.  For example:

Jeff> 	byArgh = readb(global_vmemaddr); if(byArgh==0)
Jeff> printk(KERN_DEBUG "byArgh\n"); writeb (0x5a, global_vmemaddr);
Jeff> byArgh = readb(global_vmemaddr);

There is a number of memory barrier instructions missing in that
example, you need to put an mb() in after the writeb to make sure the
compiler doesn't cache the value written to the register. On
architectures which do not guarantee write ordering this shows up even
more since the CPU may decide to issue the instructions in a different
order (though this is mainly of interest if you are accessing several
different registers in the mapped area). Anyway the correct way to do
things is this way:

	byArgh = readb(global_vmemaddr);
	if(byArgh==0) printk(KERN_DEBUG "byArgh\n");
	writeb (0x5a, global_vmemaddr);
	mb();
	byArgh = readb(global_vmemaddr);

You are absolutely right about the use of readb/writeb though, one
should _never_ access PCI shared memory directly.

Jes

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
