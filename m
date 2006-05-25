Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbWEYFSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbWEYFSE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 01:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbWEYFSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 01:18:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:61118 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S965045AbWEYFSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 01:18:02 -0400
X-IronPort-AV: i="4.05,170,1146466800"; 
   d="scan'208"; a="41073002:sNHT46594128"
Subject: Re: [PATCH 2/2] microcode update driver rewrite
From: Shaohua Li <shaohua.li@intel.com>
To: Greg KH <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Tigran Aivazian <tigran@veritas.com>,
       Rajesh Shah <rajesh.shah@intel.com>,
       "Van De Ven, Adriaan" <adriaan.van.de.ven@intel.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060525040557.GA30175@kroah.com>
References: <1148529049.32046.103.camel@sli10-desk.sh.intel.com>
	 <20060525040557.GA30175@kroah.com>
Content-Type: text/plain
Date: Thu, 25 May 2006 13:16:26 +0800
Message-Id: <1148534186.32046.115.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 21:05 -0700, Greg KH wrote:
> On Thu, May 25, 2006 at 11:50:49AM +0800, Shaohua Li wrote:
> > This is the rewrite of microcode update driver. Changes:
> > 1. trim the code
> 
> Hm, but the code is now bigger.
Ok, I'll consider move the old interface part to a separate file as Arjan suggested.

> > 2. using request_firmware to pull ucode from userspace, so we don't need
> > the application 'microcode_ctl' to assist. We name each ucode file
> > according to CPU's info as intel-ucode/family-model-stepping. In this
> > way we could split ucode file as small one. This has a lot of advantages
> > such as selectively update and validate microcode for specific models,
> > better manage microcode file, easily write tools for administerators and
> > so on.
> > 3. add sysfs support. Currently each CPU has two microcode related
> > attributes. One is 'version' which shows current ucode version of CPU.
> > Tools can use the attribute do validation or show CPU ucode status. The
> > other is 'reload' which allows manually reloading ucode. 
> 
> Why are you not using the current cpu struct devices in the system?
> Don't roll your own logic for this with "raw" kobjects please.
Not sure if I understand. Using attribute_gropu?

> > 4. add suspend/resume and CPU hotplug support. 
> > 
> > With the changes, we should put all intel-ucode/xx-xx-xx microcode files
> > into the firmware dir (I had a tool to split previous big data file into
> > small one and later we will release new style data file). The init
> > script should be changed to just loading the driver without unloading
> > for hotplug and suspend/resume (for back compatibility I keep old
> > interface, so old init script also works).
> > 
> > Downside. We are using request_firmware. If the driver is build-in and
> > initramfs hasn't udev support, the driver will wait for request_firmware
> > to finish for a long time. But I suppose this is very rare, as microcode
> > driver usually is a module.
> 
> Don't use request_firmware, use request_firmware_nowait() instead.  
If it really does matter, I'll. Other drivers have the same issue, and
nobody complains. I suppose it's really module instead of build-in. In
the meantime it's meanless to let the module build-in, as the firmware
usually isn't in initramfs.

> That
> way you never stall.  You only want to update the firmware when
> userspace tells you to, not for every boot like I think this will do.
We need update it when suspend/resume and hotplug. Userspace can
manually update it as well.

Thanks,
Shaohua
