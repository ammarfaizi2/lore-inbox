Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755392AbWKNEv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755392AbWKNEv2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 23:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755399AbWKNEv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 23:51:28 -0500
Received: from cantor.suse.de ([195.135.220.2]:51914 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1755392AbWKNEv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 23:51:27 -0500
From: Neil Brown <neilb@suse.de>
To: Kirill Korotaev <dev@sw.ru>
Date: Tue, 14 Nov 2006 15:51:08 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17753.19260.9836.716649@cse.unsw.edu.au>
Cc: devel@openvz.org, Vasily Averin <vvs@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Balbir Singh <balbir@in.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>, Olaf Hering <olh@suse.de>,
       Jan Blunck <jblunck@suse.de>
Subject: Re: [Devel] Re: [PATCH 2.6.19-rc3] VFS: per-sb dentry lru list
In-Reply-To: message from Kirill Korotaev on Wednesday November 1
References: <4541BDE2.6050703@sw.ru>
	<45409DD5.7050306@sw.ru>
	<453F6D90.4060106@sw.ru>
	<453F58FB.4050407@sw.ru>
	<20792.1161784264@redhat.com>
	<21393.1161786209@redhat.com>
	<19898.1161869129@redhat.com>
	<22562.1161945769@redhat.com>
	<24249.1161951081@redhat.com>
	<4542123E.4030309@sw.ru>
	<20061030042419.GW8394166@melbourne.sgi.com>
	<45459B92.400@sw.ru>
	<17734.54114.192151.271984@cse.unsw.edu.au>
	<45487D2C.4000205@sw.ru>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday November 1, dev@sw.ru wrote:
> <<<< AFAICS, doing so you introduced a leak of anonymous dentries.
> 
> d_alloc_anon() calls d_alloc() with parent == NULL, i.e. dentries have no parent
> and are not linked to the sb->s_root...

Yep, thanks.

> BTW, looking at it, I found that s_anon field on super block is not
> used any more. 

I don't know what you mean by that.  It is still used...

> we can add BUG_ON(!hlist_empty(&sb->s_anon)) in generic_shutdown_super to avoid such issues like this.
> 
> maybe we can fix it adding something like:
> while (!list_empty(&sb->s_anon)))
>     prune_dcache(MAX_INT, &sb->s_anon);

It seems that anon dentries can now have children (I think someone
explained that too me - shrink_dcache_for_umount certainly suggests
it).
Also, in this context we cannot be sure that all dentries can be
freed.  This is being called a remount time remember, and some stuff
might still be in use.

We probably need to move the s_anon list to a temporary list and
repeatedly:
  move the top entry back to s_anon and call shrink_dcache_parent
 on it.

Needs more thought.
	
NeilBrown
