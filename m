Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbUBZWeE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbUBZWdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:33:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38022 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261219AbUBZWca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:32:30 -0500
Date: Thu, 26 Feb 2004 17:32:26 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PATCH] Add getdents32t syscall
Message-ID: <20040226223212.GA31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040226193819.GA3501@sunsite.ms.mff.cuni.cz> <Pine.LNX.4.58.0402261411420.7830@ppc970.osdl.org> <Pine.LNX.4.58.0402261415590.7830@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402261415590.7830@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 02:25:01PM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 26 Feb 2004, Linus Torvalds wrote:
> > 
> > In other words, what's wrong with this much simpler "extended getdents" 
> > instead?
> 
> Actually, let's put the "d_type" always at the last character, so that you 
> don't have to search for it. Ie like the appended.
> 
> Then you just get
> 
> 	d_type = ((unsigned char *)dirent)[dirent->d_reclen-1];
> 
> inside glibc. Instead of having a new system call.

Userland struct dirent is:

struct dirent
  {
#ifndef __USE_FILE_OFFSET64
    __ino_t d_ino;
    __off_t d_off;
#else
    __ino64_t d_ino;
    __off64_t d_off;
#endif
    unsigned short int d_reclen;
    unsigned char d_type;
    char d_name[256];           /* We must not include limits.h! */
  };

(since 1997 or so), so with the extended getdents syscall glibc would need
to memmove every name by 1 byte.

> You can even trivially check whether the system call fills in the d_type 
> field or not:
> 
>  - pre-fill the dirent area with 0xff or something
>  - do a small old-style "readdir()"
>  - check the first entry: the above gives a d_type of 0xff, then you have 
>    an old-style readdir. If it gives 0, then you have to test whether it 
>    is an old-style readdir (and the zero is the end-of-name marker) or a 
>    new-style readdir (and the zero is DT_UNKNOWN). You can trivially do 
>    that by checking the length of the name, and comparing it with the 
>    reclen.

This has a few problems:
- unless glibc is configured to assume 2.6.4+ kernel, it would need to
  do on first readdir one small getdents (instead of as big getdents as
  needed)
- how to find what is the right small size for the test (it would need to
  retry if it did not fit any entries)
- and if on the old kernel, it would need to seek back so that getdents64
  can be used
Yes, this would only happen the first time getdents is called, but still,
aren't syscalls quite cheap?

	Jakub
