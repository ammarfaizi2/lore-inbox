Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271278AbUJVMgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271278AbUJVMgL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 08:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269105AbUJVMff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 08:35:35 -0400
Received: from [213.85.13.118] ([213.85.13.118]:17025 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S271282AbUJVM2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 08:28:05 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16760.64712.751231.4772@gargle.gargle.HOWL>
Date: Fri, 22 Oct 2004 16:27:52 +0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Gunther Persoons <gunther_persoons@spymac.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
In-Reply-To: <20041022115734.GA1790@elte.hu>
References: <20041018145008.GA25707@elte.hu>
	<20041019124605.GA28896@elte.hu>
	<20041019180059.GA23113@elte.hu>
	<20041020094508.GA29080@elte.hu>
	<20041021132717.GA29153@elte.hu>
	<4177FAB0.6090406@spymac.com>
	<20041021164018.GA11560@elte.hu>
	<16759.63466.507400.649099@thebsh.namesys.com>
	<20041022102210.GA21734@elte.hu>
	<16760.62448.307737.588876@gargle.gargle.HOWL>
	<20041022115734.GA1790@elte.hu>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
 > 
 > * Nikita Danilov <nikita@clusterfs.com> wrote:
 > 
 > >  > condition variables are fine if you 1) already know them from userspace
 > >  > and 2) want to use a single locking abstraction for everything. It is
 > >  > thus also a kitchen-sink primitive that is inevitably slow and complex.
 > >  > I still have to see a locking problem where condvars are the
 > >  > cleanest/simplest answer, and i've yet to see a locking problem where
 > >  > condvars are not the slowest answer ;)
 > > 
 > > A kernel daemon that waits for some work to do is an example.
 > 
 > what type of work - could you be a bit more specific?

Take a loop in fs/cifs/cifsfs.c:cifs_oplock_thread() (I won't copy it
here to avoid you all going blind). It can be recoded as

    while(1) {
        spin_lock(&GlobalMid_Lock);
        while (list_empty(&GlobalOplock_Q)) {
             if (kcond_timedwait(&SomeCIFSCVAR, &GlobalMid_Lock, HZ) == -EINTR) {
                     spin_unlock(&GlobalMid_Lock);
                     complete_and_exit(&cifs_oplock_exited, 0);
             }
        }
        oplock_item = list_entry(GlobalOplock_Q.next, struct oplock_q_entry, qhead);
        /* do stuff with oplock_item ... */
        spin_unlock(&GlobalMid_Lock);
        ....
    }

Point is that this is very stylistic usage---easily recognizable.

 > 
 > 	Ingo

Nikita.
