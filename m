Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWDRI17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWDRI17 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 04:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWDRI16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 04:27:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60365 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750706AbWDRI16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 04:27:58 -0400
Date: Tue, 18 Apr 2006 01:27:40 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: akpm@osdl.org, hugh@veritas.com, linux-kernel@vger.kernel.org,
       lee.schermerhorn@hp.com, linux-mm@kvack.org, taka@valinux.co.jp,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 5/5] Swapless V2: Revise main migration logic
In-Reply-To: <20060418170517.b46736d8.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0604180126221.4627@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
 <20060414113455.15fd5162.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604140945320.18453@schroedinger.engr.sgi.com>
 <20060415090639.dde469e8.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604151040450.25886@schroedinger.engr.sgi.com>
 <20060417091830.bca60006.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604170958100.29732@schroedinger.engr.sgi.com>
 <20060418090439.3e2f0df4.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604171724070.2752@schroedinger.engr.sgi.com>
 <20060418094212.3ece222f.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604171856290.2986@schroedinger.engr.sgi.com>
 <20060418120016.14419e02.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604172011490.3624@schroedinger.engr.sgi.com>
 <20060418123256.41eb56af.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604172353570.4352@schroedinger.engr.sgi.com>
 <20060418170517.b46736d8.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2006, KAMEZAWA Hiroyuki wrote:

> On Mon, 17 Apr 2006 23:58:41 -0700 (PDT)
> Christoph Lameter <clameter@sgi.com> wrote:
> 
> > Hmmm... Good ideas. I think it could be much simpler like the following 
> > patch.
> > 
> > However, the problem here is how to know that we really took the anon_vma 
> > lock and what to do about a page being unmmapped while migrating. This 
> > could cause the anon_vma not to be unlocked.
> > 
> lock dependency here is page_lock(page) -> page's anon_vma->lock.
> So, I guess  anon_vma->lock cannot be unlocked by other threads 
> if we have page_lock(page).

No the problem is to know if the lock was really taken. SWAP_AGAIN could 
mean that page_lock_anon_vma failed.

Also the page may be freed while it is being processes. In that case 
remove_migration_ptes may not find the mapping and may not unlock the 
anon_vma.

> > I guess we would need to have try_to_unmap return some state information.
> What kind of information ?

Information that indicates that the anon_vma lock was taken.

