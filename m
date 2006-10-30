Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWJ3OYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWJ3OYa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 09:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbWJ3OY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 09:24:29 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:47533 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751846AbWJ3OY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 09:24:28 -0500
Message-ID: <45460B16.7050201@sw.ru>
Date: Mon, 30 Oct 2006 17:24:22 +0300
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: David Howells <dhowells@redhat.com>, Neil Brown <neilb@suse.de>,
       Jan Blunck <jblunck@suse.de>, Olaf Hering <olh@suse.de>,
       Balbir Singh <balbir@in.ibm.com>, Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [PATCH 2.6.19-rc3] VFS: per-sb dentry lru list
References: <4541F2A3.8050004@sw.ru>	<4541BDE2.6050703@sw.ru>	<45409DD5.7050306@sw.ru>	<453F6D90.4060106@sw.ru>	<453F58FB.4050407@sw.ru>	<20792.1161784264@redhat.com>	<21393.1161786209@redhat.com>	<19898.1161869129@redhat.com>	<22562.1161945769@redhat.com>	<24249.1161951081@redhat.com>	<4542123E.4030309@sw.ru> <20061027110645.b906839f.akpm@osdl.org>
In-Reply-To: <20061027110645.b906839f.akpm@osdl.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 27 Oct 2006 18:05:50 +0400
> Vasily Averin <vvs@sw.ru> wrote:
> 
>> Virtuozzo/OpenVZ linux kernel team has discovered that umount/remount can last
>> for hours looping in shrink_dcache_sb() without much successes. Since during
>> shrinking s_umount semaphore is taken lots of other unrelated operations like
>> sync can stop working until shrink finished.
> 
> Did you consider altering shrink_dcache_sb() so that it holds onto
> dcache_lock and moves all the to-be-pruned dentries onto a private list in
> a single pass, then prunes them all outside the lock?

At the first glance it is wrong because of 2 reasons:
1) it continues to check the whole global LRU list (we propose to use per-sb
LRU, it will provide very quick search)
2) we have not any guarantee that someone will add new unused dentries to the
list when we prune it outside the lock. And to the contrary, some of unused
dentries can be used again. As far as I understand we should hold dcache_lock
beginning at the removing dentry from unused_list until dentry_iput() call.

David did it inside shrink_dcache_for_umount() just because it have guarantee
that all the filesystem operations are finished and new ones cannot be started.

Thank you,
	Vasily Averin
