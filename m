Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266848AbSKHR71>; Fri, 8 Nov 2002 12:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266849AbSKHR71>; Fri, 8 Nov 2002 12:59:27 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:31898 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S266848AbSKHR7Z>; Fri, 8 Nov 2002 12:59:25 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C0101F4EE@usslc-exch-4.slc.unisys.com>
From: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
To: "'Matthew Wilcox '" <willy@debian.org>,
       "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
Cc: "''Linus Torvalds ' '" <torvalds@transmeta.com>,
       "''Jeremy Fitzhardinge ' '" <jeremy@goop.org>,
       "''William Lee Irwin III ' '" <wli@holomorphy.com>,
       "''linux-ia64@linuxia64.org ' '" <linux-ia64@linuxia64.org>,
       "''Linux Kernel List ' '" <linux-kernel@vger.kernel.org>,
       "''rusty@rustcorp.com.au ' '" <rusty@rustcorp.com.au>,
       "''dhowells@redhat.com ' '" <dhowells@redhat.com>,
       "''mingo@elte.hu ' '" <mingo@elte.hu>
Subject: RE: [Linux-ia64] reader-writer livelock problem
Date: Fri, 8 Nov 2002 12:05:30 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Absolutely you should minimize the locking contention.
However, that isn't always possible, such as when you
have 64 processors contending on the same resource.
With the current kernel, the trivial example with reader/
writer locks was having them all call gettimeofday().
But try having 64 processors fstat() the same file,
which I have also seen happen (application looping,
waiting for another process to finish setting up the
file so they can all mmap it).

What MCS locks do is they reduce the number of times
the cacheline has to be flung around the system in
order to get work done: they "scale" much better with
the number of processors: O(N) instead of O(N^2).

Kevin

-----Original Message-----
From: Matthew Wilcox
To: Van Maren, Kevin
Cc: 'Linus Torvalds '; 'Jeremy Fitzhardinge '; 'William Lee Irwin III ';
'linux-ia64@linuxia64.org '; 'Linux Kernel List '; 'rusty@rustcorp.com.au ';
'dhowells@redhat.com '; 'mingo@elte.hu '
Sent: 11/8/02 12:52 PM
Subject: Re: [Linux-ia64] reader-writer livelock problem

On Fri, Nov 08, 2002 at 11:41:57AM -0600, Van Maren, Kevin wrote:
> processor to acquire/release the lock once.  So with 32 processors
> contending for the lock, at 1us per cache-cache transfer (picked

if you have 32 processors contending for the same spinlock, you have
bigger problems.

-- 
Revolutions do not require corporate support.
