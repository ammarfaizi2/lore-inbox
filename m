Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265015AbSJWXXI>; Wed, 23 Oct 2002 19:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265042AbSJWXXI>; Wed, 23 Oct 2002 19:23:08 -0400
Received: from fmr01.intel.com ([192.55.52.18]:61683 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S265015AbSJWXXG> convert rfc822-to-8bit;
	Wed, 23 Oct 2002 19:23:06 -0400
Subject: RE: [BUG] e100 driver fails to initialize NIC on 2.5.44
From: Rob Rhoads <errhoads@linux.co.intel.com>
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <288F9BF66CD9D5118DF400508B68C44604758C30@orsmsx113.jf.intel.com>
References: <288F9BF66CD9D5118DF400508B68C44604758C30@orsmsx113.jf.intel.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 23 Oct 2002 16:28:53 -0700
Message-Id: <1035415733.676.446.camel@beer.co.intel.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 13:07, Feldman, Scott wrote:
> Rob Rhoads wrote:
> > -#define E100_MAX_SCB_WAIT	100	/* Max udelays in wait_scb */
> > +#define E100_MAX_SCB_WAIT	2000	/* Max udelays in wait_scb */
> 
> I'm not in favor of increasing a hardware timeout value 20x without knowing
> root-cause of the failure.  What is unique about your environment?  I'd like
> to know if there are others out there that have run into this same failure.
> List?

Can't blame you on that one. :-) 

It's a standard Intel STL2 Server Board, nothing really unique about it.
But here is more detail on how it is configured:

o 2 x Intel® Pentium® III Processors @ 1-GHz
o 2.5 GB PC133 ECC Registered SDRAM Memory
o Integrated SCSI (Adaptec* AIC7899 dual-channel SCSI controller)
o ServerWorks* ServerSet* III LE Chipset
o ATI Rage* IIC PCI graphics controller with 4 MB of memory
o Integrated Intel® Pro/100+ Server Adapter (Intel® 82559 Controller)
o Dual-Peer PCI, Six Available PCI Slots
  - Bus A-four 32-bit/33MHz PCI slots
  - Bus B-two 64-bit/66MHz PCI slots

We've seen this same problem before on the STL2 & the 2.4.18 kernel
running the 2.1.15 version of the Intel e100 driver. This same problem
had also been previously reported to the kernel mailing list, but I
don't recall the exact version of either the 2.4.x kernel or e100
driver.

Upon further investigation, when I set E100_MAX_SCB_WAIT to 2000 on the
2.5.44 kernel, as in my original patch, it only works for when the e100
driver is compiled into the kernel. I had to bump it up to 5000 to make
it work as a loadable module. When I dumped the value of the loop
variable 'i', it would succeed at either 4078 or 4095 iterations of the
for-loop. So 5000 may very well NOT work for other configurations.

Also the comment for the function states that the driver may need to
wait up to 1 millisecond, yet the original for-loop uses a udelay(1) for
a max of 100 iterations. Since 100 usecs. != 1 millisecond, this is what
clued us into increasing the max. loop count. Experimentation is what
got us to 2000 and now 5000.

Let me know if there is anything else I can do to help root cause this
problem.

-RobR

