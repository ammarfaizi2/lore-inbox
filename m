Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWHEUCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWHEUCT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 16:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWHEUCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 16:02:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23473 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932269AbWHEUCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 16:02:18 -0400
Date: Sat, 5 Aug 2006 13:02:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: torvalds@osdl.org, michal.k.k.piotrowski@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at
 /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
Message-Id: <20060805130202.f63bcc9a.akpm@osdl.org>
In-Reply-To: <20060805194730.GG13393@redhat.com>
References: <6bffcb0e0608041204u4dad7cd6rab0abc3eca6747c0@mail.gmail.com>
	<Pine.LNX.4.64.0608041222400.5167@g5.osdl.org>
	<20060804222400.GC18792@redhat.com>
	<20060805003142.GH18792@redhat.com>
	<20060805021051.GA13393@redhat.com>
	<20060805022356.GC13393@redhat.com>
	<20060805024947.GE13393@redhat.com>
	<20060805064727.GF13393@redhat.com>
	<20060805004600.2e63fcd9.akpm@osdl.org>
	<20060805194730.GG13393@redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Aug 2006 15:47:30 -0400
Dave Jones <davej@redhat.com> wrote:

> On Sat, Aug 05, 2006 at 12:46:00AM -0700, Andrew Morton wrote:
>  > @@ -320,10 +320,10 @@ void fastcall flush_workqueue(struct wor
>  >  	} else {
>  >  		int cpu;
>  >  
>  > -		lock_cpu_hotplug();
>  > +		mutex_lock(&workqueue_mutex);
>  >  		for_each_online_cpu(cpu)
>  >  			flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, cpu));
>  > -		unlock_cpu_hotplug();
>  > +		mutex_unlock(&workqueue_mutex);
>  >  	}
>  >  }
> 
> Is this enough though? I mean, what stops the hotplug cpu code
> from modifying cpu_online_map underneath us here, making for_each_online_cpu
> do the wrong thing ?
> 

The patch takes that mutex in workqueue_cpu_callback() in such a way as to
prevent that.  What it _effectively_ does is to change cpu_up() thusly:

--- a/kernel/cpu.c~x
+++ a/kernel/cpu.c
@@ -197,6 +197,7 @@ int __devinit cpu_up(unsigned int cpu)
 	}
 
 	ret = blocking_notifier_call_chain(&cpu_chain, CPU_UP_PREPARE, hcpu);
+	mutex_lock(&workqueue_mutex);
 	if (ret == NOTIFY_BAD) {
 		printk("%s: attempt to bring up CPU %u failed\n",
 				__FUNCTION__, cpu);
@@ -213,12 +214,15 @@ int __devinit cpu_up(unsigned int cpu)
 	BUG_ON(!cpu_online(cpu));
 
 	/* Now call notifier in preparation. */
+	mutex_unlock(&workqueue_mutex);
 	blocking_notifier_call_chain(&cpu_chain, CPU_ONLINE, hcpu);
 
 out_notify:
-	if (ret != 0)
+	if (ret != 0) {
 		blocking_notifier_call_chain(&cpu_chain,
 				CPU_UP_CANCELED, hcpu);
+		mutex_unlock(&workqueue_mutex);
+	}
 out:
 	mutex_unlock(&cpu_add_remove_lock);
 	return ret;
_


and similarly in cpu_down().

So the workqueue code itself is protecting its per-cpu data from the hot
plug/unplug code across its critical regions.

