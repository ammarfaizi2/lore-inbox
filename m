Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315971AbSGBBd1>; Mon, 1 Jul 2002 21:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316569AbSGBBd0>; Mon, 1 Jul 2002 21:33:26 -0400
Received: from OL65-148.fibertel.com.ar ([24.232.148.65]:48595 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S315971AbSGBBd0>;
	Mon, 1 Jul 2002 21:33:26 -0400
Date: Mon, 1 Jul 2002 22:40:34 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Michael Nguyen <mnguyen@ariodata.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RE2: [OKS] Module removal
Message-ID: <20020701224034.C2295@almesberger.net>
References: <8A098FDFC6EED94B872CA2033711F86F0EC115@orion.ariodata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8A098FDFC6EED94B872CA2033711F86F0EC115@orion.ariodata.com>; from mnguyen@ariodata.com on Mon, Jul 01, 2002 at 01:21:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Nguyen wrote:
> I saw this mail flashes thru the reflector. It is worrying to know
> that this great feature is on the discussion table for removal.

One work-around that was suggested was to allow modules to be
superseded, i.e. the old module stays forever, but a new
version can be loaded in parallel. I must say that I'm very
sceptic about this idea, as it seems likely to just mask more
severe problems.

If I remember right, the main arguments why module removal can
race with references were:

 - buggy modules that don't even know themselves if they still
   serve a purpose or not (solution: fix 'em)
 - likewise, but with the excuse that correctness was
   sacrificed on the altar of performance
 - references getting copied without the module knowing. Looks
   like a problem in the subsystem managing the references.
   (This was discussed mainly in the context of automating
   reference tracking.)
 - removal happening immediately after module usage count is
   decremented to zero may unload module before module has
   executed "return" instruction

While I can accept the theoretical possibility that some code
may indeed not be able to afford handling the module usage
count, I kind of doubt that such conditions exist in real life.

For the removal-before-return problem, I thought a bit about it
on my return flight. It would seem to me that an "atomic"
"decrement_module_count_and_return" function would do the trick.

That function would prepare to return from its caller, then
decrement the module count, and finally do the return. That way,
no resources of the caller would be used after the module usage
counter drops to zero. Obviously, any related cleanup would have
to happen before this. Also, you couldn't call
decrement_module_count_and_return from a function that gets
called from another function in the same module.

Not sure if such a solution for removal-before-return has been
considered/rejected yet. It would seem obvious enough.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://icapeople.epfl.ch/almesber/_____________________________________/
