Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbTHZVtW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 17:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262921AbTHZVtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 17:49:22 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:1935 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262914AbTHZVtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 17:49:18 -0400
Date: Tue, 26 Aug 2003 23:43:23 +0200 (MEST)
Message-Id: <200308262143.h7QLhNoE003465@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de, akpm@osdl.org, haveblue@us.ibm.com, mikpe@csd.uu.se,
       venkatesh.pallipadi@intel.com, vojtech@suse.cz
Subject: RE: [PATCH][2.6][2/5]Support for HPET based timer
Cc: jun.nakajima@intel.com, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Aug 2003 11:31:16 -0700, "Pallipadi, Venkatesh" wrote:
>  This is an update on the option of using some sort of early_ioremap in
>place of fixmap for 
>HPET timers.
>
>Problem Description:
>  The requirement from HPET side is, we need to map HPET physical
>address during timer_init() 
>routine and also during any read/write HPET addresses. We need to have
>this mapping kind of
>permanently, as  we will do HPET reads/writes during every timer
>interrupt and also during 
>every gettimeofday (if we don't use tsc timer).
>  And the timer_init() happens before mem_init() (but after paging
>init()), so we cannot 
>directly use ioremap(). Current implementation is using a separate
>fixmap region for HPET.
...
>The question I have is,
>- Is it really worth to move from the current fixmap implementation to
>bt_ioremap/ioremap 
>combination, given all the changes that is required?
>- Isn't current implementation (using own fixmap) a cleaner way to do
>it? Only drawback 
>I see is it consumes one page in virtual memory when HPET is configured,
>irrespective of 
>HPET is used at run time or not.

As long as you _must_ map the HPET before ioremap() is working,
and you also must have a permanent mapping, then grabbing a fixmap
page is IMO the cleanest solution. This is for example how the
local APIC mapping is handled. boot/bt ioremap are as you noticed
for temporary mappings only.

However, dynamically migrating the timer to HPET after mem_init()
would be even better, since that avoids the problem altogether.

/Mikael
