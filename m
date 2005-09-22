Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbVIVJsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbVIVJsV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 05:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbVIVJsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 05:48:20 -0400
Received: from colin.muc.de ([193.149.48.1]:56848 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1030239AbVIVJsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 05:48:20 -0400
Date: 22 Sep 2005 11:48:18 +0200
Date: Thu, 22 Sep 2005 11:48:18 +0200
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, suresh.b.siddha@intel.com,
       discuss@x86-64.org
Subject: Re: init and zap low address mappings on demand for cpu hotplug
Message-ID: <20050922094818.GB79762@muc.de>
References: <20050921135731.B14439@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050921135731.B14439@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 01:57:31PM -0700, Ashok Raj wrote:
> Hi,
> 
> to simplyfy cpu hotplug we didnt zap low mem address since we would require
> them post boot to bringup a new cpu. This caused bad effects when 
> Suresh was testing some new code. More below.

This seems racy - how do you prevent udev running on another
CPU while another CPU boots? I suspect you need additional locks
to plug this race. Or use a fresh mm cloned from init_mm mm to do the 
CPU bootup.  

I don't like zap_low_first_time - it shouldn't be needed. In general
people have been complaining on i386 and x86-64 that we don't
unmap NULL early, so we don't catch bugs that happen on other 
architectures. 

Using a fresh mm for smp bootup would solve this nicely - one could
zap init_mm really early after entering from head.S and then
only ever undo it in private mms for smp bootup.

-Andi
