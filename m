Return-Path: <linux-kernel-owner+w=401wt.eu-S1751546AbXALAgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbXALAgq (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 19:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbXALAgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 19:36:46 -0500
Received: from smtp.osdl.org ([65.172.181.24]:47571 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751546AbXALAgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 19:36:45 -0500
Date: Thu, 11 Jan 2007 16:36:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH/RFC 2.6.20-rc4 1/1] fbdev,mm: hecuba/E-Ink fbdev driver
Message-Id: <20070111163629.b3cfea0c.akpm@osdl.org>
In-Reply-To: <45a44e480701111622i32fffddcn3b4270d539620743@mail.gmail.com>
References: <20070111142427.GA1668@localhost>
	<20070111133759.d17730a4.akpm@osdl.org>
	<45a44e480701111622i32fffddcn3b4270d539620743@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007 19:22:45 -0500
"Jaya Kumar" <jayakumar.lkml@gmail.com> wrote:

> On 1/11/07, Andrew Morton <akpm@osdl.org> wrote:
> > That's all very interesting.
> >
> > Please don't dump a bunch of new implementation concepts like this on us
> > with no description of what it does, why it does it and why it does it in
> > this particular manner.
> 
> Hi Andrew,
> 
> Actually, I didn't dump without description. :-) I had posted an RFC
> and an explanation of the design to the lists. Here's an archive link
> to that post. http://marc.theaimsgroup.com/?l=linux-kernel&m=116583546411423&w=2
> I wasn't sure whether to include that description with the patch email
> because it was long.

Yes, please always include the full description as an integral part of the
patch.  In fact, it's very often best to communicate this information
permanently, via code comments.

> >From that email:
> ---
> This is there in order to hide the latency
> associated with updating the display (500ms to 800ms). The method used
> is to fake a framebuffer in memory. Then use pagefaults followed by delayed
> unmaping and only then do the actual framebuffer update. To explain this
> better, the usage scenario is like this:
> 
> - userspace app like Xfbdev mmaps framebuffer
> - driver handles and sets up nopage and page_mkwrite handlers
> - app tries to write to mmaped vaddress
> - get pagefault and reaches driver's nopage handler
> - driver's nopage handler finds and returns physical page ( no
>   actual framebuffer )
> - write so get page_mkwrite where we add this page to a list
> - also schedules a workqueue task to be run after a delay
> - app continues writing to that page with no additional cost
> - the workqueue task comes in and unmaps the pages on the list, then
>   completes the work associated with updating the framebuffer
> - app tries to write to the address (that has now been unmapped)
> - get pagefault and the above sequence occurs again
> 
> The desire is roughly to allow bursty framebuffer writes to occur.
> Then after some time when hopefully things have gone quiet, we go and
> really update the framebuffer. For this type of nonvolatile high latency
> display, the desired image is the final image rather than intermediate
> stages which is why it's okay to not update for each write that is
> occuring.

OK, makes sense.  The whole idea is neat.

> 
> >
> > What is the "theory of operation" here?
> >
> > Presumably this is a performance optimisation to permit batching of the
> > copying from user memory into the frambuffer card?  If so, how much
> > performance does it gain?
> 
> Yes, you are right. Updating the E-Ink display currently requires
> about 500ms - 800ms. It is a non-volatile display and as such it is
> typically used in a manner where only the final image is important. As
> a result, being able to avoid the bursts of IO associated with screen
> activity and only write the final result is attractive.
> 
> I have not done any performance benchmarks. I'm not sure exactly what
> to compare. I imagine in one case would be using write() to deliver
> the image updates and the other case would be mmap(), memcpy(). The
> latter would win because it's hiding all the intermediate "writes".
> 
> >
> > I expect the benefit will be large, and could be increased if you were to
> > add a small delay between first-touch and writeback to the display.  Let's
> > talk about that a bit.
> 
> Agreed. Though I may be misunderstanding what you mean by first-touch.

First modification - when the page goes from clean to dirty (and
page_mkwrite gets called)

> Currently, I do a schedule_delayed_work and leave 1s between when the
> page_mkwrite callback indicating the first touch is received and when
> the deferred IO is processed to actually deliver the data to the
> display.

oh, doh - I missed the fact that you're already adding a delay.

> I picked 1s because it rounds up the display latency. I
> imagine increasing the delay further may make it miss some desirable
> display activity. For example, a slider indicating progress of music
> may be slower than optimal. Perhaps I should make the delay a module
> parameter and leave the choice to the user?

Don't know - your call.

It would be interesting to know if this trick is applicable to any other
framebuffer drivers.

> >
> > Is the optimisation applicable to other drivers?  If so, should it be
> > generalised into library code somewhere?
> 
> I think the deferred IO code would be useful to devices that have slow
> updates and where only the final result is important. So far, this is
> the only device I've encountered that has this characteristic.

OK.

> >
> > I guess the export of page_mkclean() makes sense for this application.
> >
> > The use of lock_page_nosync() is wrong.  It can still sleep, and here it's
> > inside spinlock.  And we don't want to export __lock_page_nosync() to
> > modules.  I suggest you convert the list locking here to a mutex and use
> > lock_page().
> >
> 
> Oops, sorry about that. I will correct it.

Thanks.  Consider adding a nice long "Overview of operation" comment in
there too.

