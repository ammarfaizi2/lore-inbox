Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263678AbUDFJrl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 05:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUDFJrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 05:47:41 -0400
Received: from mailbox.leidenuniv.nl ([132.229.102.4]:32404 "EHLO
	mailbox.leidenuniv.nl") by vger.kernel.org with ESMTP
	id S263678AbUDFJri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 05:47:38 -0400
From: Willem de Bruijn <wdebruij@dds.nl>
To: Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] various linux kernel devtools : device handling/memory mapping/profiling/etc
Date: Tue, 6 Apr 2004 11:55:05 +0000
User-Agent: KMail/1.6.1
References: <1081191622.4071acc6e100c@webmail.dds.nl> <20040405193004.GA3545@kroah.com>
In-Reply-To: <20040405193004.GA3545@kroah.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404061155.05935.wdebruij@dds.nl>
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> pci_register_driver() as Documentation/pci.txt says to use.  Works just
> wonderful from 2.4 to 2.6, and I think it's even been backported to work
> on 2.2 if you so desire.

thanks. I need something that works with a specially patched 
2.3.99-pre3-rmk3-ds1 kernel for an IXP1200 network processor. Porting the 
original patch to 2.6 is simply too much work, so everything *must* be 
backward compatible to this prerelease. Hence the module template files.

>
> Well, feel free to submit portions of it as patches that clean up the
> current API, if you think it will help out any.  In my short glance, I
> didn't really see anything that would help out all that much, but I'm
> probably missing something.
>

AFAIK there the kernel reverts to a standard llseek implementation when this 
operation is left empty. How about having standard fallback behaviour for all 
system call handlers? That's what most of my device code is about: 
implementing regular file access and memory mapping, so that device driver 
writers won't have to do that each time for themselves. 9 times of out 10 
people will want the same .nopage handler, right? Why implement it for each 
driver individually?

having a generic interface does entail that drivers must export the memory 
region information in a standard fashion, which is why I created the 
dev_file_t, dev_file_open_t and dev_file_open_region_t structures (for lack 
of a better name). Once these were finished, adding automatic default 
handling was relatively straightforward. However, as you pointed out, I 
shouldn't have made claims about udev, as I never actually tested that. 

considering udev and devfs are both still being developed (although the latter 
is marked `deprecated'), a single interface to the device file creation, 
would IMO, also be useful, as not all drivers have to be updated or filled 
with KERNEL_VERSION statements. The actual code is quite small (it all 
resides in dev.c), but even without supporting udev I have 3 different cases 
to deal with (2devfs+mknod).

I'm not saying my code should be used for this per se, but I do believe that 
these two features are so generic across drivers that they deserve to be 
included in the main tree somewhere. As for the rest of the package, that 
might not be too useful. I discussed the addition of prepending __FILE__, 
__FUNCTION__ and clockcycles to printk previously and someone else actually 
sent in a patch to printk allowing vsprintf functionality. The buffer 
structure is probably too heavyweight for kernel inclusion, anyway.

Willem

-- 
Dit bericht is gescand op virussen en andere gevaarlijke inhoud door ULCN MailScanner en het bericht lijkt schoon te zijn.
This message has been scanned for viruses and dangerous content by ULCN MailScanner, and is believed to be clean.

