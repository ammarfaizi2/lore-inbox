Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283862AbRLABRt>; Fri, 30 Nov 2001 20:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283865AbRLABRp>; Fri, 30 Nov 2001 20:17:45 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:3334 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S283862AbRLABRS>;
	Fri, 30 Nov 2001 20:17:18 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Henning Schmiedehausen <hps@intermeta.de>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Larry McVoy <lm@bitmover.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue 
In-Reply-To: Your message of "30 Nov 2001 18:15:28 BST."
             <1007140529.6655.37.camel@forge> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 01 Dec 2001 12:17:03 +1100
Message-ID: <10605.1007169423@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Nov 2001 18:15:28 +0100, 
Henning Schmiedehausen <hps@intermeta.de> wrote:
>Are you willing to judge "ugliness" of kernel drivers? What is ugly?
>... Is the aic7xxx driver ugly because it needs libdb ? ...

Yes, and no, mainly yes.  Requiring libdb, lex and yacc to to generate
the firmware is not ugly, user space programs can use any tools that
the developer needs.  I have no opinion either way about the driver
code, from what I can tell aic7xxx is a decent SCSI driver, once it is
built.

What is ugly in aic7xxx is :-

* Kludging BSD makefile style into aix7ccc/aicasm/Makefile.  It is not
  compatible with the linux kernel makefile style.

* Using a manual flag (CONFIG_AIC7XXX_BUILD_FIRMWARE) instead of
  automatically detecting when the firmware needs to be rebuilt.  Users
  who set that flag by mistake but do not have libdb, lex and yacc
  cannot compile a kernel.

* Not checking that the db.h file it picked will actually compile and
  link.

* Butchering the modules_install rule to add a special case for aic7xxx
  instead of using the same method that every other module uses.

* Including endian.h in the aic7xxx driver, but endian.h is a user
  space include.  Code that is linked into the kernel or a module
  MUST NOT include user space headers.

* Not correctly defining the dependencies between generated headers and
  the code that includes those headers.  Generated headers require
  explicit dependencies, the only reason it works is because aic7xxx ...

* Ships generated files and overwrites them under the same name.
  Shipping generated files is bad enough but is sometime necessary when
  the end user might not have the tools to build the files (libdb, lex,
  yacc).  Overwriting the shipped files under the same name is asking
  for problem with source repositories and generating spurious diffs.

All of the above problems are caused by a developer who insists on
doing his own makefile style instead of following the kernel standards
for makefiles.  Developers with their own standards are BAD!

BTW, I have made repeated offers to rewrite the aic7xx makefiles for
2.4 but the aic7xxx maintainer refuses to do so.  I _will_ rewrite them
in 2.5, as part of the kernel build 2.5 redesign.

Keith Owens, kernel build maintainer.

