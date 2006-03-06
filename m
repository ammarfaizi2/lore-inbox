Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751655AbWCFVCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbWCFVCH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbWCFVCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:02:07 -0500
Received: from smtp-2.llnl.gov ([128.115.3.82]:55478 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S1751655AbWCFVCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:02:06 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] EDAC: core EDAC support code
Date: Mon, 6 Mar 2006 13:01:37 -0800
User-Agent: KMail/1.5.3
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603061052.57188.dsp@llnl.gov> <20060306195348.GB8777@kroah.com>
In-Reply-To: <20060306195348.GB8777@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603061301.37923.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 March 2006 11:53, Greg KH wrote:
> > Is the concern here that EDAC is not waiting for the reference count
> > on the kobject to reach 0, therefore creating the possibility of the
> > module unloading while the kobject (declared statically within the
> > module) is still in use?
>
> Eeek, don't statically create a kobject :(
>
> Anyway, yes, that is a problem, if it is static, then you need to know
> it is safe to unload.  Even if it is dynamic that is also true...

Ok, now I understand.  At first I thought it was something specific
to the way the debugf1() call was implemented that people were
commenting on.

Regarding the above problem with the kobject reference count, this
was recently fixed in the -mm tree (see edac-kobject-sysfs-fixes.patch
in 2.6.16-rc5-mm2).  The fix I implemented was to add a call to
complete() in edac_memctrl_master_release() and then have the module
cleanup code wait for the completion.  I think there were a few other
instances of this type of problem that I also fixed in the
above-mentioned patch.

Is it more desirable to dynamically allocate kobjects than to declare
them statically?  If so, I'd be curious to know why dynamic
allocation is preferred over static allocation.  If desired, I can
make a patch that fixes EDAC so that its kobjects are dynamically
allocated.

Dave
