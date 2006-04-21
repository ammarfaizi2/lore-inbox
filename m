Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWDUU5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWDUU5e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 16:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWDUU5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 16:57:34 -0400
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:52963 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S932473AbWDUU5d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 16:57:33 -0400
Message-Id: <4448F2C90200003600005340@zoot.lnxi.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Fri, 21 Apr 2006 14:57:13 -0600
From: "Doug Thompson" <dthompson@lnxi.com>
To: <mark.gross@intel.com>
Cc: <soo.keong.ong@intel.com>, <steven.carbonari@intel.com>,
       <zhenyu.z.wang@intel.com>, <bluesmoke-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Problems with EDAC coexisting with BIOS
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark thanks for the informaton on this.

Now the e752x_edac.c driver contains no direct calls to panic within
itself. The edac_mc.c 'core' piece does, but only calls that if an UE
error is found and panic on UE is enabled. (The other is a PCI parity
panic, but doesn't effect this path). It might be possible that since
the hidden register was now hidden, the retrieval function returns some
garbage which falsely triggers the panic by the core.

I would like to see the panic output and stack trace to see where that
panic came from. It might have come from the PCI device access subsytem
when it was trying to access the now hidden register.

can you post that panice information?

thanks

doug thompson


On Fri, 2006-04-21 at 16:01 +0000, "Gross, Mark"  wrote:
> I'm sorry to have to bring up these issues after a fare amount of good
> work, and I don't know how this problem managed to get by for as long as
> it has, but there are some issues with the EDAC and the BIOS for managed
> computer systems.
> 
> Managed computers are systems with automatic ECC logging to a System
> Event Log or SEL.  They typically have an out of band Board Management
> Controller aka BMC or IPMC that runs out of band WRT the OS payload.
> 
> The issues found with the EDAC driver are:
> 1) The default AMI BIOS behavior on SMI is to check the chipset error
> registers (Dev0:Fun1) and re-hide them.
> 2) If you are lucky enough to have BIOS code that doesn't re-hide
> Dev0:Fun1; then when EDAC is loaded there is a race condition between
> the platform BIOS and the driver to gain access to these registers. 
> 3) If the platform BIOS does the ECC logging out of band WRT the payload
> OS, there is no good way for the driver to know at load time.  
> 
> We discovered these problems when testing with one of the later RHEL4-U3
> RC's.  The EDAC driver called panic when the device 0 Function 1 of the
> E7250 was re-hidden by the legacy USB SMI that when off between the load
> of the EDAC driver and the USB host driver.  Loading the EDAC driver for
> many AMI bios's is a panic land mine waiting go off.  Unless the OS
> knows that it can trust the BIOS to not re-hide those chipset registers
> using this driver is not a safe thing to do.
> 
> Basically if device 0 : function 1 is hidden by the platform at boot
> time un-hiding and using the device and function is a risky thing to do,
> as there is likely a good reason for it to have been hidden in the first
> place.  If the BIOS thinks that it owns some registers then the OS
> should not use them without great care.
> 
> It is possible that the driver could be modified to check for re-hiding
> of the DEV0:FUN1, but this will be racey WRT SMI processing.  At least
> it shouldn't panic.  
> 
> The driver should never get loaded by default or automatically.  If the
> user knows enough about there BIOS to trust that the SMI behavior will
> coexist with the driver then its OK to load otherwise using this driver
> is not a safe thing to do.
> 
> I think the best thing to do is to have the driver error out in its init
> or probe code if the dev0:fun1 is hidden at boot time.
> 
> Comments?
> 
> Next steps?
> 
> Do you want me to send a patch implementing graceful error handling at
> driver init time so it doesn't load if DEV0:FUN1 is hidden?
> 
> --mgross
> Intel Open Source Technology Center
> (503) 677-4628
> (503)-712-6227
> ms: JF1-235
> 2111 NW 25th Ave
> Hillsboro, OR 97124
>  
> 
> 
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid0709&bid&3057&dat1642
> _______________________________________________
> bluesmoke-devel mailing list
> bluesmoke-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluesmoke-devel

