Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316937AbSEWQN3>; Thu, 23 May 2002 12:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316938AbSEWQN2>; Thu, 23 May 2002 12:13:28 -0400
Received: from scfdns02.sc.intel.com ([143.183.152.26]:37096 "EHLO
	crotus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S316937AbSEWQNZ>; Thu, 23 May 2002 12:13:25 -0400
Message-Id: <200205231612.g4NGCTw28127@unix-os.sc.intel.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Mark Gross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
Subject: Re: PATCH Multithreaded core dumps for the 2.5.17 kernel  was ....RE: PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
Date: Thu, 23 May 2002 09:12:05 -0400
X-Mailer: KMail [version 1.3.1]
Cc: "Gross, Mark" <mark.gross@intel.com>, "'Erich Focht'" <efocht@ess.nec.de>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'Robert Love'" <rml@tech9.net>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C057B489B@orsmsx111.jf.intel.com> <200205230009.g4N09Ow08254@unix-os.sc.intel.com> <20020522201218.B16554@crack.them.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 May 2002 09:12 pm, Daniel Jacobowitz wrote:
> > For Ia64 those down_writes are just a pain.  If a user application is
> > crashing because someone is being rude with GDB corrupting its user pages
> > then I don't think its worth the hassle of protecting the core dumped
> > user page mm data from being messed up by a GDB user.
> > 
> > I would like to leave the down_write out of elf_core_dump, but it could
> > be put back if its felt that its needed.
> > 
> > Opinions? Comments?
>
> I'm not worried about the application crashing.  I'm worried about
> oopsing if someone is poking at the mmap_sem while we are pretending to
> have it.  If that is not a valid concern, there should at least be a
> big red flag saying so.

We are worried about the same thing :)  
I can add a nice comment to binfmt_elf.c explaining why the current->mmap_sem 
isn't taken in elf_core_dump.  

( I find comments for code that's not there a bit more confusing than 
comments for code that is there.   I'll try to come up with something 
meaningful as a comment to the lack of locking policy in elf_core_dump for my 
next posting.)

The only risk I can see of oopsing is if some of the user pages get taken 
away while the core dump is progressing.  With the other processes in the 
thread group suspended, not holding the  mmap_sem, I truly believe we are 
good.

I'd like to avoid over locking where no clear need exists.  I understand that 
this may be the more risky position to take, but I believe its the right 
thing to do.  Especially on a development kernel.

--mgross
