Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264670AbTE1K4m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 06:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264671AbTE1K4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 06:56:41 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:56460 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S264670AbTE1K4k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 06:56:40 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Disabling Symbolic Link Content Caching in NFS Client
Date: Wed, 28 May 2003 16:39:36 +0530
Message-ID: <2BB7146B38D9CA40B215AB3DAAE24C080BA4F3@blr-m2-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Disabling Symbolic Link Content Caching in NFS Client
Thread-Index: AcMlCZ9/4EkM/w+tRUexncMReMSQfQ==
From: "Vivek Goyal" <vivek.goyal@wipro.com>
To: <linux-kernel@vger.kernel.org>, <nfs@lists.sourceforge.net>
Cc: <trond.myklebust@fys.uio.no>, <indou.takao@jp.fujitsu.com>,
       "Vivek Goyal" <vivek.goyal@wipro.com>, <ionut@cs.columbia.edu>,
       <ezk@cs.sunysb.edu>, <viro@math.psu.edu>, <davem@redhat.com>
X-OriginalArrivalTime: 28 May 2003 11:09:36.0523 (UTC) FILETIME=[9FF765B0:01C32509]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are planning to implement a set of Kernel Tunable Parameters and one
of these parameters is nfs_symlink_caching for disabling/enabling
symbolic link content caching in NFS client. Unices like Solaris have
this feature implemented.

Existing NFS client implementation in Linux performs symbolic link
content caching by default. There is no provision for disabling this
caching either at mount time or through kernel tuning mechanism.

This caching mechanism leads to problems in following two conditions.

a. File is modified in server without updating the modification
time-stamp.
b. Granularity of the time-stamp is too large.

I was following previous discussions in the mailing list and found that
caching mechanism affected hlfsd behavior. It looks like the problem was
resolved by updating mtime on every access. But still caching will lead
to a problem if two accesses are taking place in same jiffy.

We are considering following design strategy to implement the parameter.

1. Make nfs_symlink_caching dynamically tunable using /proc and sysctl
interface.

2. Change NFS client code as follows.

A. If caching is enabled.
There are no changes. Existing caching mechanism remains intact.

B. If caching is disabled.

	i. While serving a symlink read request (nfs_getlink ()) don't
look for the requested page in page cache (read_cache_page()). Instead
always allocate a page frame (page_cache_alloc_cold()) and send a
READLINK request to the server. This allocated page frame is not added
to the cache and hence remains local to the thread of execution and is
not visible to other execution threads.

	ii. Upon receiving the response from the server, pass the data
to the user space and free the page frame. 

Please let us know your comments/opinion on this design.

Thanks and Regards
Vivek

