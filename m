Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131382AbRDWQGX>; Mon, 23 Apr 2001 12:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131407AbRDWQGO>; Mon, 23 Apr 2001 12:06:14 -0400
Received: from ash.lnxi.com ([207.88.130.242]:52975 "EHLO DLT.linuxnetworx.com")
	by vger.kernel.org with ESMTP id <S131382AbRDWQF5>;
	Mon, 23 Apr 2001 12:05:57 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Longstanding elf fix (2.4.3 fix)
In-Reply-To: <m31yqk8oas.fsf@DLT.linuxnetworx.com> <15075.40500.408470.152332@pizda.ninka.net>
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: 23 Apr 2001 10:05:07 -0600
In-Reply-To: "David S. Miller"'s message of "Sun, 22 Apr 2001 20:15:00 -0700 (PDT)"
Message-ID: <m3snizbo0c.fsf@DLT.linuxnetworx.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> Eric W. Biederman writes:
>  > In building a patch for 2.4.3 I also discovered that we are not taking 
>  > the mmap_sem around do_brk in the exec paths.
> 
> Does that really matter?  Who else can get at the address space?  We
> are a singly referenced address space at that point... perhaps ptrace?

Well looking a little more closely than I did last night it looks like
access_process_vm (called from ptrace) can cause what amounts to a
page fault at pretty arbitrary times.  

ptrace is protected by the big kernel lock, but exec isn't so that
doesn't help.  Hmm.  ptrace does require that the process be stopped
in all cases, before it does anything and that probably saves us.  This
is subtle enough I'd rather be locally correct, and not have to
worry about someone enhancing ptrace...

I'm actually a little curious what the big kernel lock in ptrace buys
us.  I suspect it could be a performance issue with user mode linux.
Where you have multiple processes being ptraced at the same time.

Eric
