Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316425AbSEJNYy>; Fri, 10 May 2002 09:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316426AbSEJNYy>; Fri, 10 May 2002 09:24:54 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:19472 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316425AbSEJNYw>;
	Fri, 10 May 2002 09:24:52 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: spin-locks 
In-Reply-To: Your message of "Fri, 10 May 2002 08:58:47 -0400."
             <Pine.LNX.3.95.1020510084519.1902A-100000@chaos.analogic.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 May 2002 23:24:42 +1000
Message-ID: <30386.1021037082@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2002 08:58:47 -0400 (EDT), 
"Richard B. Johnson" <root@chaos.analogic.com> wrote:
>First, if I create a spin-lock in the ".data" segment it
>doesn't work on a SMP machine with two CPUs. I know I am
>supposed to use the macros, but I have some high-speed stuff
>written in assembly that needs a spin-lock. The 'doesn't work'
>is that the spin-lock seems to dead-lock, i.e., they loop
>forever with the interrupts disabled. I think what's really
>happening is that .data was paged and can't be paged back in
>with the interrupts off. I don't know. This stuff used to
>work....

Kernel .data sections are not paged.  They are identity[*] mapped along
with the rest of the kernel text and data and are locked down.

[*] Ignoring NUMA machines which may use non-identity mappings on each
node.

>In earlier versions of Linux, the locks were in .text_lock.
>Now they are in : _text_lock_KBUILD_BASENAME

Not quite.  They were all in section .text.lock but that broke when
binutils started detecting dangling references to discarded sections.

The fix was to store the lock code in the same section that called the
lock, so .text locks are in the .text section, .text.exit locks are in
the .text.exit section, no dangling references when .text.exit is
discarded.

The locks are now at the end of the section that references the lock,
preceded by a label (not a section) of _text_lock_KBUILD_BASENAME.

>So, what is special about this area that allows locks to work?

There is nothing special about the text lock code.  It is just moving
the failure path out of line to speed up the normal case.

>And, what is special about .data that prevents them from working?

Again nothing.  The spin lock area goes in .data, the code goes in the
relevant text section.

>Also, there is a potential bug (ducks and hides under the desk) in
>the existing spin-lock unlocking. To unlock, the lock is simply
>set to 1. This works if you have two CPUs, but what about more?
>
>Shouldn't the lock/unlock just be incremented/decremented so 'N' CPUs
>can pound on it?

Spinlocks are single cpu.  Only one cpu at a time can modify the data
that is being protected by obtaining the lock.

>From your description, you are confused about spinlocking.  Perhaps if
you mailed your code instead of assuming where the error was ...

