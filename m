Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWDVAkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWDVAkk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 20:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWDVAkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 20:40:40 -0400
Received: from fmr17.intel.com ([134.134.136.16]:49792 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750796AbWDVAkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 20:40:39 -0400
Date: Fri, 21 Apr 2006 17:40:02 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@linux.intel.com>
Subject: [ANNOUNCE] ebizzy 0.1: Search application simulator
Message-ID: <20060422004001.GB32385@goober>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

While investigating performance problems at a Large Web Company You
Have Heard Of, I found Linux isn't super great for an application with
the following characteristics:

* Many threads in one process, doing the following:
  * alloc/write/free of large (> 128K) chunks of memory
  * large (> 16GB) in-memory working set with low locality
  * unpredictable memory access patterns

As the original app is closed source, I wrote an app with similar
characteristics, called ebizzy.  It allocates a lot of memory and
kicks off a bunch of threads to copy large chunks of memory, do a
binary search for a random key, and free it again.  It's available
now, under the GPL:

http://infohost.nmt.edu/~val/patches/ebizzy.tar.gz

You may recall that Arjan van de Ven posted some kernel patches
related to this a couple of months ago and several people asked for
our test program, but at the time I couldn't release it.

Arjan and I wrote a patch to libc that fixes the most obvious
performance problem (mmap/clear page/unmap cycle due to static
malloc() mmap threshold of 128KB); the rest is up for grabs.  Hint:
making it use large pages _without_ rewriting it would be a big win.

The README is below; download the tar.gz for actual code.

-VAL

ebizzy
------

ebizzy is designed to generate a workload resembling common web
application server workloads.  It is highly threaded, has a large
in-memory working set, and allocates and deallocates memory
frequently.  When running most efficiently, it will max out the CPU.

Compiling
---------

To compile ebizzy, simply type "make".  The resulting binary will
be named "ebizzy".

Running
-------

ebizzy does not require any command line arguments.  To get
results, run it with the "time" program, e.g.:

$ time ./ebizzy

The shorter the elapsed time, the better.  The system time should be
as close to zero as possible.

An interesting part of this app is difference between memory
allocation using the "always mmap" and "never mmap" flags.  -m is
"always mmap" and -M is "never mmap":

$ time ./ebizzy -m
$ time ./ebizzy -M

The output of the above two commands should be quite different.

ebizzy has many command line arguments.  To get a list of them and
their descriptions, type:

$ ./ebizzy -?

Support
-------

There is none.  However, you can try emailing the author with
questions and suggestions.

Val Henson <val_henson@linux.intel.com>
