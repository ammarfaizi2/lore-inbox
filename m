Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbULHWVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbULHWVN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 17:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbULHWVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 17:21:12 -0500
Received: from [63.81.117.10] ([63.81.117.10]:36984 "EHLO mail00hq.adic.com")
	by vger.kernel.org with ESMTP id S261377AbULHWU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 17:20:57 -0500
Message-ID: <41B77D54.4080909@xfs.org>
Date: Wed, 08 Dec 2004 16:16:52 -0600
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: negative dentry_stat.nr_unused causes aggressive dcache pruning
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Dec 2004 22:20:55.0094 (UTC) FILETIME=[2F319560:01C4DD74]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have seen this stat go negative (just from booting up a multi cpu box),
and looking at the code, it is manipulated without locking in a number
of places. I have only seen this in real life on a 2.4 kernel, but 2.6
also looks vulnerable.

In 2.4 this can cause shrink_dcache_memory to attempt to push the whole
dcache out by calling prune_dcache with a negative parameter, prune_dcache
just keeps going until count hits zero or the dentry_unused list
empties.

In 2.6 kernels I do not see a real use of the variable which would cause harm,
although is someone was to start relying on more than -1 coming back from
shrink_dcache_memory there might be problems.

The problem code is dput which is the only place it is manipulated
without the dcache lock.

nr_dentry is not mp safe either, but no one depends on that.

Steve


