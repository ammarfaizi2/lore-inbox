Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbVANWKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVANWKh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 17:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVANWKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 17:10:37 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:19885 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S262186AbVANWJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 17:09:19 -0500
Date: Sat, 15 Jan 2005 01:31:03 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Cc: Michal Ludvig <michal@logix.cz>, Fruhwirth Clemens <clemens@endorphin.org>,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       cryptoapi@lists.logix.cz, "David S. Miller" <davem@davemloft.net>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Fw: [PATCH 1/2] CryptoAPI: prepare for processing multiple buffers
 at a time
Message-ID: <20050115013103.05698f1a@zanzibar.2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Size was too big for mail lists, sorry.
Splitted to several messages.

Begin forwarded message:

Date: Fri, 14 Jan 2005 23:43:56 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Michal Ludvig <michal@logix.cz>
Cc: Fruhwirth Clemens <clemens@endorphin.org>, Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>, cryptoapi@lists.logix.cz, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] CryptoAPI: prepare for processing multiple buffers at a time


On Fri, 14 Jan 2005 17:40:39 +0100 (CET)
Michal Ludvig <michal@logix.cz> wrote:

> On Fri, 14 Jan 2005, Fruhwirth Clemens wrote:
> 
> > On Fri, 2005-01-14 at 14:10 +0100, Michal Ludvig wrote:
> > 
> > > This patch extends crypto/cipher.c for offloading the whole chaining modes
> > > to e.g. hardware crypto accelerators. It is much faster to let the 
> > > hardware do all the chaining if it can do so.
> > 
> > Is there any connection to Evgeniy Polyakov's acrypto work? It appears,
> > that there are two project for one objective. Would be nice to see both
> > parties pulling on one string.
> 
> These projects do not compete at all. Evgeniy's work is a complete 
> replacement for current cryptoapi and brings the asynchronous 
> operations at the first place. My patches are simple and straightforward 
> extensions to current cryptoapi that enable offloading the chaining to 
> hardware where possible.

Actualy acrypto genetically allows to use such hardware acceleration.
I do not call it a feature but a logical consequence from design.
When hardware has access to the queue of requests it can do anything
it wants to properly complete it's sessions. 
For example use hardware accelerated block chaining encryption...

Probably it is time to show the work.

Attached files:
bd archive - simple in-mamory block device used for test. I currently work 
	on creating modular loop device replacement based on bd, which could allow
	network block device to be removed(btw, it is broken at least in 2.6.9)
	and also allow acrypto module to be used with various tweakable ciphers.
	I hope that system will provide more flexible control over dataflow
	than loop device currently does.
	I recomend following  interesting reading about tweaking ciphers: 
	http://clemens.endorphin.org/cryptography

acrypto archive - asynchronous crypto layer, the latest(third) reincarnation(announce below).
	It also has asynchronous and synchronous test crypto providers and test crypto
	consumer module.

hifn archive - driver for HIFN 7955/7956 (7956 was not run on Clemens' setup,
	hopefully patches sent to him fixed that).
	This is work in progress and currently works only on low load 
	(about one session per 10 msec).

via-padlock - patch to enable xcrypt instructions on various VIA CPUs (for example Nehemiah family).
	It is totally Michal's work, I've just ported it to acrypto.
	Not tested.

fcrypt - driver for CE-InfoSys FastCrypt PCI card equipped with a SuperCrypt CE99C003B chip that 
	can offload DES and 3DES encryption from the CPU.
	It is totally Michal's work too, I've just ported it to acrypto.
	Not tested.

fcrypt and via-padlock can be found at Michal's Ludvig page: http://www.logix.cz

Btw, I've made several changes in acrypto for proper multi scatterlist processing,
so above drivers will not compile clearly, but I suspect noone will apply it today,
so it is currently for examination, 
I will fix them all after finish relaxing after vocations.


I've added disk write emulation into async and sync crypto providers, and what do we see:
actual disk write speed is about 46 kb/msec, encryption speed is about 68 kb/msec. 
Encryption of one byte takes ~0.014 usec, disk writing thus will take ~0.014/46*68 = 0.019 usec.
With such delay I've gotten following numbers on 4-way system:
scaled to 4 processors async_provider: 800 Mb in 12.6376 sec.
scaled to 1 processor async_provider: 800 Mb in 12.1828 sec.
sync_provider: 800 Mb in 13.5662 sec.
Actually the former two tests with async_provider show 
the same values in average when running several times. 

Thus about 10% even on one CPU(strange).

I posted several times acrypto with userspace support(both direct vma/page 
access and ioctl based one) to netdev@oss.sgi.com, but probably due 
to message size(only acrypto patch is about 120K) it was not appeared there.

Please test and comment.

Here is an annonce:

 Acrypto - asynchronous crypto layer for linux kernel 2.6

