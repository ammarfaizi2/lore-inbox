Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbVAKPfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbVAKPfO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 10:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbVAKPfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 10:35:14 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:49559 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262802AbVAKPex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 10:34:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=go8Wc2GBYnche0RsE2JntLvEmKpSlvvnlB1LbKZtvOxS2EYsrAOEQ1p+vtp0KW+ZdvOAuFQe4gh72m1vNP5uTJef+9eOaOKB5Hmv+PDvdb1iy5A7gbUgT2UdbuXEdfnebSP7veZ75QCMHCyVn1o+bsLkxEZGhXjt2nXeJIihhRE=
Message-ID: <aa667b8b0501110734266a44ab@mail.gmail.com>
Date: Tue, 11 Jan 2005 16:34:49 +0100
From: Kevin Hilman <khilman@gmail.com>
Reply-To: Kevin Hilman <khilman@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.34-01
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using V0.7.34-01, I'm seeing the 'lock held at task exit time' bug. 
It's coming from a kernel module which in its init function creates a
thread.  The thread does a daemonize() and then goes to sleep waiting
on a semaphore which will be up'ed elsewhere.  In other words:

init_module()
 - sema_init(&sem, 0)
 - kernel_thread(thread_func, 0, 0);

thread_func()
 - daemonize()
 - down(&sem)

The BUG() (see below for log) seems to be triggered when insmod exits.  

BUG: insmod/2115, lock held at task exit time!
 [c883225c] {&tinfo[i].sem}
.. held by:            insmod: 2115 [c7b6f340,   0]
... acquired at:  threads_init+0x8e/0x170 [rt_kthreads]
hm, PI interest held at exit time? Task:
          insmod: 2115 [c7b6f340,   0]-------------------------
| waiter struct c4c1bf74:
| w->task:
          insmod: 2123 [c7e68680,   0]
| lock:
 [c883225c] {&tinfo[i].sem}
.. held by:            insmod: 2115 [c7b6f340,   0]
... acquired at:  threads_init+0x8e/0x170 [rt_kthreads]
| blocked at:  thread_func+0x3d/0xb0 [rt_kthreads]
-------------------------


--
Kevin Hilman
http://hilman.org/kevin/
