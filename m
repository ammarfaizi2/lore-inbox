Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWBQTm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWBQTm6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 14:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWBQTm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 14:42:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:150 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751423AbWBQTm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 14:42:57 -0500
Date: Fri, 17 Feb 2006 19:42:49 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Cc: Neil Brown <neilb@suse.de>, Alasdair Kergon <agk@redhat.com>,
       Lars Marowsky-Bree <lmb@suse.de>,
       device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] sysfs representation of stacked devices (dm/md)
Message-ID: <20060217194249.GO12169@agk.surrey.redhat.com>
Mail-Followup-To: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>,
	Neil Brown <neilb@suse.de>, Alasdair Kergon <agk@redhat.com>,
	Lars Marowsky-Bree <lmb@suse.de>,
	device-mapper development <dm-devel@redhat.com>,
	linux-kernel@vger.kernel.org
References: <43F60F31.1030507@ce.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F60F31.1030507@ce.jp.nec.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 01:00:17PM -0500, Jun'ichi Nomura wrote:
> These patches provide common representation of dependencies
> between stacked devices (dm and md) in sysfs.

I'm neutral on this change so long as it can be done without 
introducing problems for device-mapper.

> Though md0, dm-0, dm-1 and sd[a-d] contain same LVM2 meta data,
> LVM2 should pick up md0 as PV, not dm-0, dm-1 and sdXs.
> mdadm should build md0 from dm-0 and dm-1, not from sdXs.
> Similar things will happen on 'mount' and 'fsck' if we use
> file system labels instead of LVM2.
 
I can't speak for the 'mount' code base, but I don't think it'll
make any significant difference to LVM2 - we'd still have to do 
all the same device scanning as we do now because we have to be
aware of md devices defined in on-disk metadata regardless of 
whether or not the kernel knows about them at the time the 
command is run.

> Currently, these relationships are determined by each tool
> combining information like the existence of md metadata
> and dm dependency ioctl.
 
And attempts to open a device exclusively.  That's one check LVM2 
does before running 'pvcreate' on a device.

> thus we only need to check "holders" directory of the device
> to decide whether the device is used by dm/md.
> Also we can walk down the "slaves" directories to collect
> the devices conposing the given dm/md device.

For device-mapper devices, 'dmsetup deps' and ls --tree already
gives you this information reasonably efficiently.

Would others find the proposal useful for non-dm devices?

And rather than adding code just to dm and md, would it be better 
to implement it by enhancing bd_claim()?
 
Alasdair
-- 
agk@redhat.com
