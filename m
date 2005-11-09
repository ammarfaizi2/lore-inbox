Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbVKIRy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbVKIRy2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 12:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbVKIRy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 12:54:28 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:59596 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932526AbVKIRy1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 12:54:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rHLMjRjvgLNkO76SbrRK9q+HwJZlaVQcZ7t41IJBODvPTHlFaUaHZHTetNQeZlNmWvZ45kdHe04DCW+IcLt5qakbxtzCnvG3HUSIQU9ZOlAkBhbHcGjOrO4b1srO8cgyJzziHmaXEovznsHualzbeoyY3XKC6OZQDV4FF3fpGXc=
Message-ID: <7d40d7190511090954u16ba0d65s@mail.gmail.com>
Date: Wed, 9 Nov 2005 18:54:26 +0100
From: Aritz Bastida <aritzbastida@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Stopping Kernel Threads at module unload time
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7d40d7190511090949xc550b68k@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7d40d7190511090749j3de0e473x@mail.gmail.com>
	 <Pine.LNX.4.61.0511091110190.10303@chaos.analogic.com>
	 <7d40d7190511090856x24fd68f5g@mail.gmail.com>
	 <200511091827.49144.arnd@arndb.de>
	 <7d40d7190511090949xc550b68k@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much Arnd!
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

PS:  Sorry Arnd, I forgot adding the linux-kernel address to the message
