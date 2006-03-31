Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWCaHg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWCaHg4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 02:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWCaHg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 02:36:56 -0500
Received: from dp.samba.org ([66.70.73.150]:63961 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S1751050AbWCaHg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 02:36:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17452.56376.371309.260740@samba.org>
Date: Fri, 31 Mar 2006 18:37:28 +1100
To: "Antonio Vargas" <windenntw@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] splice support #2
In-Reply-To: <69304d110603302259geac2ba8t11babc2c6854842d@mail.gmail.com>
References: <17452.50912.404106.256236@samba.org>
	<69304d110603302259geac2ba8t11babc2c6854842d@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonio,

 > Maybe "ssize_t psplice(int fdin, int fdout, size_t len, off_t
 > fdin_ofs, unsigned flags);"

yep, thats clearer

I think ideally splice() would just be changed to always take a off_t
as the interface is so new hopefully no apps depend on it yet. Then we
don't need psplice(). 

A while ago we got bitten with tdb in Samba and systems that only have
write(), and no pwrite(). If a process forks then accesses the db in
both parent and child the shared seek pointer semantics of inherited
file descriptors causes races with seek/write. It would be nice if
splice() was immune from this from the start.

If people want it both ways, then an alternative would be to have a
SPLICE_FLAG_OFS_CURRENT flag to splice(), which would tell splice() to
ignore the off_t and use the current seek ptr. I guess that would save
some book keeping for some apps that know they don't have any seek
races and want to always write at the current position. I wouldn't
need this, but some people might find it convenient.

 > would be better at documenting that the offset is for the input? Or
 > maybe adding also a fdout_ofs for when fdout is also a file...

I thought about that, but Stephen convinced me it was a bad idea, as
the semantics with whats in the pipe buffer at any one time gets too
messy if the output is a socket. I guess you could return -EINVAL if
you used the fdout_ofs and its not a seekable file, but that seems to
be overloading the system call too much for my liking.

Cheers, Tridge
