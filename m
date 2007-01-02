Return-Path: <linux-kernel-owner+w=401wt.eu-S1754975AbXABViS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754975AbXABViS (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755416AbXABViR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:38:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:27482 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975AbXABViP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:38:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=TxEu+W5s2ebZeOmeHABKtAapUSJ17GeAgLXge7403Xq5QQm8knhA5LBvec78gciWUHH8FjL7E1TnUpjX+nql0XC7t+5+1x18wVsGtiDK5eaf8E5gQelcgnufypglFThSxbsnU1RcPxYQMCX8g3YLjfBxA60Nfbc3jTTjy0d5SqE=
Message-ID: <e9c3a7c20701021338m4c229ef9rf4dbae9f53908e1b@mail.gmail.com>
Date: Tue, 2 Jan 2007 14:38:13 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: Re: [RFC] Heads up on a series of AIO patchsets
Cc: "Christoph Hellwig" <hch@infradead.org>,
       "Suparna Bhattacharya" <suparna@in.ibm.com>, linux-aio@kvack.org,
       akpm@osdl.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu
In-Reply-To: <20061228114127.GB26314@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061227153855.GA25898@in.ibm.com>
	 <20061227162530.GA23000@infradead.org>
	 <20061228114127.GB26314@2ka.mipt.ru>
X-Google-Sender-Auth: 227495929d2f8266
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> [ I'm only subscribed to linux-fsdevel@ from above Cc list, please keep this
> list in Cc: for AIO related stuff. ]
>
> On Wed, Dec 27, 2006 at 04:25:30PM +0000, Christoph Hellwig (hch@infradead.org) wrote:
> > (1) note that there is another problem with the current kevent interface,
> >       and that is that it duplicates the event infrastructure for it's
> >       underlying subsystems instead of reusing existing code (e.g.
> >       inotify, epoll, dio-aio).  If we want kevent to be _the_ unified
> >       event system for Linux we need people to help out with straightening
> >       out these even provides as Evgeny seems to be unwilling/unable to
> >       do the work himself and the duplication is simply not acceptable.
>
> I would rewrite inotify/epoll to use kevent, but I would strongly prefer
> that it would be done by peopl who created original interfaces - it is
> politic decision, not techinical - I do not want to be blamed on each
> corner that I killed other people work :)
>
> FS and network AIO kevent based stuff was dropped from kevent tree in
> favour of upcoming project (description below).
>
> According do AIO - my personal opinion is that AIO should be designed
> asynchronously in all aspects. Here is brief note on how I plan to
> iplement it (I plan to start in about a week after New Year vacations).
>
> ===
>
> All existing AIO - both mainline and kevent based lack major feature -
> they are not fully asyncronous, i.e. they require synchronous set of
> steps, some of which can be asynchronous. For example aio_sendfile() [1]
> requires open of the file descriptor and only then aio_sendfile() call.
> The same applies to mainline AIO and read/write calls.
>
> My idea is to create real asyncronous IO - i.e. some entity which will
> describe set of tasks which should be performed asynchronously (from
> user point of view, although read and write obviously must be done after
> open and before close), for example syscall which gets as parameter
> destination socket and local filename (with optional offset and length
> fields), which will asynchronously from user point of view open a file
> and transfer requested part to the destination socket and then return
> opened file descriptor (or it can be closed if requested). Similar
> mechanism can be done for read/write calls.
>
> This approach as long as asynchronous IO at all requires access to user
> memory from kernels thread or even interrupt handler (that is where
> kevent based AIO completes its requests) - it can be done in the way
> similar to how existing kevent ring buffer implementation and also can
> use dedicated kernel thread or workqueue to copy data into process
> memory.
>
Would you have time to comment on the approach I have taken to
implement a standard asynchronous memcpy interface?  It seems it would
be a good complement to what you are proposing.  The entity that
describes the aio operation could take advantage of asynchronous
engines to carry out copies or other transforms (maybe an acrypto tie
in as well).

Here is the posting for 2.6.19.  There has since been updates for
2.6.20, but the overall approach remains the same.
intro: http://marc.theaimsgroup.com/?l=linux-raid&m=116491661527161&w=2
async_tx: http://marc.theaimsgroup.com/?l=linux-raid&m=116491753318175&w=2

Regards,

Dan
