Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbVCBTld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbVCBTld (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 14:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbVCBTld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 14:41:33 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:54794 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262438AbVCBTlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 14:41:22 -0500
Date: Wed, 2 Mar 2005 20:44:20 +0100
To: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>
Cc: linux-os <linux-os@analogic.com>, linux-kernel@vger.kernel.org
Subject: Re: user space program from keyboard driver
Message-ID: <20050302194420.GA9839@hh.idb.hist.no>
References: <Pine.LNX.4.60.0502282118480.2017@lantana.cs.iitm.ernet.in> <Pine.LNX.4.61.0502281104480.31437@chaos.analogic.com> <Pine.LNX.4.60.0503012031560.13310@lantana.cs.iitm.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0503012031560.13310@lantana.cs.iitm.ernet.in>
User-Agent: Mutt/1.5.6+20040907i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 08:38:01PM +0530, Payasam Manohar wrote:
> 
> 
> Hai thank u for ur information. If possible can u please give some 
> reference for the above task of creating a daemon and waking up in demand.
> 
> Is it possible to call a daemon from keyboard driver on pressing certain 
> key, if so how to kill the daemon from the driver itself with some other 
> condition.

I don't know exactly what you want to do, but there is asimple
interface for kernelspace to userspace communication, and that is
to make a character device driver.

You needed to have the kernel ask userspace something and have
userspace report back an answer?  Simple:

1. Userspace program opens your "kernel communication" device
2. The program, or daemon, tries to read from the device.
3. The program will block, because the kernel doesn't have data for
   it at the moment.
4. When the kernel needs data, it writes something to the device.
   If you need to pass information to the daemon program, use thie
   opportunity to write that information.
5. The daemon wakes up because it got data.  It interprets the data,
   and does whatever you want it to do.  When the program have an
   answer to the kernel, it writes the answer into the device.
6. The kernel code gets the answer, in the form of a call into
   the part of the device driver that handles writes from userspace.
   Now the kernel can utilize the information.
7. The daemon can run in a loop, issuing a new read from the device in case
   its services will be needed again.

Thare are variations on this theme.  You may not want to create a new
device if the kernel code that needs this daemnon service is a device 
driver already, for example.  In that case you may want to use an ioctl 
interface for  that device instead.  Note that ioctl's isn't all that 
popular though.

Helge Hafting 
