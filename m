Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbVJUEWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbVJUEWS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 00:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbVJUEWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 00:22:18 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:35815 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964864AbVJUEWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 00:22:17 -0400
Date: Thu, 20 Oct 2005 21:22:07 -0700
From: mike kravetz <kravetz@us.ibm.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, magnus.damm@gmail.com,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 0/4] Swap migration V3: Overview
Message-ID: <20051021042207.GD6846@w-mikek2.ibm.com>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com> <20051020160638.58b4d08d.akpm@osdl.org> <20051020234621.GL5490@w-mikek2.ibm.com> <43585EDE.3090704@jp.fujitsu.com> <20051021033223.GC6846@w-mikek2.ibm.com> <435866E0.8080305@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435866E0.8080305@jp.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2005 at 12:56:16PM +0900, KAMEZAWA Hiroyuki wrote:
> mike kravetz wrote:
> >We have been using Mel's fragmentation patches.  One of the data structures
> >created by these patches is a 'usemap' thats tracks how 'blocks' of memory
> >are used.  I exposed the usemaps via sysfs along with other hotplug memory
> >section attributes.  So, you can then have a user space program scan the
> >usemaps looking for sections that can be easily offlined.
> >
> yea, looks nice :)
> But such pages are already shown as hotpluggable, I think.
> ACPI/SRAT will define the range, in ia64.

I haven't taken a close look at that code, but don't those just give
you physical ranges that can 'possibly' be removed?  So, isn't it
possible for hotpluggable ranges to contain pages allocated for kernel
data structures which would be almost impossible to offline?

> The difficulty is how to find hard-to-migrate pages, as Andrew pointed out.

By examining the fragmentation usemaps, we have a pretty good idea about
how the blocks are being used.  If a block is flagged as 'User Pages' then
there is a good chance that it can be offlined.  Of course, depending on
exactly how those 'user pages' are being used will determine if they can
be offlined.  If the offline of a section marked user is unsuccessful, you
can retry in the hope that the situation was transient.  Or, you can move
on to the next user block.  By concentrating your efforts on blocks only
containing user pages, your chances of success are greatly increased.
For blocks that are marked 'Kernel' we know an offline will not be successful
and don't even try.  

-- 
Mike
