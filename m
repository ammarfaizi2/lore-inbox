Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWDZSla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWDZSla (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 14:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWDZSla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 14:41:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24772 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750784AbWDZSl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 14:41:29 -0400
Date: Wed, 26 Apr 2006 11:43:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: sekharan@us.ibm.com
Cc: stern@rowland.harvard.edu, herbert@13thfloor.at, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, ashok.raj@intel.com
Subject: Re: Linux 2.6.17-rc2 - notifier chain problem?
Message-Id: <20060426114348.51e8e978.akpm@osdl.org>
In-Reply-To: <1146075534.24650.11.camel@linuxchandra>
References: <Pine.LNX.4.44L0.0604261144010.6376-100000@iolanthe.rowland.org>
	<1146075534.24650.11.camel@linuxchandra>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman <sekharan@us.ibm.com> wrote:
>
> On Wed, 2006-04-26 at 11:49 -0400, Alan Stern wrote:
> > On Mon, 24 Apr 2006, Andrew Morton wrote:
> <snip>
> 
> > > I guess for now, bringing those things into .text and .data when there's
> > > doubt is a reasonable thing to do.
> > 
> > It seems clear that this particular oops was caused by the xfs driver 
> > trying to register a cpu_notifier at a time when that notifier chain was 
> > expected to be completely idle.
> > 
> > Instead of moving all this code and data out of the init sections, 
> > wouldn't it be better to fix the individual drivers (like xfs) so they 
> > won't try to use inaccessible notifier chains?
> > 
> > For that matter, if lots of entries on the cpu_notifier chain are marked 
> > with __cpuinit, then shouldn't the chain header itself plus 
> > register_cpu_notifier and unregister_cpu_notifier be marked the same way?
> 
> Your suggestion is very valid, since the cpu_notifiers are called only
> at init time, unless CONFIG_HOTPLUG_CPU is turned ON. Definitions of
> __cpuinit and __cpuinitdata takes care of HOTPLUG config option.
> 
> XFS wants to register only for HOTPLUG_CPU case, and it do so by putting
> the callback, register and unregister inside #ifdef HOTPLUG_CPU.
> 
> Note: I made the changes and tested, it works.
> 
> Andrew, Linus, Any comments ?

Ashok's the one who has spent most time with this.  Basically _everything_
to do with register_cpu_notifier() and all the things which call it should
be __cpuinit and should be tossed away during boot on non-cpu-hotplug
kernels.

But there are a few nasty problems with that which made us give up.
