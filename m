Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVCAQiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVCAQiO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 11:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVCAQiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 11:38:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14762 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261965AbVCAQhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 11:37:45 -0500
Message-ID: <42249A44.4020507@pobox.com>
Date: Tue, 01 Mar 2005 11:37:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linas Vepstas <linas@austin.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
References: <422428EC.3090905@jp.fujitsu.com>
In-Reply-To: <422428EC.3090905@jp.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hidetoshi Seto wrote:
> Hi, long time no see :-)
> 
> Currently, I/O error is not a leading cause of system failure.
> However, since Linux nowadays is making great progress on its
> scalability, and ever larger number of PCI devices are being
> connected to a single high-performance server, the risk of the
> I/O error is increasing day by day.
> 
> For example, PCI parity error is one of the most common errors
> in the hardware world. However, the major cause of parity error
> is not hardware's error but software's - low voltage, humidity,
> natural radiation... etc. Even though, some platforms are nervous
> to parity error enough to shutdown the system immediately on such
> error. So if device drivers can retry its transaction once results
> as an error, we can reduce the risk of I/O errors.
> 
> So I'd like to suggest new interfaces that enable drivers to
> check - detect error and retry their I/O transaction easily.

I have been thinking about PCI system and parity errors, and how to 
handle them.  I do not think this is the correct approach.

A simple retry is... too simple.  If you are having a massive problem on 
your PCI bus, more action should be taken than a retry.

In my opinion each driver needs to be aware of PCI sys/parity errs, and 
handle them.  For network drivers, this is rather simple -- check the 
hardware, then restart the DMA engine.  Possibly turning off 
TSO/checksum to guarantee that bad packets are not accepted.  For SATA 
and SCSI drivers, this is more complex, as one must retry a number of 
queued disk commands, after resetting the hardware.

A new API handles none of this.

	Jeff



