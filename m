Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVEKPNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVEKPNa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 11:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVEKPN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 11:13:29 -0400
Received: from graphe.net ([209.204.138.32]:62478 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261181AbVEKPMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 11:12:21 -0400
Date: Wed, 11 May 2005 08:12:16 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu,
       kenneth.w.chen@intel.com, shai@scalex86.org
Subject: Re: [RFC][PATCH] timers fixes/improvements
In-Reply-To: <4281DC03.36011256@tv-sign.ru>
Message-ID: <Pine.LNX.4.58.0505110804540.10451@graphe.net>
References: <424D373F.1BCBF2AC@tv-sign.ru> <424E6441.12A6BC03@tv-sign.ru>  
 <Pine.LNX.4.58.0505091312490.27740@graphe.net> <20050509144255.17d3b9aa.akpm@osdl.org>
  <Pine.LNX.4.58.0505091449580.29090@graphe.net> <42808B84.BCC00574@tv-sign.ru>
 <Pine.LNX.4.58.0505101212350.20718@graphe.net> <4281DC03.36011256@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2005, Oleg Nesterov wrote:

> > However, if the padding is put before ptype_base and after ptype_all
> > then the problem occurs.
>
> So. ptype_base/ptype_all is corrupted before e1000_probe()->register_netdev().
>
> Christoph, please, could you try this patch?

We found that this has nothing to do with the timer patches. There is a
scribble in pcie_rootport_aspm_quirk that overwrites ptype_all.

quirk_aspm_offset[GET_INDEX(pdev->device, dev->devfn)]= cap_base + 0x10;

does the evil deed. The array offset calculated by GET_INDEX is out of
bounds.

The definition of GET_INDEX is suspect:

#define GET_INDEX(a, b) (((a - PCI_DEVICE_ID_INTEL_MCH_PA) << 3) + b)

should this not be

#define GET_INDEX(a, b) ((((a) - PCI_DEVICE_ID_INTEL_MCH_PA) << 3) + \
				((b) & 7))

?


