Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277432AbRJJV4y>; Wed, 10 Oct 2001 17:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277435AbRJJV4p>; Wed, 10 Oct 2001 17:56:45 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:31492 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S277432AbRJJV40>;
	Wed, 10 Oct 2001 17:56:26 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Victor Yodaiken <yodaiken@fsmlabs.com>
Cc: Paul Mackerras <paulus@samba.org>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion 
In-Reply-To: Your message of "Wed, 10 Oct 2001 09:54:36 CST."
             <20011010095436.A8784@hq2> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Oct 2001 07:56:43 +1000
Message-ID: <16510.1002751003@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001 09:54:36 -0600, 
Victor Yodaiken <yodaiken@fsmlabs.com> wrote:
>Although I kind of like the idea of
>	normal operation create mess by avoiding synchronization
>	when system seems idle, get BKL, and clean up. 

That does not work.  A process can read an entry from a list then
perform an operation that puts the process to sleep.  When it wakes up
again, how can it tell if the list has been changed?  How can the
cleanup code tell if any process has slept while it was traversing a
list?  An idle system does not prevent processes from sleeping at the
wrong point.

Don't even think of requiring "processes must not sleep while
traversing a lock free list".  Programmers cannot get "processes must
not sleep while holding a lock" correct and that error is much easier
to detect.

The inability for update code to know when a lock free list is being
traversed is the reason that most lock free work requires type stable
storage.  You can mark a list entry as free and put it on a free chain
but you can never unmap the storage nor use the free entry for data of
a different type.  That is the only way to guarantee that a process can
safely determine if the list has changed under it during traversal
while still allowing the process to be interrupted or to sleep.

