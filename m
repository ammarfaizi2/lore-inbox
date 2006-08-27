Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWH0ImM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWH0ImM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 04:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWH0ImM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 04:42:12 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:8744 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750829AbWH0ImJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 04:42:09 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: ego@in.ibm.com, mingo@elte.hu, nickpiggin@yahoo.com.au,
       arjan@infradead.org, rusty@rustcorp.com.au, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@intel.linux.com,
       davej@redhat.com, dipankar@in.ibm.com, vatsa@in.ibm.com,
       ashok.raj@intel.com
Subject: Re: [RFC][PATCH 4/4] Rename lock_cpu_hotplug/unlock_cpu_hotplug 
In-reply-to: Your message of "Sun, 27 Aug 2006 00:59:44 MST."
             <20060827005944.67f51e92.pj@sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 27 Aug 2006 18:42:09 +1000
Message-ID: <9747.1156668129@ocs10w.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson (on Sun, 27 Aug 2006 00:59:44 -0700) wrote:
>The change agents (such as a system admin changing something in
>the /dev/cpuset hierarchy) are big slow mammoths that appear rarely,
>and need to single thread their entire operation, preventing anyone
>else from changing the cpuset hierarchy for an extended period of time,
>while they validate the request and setup to make the requested change
>or changes.
>
>The inhibitors are a swarm of locusts, that change nothing, and need
>quick, safe access, free of change during a brief critical section.
>
>Finally the mammoths must not trample the locusts (change what the
>locusts see during their critical sections.)

This requirement, and the similar requirement that cpu_online_mask
cannot change while anybody is reading it, both appear to cry out for
stop_machine().  Readers must be able to access the cpu related
structures at all time, without any extra locking.  Updaters (which by
definition are extremely rare) stop all other cpus, do their work then
restart_machine().  That way only kernel/stop_machine.c has to care
that the cpu masks might change underneath it, the rest of the kernel
is protected with zero overhead.

