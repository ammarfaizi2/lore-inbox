Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263973AbTEFRUm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 13:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263983AbTEFRUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 13:20:42 -0400
Received: from iole.cs.brandeis.edu ([129.64.3.240]:16257 "EHLO
	iole.cs.brandeis.edu") by vger.kernel.org with ESMTP
	id S263973AbTEFRUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 13:20:41 -0400
Date: Tue, 6 May 2003 13:33:16 -0400 (EDT)
From: Mikhail Kruk <meshko@cs.brandeis.edu>
To: <linux-kernel@vger.kernel.org>
Subject: flock races causes E_NOLCK
Message-ID: <Pine.LNX.4.33.0305061321310.7082-100000@iole.cs.brandeis.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I'm having a problem with flock on 2.4.18 kernel. 
The scenario is like this:

parent process:
open file
fcntl(file, FD_SETFD, 1) // set CLOEXEC bit
flock file
fork/exec child process
close file

child process
open the same file
flock this file
close file

This sometimes (often) results in child process being unable to do any 
further locking with the error 37 (no locks available).
Removing fcntl and doing an explicit close of all open file desciprotrs in 
the beginning of child leads to the same problem.

Here is a post from Pat Knight descirbing similar problem:
http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=UTF-8&threadm=linux.fsdevel.sxr8lna7wp.fsf%40eurologic.com&rnum=4&prev=/groups%3Fhl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3DUTF-8%26q%3DRLIMIT_LOCKS%26btnG%3DGoogle%2BSearch

I can't directly map his problem onto mine, but it's pretty clear that 
somehow (usigned) current->locks is decremented when it is 0. 

For some reason, however, simplistic test program doens't hit this 
condition, so I suspect my analysis is not 100% correct. I'm sure, though, 
that current->locks is getting messed up somehow.

