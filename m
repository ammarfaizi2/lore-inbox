Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269620AbUI3X4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269620AbUI3X4f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 19:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269624AbUI3X4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 19:56:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:64939 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269620AbUI3X4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 19:56:31 -0400
Date: Thu, 30 Sep 2004 16:56:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: CaT <cat@zip.com.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: promise controller resource alloc problems with ~2.6.8
In-Reply-To: <20040930233048.GC7162@zip.com.au>
Message-ID: <Pine.LNX.4.58.0409301646040.2403@ppc970.osdl.org>
References: <20040927084550.GA1134@zip.com.au> <Pine.LNX.4.58.0409301615110.2403@ppc970.osdl.org>
 <20040930233048.GC7162@zip.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Oct 2004, CaT wrote:
> 
> I have the one from 2.6.9-rc2-bk8 available to me (last time I booted I
> had time to grab lots of things) so I've attached that and the current
> one. If you need the rc3 it'll need to wait another 8 hours or so as I'm
> currently away from the PC.

This is enough, I think, although I'd also like to get the output from 
/sbin/lspci just to clarify what the devices are.

In 2.6.8 (working), you had:

	1080-10bf : 0000:00:0d.0
	  1080-1087 : ide2
	  1088-108f : ide3
	  1090-10bf : PDC20267
	10c0-10cf : 0000:00:14.1
	  10c0-10c7 : ide0
	  10c8-10cf : ide1

while in the nonworking setup the PCI code allowed 0:14.1 to be allocated 
_inside_ device 0:0d.0, like this:

	1080-10bf : 0000:00:0d.0
	  10a0-10af : 0000:00:14.1
	    10a0-10a7 : ide0
	    10a8-10af : ide1

which looks rather bogus. In fact, it looks like the device was mis-setup 
by the BIOS, and that the PCI resource changes allowed that broken setup.

The reason for that is the change in "arch/i386/pci/i386.c" to use 
"insert_resource()" instead of "request_resource()", which in turn is 
because we wanted to insert PCI resources _inside_ the system resources 
reserved by ACPI.

HOWEVER, we do _not_ want to allow insertion of PCI resources inside other 
PCI resources, and while this normally shouldn't happen, it definitely can 
happen if the BIOS has set things up incorrectly in the first place. As 
appears to be the case in your setup.

Now, the reason for using "insert_resource()" in arch/i386/pci/i386.c 
should go away with Shaohua Li's patch, so I'd love to hear if applying 
Li's patch _and_ making the "insert_resource()" be a "request_resource()" 
fixes the problem for you.

I bet it will.

Greg, we kind of left the ACPI resource management breakage pending, and 
clearly we need some resolution. Comments?

		Linus
