Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWH2B6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWH2B6a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 21:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWH2B6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 21:58:30 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:23528 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750974AbWH2B63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 21:58:29 -0400
Date: Tue, 29 Aug 2006 10:57:23 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: mail@renninger.de
Subject: Re: [PATCH](memory hotplug) Repost remove useless message at boot time from 2.6.18-rc4.
Cc: Thomas Renninger <trenn@suse.de>, akpm@osdl.org,
       "Brown, Len" <len.brown@intel.com>, keith mannthey <kmannth@us.ibm.com>,
       ACPI-ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       naveen.b.s@intel.com
In-Reply-To: <1156799818.12158.9.camel@linux-1vxn.site>
References: <20060828223538.F622.Y-GOTO@jp.fujitsu.com> <1156799818.12158.9.camel@linux-1vxn.site>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.068
Message-Id: <20060829102200.FC1D.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Old code registers handler for all of memory devices even if it is not
> > enabled.
> Yeah, therefore the mem_device cannot be passed as callback data as it
> might get generated in the notify handler func and all the additional
> stuff is needed..., ouch.
> > 
> > If my understanding is wrong, please let me know. ;-)
> It's me who is wrong, thanks a lot for checking!
> 
> > Memory device might not have _EJ0/_EJD, but parent device 
> > (like one NUMA node) might be able to be ejectable.
> > In this case, only the parent device has _EJ0/_EJD.
> > So, one more check is necessary.
> 
> I feared something like that (should have add a comment...), as the EJ0
> and _STA functions are only used on the device itself I thought checking
> for them makes sense, but for a missing EJ0 func powering down the
> device just fails and it should not be harmful.
> So the only useful thing from my patch (as long as .add is only invoked
> if device is present) is using the general acpi_bus_get_status() func. 
> Hmm, it must be used if the _STA function on the memory device is also
> missing and the parent _STA must be used then? Could make sense on a
> machine where a whole node must be inserted/ejected? The
> acpi_bus_get_status() function already contains the checking for the
> parent's _STA function and uses this one if the device itself has none.

I don't have any report like "no _STA on memory device" so far.
Current code assume each memory device has _STA.
I suppose each memory device should have _STA method. For example,
if a memory device is broken, its _STA should return disable status. 
So, basically checking _STA of only memory device should be ok now.

However I'm not sure that every vendor will do it in the future.
If there is no _STA on memory device, parents, grand-parents or
more ancestor might have _STA for it.
(See acpi_get_pxm() in driver/acpi/numa.c. It searches ancestor's _PXM.
 If insane vendor make like it, it will be good reference.)

Bye.
-- 
Yasunori Goto 


