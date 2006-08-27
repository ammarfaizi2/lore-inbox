Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWH0Rtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWH0Rtm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 13:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWH0Rtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 13:49:42 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:41388 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932211AbWH0Rtl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 13:49:41 -0400
Date: Sun, 27 Aug 2006 23:19:46 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       ego@in.ibm.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       arjan@intel.linux.com, mingo@elte.hu, vatsa@in.ibm.com,
       ashok.raj@intel.com
Subject: Re: [RFC][PATCH 0/4] Redesign cpu_hotplug locking.
Message-ID: <20060827174946.GB11710@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060824091704.cae2933c.akpm@osdl.org> <20060825095008.GC22293@redhat.com> <Pine.LNX.4.64.0608261404350.11811@g5.osdl.org> <20060826150422.a1d492a7.akpm@osdl.org> <20060827061155.GC22565@in.ibm.com> <20060826234618.b9b2535a.akpm@osdl.org> <20060827071116.GD22565@in.ibm.com> <20060827004213.4479e0df.akpm@osdl.org> <20060827110657.GF22565@in.ibm.com> <20060827102116.f9077bac.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060827102116.f9077bac.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2006 at 10:21:16AM -0700, Andrew Morton wrote:
> On Sun, 27 Aug 2006 16:36:58 +0530
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> 
> > > Did you look?  workqueue_mutex is used to protect per-cpu workqueue
> > > resources.  The lock is taken prior to modification of per-cpu resources
> > > and is released after their modification.  Very very simple.
> > 
> > I did and there is no lock named workqueue_mutex. workqueue_cpu_callback()
> > is farily simple and doesn't have the issues in cpufreq that
> > we are talking about (lock_cpu_hotplug() in cpu callback path).
> 
> http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=9b41ea7289a589993d3daabc61f999b4147872c4

Ah, I didn't realize that it was already in git. It does take
care of create_workqueue callers, however I don't see why this
is needed - 

+ break;
+
+ case CPU_DOWN_PREPARE:
+ 	mutex_lock(&workqueue_mutex);
+ 	break;
+
+ case CPU_DOWN_FAILED:
+ 	mutex_unlock(&workqueue_mutex);
	break;

This seems like some implicit code locking to me. Why is it not
sufficient to hold the lock in the CPU_DEAD code while walking
the workqueues ?

Thanks
Dipankar
