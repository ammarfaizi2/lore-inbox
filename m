Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266657AbUBFHMc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 02:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266664AbUBFHMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 02:12:32 -0500
Received: from almesberger.net ([63.105.73.238]:27400 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S266657AbUBFHMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 02:12:30 -0500
Date: Fri, 6 Feb 2004 04:12:24 -0300
From: Werner Almesberger <wa@almesberger.net>
To: linux-kernel@vger.kernel.org
Subject: VFS locking: f_pos thread-safe ?
Message-ID: <20040206041223.A18820@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to figure out how all the locking in VFS and friends
works, and I can't quite explain to myself how f_pos is kept
consistent with concurrent readers.

In fact, there might be a violation of atomicity requirements:
e.g. if we take the route sys_read -> vfs_read ->
generic_file_read -> __generic_file_aio_read ->
do_generic_file_read -> do_generic_mapping_read, we don't seem
to be holding any locks. So if I have two threads that start
reading the same fd at the same time, they could retrieve the
same data.

Section 2.9.7 of the "Austin" draft of IEEE Std. 1003.1-200x,
28-JUL-2000, says:

"[...] read( ) [...] shall be atomic with respect to each other
 in the effects specified in IEEE Std. 1003.1-200x when they
 operate on regular files. If two threads each call one of these
 functions, each call shall either see all of the specified
 effects of the other call, or none of them."

I've written a little test program with concurrent readers that
seems to support this observation, i.e. given the following
pseudo-code:

static void *reader(...)
{
    while (read(0,buffer,PAGE_SIZE));
    ...
}

...
    for (...)
	pthread_create(...,reader...);
...

More than one reader may obtain a given page.
The full test program is at
http://www.almesberger.net/misc/tt.tar.gz

Is this a real bug or am I just confused ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
