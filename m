Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268031AbTBMNI3>; Thu, 13 Feb 2003 08:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268033AbTBMNI3>; Thu, 13 Feb 2003 08:08:29 -0500
Received: from services.cam.org ([198.73.180.252]:42487 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S268031AbTBMNI2>;
	Thu, 13 Feb 2003 08:08:28 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [PATCH] (0-2) governors for 60-bk
Date: Thu, 13 Feb 2003 08:18:18 -0500
User-Agent: KMail/1.5.9
References: <3DF453C8.18B24E66@digeo.com> <200212092059.06287.tomlins@cam.org> <3DF54BD7.726993D@digeo.com>
In-Reply-To: <3DF54BD7.726993D@digeo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302130818.19387.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is an update of my thread group and user governor patch.  This
patch reduces timeslices of process belonging to groups with too many
active processes.  This, in effect, lowers their priority and makes
it more likely that other tasks can run preventing tasks in a governed 
group from using too large a share of the the cpu.

There is a governor for thread groups, which are defined as processes
sharing both mm and files or processes with CLONE_THREAD set.  The 
default governor is set to 1.5 threads (15).  This means that when
there are 2 or more threads active the timeslices will be reduced
as follows:

slice = (slice * 1.5) / 2

A second governor is defined for user processes.  This one defaults 
to 30 active task (300).  A process has only one governor.  If its
a member of a thread group that governor applies and it is ignored
by the user governor process.

A couple of notes about the patch.  There is debug code in 
sched.c that can be enabled if you want to see what is happening.
I would not recommend this code be used on NUMA systems.  I am
looking into a version of the patch that would impose the governors
on a per node basis.  Earlier versions of this patch counted user
processes incorrectly which caused the user governor to trigger 
limiting users when it should not have.  This is now fixed.  

As it stands now a modified schedule-tunables patch based off the one
found in the mm kernels can optionally be applied.  I think that using
the rlimit infrastructure probably makes more sense - comments?

The patches should apply to 60-mk and probably to -mm1 after reversing
the schedule-tunables included in it.

The patch as been tested on UP.

As always comments/suggestion appriecated

Ed Tomlinson


