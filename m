Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbWEYEIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWEYEIk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 00:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWEYEIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 00:08:40 -0400
Received: from cantor.suse.de ([195.135.220.2]:2285 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964859AbWEYEIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 00:08:19 -0400
Date: Wed, 24 May 2006 21:05:57 -0700
From: Greg KH <greg@kroah.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Tigran Aivazian <tigran@veritas.com>,
       Rajesh Shah <rajesh.shah@intel.com>,
       "Van De Ven, Adriaan" <adriaan.van.de.ven@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] microcode update driver rewrite
Message-ID: <20060525040557.GA30175@kroah.com>
References: <1148529049.32046.103.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148529049.32046.103.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 11:50:49AM +0800, Shaohua Li wrote:
> This is the rewrite of microcode update driver. Changes:
> 1. trim the code

Hm, but the code is now bigger.

> 2. using request_firmware to pull ucode from userspace, so we don't need
> the application 'microcode_ctl' to assist. We name each ucode file
> according to CPU's info as intel-ucode/family-model-stepping. In this
> way we could split ucode file as small one. This has a lot of advantages
> such as selectively update and validate microcode for specific models,
> better manage microcode file, easily write tools for administerators and
> so on.
> 3. add sysfs support. Currently each CPU has two microcode related
> attributes. One is 'version' which shows current ucode version of CPU.
> Tools can use the attribute do validation or show CPU ucode status. The
> other is 'reload' which allows manually reloading ucode. 

Why are you not using the current cpu struct devices in the system?
Don't roll your own logic for this with "raw" kobjects please.

> 4. add suspend/resume and CPU hotplug support. 
> 
> With the changes, we should put all intel-ucode/xx-xx-xx microcode files
> into the firmware dir (I had a tool to split previous big data file into
> small one and later we will release new style data file). The init
> script should be changed to just loading the driver without unloading
> for hotplug and suspend/resume (for back compatibility I keep old
> interface, so old init script also works).
> 
> Downside. We are using request_firmware. If the driver is build-in and
> initramfs hasn't udev support, the driver will wait for request_firmware
> to finish for a long time. But I suppose this is very rare, as microcode
> driver usually is a module.

Don't use request_firmware, use request_firmware_nowait() instead.  That
way you never stall.  You only want to update the firmware when
userspace tells you to, not for every boot like I think this will do.

thanks,

greg k-h
