Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWDZSTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWDZSTH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 14:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWDZSTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 14:19:07 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:26558 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964783AbWDZSTG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 14:19:06 -0400
Subject: Re: Linux 2.6.17-rc2 - notifier chain problem?
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, herbert@13thfloor.at, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, Ashok Raj <ashok.raj@intel.com>
In-Reply-To: <Pine.LNX.4.44L0.0604261144010.6376-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0604261144010.6376-100000@iolanthe.rowland.org>
Content-Type: text/plain
Organization: IBM
Date: Wed, 26 Apr 2006 11:18:54 -0700
Message-Id: <1146075534.24650.11.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 11:49 -0400, Alan Stern wrote:
> On Mon, 24 Apr 2006, Andrew Morton wrote:
<snip>

> > I guess for now, bringing those things into .text and .data when there's
> > doubt is a reasonable thing to do.
> 
> It seems clear that this particular oops was caused by the xfs driver 
> trying to register a cpu_notifier at a time when that notifier chain was 
> expected to be completely idle.
> 
> Instead of moving all this code and data out of the init sections, 
> wouldn't it be better to fix the individual drivers (like xfs) so they 
> won't try to use inaccessible notifier chains?
> 
> For that matter, if lots of entries on the cpu_notifier chain are marked 
> with __cpuinit, then shouldn't the chain header itself plus 
> register_cpu_notifier and unregister_cpu_notifier be marked the same way?

Your suggestion is very valid, since the cpu_notifiers are called only
at init time, unless CONFIG_HOTPLUG_CPU is turned ON. Definitions of
__cpuinit and __cpuinitdata takes care of HOTPLUG config option.

XFS wants to register only for HOTPLUG_CPU case, and it do so by putting
the callback, register and unregister inside #ifdef HOTPLUG_CPU.

Note: I made the changes and tested, it works.

Andrew, Linus, Any comments ?

> Alan Stern
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


