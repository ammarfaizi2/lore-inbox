Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbVCBThA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbVCBThA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 14:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbVCBThA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 14:37:00 -0500
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:46599 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262436AbVCBTgq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 14:36:46 -0500
Date: Wed, 2 Mar 2005 20:37:21 +0100
From: Jean Delvare <khali@linux-fr.org>
To: James Chapman <jchapman@katalix.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH: 2.6.11-rc5] i2c chips: add adt7461 support to lm90
 driver
Message-Id: <20050302203721.7cce650d.khali@linux-fr.org>
In-Reply-To: <20050302165532.GB2311@kroah.com>
References: <4223513F.4030403@katalix.com>
	<20050302165532.GB2311@kroah.com>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> > Add ADT7461 (temperature sensor) support to LM90 driver.
> > 
> > Signed-off-by: James Chapman <jchapman@katalix.com>
> 
> Applied, thanks.

I had Greg drop this patch because it doesn't seem to be correct to me.
The patch assumes that the ADT7461 is 100% compatible with the ADM1032.
The datasheets mentions that, but only in the default confiuration of
the chip. If I read it correctly, the ADT7461 can also be switched to an
extended temperature range mode, where the register formats are
different. In this mode, the chip is NOT compatible with the ADM1032 and
needs specific handling.

I wonder how the limits are affected by the extended mode. The datasheet
doesn't give much details about this. I would assume that they are
affected too though, or it wouldn't make much sense.

I also see that the ADT7461 datasheet explicitely says that temperature
measurements below 0 return 0 and over 127 return 127, in compatibility
mode. Then we probably should not allow limits to be set outside of this
range, as it might fool the user into thinking that the device can
actually measure this. The ADM1032 datasheet isn't as clear on the
topic, so I'm not sure what should be done for this one.

Please modify your patch so that it works properly for both modes. I do
not request that you implement mode change, nor even that you support
extended range mode if you don't need it. But I want you to ensure that
the driver will behave properly on an ADT7461 found in this
non-compatible range. This might be as easy as to not recognize the chip
as supported if found in that mode, providing you don't care about the
extended range.

I would also like you do update the documentation located on top of the
lm90 driver source file. I listed all supported chips with links to
datasheet and some additional per-chip information. The ADT7461
definitely needs something similar. Then please update Kconfig to
mention the new chip.

I would also appreciate a patch to lm_sensors' sensors-detect script for
the ADT7461, and possibly a patch for libsensors and sensors as well,
unless you are not interested in these (in which case you would need to
explicitely mention in Kconfig that the ADT7461 has no user-space
support at the moment).

Thanks,
-- 
Jean Delvare
