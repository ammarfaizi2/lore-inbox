Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbWAXRRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbWAXRRF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 12:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWAXRRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 12:17:05 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:11794 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030382AbWAXRRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 12:17:04 -0500
Message-ID: <43D6615D.2090101@sw.ru>
Date: Tue, 24 Jan 2006 20:18:21 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Jan Blunck <jblunck@suse.de>, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       olh@suse.de
Subject: Re: [PATCH] shrink_dcache_parent() races against shrink_dcache_memory()
References: <20060120203645.GF24401@hasse.suse.de> <43D48ED4.3010306@sw.ru> <20060123155728.GC26653@hasse.suse.de> <20060124055425.GA30609@in.ibm.com> <43D5F7DD.7010507@sw.ru> <20060124111019.GA9375@in.ibm.com>
In-Reply-To: <20060124111019.GA9375@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>><<<< and here, when you drop sb_lock, and dentry->d_lock/dcache_lock in 
>>prune_dentry() it looks to me that we have exactly the same situation as 
>>it was without your patch:
>><<<< another CPU can start umount in parallel.
>><<<< maybe sb_lock barrier helps this somehow, but I can't see how yet...
> 
>>From the unmount path, __mntput() is called. It sets s_active to 0 in
> deactivate_super(), hence our check would prevent us from pruning a dentry
> that is a part of a super block that is going to go away soon. The idea
> is to let the unmount do all the work here, the allocator can concentrate
> on other dentries.
you check can happen 1 nanosecond before it sets s_active, after that 
the code goes into prune_dentry(), while deactivate_super() successfully 
sets s_active and starts umount main job. Nothing prevents the race... :(

Kirill

