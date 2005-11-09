Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932645AbVKIRtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbVKIRtF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 12:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbVKIRtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 12:49:05 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:38727 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932526AbVKIRtC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 12:49:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sGbIdZlqk4SUXKwCmQFjnzV3Fi2gd43T7SIJH2qSnaxgkrJpNbM/IoUu/vOBEK1AmDSFBIw/8rjmH2Dl04DzCOBDkiIsF+8s1JCinzN3T2JLtMtsTxTvp673ZmRDjZ+Gu4rQixK/hCN/imJXZwgr8AVgSsPmevTDo9w1X9POuKE=
Message-ID: <7d40d7190511090949xc550b68k@mail.gmail.com>
Date: Wed, 9 Nov 2005 18:49:01 +0100
From: Aritz Bastida <aritzbastida@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Stopping Kernel Threads at module unload time
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200511091827.49144.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7d40d7190511090749j3de0e473x@mail.gmail.com>
	 <Pine.LNX.4.61.0511091110190.10303@chaos.analogic.com>
	 <7d40d7190511090856x24fd68f5g@mail.gmail.com>
	 <200511091827.49144.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/9, Arnd Bergmann <arnd@arndb.de>:
> On Middeweken 09 November 2005 17:56, Aritz Bastida wrote:
> > Now, if I call kthread_stop() in module unload time, does that code
> > run in user process context just like system calls do? That is
> > important, because if it cannot sleep, it would deadlock.
>
> Yes, it runs in the context of the delete_module system call.
> I think it's more likely that you're not returning from your
> thread loop.
>
> Please post a URL for your module source code so we can see
> what goes wrong there.
>
>         Arnd <><

Than you very much Arnd!
You solved my problem. hehe

I began to write a test module for showing you this and have just
realized about the problem. As I create as many threads as CPUs, I
have to delete them all when finishing.

I killed them like this:

        /* We don't need the distraction of CPUs appearing and vanishing. */
        lock_cpu_hotplug();
        for_each_online_cpu(cpu) {
                p = per_cpu(ksensord_info, cpu);
                kthread_stop(p);
        }
        unlock_cpu_hotplug();

I locked the cpu hotplug lock to protect the for_each_online_cpu()
code in case a cpu appears/vanishes, so I am actually calling
kthread_stop() in an atomic context, so it wakes up the process, but
dont let it run!

This is quite a subtle error, but of course it's my complete fault :P
May be a BUG_ON(in_atomic()) within kthread_stop() would let this kind of
errors be acknowledged more easily.

Thank you for your help
Regards

Aritz Bastida
