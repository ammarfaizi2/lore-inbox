Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTLUKva (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 05:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTLUKv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 05:51:29 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:26629 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262566AbTLUKv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 05:51:28 -0500
Date: Sun, 21 Dec 2003 11:51:10 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] O_DIRECTORY|O_CREAT handling
Message-ID: <20031221105110.GA1323@alpha.home.local>
References: <3FE56A97.3060901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE56A97.3060901@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulrich,

On Sun, Dec 21, 2003 at 01:40:39AM -0800, Ulrich Drepper wrote:
> 
> Some programs create temporary directory which they afterward use as the
> working directory or changed root.  I.e., we have code like this:
> 
>   mkdir ("/some/dirRANDOM");
>   chdir ("/some/dirRANDOM");
> 
> or
> 
>   mkdir ("/some/dirRANDOM");
>   fd = open ("/some/dirRANDOM", O_DIRECTORY);
>   fchdir (fd);
> 
> or
> 
>   mkdir ("/some/dirRANDOM");
>   chroot ("/some/dirRANDOM");
> 
> All these pieces of code have an obvious flaw, a race.  There is no
> atomic way to do what we want.

Although I agree on the race, I fail to see in what case it matters.
In my programs, I often use mkdir() to get temporary directories instead
of temporary files, just because of the atomicity of the test-and-set which
mkdir() provides. Basically, I do :

  base_dir="/tmp/tmpdir"; 
  do {
     rnd=random();
     sprintf(dir, "%s%d", base_dir, rnd);
  } while (!mkdir(dir, 0700);
  /* now I'm guaranteed that I'm the first to get this dir, */
  /* and only my UID can work in it */
  chdir(dir);
  
So the only race would be someone working with the same UID (or root) removing
the directory and replacing it with another one (or a symlink or anything)
between mkdir() and chdir(). But don't see any use or consequence to this.

> Now combine these two problems.  How about making this work?
> 
>   fd = open ("/some/dirRANDOM", O_RDONLY|O_CREAT|O_DIRECTORY|O_EXCL, 0700);
>   fchdir (fd);

It would be interesting, of course, but is it portable to other systems ? If
it is not, very few people will use it, unfortunately. But if others already
do it right, then why not include it ?

Cheers,
Willy

