Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbVGMK56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbVGMK56 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 06:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbVGMK55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 06:57:57 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:56248 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262581AbVGMK4K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 06:56:10 -0400
Date: Wed, 13 Jul 2005 16:26:03 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Bharata B Rao <bharata@in.ibm.com>
Cc: "Moore, Eric Dean" <Eric.Moore@lsil.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "Wade, Roy" <Roy.Wade@lsil.com>, fastboot@lists.osdl.org
Subject: Re: [BUG] Fusion MPT Base Driver initialization failure with kdum p
Message-ID: <20050713105603.GC29375@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <91888D455306F94EBD4D168954A9457C030A9D9C@nacos172.co.lsil.com> <1121250903.10622.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121250903.10622.28.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 04:05:03PM +0530, Bharata B Rao wrote:
> On Tue, 2005-07-12 at 12:15 -0600, Moore, Eric Dean wrote:
> > I've seen the report. I need more info from Bharata on how
> > to reproduce. Perhaps you can send me email offline which
> > provides specific instructions to how to configure kdump,
> > how to capture the dump, and what you did to crash your system.
> 
> This is how I could reproduce this bug:
> (http://bugzilla.kernel.org/show_bug.cgi?id=4870)
> 
> - Configure the 1st kernel to take a kdump and run 4 instances of LTP on
> it (I used `runltp -p -l logfile -t 12h -x 4)
> - After a few hours, the 1st kernel crashes which results in the booting
> of the 2nd kernel (the kernel which captures kdump). While this is
> booting, mptbase driver fails during initialization leading to the panic
> of the 2nd kernel.

I had also faced this problem and I had simply used Alt-Sysrq-c to force
kexec on panic. As mentioned in the report below the problem goes away
if mpt driver is compiled with MPT_DEBUG_IRQ support. 

In kdump environment, device might not be in a reset state while driver is
initializing in second kernel. Hence we probably need two things from the 
driver to be able to successfully initialize over kdump.

- Reset the underlying device before enabling the interrupts.
- In interrupt handler, make sure the interrupt belongs to the driver 
  before processing it further.  (Shared interrupt lines) 

Thanks
Vivek
