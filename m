Return-Path: <linux-kernel-owner+w=401wt.eu-S1750778AbXACNgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbXACNgq (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 08:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbXACNgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 08:36:46 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:50635 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747AbXACNgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 08:36:45 -0500
Date: Wed, 3 Jan 2007 16:35:12 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>, linux-aio@kvack.org,
       akpm@osdl.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [RFC] Heads up on a series of AIO patchsets
Message-ID: <20070103133512.GA3962@2ka.mipt.ru>
References: <20061227153855.GA25898@in.ibm.com> <20061227162530.GA23000@infradead.org> <20061228114127.GB26314@2ka.mipt.ru> <e9c3a7c20701021338m4c229ef9rf4dbae9f53908e1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <e9c3a7c20701021338m4c229ef9rf4dbae9f53908e1b@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 03 Jan 2007 16:35:20 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 02:38:13PM -0700, Dan Williams (dan.j.williams@intel.com) wrote:
> Would you have time to comment on the approach I have taken to
> implement a standard asynchronous memcpy interface?  It seems it would
> be a good complement to what you are proposing.  The entity that
> describes the aio operation could take advantage of asynchronous
> engines to carry out copies or other transforms (maybe an acrypto tie
> in as well).
> 
> Here is the posting for 2.6.19.  There has since been updates for
> 2.6.20, but the overall approach remains the same.
> intro: http://marc.theaimsgroup.com/?l=linux-raid&m=116491661527161&w=2
> async_tx: http://marc.theaimsgroup.com/?l=linux-raid&m=116491753318175&w=2

My first impression is that it has too many lists :)

Looks good, but IMHO there are steps to implement further.
I have not found there any kind of scheduler - what if system has two
async engines? What if sync engine faster than async in some cases (and
it is indeed the case for small buffers), and should be selected that time?
What if you will want to add additional transformations for some
devices like crypto processing or checksumming?

I would just create a driver for low-level engine, and exported its
functionality - iop3_async_copy(), iop3_async_checksum(), iop3_async_crypto_1(),
iop3_async_crypto_2() and so on.

There will be a lot of potential users of exactly that functionality,
but not stricly hardcoded higher layer operations like raidX.

More generic solution must be used to select appropriate device.
We had a very brief discussion about asynchronous crypto layer (acrypto)
and how its ideas could be used for async dma engines - user should not
even know how his data has been transferred - it calls async_copy(),
which selects appropriate device (and sync copy is just an additional 
usual device in that case) from the list of devices, exported its
functionality, selection can be done in millions of different ways from
getting the fisrt one from the list (this is essentially how your
approach is implemented right now), or using special (including run-time
updated) heueristics (like it is done in acrypto).

Thinking further, async_copy() is just a usual case for async class of
operations. So the same above logic must be applied on this layer too.

But 'layers are the way to design protocols, not implement them'.
	David Miller on netchannels

So, user should not even know about layers - it should just say 'copy
data from pointer A to pointer B', or 'copy data from pointer A to
socket B' or even 'copy it from file "/tmp/file" to "192.168.0.1:80:tcp"',
without ever knowing that there are sockets and/or memcpy() calls,
and if user requests to perform it asynchronously, it must be later
notified (one might expect, that I will prefer to use kevent :)
The same approach thus can be used by NFS/SAMBA/CIFS and other users.

That is how I start to implement AIO (it looks like it becomes popular):
1. system exports set of operations it supports (send, receive, copy,
crypto, ....)
2. each operation has subsequent set of suboptions (different crypto 
types, for example)
3. each operation has set of low-level drivers, which support it (with
optional performance or any other parameters)
4. each driver when loaded publishes its capabilities (async copy with
speed A, XOR and so on)

>From user's point of view its aio_sendfile() or async_copy() will look
following:
1. call aio_schedule_pointer(source='0xaabbccdd', dest='0x123456578')
1. call aio_schedule_file_socket(source='/tmp/file', dest='socket')
1. call aio_schedule_file_addr(source='/tmp/file',
dest='192.168.0.1:80:tcp')

or any other similar call

then wait for received descriptor in kevent_get_events() or provide own
cookie in each call.

Each request is then converted into FIFO of smaller request like 'open file',
'open socket', 'get in user pages' and so on, each of which should be
handled on appropriate device (hardware or software), completeness of
each request starts procesing of the next one.

Reading microthreading design notes I recall comparison of the NPTL and
Erlang threading models on Debian site - they are _completely_ different 
models, NPTL creates real threads, which is supposed (I hope NOT) 
to be implemented in microthreading design too. It is slow. 
(Or is it not, Zach, we are intrigued :)
It's damn bloody slow to create a thread compared to the correct non-blocking 
state machine. TUX state machine is similar to what I had in my first kevent 
based FS and network AIO patchset, and what I will use for current async 
processing work.


A bit of empty words actually, but it can provide some food for
thoughts.

> Regards,
> 
> Dan

-- 
	Evgeniy Polyakov
