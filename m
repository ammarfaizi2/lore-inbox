Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbWGFQQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWGFQQu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 12:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbWGFQQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 12:16:49 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:58814 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030274AbWGFQQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 12:16:48 -0400
Date: Thu, 6 Jul 2006 11:16:40 -0500
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: Auke Kok <auke-jan.h.kok@intel.com>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>, akpm@osdl.org,
       LKML <linux-kernel@vger.kernel.org>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       netdev@vger.kernel.org, wenxiong@us.ibm.com
Subject: Re: [PATCH] ixgb: add PCI Error recovery callbacks
Message-ID: <20060706161640.GT29526@austin.ibm.com>
References: <20060629162634.GC5472@austin.ibm.com> <1151905766.28493.129.camel@ymzhang-perf.sh.intel.com> <44ABDF87.8000801@intel.com> <20060705194437.GJ29526@austin.ibm.com> <1152148899.28493.168.camel@ymzhang-perf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152148899.28493.168.camel@ymzhang-perf.sh.intel.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 09:21:39AM +0800, Zhang, Yanmin wrote:
> On Thu, 2006-07-06 at 03:44, Linas Vepstas wrote:
> > On Wed, Jul 05, 2006 at 08:49:27AM -0700, Auke Kok wrote:
> > > Zhang, Yanmin wrote:
> > > >On Fri, 2006-06-30 at 00:26, Linas Vepstas wrote:
> > > >>Adds PCI Error recovery callbacks to the Intel 10-gigabit ethernet
> > > >>ixgb device driver. Lightly tested, works.
> > > >
> > > >Both pci_disable_device and ixgb_down would access the device. It doesn't
> > > >follow Documentation/pci-error-recovery.txt that error_detected shouldn't 
> > > >do
> > > >any access to the device.
> > > 
> > > Moreover, it was Linas who wrote this documentation in the first place :)
> > 
> > On the pSeries, its harmless to try to do i/o; the i/o will e blocked.
> In the future, we might move the pci error recovery codes to generic to
> support other platforms which might not block I/O. So it's better to follow
> Documentation/pci-error-recovery.txt when adding error recovery codes into driver.

Or we could change the documentation. The point was that doing
unexpected i/o after the aapter reset is likely to wedge the adapter
again, leading to an inf loop of resets. As a practical matter, 
I found that, while developing this patch, and the other related
patches, that this was indeed the usual failure mode: incorrect bringup
just lead to more errors.

What I really want to do is to perform as clean a shut-down as possible, 
reset the adapter, and then bring it back up.  I'm concerned that changing 
the order to "reset"-"shutdown-"bringup" would be inappropriate.

Perhaps the right fix is to figure out what parts of the driver do i/o
during shutdown, and then add a line "if(wedged) skip i/o;" to those
places?

--linas
