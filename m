Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVDPXsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVDPXsk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 19:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVDPXsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 19:48:40 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:30985 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S261206AbVDPXsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 19:48:38 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Why system call need to copy the date from the userspace before 
 using it
Date: Sat, 16 Apr 2005 23:46:39 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <d3s84v$j64$2@abraham.cs.berkeley.edu>
References: <Pine.LNX.4.61.0504131507280.21367@chaos.analogic.com> <200504160450.j3G4oqC9029496@hacksaw.org>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1113695199 19652 128.32.168.222 (16 Apr 2005 23:46:39 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Sat, 16 Apr 2005 23:46:39 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hacksaw  wrote:
>What I would expect the kernel to do is this:
>
>system_call_data_prep (userdata, size){	 [...]
>      for each page from userdata to userdata+size
>      {
> 	if the page is swapped out, swap it in
>	if the page is not owned by the user process, return -ENOWAYMAN
>	otherwise, lock the page
>      }   [...]

One challenge that might make this issue a little tricky is that
you have to handle double-indirection, where the kernel copies in
a buffer that includes a pointer to some other buffer that you then
have to copy in.  I think this comes up in some of the ioctl() calls.
Because only the guts of the ioctl() implementation knows the format of
the data structure, only it knows what system_call_data_prep() calls
would be needed.  So, everywhere that currently does copy_from_user()
would have to do system_call_data_prep().  (It wouldn't be sufficient
to call system_call_data_prep() once in some standardized way at the
start of each system call, and leave it at that.)
