Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946235AbWJ0IGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946235AbWJ0IGG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 04:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946238AbWJ0IGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 04:06:06 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:57506 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1946235AbWJ0IGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 04:06:03 -0400
Message-ID: <4541BDE2.6050703@sw.ru>
Date: Fri, 27 Oct 2006 12:05:54 +0400
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Neil Brown <neilb@suse.de>, Jan Blunck <jblunck@suse.de>,
       Olaf Hering <olh@suse.de>, Balbir Singh <balbir@in.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Q] missing unused dentry in prune_dcache()?
References: <45409DD5.7050306@sw.ru>  <453F6D90.4060106@sw.ru> <453F58FB.4050407@sw.ru> <20792.1161784264@redhat.com> <21393.1161786209@redhat.com> <19898.1161869129@redhat.com>
In-Reply-To: <19898.1161869129@redhat.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Vasily Averin <vvs@sw.ru> wrote:
> 
>> Therefore I've removed break of cycle and insert this dentry to head of the
>> list. Theoretically it can lead to the second using of the same dentry,
>> however I do not think that it is a big problem.
> 
> Hmmm...  Or maybe it could be a problem.  If whenever we find the dentry we
> stick it back on the head of the list, this could be a problem as we're
> traversing the list from tail to head.

I still do not think that it could be a problem:
count argument of prune_dcache is 128 if prune_dcache is called from
shrink_dcache_memory() function and even lesser if prune_dcache is called from
shrink_dcache_parent() function. I think usually the size of unused_dentry list
(nr_usnused) is much greater and may be compared with these values only in case
of very hard memory shortage. From my point of view it is very rare situation
and I even not sure that it can really happen at all.

However even if this situation will happen I do not see here any seriously
troubles: Yes, we will try to free the same dentries, much probably without
success again, but why it is bad in case of hard memory shortage?

If my arguments are not convincing, I can protect second use of the same dentry:
we can compare counter of the skipped dentries with nr_unused value.

And what the alternatives we have?
1) We can move this dentry to end of list? But it is bad because it will prevent
shrink_dcache_memory().
2) we can move these dentries into some temporal list, and insert it back to
unused_list later? But it is bad because of we can be rescheduled and drop
dcache_lock and may confuse someone who will assume that these dentries are in
unused_list.

Therefore I believe that my patch is optimal solution.

Thank you,
	Vasily Averin
