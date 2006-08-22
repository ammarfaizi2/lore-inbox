Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWHVS4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWHVS4P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 14:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWHVS4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 14:56:15 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:36544 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750796AbWHVS4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 14:56:14 -0400
Date: Tue, 22 Aug 2006 11:55:40 -0700
From: Paul Jackson <pj@sgi.com>
To: Mike Galbraith <efault@gmx.de>
Cc: vatsa@in.ibm.com, mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, balbir@in.ibm.com,
       sekharan@us.ibm.com, akpm@osdl.org, nagar@watson.ibm.com,
       matthltc@us.ibm.com, dipankar@in.ibm.com
Subject: Re: [PATCH 7/7] CPU controller V1 - (temporary) cpuset interface
Message-Id: <20060822115540.627de867.pj@sgi.com>
In-Reply-To: <1156269661.4954.6.camel@Homer.simpson.net>
References: <20060820174015.GA13917@in.ibm.com>
	<20060820174839.GH13917@in.ibm.com>
	<1156245036.6482.16.camel@Homer.simpson.net>
	<20060822101028.GB5052@in.ibm.com>
	<1156257674.4617.8.camel@Homer.simpson.net>
	<1156260209.6225.7.camel@Homer.simpson.net>
	<20060822140124.GC7125@in.ibm.com>
	<1156269661.4954.6.camel@Homer.simpson.net>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike wrote:
> By cat'ing each task pid
> (including init's) to root (or mikeg) task's file?

I guess you meant:
  echo'ing
not:
  cat'ing

Lets say for example one has cpusets:
    /dev/cpuset
    /dev/cpuset/foo

One cannot move the tasks in 'foo' to the top (root) cpuset by doing:

    cat < /dev/cpuset/foo/tasks > /dev/cpuset/tasks    		# fails

That cat fails because the tasks file has to be written one pid at a
time, not in big buffered writes of multiple lines like cat does.

The usual code for doing this move is:

    while read i
    do
	/bin/echo $i > /dev/cpuset/tasks
    done < /dev/cpuset/foo/tasks

There is a cute trick that lets you move all the tasks in one cpuset to
another cpuset in a one-liner, by making use of the "sed -u" unbuffered
option:

    sed -nu p < /dev/cpuset/foo/tasks > /dev/cpuset/tasks	# works

For serious production work, the above is still racey.  A task could be
added to the 'foo' cpuset when another task in 'foo' forks while the
copying is being done.  The following loop minimizes (doesn't perfectly
solve) this race:

    while test -s /dev/cpsuet/foo/tasks
    do
	sed -nu p < /dev/cpuset/foo/tasks > /dev/cpuset/tasks
    done

The above loop is still theoretically racey with fork, but seems to
work in practice.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
