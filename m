Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132175AbQL1Man>; Thu, 28 Dec 2000 07:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132299AbQL1Mad>; Thu, 28 Dec 2000 07:30:33 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:41172 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S132287AbQL1MaX>; Thu, 28 Dec 2000 07:30:23 -0500
To: Andries Brouwer <aeb@veritas.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Dave Gilbert <gilbertd@treblig.org>
Subject: Re: [Patch] shmmin behaviour back to 2.2 behaviour
In-Reply-To: <m3d7eeb1pa.fsf@linux.local>
	<Pine.LNX.4.21.0012271316020.11471-100000@freak.distro.conectiva>
	<20001227215703.A1302@veritas.com>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <20001227215703.A1302@veritas.com>
Message-ID: <m3wvck99wx.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 28 Dec 2000 13:01:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aeb@veritas.com> writes:

> On Wed, Dec 27, 2000 at 01:16:44PM -0200, Marcelo Tosatti wrote:
> I happen to see this post, but have not followed earlier discussion.
> See a patch fragment

(The patch does not show a lot of context. You should look at the
whole files)

> 
> 	-#define SHMMIN 0    /* min shared seg size (bytes) */
> 	+#define SHMMIN 1    /* min shared seg size (bytes) */
> 
> 	+ if (size < SHMMIN || size > shm_ctlmax)
> 	+   return -EINVAL;
> 
> My first reaction is that this patch is broken, since
> one usually specifies size 0 in shmget to get an existing
> bit of shared memory (with known key but unknown size).

That's still covert: The check is moved out of shmget into the create
function. So you cannot create segments of size 0 but you can get
existing segments by giving a size 0.

> [Was this rehashed in earlier discussion? I wonder whether there
> are any reasons to forbid size 0. Forbidding size 0 is
> allowed by SUSv2 as I read it - it says
> 
> 	The shmget() function will fail if: 
> 
> 	[EINVAL]
> 		The value of size is less than the system-imposed minimum
> 		or greater than the system-imposed maximum,

We match this with a system-imposed minimum of 1 now.

> 		or a shared memory identifier exists for the argument key
> 		but the size of the segment associated with it is less
> 		than size and size is not 0. 

We don't match this exactly since we allow arbitrary sizes smaller
than segment size for existing segments (0 included).

> but is contrary to AIX, which says
> 
> 	EINVAL
>          A shared memory identifier does not exist and the Size
> 	parameter is less than the system-imposed minimum or greater
> 	than the system-imposed maximum.
> 	EINVAL
>          A shared memory identifier exists for the Key parameter,
> 	but the size of the segment associated with it is less than
> 	the Size parameter, and the Size parameter is not equal to 0.

That's what we do and always did.

So should we go for SUSv2? I do not think that we should restrict the
shmget so late in the release cycle. We could enhance this check
further in 2.5 perhaps.

Greetings
                Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
