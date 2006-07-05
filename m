Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbWGEToo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWGEToo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 15:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWGETon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 15:44:43 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:37047 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965006AbWGETom
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 15:44:42 -0400
Date: Wed, 5 Jul 2006 14:44:37 -0500
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>, akpm@osdl.org,
       LKML <linux-kernel@vger.kernel.org>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       netdev@vger.kernel.org, wenxiong@us.ibm.com
Subject: Re: [PATCH] ixgb: add PCI Error recovery callbacks
Message-ID: <20060705194437.GJ29526@austin.ibm.com>
References: <20060629162634.GC5472@austin.ibm.com> <1151905766.28493.129.camel@ymzhang-perf.sh.intel.com> <44ABDF87.8000801@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44ABDF87.8000801@intel.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 08:49:27AM -0700, Auke Kok wrote:
> Zhang, Yanmin wrote:
> >On Fri, 2006-06-30 at 00:26, Linas Vepstas wrote:
> >>Adds PCI Error recovery callbacks to the Intel 10-gigabit ethernet
> >>ixgb device driver. Lightly tested, works.
> >
> >Both pci_disable_device and ixgb_down would access the device. It doesn't
> >follow Documentation/pci-error-recovery.txt that error_detected shouldn't 
> >do
> >any access to the device.
> 
> Moreover, it was Linas who wrote this documentation in the first place :)

On the pSeries, its harmless to try to do i/o; the i/o will e blocked. 

> Linas, have you tried moving the e1000_down() call into the _reset part? I 
> suspect that the e1000_reset() in there however may already be sufficient.

I wanted to perform all of the "down" type functions BEFORE the reset. 
The idea is to get the device driver and the various parts of the 
Linux kernel into a state that would be consisten with a reset.

I don't want to do these functions after the reset, since, at this
point, the card is a "clean slate"; it has the PCI bars set, but 
nothing else.  Doing random i/o to it at this point could confuse
the card; instead, one wants to bring the card up using the usual
bringup sequence.

For example, I tipped over one rather confusing bug: new code 
in the -mm tree blocks a pci_enable_device() if it thinks the
card is already enabled (even if its not). Doing I/O to a card
that is not enabled will cause either a target abort or a master 
abort.  Thus, I found I had to call pci_disable_device(); and it
seemed that the best time to do this would be before the reset, not
afterwords.  However, I did not play at length with other possibilities.

I recently lost access to my ixgb cards, and so can't do more testing
just right now.

--linas


