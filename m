Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269356AbUINLwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269356AbUINLwl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269341AbUINLtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:49:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51885 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269327AbUINLsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:48:37 -0400
Message-ID: <4146DA84.9040707@redhat.com>
Date: Tue, 14 Sep 2004 07:48:20 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] close race condition in shared memory mapping/unmapping
References: <4146041F.2040106@redhat.com> <20040913140101.S1973@build.pdx.osdl.net>
In-Reply-To: <20040913140101.S1973@build.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Neil Horman (nhorman@redhat.com) wrote:
> 
>>Hey all-
>>	Found this the other day poking through the ipc code.  There appears to 
>>be a race condition in the counter that records how many processes are 
>>accessing a given shared memory segment.  In most places the shm_nattch 
>>variable is protected by the shm_ids.sem semaphore, but there are a few 
>>openings which appear to be able to allow a corruption of this variable 
>>when run on SMP systems.  I've attached a patch to 2.6.9-rc2 for review. 
>>  The locking may be a little over-aggressive (I was following examples 
>>from other points in this file), but I figure better safe than sorry :).
> 
> 
> Are you sure you've got this right?  I thought that the shmid_kernel
> struct protects shm_nattch with a local (per structure) lock which is
> embedded in kern_ipc_perm.  Did you find shm_nattch changes w/out
> shm_lock/shm_unlock around it?  I believe shm_ids.sem is protecting the
> id allocation, not per object data such as shm_nattch.
> 
> thanks,
> -chris
You're right, its not correct.  I'm sorry.  I'm looking into a locking 
bug in 2.4, which does its ipc locking for shared memory very 
differently.  Since the shared memory code looks simmilar in 2.6, I was 
making the assumption that the change applied upstram as well, but I 
don't think thats the case after looking more carefully.  My bad.
Neil

-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
