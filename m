Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283914AbRLADfw>; Fri, 30 Nov 2001 22:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283915AbRLADfm>; Fri, 30 Nov 2001 22:35:42 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:27654 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S283914AbRLADfe>;
	Fri, 30 Nov 2001 22:35:34 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Did someone try to boot 2.4.16 on a 386 ? [SOLVED] 
In-Reply-To: Your message of "Sat, 01 Dec 2001 01:42:47 BST."
             <20011201004247.90162.qmail@web20510.mail.yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 01 Dec 2001 14:35:21 +1100
Message-ID: <11661.1007177721@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Dec 2001 01:42:47 +0100 (CET), 
=?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr> wrote:
>Just to say that I finally solved my problem. It came
>from a wrong vmlinux.lds that had been modified by a
>TUX patch applied to an earlier kernel sharing a hard
>link with this one. Although I think an unlink before
>a regeneration of this file would have been better,

A perfect example of why having the same tree for source and generated
files and using cp -al is a bad idea.  cp -al picks up both source and
objects and you have to hope that anything that is overwritten is hard
link safe (I can tell you now that it is not).  kbuild 2.5 allows
multiple builds from the same source tree into separate object trees
with different configs and is safe.

>I'll check around to see if there are other parts
>which risk to modify a file on disk without previously
>unlink it.

Any Makefile that does "some_command > target_file" or runs a utility
that does open(O_TRUNC) instead of unlink(), open(O_EXCL).

BTW, cp -al of a pristine source tree to multiple source trees followed
by multiple compiles in parallel is not safe either.  make dep relies
on changing time stamps for include files, because the include files
are hard linked, a change in one compile affects the other trees, with
undefined results.  Also fixed in kbuild 2.5.

