Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292408AbSB0PYT>; Wed, 27 Feb 2002 10:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292576AbSB0PYK>; Wed, 27 Feb 2002 10:24:10 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:12799 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292571AbSB0PX5>;
	Wed, 27 Feb 2002 10:23:57 -0500
Date: Wed, 27 Feb 2002 10:24:46 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Martin Wirth <Martin.Wirth@dlr.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Lightweight userspace semphores
Message-ID: <20020227102446.A838@elinux01.watson.ibm.com>
In-Reply-To: <3C7C9C41.5080400@dlr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7C9C41.5080400@dlr.de>; from Martin.Wirth@dlr.de on Wed, Feb 27, 2002 at 09:43:45AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 09:43:45AM +0100, Martin Wirth wrote:
> Hi Hubertus,
> 
> I just had a quick look on your semaphore code. As far as I can see you 
> do no re-check of the userspace semaphore counter while going to sleep 
> on your kernel semaphore. But this way you may loose synchronization 
> between the kernel semaphore and the user-space semaphore counter if 
> more than two processes are involved. Or did I miss some tricky form
> of how you avoided this problem?
> 
> Martin Wirth

Yes, you are missing something.
I assume you are looking at the usema (non spinning version).
The trick is that the kernel semaphore stores a token in case a race
condition occurs and it will resolve it that way.
I rely on the fact that the kernel only provides a wait queue nothing
else, the entire state on how many are waiting are stored in user space.

Effectively you have a P operation in user space followed by a P operation
in kernel space. Same for V operation.

Assuming you have two or more processes 0,1,2 ... you can show
that race conditions are properly resolved. Again, the trick is to not
sync the state of the kernel and the user level. It comes naturally 
if you properly separate the duties.

The spinning versions were much more interesting, you can really have 
some tricky situations for 3 or more processes. The ulockflex program
really helped to identify problems.

In future messages please point out which of the user locks are in question.
Remember I provide several:
	(1) semaphores
	(2) semaphores with timed spinning
	(3) convoy avoidance locks
	(4) convoy avoidance locks with spinning
	(5) shared locks == multiple reader/single writer locks
	This list is growing as we speak.

I also modified the code (I will post the update at the lse site).
This also fixes a small bug in the ulockflex program, that I introduced
in the last posting at lse.
I took Ben LaHaises suggestions and provide multiple runqueues
up to a limit, rather then explicitely coding exclusive/shared version.


