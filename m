Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261365AbSKHTM2>; Fri, 8 Nov 2002 14:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261557AbSKHTM2>; Fri, 8 Nov 2002 14:12:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36364 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261365AbSKHTM1>;
	Fri, 8 Nov 2002 14:12:27 -0500
Date: Fri, 8 Nov 2002 19:19:07 +0000
From: Matthew Wilcox <willy@debian.org>
To: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
Cc: "'Matthew Wilcox '" <willy@debian.org>,
       "''Linus Torvalds ' '" <torvalds@transmeta.com>,
       "''Jeremy Fitzhardinge ' '" <jeremy@goop.org>,
       "''William Lee Irwin III ' '" <wli@holomorphy.com>,
       "''linux-ia64@linuxia64.org ' '" <linux-ia64@linuxia64.org>,
       "''Linux Kernel List ' '" <linux-kernel@vger.kernel.org>,
       "''rusty@rustcorp.com.au ' '" <rusty@rustcorp.com.au>,
       "''dhowells@redhat.com ' '" <dhowells@redhat.com>,
       "''mingo@elte.hu ' '" <mingo@elte.hu>
Subject: Re: [Linux-ia64] reader-writer livelock problem
Message-ID: <20021108191907.N12011@parcelfarce.linux.theplanet.co.uk>
References: <3FAD1088D4556046AEC48D80B47B478C0101F4EE@usslc-exch-4.slc.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C0101F4EE@usslc-exch-4.slc.unisys.com>; from kevin.vanmaren@unisys.com on Fri, Nov 08, 2002 at 12:05:30PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 12:05:30PM -0600, Van Maren, Kevin wrote:
> Absolutely you should minimize the locking contention.
> However, that isn't always possible, such as when you
> have 64 processors contending on the same resource.

if you've got 64 processors contending on the same resource, maybe you
need to split that resource up so they can have a copy each.  all that
cacheline bouncing can't do your numa boxes any good.

> With the current kernel, the trivial example with reader/
> writer locks was having them all call gettimeofday().

i hear x86-64 has a lockless gettimeofday.  maybe that's the solution.

> But try having 64 processors fstat() the same file,
> which I have also seen happen (application looping,
> waiting for another process to finish setting up the
> file so they can all mmap it).

umm.. the call trace:

sys_fstat
|-> vfs_fstat
|   |-> fget
|	|-> read_lock(&files->file_lock)
|   |-> vfs_getattr
|	|-> inode->i_op->getattr
|	|-> generic_fillattr
|-> cp_new_stat64
    |-> memset
    |-> copy_to_user

so you're talking about contention on files->file_lock, right?  it's really
not the kernel's fault that your app is badly written.  that lock's private
to process & children, so it's not like another application can hurt you.

> What MCS locks do is they reduce the number of times
> the cacheline has to be flung around the system in
> order to get work done: they "scale" much better with
> the number of processors: O(N) instead of O(N^2).

yes, but how slow are they in the uncontended case?

-- 
Revolutions do not require corporate support.
