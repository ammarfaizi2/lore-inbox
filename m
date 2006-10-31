Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423241AbWJaNYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423241AbWJaNYm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 08:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423239AbWJaNYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 08:24:42 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:51213 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1423242AbWJaNYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 08:24:42 -0500
Message-ID: <45474E94.7030506@sw.ru>
Date: Tue, 31 Oct 2006 16:24:36 +0300
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: devel@openvz.org, David Howells <dhowells@redhat.com>
CC: Neil Brown <neilb@suse.de>, Jan Blunck <jblunck@suse.de>,
       Olaf Hering <olh@suse.de>, Balbir Singh <balbir@in.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [Q] missing ->d_delete() in shrink_dcache_for_umount()?
References: <453F58FB.4050407@sw.ru>
In-Reply-To: <453F58FB.4050407@sw.ru>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

Vasily Averin wrote:
> Hello folks,
> 
> I would like to ask you clarify me one question in the the following patch:
> http://linux.bkbits.net:8080/linux-2.6/gnupatch@449b144ecSF1rYskg3q-SeR2vf88zg
> # ChangeSet
> #   2006/06/22 15:05:57-07:00 neilb@suse.de
> #   [PATCH] Fix dcache race during umount
> 
> #   If prune_dcache finds a dentry that it cannot free, it leaves it where it
> #   is (at the tail of the list) and exits, on the assumption that some other
> #   thread will be removing that dentry soon.

It looks like I've noticed yet one suspicious place in your patch. As far as I
see you have removed dput(root) call in shrink_dcache_for_umount() function.
However I would note that dput contains ->d_delete() call that is missing in
your function:

if (dentry->d_op && dentry->d_op->d_delete) {
	if (dentry->d_op->d_delete(dentry))
		goto unhash_it;

I'm not sure but it seems to me some (probably out-of-tree) filesystems can do
something useful in this place.

Thank you,
	Vasily Averin
