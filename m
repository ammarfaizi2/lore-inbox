Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131752AbQL0V17>; Wed, 27 Dec 2000 16:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131834AbQL0V1s>; Wed, 27 Dec 2000 16:27:48 -0500
Received: from hera.cwi.nl ([192.16.191.1]:31204 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131763AbQL0V1f>;
	Wed, 27 Dec 2000 16:27:35 -0500
Date: Wed, 27 Dec 2000 21:57:03 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Christoph Rohland <cr@sap.com>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org, Dave Gilbert <gilbertd@treblig.org>
Subject: Re: [Patch] shmmin behaviour back to 2.2 behaviour
Message-ID: <20001227215703.A1302@veritas.com>
In-Reply-To: <m3d7eeb1pa.fsf@linux.local> <Pine.LNX.4.21.0012271316020.11471-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0012271316020.11471-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Wed, Dec 27, 2000 at 01:16:44PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2000 at 01:16:44PM -0200, Marcelo Tosatti wrote:
> 
> On 27 Dec 2000, Christoph Rohland wrote:
> 
> > Hi Linus,
> > 
> > The following patchlet bring the handling of shmget with size zero
> > back to the 2.2 behaviour. There seem to be programs out, which
> > (erroneously) rely on this.
> 
> Just curiosity: do you know if any specification (POSIX?) defines this
> behaviour? 

I happen to see this post, but have not followed earlier discussion.
See a patch fragment

	-#define SHMMIN 0    /* min shared seg size (bytes) */
	+#define SHMMIN 1    /* min shared seg size (bytes) */

	+ if (size < SHMMIN || size > shm_ctlmax)
	+   return -EINVAL;

My first reaction is that this patch is broken, since
one usually specifies size 0 in shmget to get an existing
bit of shared memory (with known key but unknown size).

[Was this rehashed in earlier discussion? I wonder whether there
are any reasons to forbid size 0. Forbidding size 0 is
allowed by SUSv2 as I read it - it says

	The shmget() function will fail if: 

	[EINVAL]
		The value of size is less than the system-imposed minimum
		or greater than the system-imposed maximum,
		or a shared memory identifier exists for the argument key
		but the size of the segment associated with it is less
		than size and size is not 0. 

but is contrary to AIX, which says

	EINVAL
         A shared memory identifier does not exist and the Size
	parameter is less than the system-imposed minimum or greater
	than the system-imposed maximum.
	EINVAL
         A shared memory identifier exists for the Key parameter,
	but the size of the segment associated with it is less than
	the Size parameter, and the Size parameter is not equal to 0.

and is also contrary to the SysVR4 implementation.]

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
