Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263530AbREYFCK>; Fri, 25 May 2001 01:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263531AbREYFCA>; Fri, 25 May 2001 01:02:00 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:21775 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S263530AbREYFBl>;
	Fri, 25 May 2001 01:01:41 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: PATCH: "Kernel Insider" (security optimization)
Date: 25 May 2001 04:59:47 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9ekos3$v07$1@abraham.cs.berkeley.edu>
In-Reply-To: <Pine.LNX.4.31.0105250006440.1495-100000@Ono-Sendai.linux.hack>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 990766787 31751 128.32.45.153 (25 May 2001 04:59:47 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 25 May 2001 04:59:47 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Its a linux kernel modification, that allows to decide wich uid, pid or
>file can open a tcp socket in listening state.

- Putting access control on listen() [rather than socket()/bind()]
  seems like a really bad idea.  In particular, in some cases one can
  bind to a port and receive messages on it without ever calling listen(),
  if I am not mistaken.

- The use of sock_i_uid(sock) seems poorly chosen; if sock->socket==NULL,
  then your module will mistakenly think that the action was requested by
  uid 0.  In general, the return value from sock_i_uid() cannot be trusted
  for permission checks for several reasons.  Why don't you simply use
  current->euid for your permission checks?

- Checking pid's doesn't seem like a good idea.  If a process listed in
  allowed_pids dies, then some other malicious process can wrap the pid
  space and take over that trusted pid, thereby subverting your access
  control policy.

- Are you aware of previous work on this subject?  In particular, you
  might enjoy checking out the Janus project, which is a much more general
  implementation of this idea: http://www.cs.berkeley.edu/~daw/janus/

- You should really join the mailing list hosted by Crispin Cowan working
  to develop kernel hooks for this sort of kernel security modification.
