Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271306AbUJVMxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271306AbUJVMxb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 08:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271299AbUJVMut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 08:50:49 -0400
Received: from mx2.elte.hu ([157.181.151.9]:30882 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S271307AbUJVMpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 08:45:50 -0400
Date: Fri, 22 Oct 2004 14:42:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Gunther Persoons <gunther_persoons@spymac.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
Message-ID: <20041022124208.GA4489@elte.hu>
References: <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <4177FAB0.6090406@spymac.com> <20041021164018.GA11560@elte.hu> <16759.63466.507400.649099@thebsh.namesys.com> <20041022102210.GA21734@elte.hu> <16760.62448.307737.588876@gargle.gargle.HOWL> <20041022115734.GA1790@elte.hu> <16760.64712.751231.4772@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16760.64712.751231.4772@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nikita Danilov <nikita@clusterfs.com> wrote:

>  > > A kernel daemon that waits for some work to do is an example.
>  > 
>  > what type of work - could you be a bit more specific?
> 
> Take a loop in fs/cifs/cifsfs.c:cifs_oplock_thread() (I won't copy it
> here to avoid you all going blind). It can be recoded as
> 
>     while(1) {
>         spin_lock(&GlobalMid_Lock);
>         while (list_empty(&GlobalOplock_Q)) {
>              if (kcond_timedwait(&SomeCIFSCVAR, &GlobalMid_Lock, HZ) == -EINTR) {
>                      spin_unlock(&GlobalMid_Lock);
>                      complete_and_exit(&cifs_oplock_exited, 0);
>              }
>         }
>         oplock_item = list_entry(GlobalOplock_Q.next, struct oplock_q_entry, qhead);
>         /* do stuff with oplock_item ... */
>         spin_unlock(&GlobalMid_Lock);
>         ....
>     }

in this particular case i'd use a workqueue, which would simplify this
down to something like:

	workqueue_handler()
	{	
		spin_lock(&GlobalMid_Lock);
		oplock_item = list_entry(GlobalOplock_Q.next, ...);
		/* do stuff with oplock_item */
		spin_unlock(&GlobalMid_Lock);
	}

and instead of playing games with signals to exit the worker thread, i'd
use destroy_workqueue().

	Ingo
