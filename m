Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbRHJLMi>; Fri, 10 Aug 2001 07:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267009AbRHJLM2>; Fri, 10 Aug 2001 07:12:28 -0400
Received: from zero.aec.at ([195.3.98.22]:51209 "HELO zero.aec.at")
	by vger.kernel.org with SMTP id <S266977AbRHJLMR>;
	Fri, 10 Aug 2001 07:12:17 -0400
To: chris_friesen@sympatico.ca (Chris Friesen)
cc: linux-kernel@vger.kernel.org
Subject: Re: nitpicky questions regarding mmap() and msync()
In-Reply-To: <3B732DAE.CD117CBA@sympatico.ca>
From: Andi Kleen <ak@muc.de>
Date: 10 Aug 2001 13:12:26 +0200
In-Reply-To: chris_friesen@sympatico.ca's message of "Fri, 10 Aug 2001 00:42:52 +0000 (UTC)"
Message-ID: <k28zgsdv8l.fsf@zero.aec.at>
User-Agent: Gnus/5.0700000000000003 (Pterodactyl Gnus v0.83) Emacs/20.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3B732DAE.CD117CBA@sympatico.ca>,
chris_friesen@sympatico.ca (Chris Friesen) writes:
> A couple questions about mmap()'d files.
> 1) If I have an mmap()'d file and I write to it and then I am hit with a SIGKILL
> before I have a chance to msync(), am I guaranteed that changes I've made to the
> information in the file will be available if I restart and try to mmap() the
> same file?  The man page says only that there is no guarantee that changes are
> written back to disk if msync() is not called, but some informal testing seems
> to indicate that changes are in fact written out.  Is this a timing issue or
> does the system guarantee this?

The system does guarantee it. There is no special case for SIGKILL exit,
it is just an ordinary exit and it does properly munmap all your mappings.

> 2) If I make changes to the contents of an mmap()'d file, am I guaranteed that
> the order I make the changes is the same order that they will be available to
> another process that has mmap()'d the same file?  (Or can I be bit by
> optimization reordering?  If this is the case, can I get around this by reading
> it as volatile and using the barrie() macro?)

When two processes access the same mapping in Linux they always work 
on the same block of memory, so standard memory ordering rules apply.
On a lot of architectures that means you need to use appropiate read and
write barriers to avoid reordering on SMP systems.

[on some architectures like early mips chips there can be nasty issues
with virtual cache aliases though, but that should not concern you here]

The memory can be flushed to disk and reread at any time, in this 
regard it is no different from any other anonymous memory, except that 
it is not written to swap but to your backing file.

The order in which the changes are flushed to disk is completely undefined.


-Andi
