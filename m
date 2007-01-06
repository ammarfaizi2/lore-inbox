Return-Path: <linux-kernel-owner+w=401wt.eu-S1751068AbXAFBgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbXAFBgm (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 20:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbXAFBgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 20:36:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:61490 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbXAFBgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 20:36:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=QO/7RLZlCCWhaPy8BjF9L4Yrb6issmDo8tsNIcrBwL6E6eWcpxtL4qke9WZ8LrkgYTzw/sdVO53o0d50gi0RdCz5C/WjffdvEdQqh/fIclMlQTzJnt0oGpP9kkGjuGfu/f2PHmPVvR4N4nxfaWWhOzuLtOkfgrmkYCgcRtSHfwQ=
Message-ID: <e9c3a7c20701051736i113772aby31ccb34f231633a0@mail.gmail.com>
Date: Fri, 5 Jan 2007 18:36:39 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: asynchronous memory transfer/transform api(s) (was: Re: [RFC] Heads up on a series of AIO patchsets)
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: df1d2be7f51cde63
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ trimmed the cc to just linux-kernel ]
On 1/3/07, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> On Tue, Jan 02, 2007 at 02:38:13PM -0700, Dan Williams (dan.j.williams@intel.com) wrote:
> > Would you have time to comment on the approach I have taken to
> > implement a standard asynchronous memcpy interface?  It seems it would
> > be a good complement to what you are proposing.  The entity that
> > describes the aio operation could take advantage of asynchronous
> > engines to carry out copies or other transforms (maybe an acrypto tie
> > in as well).
> >
> > Here is the posting for 2.6.19.  There has since been updates for
> > 2.6.20, but the overall approach remains the same.
> > intro: http://marc.theaimsgroup.com/?l=linux-raid&m=116491661527161&w=2
> > async_tx: http://marc.theaimsgroup.com/?l=linux-raid&m=116491753318175&w=2
>
> My first impression is that it has too many lists :)
>
Ok, I think I can cut this down if I use static allocations for the
software descriptors.

> Looks good, but IMHO there are steps to implement further.
> I have not found there any kind of scheduler - what if system has two
> async engines?
It supports multiple engines (the iop341 has three), but it only does
a simple round robin for load balancing.  I'll look to acrypto for
other load balancing schemes, at the same time I am concerned about
cpu overhead of a scheduling algorithm.

> What if sync engine faster than async in some cases (and
> it is indeed the case for small buffers), and should be selected that time?
Yes I need to profile for this and make it tunable.

> What if you will want to add additional transformations for some
> devices like crypto processing or checksumming?
>
It would be nice to use an async_tx-style engine to handle the xor and
GF multiply portions of a crypto algorithm, but how do we handle the
case when an acrypto-style engine is available to handle the entire
algorithm from end-to-end?  It seems like there would need to be a
third layer to hide this distinction from application code, but as
quoted below maybe a layer is not the right way to go...

>
> I would just create a driver for low-level engine, and exported its
> functionality - iop3_async_copy(), iop3_async_checksum(), iop3_async_crypto_1(),
> iop3_async_crypto_2() and so on.
>
> There will be a lot of potential users of exactly that functionality,
> but not stricly hardcoded higher layer operations like raidX.
>
This is the goal of the async_tx layer, it provides (currently)
async_memcpy, async_memset, async_xor and async_xor_zero_sum.  The
iop-adma driver exposes iop_adma_prep_dma_memcpy,
iop_adma_prep_dma_xor etc... for async_tx to consume.

> More generic solution must be used to select appropriate device.
> We had a very brief discussion about asynchronous crypto layer (acrypto)
> and how its ideas could be used for async dma engines - user should not
> even know how his data has been transferred - it calls async_copy(),
> which selects appropriate device (and sync copy is just an additional
> usual device in that case) from the list of devices, exported its
> functionality, selection can be done in millions of different ways from
> getting the fisrt one from the list (this is essentially how your
> approach is implemented right now), or using special (including run-time
> updated) heueristics (like it is done in acrypto).
>
async_memcpy makes an attempt at transparent fallback but currently
assumes that an engine is always faster.

> Thinking further, async_copy() is just a usual case for async class of
> operations. So the same above logic must be applied on this layer too.
>
> But 'layers are the way to design protocols, not implement them'.
>         David Miller on netchannels
>
> So, user should not even know about layers - it should just say 'copy
> data from pointer A to pointer B', or 'copy data from pointer A to
> socket B' or even 'copy it from file "/tmp/file" to "192.168.0.1:80:tcp"',
> without ever knowing that there are sockets and/or memcpy() calls,
> and if user requests to perform it asynchronously, it must be later
> notified (one might expect, that I will prefer to use kevent :)
> The same approach thus can be used by NFS/SAMBA/CIFS and other users.
>
> That is how I start to implement AIO (it looks like it becomes popular):
> 1. system exports set of operations it supports (send, receive, copy,
> crypto, ....)
> 2. each operation has subsequent set of suboptions (different crypto
> types, for example)
> 3. each operation has set of low-level drivers, which support it (with
> optional performance or any other parameters)
> 4. each driver when loaded publishes its capabilities (async copy with
> speed A, XOR and so on)
>
The only problem with engines is that they are problematic to use on
userspace buffers (on non-coherent architectures).

> From user's point of view its aio_sendfile() or async_copy() will look
> following:
> 1. call aio_schedule_pointer(source='0xaabbccdd', dest='0x123456578')
> 1. call aio_schedule_file_socket(source='/tmp/file', dest='socket')
> 1. call aio_schedule_file_addr(source='/tmp/file',
> dest='192.168.0.1:80:tcp')
>
> or any other similar call
>
> then wait for received descriptor in kevent_get_events() or provide own
> cookie in each call.
>
> Each request is then converted into FIFO of smaller request like 'open file',
> 'open socket', 'get in user pages' and so on, each of which should be
> handled on appropriate device (hardware or software), completeness of
> each request starts procesing of the next one.
>
> Reading microthreading design notes I recall comparison of the NPTL and
> Erlang threading models on Debian site - they are _completely_ different
> models, NPTL creates real threads, which is supposed (I hope NOT)
> to be implemented in microthreading design too. It is slow.
> (Or is it not, Zach, we are intrigued :)
> It's damn bloody slow to create a thread compared to the correct non-blocking
> state machine. TUX state machine is similar to what I had in my first kevent
> based FS and network AIO patchset, and what I will use for current async
> processing work.
>
>
> A bit of empty words actually, but it can provide some food for
> thoughts.
>
Not at all, thank you for taking a look at the code.
> --
>         Evgeniy Polyakov
>
> --
Dan
