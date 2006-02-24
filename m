Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWBXAEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWBXAEP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 19:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWBXAEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 19:04:14 -0500
Received: from smtp-out.google.com ([216.239.45.12]:30809 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932157AbWBXAEM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 19:04:12 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
	b=AQduLHbzAOaRP87pe4cy5+3eegq3zhSjIlcHE4uzioeMg53QYb366FjzWEM9yd8OZ
	IROhiXyrwysAnHr8eKNPA==
Message-ID: <43FE4D62.4050409@google.com>
Date: Thu, 23 Feb 2006 16:03:46 -0800
From: Markus Gutschke <markus@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Debian/1.7.12-0ubuntu05.04
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@g5.osdl.org
Subject: ptrace.c change in 2.6.15 (?) breaks code for listing threads
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was recently informed by a user of google-perftools.sf.net, that 
current Linux kernels no longer allow perftools (and related code, such 
as goog-coredumper.sf.net) to list threads in a running application.

I tracked the problem down to this changelist:

--- 5b8dd98a230e442c1ec46adc968acb60dfdb74ae
+++ b88d4186cd7ac2733c3adf231d5b4daa4e14b0a9
@@ -155,7 +155,7 @@ int ptrace_attach(struct task_struct *ta
  	retval = -EPERM;
  	if (task->pid <= 1)
  		goto bad;
-	if (task == current)
+	if (task->tgid == current->tgid)
  		goto bad;
  	/* the same process cannot be attached many times */
  	if (task->ptrace & PT_PTRACED)

I believe, if I interpret the data on kernel.org correctly, this change 
was made by Linus and shipped with 2.6.15.

Both perftools and coredumper need to locate all threads in the active 
application in order to work. As libpthread has had changing and poorly 
documented APIs to get this information, and as our intent is to support 
all kernel versions and all libc versions, we resorted to ptracing any 
process that is suspected to be one of our threads in order to determine 
if it actually is. This has the added benefit of finding *all* threads 
(including ones not managed by libpthread) and of temporarily suspending 
them, so that we have a stable memory image that we can inspect. Think 
of both tools as something like a lightweight in-process debugger.

Obviously, special care has to be taken to not ptrace our own thread, 
and to avoid any library calls that could deadlock.

Before the patch, attaching ptrace to my own threads was a valid 
operation. With this new patch, I can no longer do that.

I'd be happy to consider alternative approaches (which might be cleaner, 
anyway) to list and suspend all of the threads in my application. But 
before I do that I would like to ask if there is any chance the 
restrictions imposed with this patch could be lifted. It would certainly 
make my life easier if Linux continued to allow processes to ptrace 
themselves -- as far as I have been able to test it, this feature has 
been working ever since Linux first supported threads and only broke 
very recently.


Markus

P.S.: I usually read LKML as archived on the web, so please cc me on any 
responses, if you want me to see your answer quickly. Thanks.

