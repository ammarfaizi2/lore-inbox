Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbTLZEvI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 23:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbTLZEvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 23:51:08 -0500
Received: from sitemail3.everyone.net ([216.200.145.37]:21384 "EHLO
	omta06.mta.everyone.net") by vger.kernel.org with ESMTP
	id S264472AbTLZEvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 23:51:04 -0500
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Thu, 25 Dec 2003 20:51:02 -0800 (PST)
From: john moser <bluefoxicy@linux.net>
To: linux-kernel@vger.kernel.org
Subject: Help: slab allocator and TLB
Reply-To: bluefoxicy@linux.net
X-Originating-Ip: [68.33.187.247]
Message-Id: <20031226045103.42D163963@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CC whatever replies to my address.

I'm thinking of doing a couple of things to the slab allocator to allow modular
memory managment code.  My first goal is a simple one:  modular adulteration of
pages.  I'm only focused on x86 architectures, so if anyone actually decides
they like this and want it on other archs, they've got to bring patches to me.
Of course, I'm going to try to take a whack at generating some useful code, so
I need to know my way around the kernel, and am looking for a quick jumpstart.
here's what I need:

 1 - When at any point a page mapping is loaded into the TLB, the physical page
  may be accessed without consulting the OS first and thus must be unadultered.
 2 - In leiu of (1), when a page fault is incurred and the page mapping is not
  in the TLB, the OS is queried for the page mapping.  At this query, the page
  may be adultered, and thus must be returned to an unadultered form.
 3 - In leiu of both (1) and (2), when a page fault is incurred and a mapping is
  sent to the CPU's TLB by the OS, another mapping may be discarded.  The page
  that the discarded mapping points to will be unadultered, and thus may be
  eligible for adultering.  Thus, the OS must be able to receive these events,
  if possible.
 4 - In leiu of (1), sometimes pages become invalidated and are purged from the
  TLB manually.  In these events, the pages are unadultered and may be eligible
  for adultering.  At these purges, the page must either be freed or examned
  for possible adultering.

The above four conditions are basically my goals.  Any information such as
source files, function names, and even line numbers in 2.6.0 stable would be
helpful in my attempt to impliment such a thing.

If I could impliment the hooks at just the right places, then pages in RAM could
be compressed (ram increase at CPU cost) or encrypted (security against ram
sniffing at CPU cost) via modules that hook into the kernel's memory managment,
efficiently.  I intend to make my resulting patch be 100% identical to 2.6.0
stable when the modular ram adultering hooks are disabled (responsible use of
conditional compiling).

If I get this working, I'll most likely try for a patch at the base of the
2.7 split down the line.  Just a heads-up.

My eventual goal is to identify all of the data that is required from memory
managment and derivable from same, create a uniform communication method,
and then modularize the entire MM system.  I have an affinity for red-hot
swapping, so if I ever get that far, I'll be aiming at the ability to swap
out different memory managment schemes (rmap, object based rmap, etc) while
the kernel is running, without pausing execution.  As for how I'd do this,
I can't guarentee that I'll get this far but I'm thinking of lr-rw (left-
read, right-write); that is, when it's switching, it will move pages from
the old (left) to the new (right), deleting the pages and entries as it
goes along; and write changes and new page entries to the right side.  If
done *just right*, this will incur one hell of a lot of overhead, for a
short (ehhhhhhhh not blinky but not half-hour) period of time, and then
work without any problems.

I know, these are high goals, but read top to bottom and you'll realize that
I'm going at a small goal first, and a massive ass titan last.

Just humor me ;)


-- Bluefox Icy

_____________________________________________________________
Linux.Net -->Open Source to everyone
Powered by Linare Corporation
http://www.linare.com/
