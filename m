Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030470AbWJYS7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbWJYS7K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 14:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030477AbWJYS7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 14:59:10 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:49838 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030470AbWJYS7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 14:59:07 -0400
Message-ID: <453FB3F9.9080704@in.ibm.com>
Date: Wed, 25 Oct 2006 11:59:05 -0700
From: Suzuki K P <suzuki@in.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060413 Red Hat/1.7.13-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Behaviour of compat_msgsnd/compat_msgrcv calls
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question regarding the behaviour of the comapt_msgsnd/ 
compat_msgrcv ()s. Don't know if this has been discussed already or if 
as I could not find any threads in the archives. Please bear with me if 
this is really a stupid question.

  The maximum length of the message that can be sent or received in any 
of those functions above is MAXBUF-(sizeof (struct msgbuf)), where 
MAXBUF is 64k.

ipc/compat.c : compat_msgrcv()
         if (second < 0 || (second >= MAXBUF - sizeof(struct msgbuf)))
                           ^^^^^^
                 return -EINVAL;

Is this limit due to the buffer allocation in user space as below ?

  And the way we are doing this is by allocating a buffer of msgsize on 
the userspace stack using compat_alloc_user_space() instead of using the 
buffer provided by the user and later copying the result back to the 
user buffer.

         if (!version) {
            [...]
                 if (copy_from_user (&ipck, uptr, sizeof(ipck)))
                         goto out;
                 uptr = compat_ptr(ipck.msgp);
                 msgtyp = ipck.msgtyp;

         }

         p = compat_alloc_user_space(second + sizeof(struct msgbuf));

Do we really need this allocation ?

         err = sys_msgrcv(first, p, second, msgtyp, third);

Is there any specific reason behind this ? Can't we just use the user 
buffer directly instead of doing an additional copy_in_user ?
ie,
	err = sys_msgrcv(first, uptr, second, msgtyp, third);

Thanks,

-Suzuki
