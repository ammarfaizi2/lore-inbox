Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288102AbSACBYY>; Wed, 2 Jan 2002 20:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288103AbSACBYO>; Wed, 2 Jan 2002 20:24:14 -0500
Received: from jalon.able.es ([212.97.163.2]:50100 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S288102AbSACBYJ>;
	Wed, 2 Jan 2002 20:24:09 -0500
Date: Thu, 3 Jan 2002 02:27:05 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Steinar Hauan <hauan@cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: smp cputime issues (patch request ?)
Message-ID: <20020103022705.A3163@werewolf.able.es>
In-Reply-To: <Pine.GSO.4.33L-022.0201011959360.7513-300000@unix13.andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.GSO.4.33L-022.0201011959360.7513-300000@unix13.andrew.cmu.edu>; from hauan@cmu.edu on Wed, Jan 02, 2002 at 02:00:43 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020102 Steinar Hauan wrote:
>hello,
>
>  we are encountering some weird timing behaviour on our linux cluster.
>
>  specifically: when running 2 copies of selected programs on a
>  dual-cpu system, the cputime reported for each process is up to 25%
>  higher than when the processes are run on their own. however, if running
>  two different jobs on the same machine, both complete with a cputime
>  equal to when run individually. sample timing output attached.
>

Cache pollution problems ? 

As I understand, your job does not use too much memory, does no IO,
just linear algebra (ie, matrix-times-vector or vector-plus-vector
operations). That implies sequential access to matrix rows and vectors.

I will try to guess...

Problem with linux scheduler is that processes are bounced from one CPU
to the other, they are not tied to one, nor try to stay in the one they
start, even if there is no need for the cpu to do any other job.
On an UP box, the cache is useful to speed up your matrix-vector ops.
One process on a 2-way box, just bounces from one cpu to the other,
and both caches are filled with the same data. Two processes on two
cpus, and everytime they 'swap' between cpus they trash the previous
cache for the other job, so when it returs it has no data cached.

Solutions:
- cpu affinity patch: manually tie processes to cpus
- new scheduler: a patch for the scheduler that tries to
  keep processes on the cpu they start was talked about on the list.

I would prefer the second option. I think it is named something like
'multiqueue scheduler', and its 'father' could be (AFAIR) Davide Libezni.
Look for that on the list archives. Problem: I think the patch only
exists for 2.5.

Request: a version for 2.4.17+ ?? (plz)

Disclaimer: of course, all the previous discussion can be crap.

Good luck. I am also interested in this problem.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-pre1-beo #3 SMP Thu Dec 27 10:15:27 CET 2001 i686
