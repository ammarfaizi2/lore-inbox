Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289677AbSBJPoo>; Sun, 10 Feb 2002 10:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289679AbSBJPoe>; Sun, 10 Feb 2002 10:44:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:65092 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S289677AbSBJPoY>; Sun, 10 Feb 2002 10:44:24 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <Pine.LNX.4.33.0202092211001.10024-100000@home.transmeta.com>
	<Pine.LNX.4.33.0202092211001.10024-100000@home.transmeta.com>
	<m1k7tl6ek2.fsf@frodo.biederman.org> <3C66181C.95DF04E3@zip.com.au>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Feb 2002 08:40:22 -0700
In-Reply-To: <3C66181C.95DF04E3@zip.com.au>
Message-ID: <m1eljt5ord.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:

> "Eric W. Biederman" wrote:
> > 
> > One possibility is to do something like:
> > 
> > ud2
> > .word __LINE__
> > .long 1f
> > .section __FILE__
> > .linkonce discard
> > 1: .asciz __FILE__
> > .previous
> > 
> > Which will put each filename string in it's own section and let the
> > linker merge the duplicates.
> 
> That would work.  When it didn't I r'ed tfm:
> 
> 	http://www.gnu.org/manual/gas-2.9.1/html_node/as_102.html
> 
> 	"This directive is only supported by a few object file formats;
> 	 as of this writing, the only object file format which supports
> 	 it is the Portable Executable format used on Windows NT."

It is supported for ELF and most other targets, but unfortunately not
with the same syntax :(  I just looked and you have to do it a
slightly different way.  You must prefix section name with  ".gnu.linkonce"

binutils/bfd/elf.c:416
  /* As a GNU extension, if the name begins with .gnu.linkonce, we
     only link a single copy of the section.  This is used to support
     g++.  g++ will emit each template expansion in its own section.
     The symbols will be defined as weak, so that multiple definitions
     are permitted.  The GNU linker extension is to actually discard
     all but one of the sections.  */

This has been supported since 1997 so it should be safe to use.
Though it would be nice if someone would actually document it...

Eric
