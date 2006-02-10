Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWBJOxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWBJOxw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 09:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWBJOxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 09:53:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47261 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751272AbWBJOxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 09:53:50 -0500
Date: Fri, 10 Feb 2006 14:53:48 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: dm-devel@redhat.com, Chris McDermott <lcm@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support HDIO_GETGEO on device-mapper volumes
Message-ID: <20060210145348.GA12173@agk.surrey.redhat.com>
Mail-Followup-To: "Darrick J. Wong" <djwong@us.ibm.com>,
	dm-devel@redhat.com, Chris McDermott <lcm@us.ibm.com>,
	linux-kernel@vger.kernel.org
References: <43EBEDD0.60608@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EBEDD0.60608@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 05:35:12PM -0800, Darrick J. Wong wrote:
> Since dm doesn't implement the HDIO_GETGEO ioctl,

Why should it?  Device-mapper constructs a virtual device and
I think it's completely wrong for it to 'fake' a geometry.

Of course dm could recognise the ioctl - but the default response
should be the one that indicates the geometry is unknown.

> grub assumes that the CHS
> geometry is 620/128/63, which makes it impossible to configure it to
> boot a filesystem that lives beyond the 2GB mark, even if the system
> BIOS supports that.

Surely a problem in grub, not the kernel?

> The attached patch implements a simple ioctl handler that supplies a
> compatible geometry when HDIO_GETGEO is called against a device-mapper
> device.  Its behavior is somewhat similar to what sd_mod does if the
> scsi controller doesn't provide its own geometry. 

What if the dm device is a linear mapping to an sd device that *does*
provide a different geometry?  Then the 'fake' geometry dm would return
with this patch would be wrong!

> this seems to be a better option than having each program make
> up its own potentially different geometry, or making an arbitrary guess.

I disagree - either dm should work out the *correct* geometry to
return for those mappings where a geometry is known and it's sensible
to return one (e.g. linear mapping to the start of certain scsi
devices), or else it should leave it to userspace to decide how to
handle the situation.  (And there's nothing currently stopping
userspace seeing that a dm device is constructed out of a scsi device
and choosing to use the geometry of that underlying device.)

Alasdair
--
agk@redhat.com