I'm pleased to announce asynchronous crypto layer for Linux kernel 2.6.
It supports following features:
- multiple asynchronous crypto device queues
- crypto session routing
- crypto session binding
- modular load balancing
- crypto session batching genetically implemented by design
- crypto session priority
- different kinds of crypto operation(RNG, asymmetrical crypto, HMAC and any other)

Some design notes:
acrypto has one main crypto session queue(double linked list, probably it should 
be done like crypto_route or sk_buff queue), into which each newly allocated session 
is inserted and this is a place where load balancing searches it's food. When new 
session is being prepared for insertion it calls load balancer's ->find_device() method, 
which should return suitable device(current simple_lb load balancer returns device with 
the lowest load(device has the least number of session in it's queue)) if it exists. 
After crypto_device being returned acrypto creates new crypto routing entry which points 
to returned device and adds it to crypto session routing queue. Crypto session is being
 inserted into device's queue according to it's priority and it is crypto device driver 
that should process it's session list according to session's priority.

All insertion and deletion are guarded by appropriate locks, but session_list traversing 
is not guarded in crypto_lb_thread() since session can be removed _only_ from that 
function by design, so if crypto device (atomically) marks session as completed and 
not being processed and use list_for_each_safe() for traversing it's queue all should be OK.

Each crypto load balancer must implement 2 methods:
->rehash() and ->find_device() which will be called from any context and under spinlock.
->rehash() method should be called to remix crypto sessions in device's queues, 
for example if driver decides that it's device is broken it marks itself as broken 
and load balancer(or scheduler if you like) should remove all sessions from this 
queue to some other devices. If session can not be completed scheduler must mark 
it as broken and complete it(by calling first broke_session() and then complete_session() 
and stop_process_session()). Consumer must check if operation was successful
(and therefore session is not broken).
->find_device() method should return appropriate crypto device.

For crypto session to be successfully allocated crypto consumer must provide two structures - 
struct crypto_session_initializer (hmm, why only one z?) and struct crypto_data. 
struct crypto_session_initializer contains data needed to find appropriate device, like 
type of operation, mode of operation, some flags(for example SESSION_BINDED, which means 
that session must be bound to specified in bdev field crypto device, it is useful for TCPA/TPM), 
session priority and callback which will be called after all routing for given session are finished.
struct crypto_data contains scatterlists for src, dst, key and iv. It also has void *priv 
field and it's size which is allocated and may be used by any crypto agent(for example VIA 
PadLock driver uses it to store aes_ctx field, crypto_session can use this field to store 
some pointers needed in ->callback()).
Actually callback will be called from queue_work, but I suppose it is better to not assume 
calling context.
->callback() will be called after all crypto routing for given session are done with the 
same parameters as were provided in initialisation time(if session has only one routing 
callback will be called with original parameters, but if it has several routes callback 
will be called with parameters from the latest processed one). I believe crypto callback 
should not know about crypto sessions, routings, device and so on, proper restriction is 
always a good idea.

Crypto routing.
This feature allows the same session to be processed by several devices/algorithms. 
For example if you need to encrypt data and then sign it in TPM device you can create 
one route to encryption device and then route it to TPM device. (Note: this feature 
must be discussed since there is no time slice after session allocation, only in 
crypto_device->data_ready() method and there are locking issues in ->callback() method).

Crypto device.
It can be either software emulator or hardware accelerator chip(like HIFN 79*/83* or 
Via PadLock ACE/RNG, or even TPM device like each IBM ThinkPad or some HP laptops have 
(gentle hint: _they_ even have a _windows_ software for them, HP gimme specs :) )). 
It can be registered with asynchronous crypto layer and must provide some data for it:
->data_ready() method - it is called each time new session is added to device's queue.
Array of struct crypto_capability and it's amount - struct crypto_capability describes 
each operation given device can handle, and has a maximum session queue length parameter. 
Note: this structure can [be extended to] include "rate" parameter to show absolute speed 
of given operation in some units, which therefore can be used by scheduler(load balancer) 
for proper device selection. Actually queue length can somehow reflects device's "speed".

Acrypto has full userspace support through ioctl and direct process' vmas and pages access. 
It is done using ioctl() with 2 copyings from+to userspace data.
Session processing contains of 3 major parts:
1. Session creation. CRYPTO_SESSION_ALLOC ioctl.
User must provide special structure which has src, dst, key and iv data sizes and crypto 
initializer(crypto operation, mode, type and priority).
2. Data filling. User must call several CRYPTO_FILL_DATA ioctls.
Each one requires data size and data type(structure crypto_user_data) and data itself.
3. Finish. User must call CRYPTO_SESSION_ADD ioctl with pointer to the are whre crypting 
result must be stored.
The latter ioctl will sleep while session is being processed.

Second userspace communication mechanism is based on direct access to the process' vmas 
and pages from acrypto, pointers are transferred using special kernel connector structure.
Obviously it can not be used with the most hardware and sizes more than one page, but 
I like the idea itself.

Some discussion can be found at http://marc.theaimsgroup.com/?l=linux-netdev&m=109903101312733&w=2


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt

