Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932611AbVLQQsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbVLQQsB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 11:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbVLQQsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 11:48:01 -0500
Received: from mxout01.versatel.de ([212.7.152.117]:28073 "EHLO
	mxout01.versatel.de") by vger.kernel.org with ESMTP id S932611AbVLQQsA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 11:48:00 -0500
Date: Sat, 17 Dec 2005 17:47:26 +0100
From: Christian Trefzer <ctrefzer@gmx.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Stefan Seyfried <seife@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
Subject: [RFC] swsusp: brainstorming on a freaked-out approach (was: Re: [RFC/RFT] swsusp: image size tunable)
Message-ID: <20051217164726.GA12021@hermes.uziel.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <200512162209.53128.rjw@sisk.pl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello there,

On Fri, Dec 16, 2005 at 10:09:52PM +0100, Rafael J. Wysocki wrote:
> On Friday, 16 December 2005 20:29, Christian Trefzer wrote:
> > My point is, that the generic algorithm to determine the maximum image
> > size desired by the user will, as a whole, remain the same, whether
> > implemented in kernel or user space. Unfortunately, I am very unfamiliar
> > with swsusp code and all of its implications wrt. drivers etc. - this
> > still holds true after looking at swsusp_shrink_memory().
> >=20
> > But generally speaking: at some point, memory is freed for the image
> > creation process. Recent efforts towards tunable max_image_size make it
> > seem to me that we likely know beforehand, how much we are going to
> > free. Now say we have max_image_size of 500MB, but we know that active
> > swaps will hold 400MB at max. So we start out freeing enough memory for
> > a 400MB image, and once we're done, we notice we can only save 350MB.
> > Does anything keep us from reducing the image size to 350MB right now?
>=20
> Basically nothing and it could be implemented, but IMO it would be a step
> in a wrong direction.
>=20
> Namely, we want the image-writing code to go to the user space in the long
> run. Then, the whole suspend will be handled by a userspace process and t=
he
> kernel will not know what kind of storage this process is using (it may or
> may not be a swap partition).  Consequently, the kernel will not know how
> much space there is for the image, _unless_ the user space process tells =
it.

So far everything seems clear to me.

> The user space process can do this _once_, using /sys/power/image_size
> before it asks the kernel to create the image.  Next, the kernel creates
> the image and swsusp_shrink_memory() is called in the process.  Of course
> at this point the amount of available storage can change, but to know it
> the kernel would have to ask the userspace process if that happened.
> Generally speaking it can't do this, so it "returns" the image to the
> userspace process which should verify if the image is small enough
> and if not, repeat from writing /sys/power/image_size with a smaller
> number or just fail (if so configured).

I see now - when I was thinking about uswsusp, I wrongly guessed that
image creation will happen in the same region (user vs. kernel space) as
the checks for available storage. We can't really let image_size
converge towards free_storage with an upper limit of max_image_size
anyway, yet the silent retry with a smaller image size will eventually
be an option, although configurable via the userland utility. The latter
was what I intended, for checking available storage in every loop
iteration would indeed not be very efficient. Nice one!

Just a spontaneous idea: before we smash memory free with a sledge
hammer (no offense intended), would it be sensible to create sort of a
map of actual memory usage, determining the importance (kernel/user
apps/buffers) and relevance (frequently/recently/not used) of pages?=20

With a long-term target of a responsive post-resume system in mind, it
seems desirable to me to restore as much information as possible.
Putting pressure on the VM will (afaik) free buffers first, but swap out
applications later. If i am not misunderstood once more, that means
swsusp will mostly trash some cache, at least while freeing memory, yet
not push applications out to swaps. Obviously, the process of suspending
and resuming will require some memory by itself, and this amount will
grow the more functionality is added.

I hereby assume that the "underlying" functionality of reserving space
for suspend and resume routines, as well as "freezing everything" for
image creation and "restoring everything", basically "just works". That
means, from my naive point of view, that "time has stopped" wrt. the
"running" kernel and applications, leaving alive only the means to write
the image and swaps. Now it is "only" a matter of what to write to the
image, what to swap out, and what to forget.

Basically, importance of pages is pretty boolean - there are pages we
can throw away without harm, and there are those we can't. Then again,
some of the latter can be swapped if necessary, but a reluctance to do
so would improve system responsiveness post-resume. Unused application
data will eventually be swapped out already by the time we want to
suspend, yet with today's common memory size and current kernel
versions, this assumption becomes less and less valid. Therefore, I
assume again that application data is mostly paged in by the time
suspend is triggered.

So far my picture of the situation - any misunderstandings in there
might flaw the following suggestions.


My basic idea was to create the image incrementally, using a variable
slice size, in which important pages come before unimportant ones and
hot pages before cold ones. I bet the kernel/uswsusp interface for that
mechanism can become arbitrarily complex, but to keep it simple, would
it be possible to request one image slice at a time? Say, request and
write to the image all pages related to kernel space, then user apps,
then caches, ordered by relevance ("temperature").


* Looking at a case of extreme storage constraints:
	If not even kernel and userland can be saved during susped, we fail.
	If the image is stored anywhere but in swaps, we can try to swap out
	pages [1] - once all the necessary areas are safe, we are as well, else
	we fail.  Caches can be forgotten if necessary, but are nice to have
	- keep as much as possible/desired.


* In case of huge storage amounts for suspend:
	Save the kernel first, then userland, then caches until we reach a
	user-defined limit. The ordering of the latter two could be mixed
	slice-wise according to page relevance, forcing some LRU/LFU
	application pages out to swap in favour of keeping larger caches
	[1].


* Anywhere inbetween / basic algorithm:
 -	Create a map of memory usage.
 -	Group data by importance: kernel | userland | buffers/caches
 -	Group equivalently relevant ("hot") pages in slices. Use
	histogram-like maths to determine slice boundaries and stepping. [2]
 -	Determine the ordering of slices by weight, with a threshold of
	importance vs. relevance. [3]
 -	Request and store one slice at a time:

	 - 	Slice is unswappable and thus must be stored in the suspend
		image. Lack of storage implies suspend failure.
	 - 	Slice does not fit into suspend image, but is swappable [1].
		Lack of swap space leads to suspend failure. Otherwise, we
		instruct the kernel to swap out the pages contained within that
		specific slice. The fact that these pages are swapped out must
		be known to the VM before resuming the frozen kernel [4].
	 -	Slice contains buffer data which can be silently dropped, yet
		the fact that these buffers are gone must also make its way into
		the VM state before we let the frozen kernel continue where it
		has left off [4]



[1]	Aspects of storing pages in swap:
	A basic approach to guarantee integrity would be to make all
	important pages backed by swap. This is contraproductive wrt. swap
	as storage for images which can be compressed in the long run, so
	that is a no-go.
=09
	It would also require swap to be at least as large as the amount of
	memory currently occupied by applications, which won't necessarily
	be the case, esp. if the suspend image will be written to a
	dedicated partition or even an ordinary file. My conclusion is that
	swapping out a lot of pages is only feasible in case the suspend
	image is stored "out-of-swap".



[2]	Thoughts on histograms:
	Small slices induce more overhead, large slices are more likely to
	exceed the maximum possible/desired image size. It therefore appears
	sensible to me to stick to dynamically sized slices, where
	horizontal size (amount of memory) and vertical size (relevance
	range) should represent a "significant" histogram.
=09
	That said, we would end up having a suitable number of slices, with
	each bearing a sane amount of data, esp. wrt. cache slices being
	stored or dropped.  I yet have to draw some draft charts and graphs
	to visualize some relations between different sizes and
	thresholds...
  =20


[3]	Page weight / coloring:
	Looking at [1], we can skip coloring of important pages if the image
	is written to swaps as they will all need to be stored. In this
	case, we can as well treat kernel space and userland as one slice
	each, or even squash them together into one.
=09
	In case of external suspend image and buffer pages, we could color
	pages according to their relevance, and after sorting them we have a
	gradient from, say, red (hot) to blue (cold) pages. Using some sane
	histograph techniques [2] we can now slice that up, ending up with,
	well, slices we can treat "atomically".
=09


[4]	Changing VM state after freezing it:
	This occured to me pretty late during this draft and is, of course,
	crucial to all of it ; ) Murphy rules. So anyway, if we kind of
	"tar" our memory up, one slice at a time, how can we tell the frozen
	kernel's VM, "Hey, by the way, there were some pages of cache over
	there, but we decided to drop them during suspend!" Even more
	complex at first sight appears to me the treatment of pages swapped
	out due to lack of suspend storage, external suspend image presumed.
	This would require the already written kernel slices to be re-made.

	After all, the one-slice-at-a-time approach is a great
	simplification for illustrating the line of thought, but not for
	writing a consistent image. The whole point of slicing the image up
	is a calculation of what pages to store where (or at all), given an
	arbitrary configuration wrt. memory, available/desired storage/swap
	and throughput constraints. So instead of writing slices
	immediately, we take everything into consideration to achieve an
	optimum result, and once it is clear what shall be done, it is done.

	The one big problem I see here is the eventual increase in memory
	requirements to do all the maths, and potentially the need for free
	space to create an atomic copy of some special pages. Also, "late
	swapping" of slices stands in opposition to a totally frozen state
	of the previously running environment. We therefore need to
	determine which pages to swap out, order the VM system to do so
	(without clearing out buffers), take into account all changes caused
	by these actions and re-iterate/backtrack as few steps as necessary
	to act appropriately. If we can rely on a partially frozen kernel to
	only touch the pages it is told to swap out, the only further
	changes should be visible within the page tables. Complexity results
	only if such changes can shift slice boundaries, leaving at least
	one question open to the VM gods: is this possible, and how
	predictable is the resulting beaviour?



Well, so much for "quick" brainstorming on the issue... Don't bother
flaming me for any misunderstanding or misconception : )

> > Apologies for wasting your time, I am trying to get rid of my ignorance.
>=20
> It's not a waste of time at all. :-)  IMO the issue is definitely worth
> discussing.

Thanks for clearing my conscience, yet I am afraid I just stained it
even more : )

Yours,
Chris


--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ6RBHF2m8MprmeOlAQLYZw/6A6Fq0yxhlD9ooeW4huf/9QL8HvFYMFt0
7jS6b75AR3GotqushQR7smzvmiEMnNoaIyq+Rv+dt01HH69O/3/t253Wwp/z4zht
3+O6FKYGYohDcZUB+SogXx9uu6IA6YHxCmJwoSKepwVo634UxukQSL9q4WGdUvyA
yExovFLN0BgeqGbL30RqZ+bKGXgTW+vLC0u4z/3Gof562KSR1EB1+frTJ1ig/G49
TNXl0c43ViGU7uHFxm+WG9u6ISAVJSDRxpBx6dNzsDLGQWuT/hIdJ0Oq6UW9mXWL
jt86DA7W6IIJiS+iofyMKdQHxqCncHBWFgd7jicTzVDSEp22hXw1s4D4KPmLmtov
CjdmvM2pcm+loIYryToRdljAfZ3DCpDWVZtV9nIv/8WC5EzDLsix+fsmBhtW79QC
p3Qe/OsCZFSZwKcTfu0XG6RB/E5hWVPbwYh49O8xe4tdEhaFK0gqF1O2w0qjqFGL
7vpJnmuLIY8JeI1MMhfNDerkMUjXEGpiuWDIhqQ9fXQRGkN1RIgQMgZqSU0hLfNO
SMmHn5FI5NTU6LAIgFWsZxmTOJH5nPNDsVDpgK3AbbZHln8qSWia0Z6UpTKII5E9
jaFK4r+aAZNcmzwWw8vVI+qxXfdtYPoNKvls1CM/p9tqWYDy8q4QQEBlqLqlDpq5
XTQtRhcY5MU=
=OpJr
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--

