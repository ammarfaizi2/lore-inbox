Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268924AbRHFTBO>; Mon, 6 Aug 2001 15:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268926AbRHFTBF>; Mon, 6 Aug 2001 15:01:05 -0400
Received: from chaos.analogic.com ([204.178.40.224]:12162 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268924AbRHFTAn>; Mon, 6 Aug 2001 15:00:43 -0400
Date: Mon, 6 Aug 2001 15:00:07 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Colin Walters <walters@cis.ohio-state.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 (PCI ID 82820) lockups/failure
In-Reply-To: <873d75janh.church.of.emacs@space-ghost.verbum.org>
Message-ID: <Pine.LNX.3.95.1010806144632.8686A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2001, Colin Walters wrote:

> Andrey Savochkin <saw@saw.sw.com.sg> writes:
> 
> > Someone who experiences such timeouts needs to figure out how much
> > time it really can take before a command is accepted.  Some time ago
> > the timeout was increased by the factor of 10, and now the current
> > timeout looks being insufficient.  It might be a problem with the
> > time of specific commands or specific chip revisions.  Or some
> > hardware is too clever and somehow optimizes those repeated read
> > operations, so that they no longer take a fixed number of bus
> > cycles.
> 
[SNIPPED...]

This may not be a timing problem, but rather a problem that was
attempted to be fixed with some timing change.

Possible problem (and solution). Given:

	writel(value, pci_reg);
	status = readl(pci_reg);

The second readl() may (read will) complete before the writel().
This is because writes to the PCI bus may be posted (queued). The
first read will force all writes to complete, however the value
read may be something that was not yet affected by the write.

	writel(value, pci_reg);
	status = readl(pci_reg);
	status = readl(pci_reg);

Would fix, but gcc may "optimize" one of these away, therefore I
suggest reading something, within the boards address space that
is never used, i.e., some offset that gives the model number or
something. It must actually respond to a read because otherwise
performance will degrade while waiting for the PCI bus error.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


