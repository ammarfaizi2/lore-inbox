Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311193AbSCPXGO>; Sat, 16 Mar 2002 18:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310416AbSCPXGF>; Sat, 16 Mar 2002 18:06:05 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55083 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S311193AbSCPXFv>; Sat, 16 Mar 2002 18:05:51 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Anders Gustafsson <andersg@0x63.nu>, <arjanv@redhat.com>,
        <linux-kernel@vger.kernel.org>, <mochel@osdl.org>
Subject: Re: [PATCH] devexit fixes in i82092.c
In-Reply-To: <Pine.LNX.4.33.0203161421240.8278-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Mar 2002 16:00:13 -0700
In-Reply-To: <Pine.LNX.4.33.0203161421240.8278-100000@home.transmeta.com>
Message-ID: <m14rjgxgn6.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Sat, 16 Mar 2002, Alan Cox wrote:
> > > In the general reboot case yes it is a BIOS bug.  In the general Linux
> > > booting Linux case there is no BIOS involved.
> >
> > In that case yes I can see why you want to turn the bus masters off when you
> > boot the new kernel
> 
> Truning bus masters off is easy enough, and could just be done by some
> generic PCI reboot code. But for a linux-linux boot I think you also want
> to turn off interrupt generation to make sure some device isn't screaming
> on some irq, and that definitely requires explicit help by the driver
> itself.
> 
> One question that hasn't come up: do we actually want to use the "remove"
> function for this, or have a separate shutdown function? Are there reasons
> to not use "remove" for shutdown?

I had initially thought of using module_exit().  Which has the problem
of being hard to get the order right.  

remove is good (and the driver testing scenario of rmmod old_driver;
insmod new_driver) makes certain all of the code is there.

The only current downside with remove is it doesn't currently handle
non-pci devices.  Which just means that we need to generalize a little
bit.  That was already on the todo list right?

A primary example is things like the apics need cleanup code run on
them as well.  Because on x86 you go back to using the legacy PIC
and be in virtual wire mode or you really confuse the kernel.

I suspect we might want to run both the removes and the module_exit
code.  If we are going to get rid of the reboot notifier.

Eric
