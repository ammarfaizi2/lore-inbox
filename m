Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131236AbRCGXb7>; Wed, 7 Mar 2001 18:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131237AbRCGXbk>; Wed, 7 Mar 2001 18:31:40 -0500
Received: from mizar.cs.uml.edu ([129.63.32.36]:3844 "EHLO mizar.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S131236AbRCGXb2>;
	Wed, 7 Mar 2001 18:31:28 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200103072330.f27NU6w01196@mizar.cs.uml.edu>
Subject: Re: Process vs. Threads
To: helgehaf@idb.hist.no (Helge Hafting)
Date: Wed, 7 Mar 2001 18:30:06 -0500 (EST)
Cc: greg@linuxpower.cx (Gregory Maxwell), linux-kernel@vger.kernel.org
In-Reply-To: <3AA5F8E1.AC570516@idb.hist.no> from "Helge Hafting" at Mar 07, 2001 10:01:21 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting writes:
> Gregory Maxwell wrote:

>> There are no threads in Linux.
>> All tasks are processes.
>> Processes can share any or none of a vast set of resources.
>
> Is there a way a user program can find out what resources 
> are shared among which processes? 
>
> That would allow enhancing ps, top, etc to
> report memory usage correctly.

I already looked into this. Sorry, it can not be done.

Linux briefly had the code needed to support threads properly.
Linus added it with the warning that it would be removed if he
didn't get enough feedback. Well I have a real job, and the code
was gone before the weekend! Look around near 2.4.0-test8 maybe.

For proper thread support:

First you need the concept of a thread group. This groups tasks
together similar to the way they form process groups and sessions.

Then for proper POSIX thread support, you need a flag to indicate
some awkward POSIX-mandated signal behavior within a thread group.

Then for proper ps and top output, you need a reasonably efficient
way to grab all threads as a group. This could be as simple as
ensuring that /proc directory reads return related tasks together.
This works too:   /proc/42/threads/98 -> ../../98

Severely non-POSIX threads are just not going to do anything sane,
unless thread groups get automatically wrapped around any threads
that share resources. So if 50 shares memory with 67, and 50 shares
the filesystem with 82, then 67 and 82 are non-POSIX threads of the
same non-POSIX process even if they share nothing with each other.

Automatic wrapping works much better, assuming it doesn't also cause
the awkward POSIX signal behavior by default. Tasks should need to
explicitly request the extra suffering.
