Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267008AbTBPOmx>; Sun, 16 Feb 2003 09:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267038AbTBPOmx>; Sun, 16 Feb 2003 09:42:53 -0500
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:2484 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S267008AbTBPOmw>; Sun, 16 Feb 2003 09:42:52 -0500
Date: Sun, 16 Feb 2003 15:52:12 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
Message-ID: <20030216155212.E21727@nightmaster.csn.tu-chemnitz.de>
References: <Pine.LNX.4.44.0302131452450.4232-100000@penguin.transmeta.com> <3E4CAEFC.92914AB3@libero.it> <1045232677.7958.9.camel@irongate.swansea.linux.org.uk> <3E4CF5D2.6ED23062@libero.it> <20030215133600.F629@nightmaster.csn.tu-chemnitz.de> <3E4E8013.C26DFA0@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3E4E8013.C26DFA0@libero.it>; from abramo.bagnara@libero.it on Sat, Feb 15, 2003 at 06:59:47PM +0100
X-Spam-Score: -3.6 (---)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18kQ9v-0002H4-00*XaPGgtVt8sE*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

On Sat, Feb 15, 2003 at 06:59:47PM +0100, Abramo Bagnara wrote:
> We might call this thread "the neverending misunderstanding" ;-)
 
;-)

> My message was a proposal about an universal solution for
> control/out-of-band streams on pseudo-files (like the Linus sig fd,
> devices fd, socket, proc files, etc.) as a way to comunicate between
> user space and kernel space.
> 
> I.e. something that might replace ioctl/fcntl mess giving same (and
> more) flexybility and power (extending the 'everything is a file'
> concept also to control data).
> 
> This is *not* something I'd propose for user space (where we definitely
> have many good ways to achieve these results).

So you propose channels that are defined ONLY by the kernel? That
would make much more sense and could replace ioctl/fcntl indeed,
if we add one more syscall: sys_transact().

long transact(int fd, const void *request_buffer, const size_t request_size,
                      void *result_buffer, const size_t result_size);

This syscall works like read/write with some exceptions:
   
   (Basis features)
   - short reads/short writes are not allowed
   - EINTR will not happen.
   - the effects done to the fd and the underlying object must be
     undone if the request will fail
   - it is optional (file operation) and can return -1/errno=ENOSYS, 
     if not implemented by the underlying kernel object.
   - supplying (fd, NULL, 0, NULL, 0) checks for existence (NOP).

   (Advanced features)
   - supplying (fd, REQUEST, sizeof(REQUEST), MAP_FAILED, 0) 
     returns the expected return buffer size for this request (or
     zero, if no result will be returned). May return -ENXIO, if
     this checking is not supported or -EINVAL, if that request
     is not supported by the underlying kernel object.

   - supplying (fd, REQUEST, sizeof(REQUEST), NULL, 0)
     is issueing a request without a result (e.g. a COMMAND) or
     telling that the user is not interested in any detailed
     results (that variant might be supported by the kernel object or not)

   - The two buffers might alias partially or as a whole.

With that additional semantic we could replace all ioctl() too,
where an ioctl() is used only to get this semantic.

Other OSes have an ioctl() mechanism like that syscall and we
implement it by destroying the argument in IORW-ioctls.

With that in place, I could live without ioctl() and fcntl().
That would also destroy all the interfaces that require you to
read after a write, because it needs transaction semantics 
(sg.c comes to mind).

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
