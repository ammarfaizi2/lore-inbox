Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVCGVQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVCGVQn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 16:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVCGVPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 16:15:45 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:17330 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261821AbVCGUNk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:13:40 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [0/many] Acrypto - asynchronous crypto layer for linux kernel 2.6
In-Reply-To: 
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:32 +0300
Message-Id: <11102278521318@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I'm pleased to announce asynchronous crypto layer for Linux kernel 2.6.
It supports following features:
- multiple asynchronous crypto device queues
- crypto session routing
- crypto session binding
- modular load balancing
- crypto session batching genetically implemented by design
- crypto session priority
- different kinds of crypto operation(RNG, asymmetrical crypto, HMAC and
any other)

Some design notes:
acrypto has one main crypto session queue, into which each
newly allocated session is inserted and this is a place where load
balancing searches it's food. When new session is being prepared for
insertion it calls load balancer's ->find_device() method, which should
return suitable device(current simple_lb load balancer returns device
with the lowest load(device has the least number of session in it's
queue)) if it exists. After crypto_device being returned acrypto creates
new crypto routing entry which points to returned device and adds it to
crypto session routing queue. Crypto session is being inserted into
device's queue according to it's priority and it is crypto device driver
that should process it's session list according to session's priority.

Each crypto load balancer must implement 2 methods: 
->rehash() and ->find_device() which may be called from any context and
under spinlock.
->rehash() method should be called to remix crypto sessions in device's
queues, for example if driver decides that it's device is broken it
marks itself as broken and load balancer(or scheduler if you like)
should remove all sessions from this queue to some other devices. 
If session can not be completed scheduler must mark it as broken and
complete it(by calling first broke_session() and then complete_session()
and stop_process_session()). Consumer must check if operation was
successful(and therefore session is not broken).
->find_device() method should return appropriate crypto device.
Since load balancers may be loaded and unloaded without any restriction,
one may create it's own crypto load balancers, which may use
crpypto session's (crypto_data) private area to select appropriate device,
for example, one may store process' pid in private area and write it's own
crypto load balancer which will select private crypto device for given PID,
and the rest of the cypto system to process other requests.

For crypto session to be successfully allocated crypto consumer must
provide two structures - struct crypto_session_initializer and struct crypto_data.
struct crypto_session_initializer contains data needed to find
appropriate device, like type of operation, mode of operation, some
flags(for example SESSION_BINDED, which means that session must be bound
to specified in bdev field crypto device, it is useful for TCPA/TPM),
session priority and callback which will be called after all routing for
given session are finished.
struct crypto_data contains scatterlists for src, dst, key and iv.
It also has void *priv field and it's size which is allocated and may be
used by any crypto agent(for example VIA PadLock driver uses it to store
aes_ctx field, crypto_session can use this field to store some pointers
needed in ->callback()).
Actually callback will be called from work queue context, but I suppose it is
better to not assume calling context.
->callback() will be called after all crypto routing for given session
are done with the same parameters as were provided in initialisation
time(if session has only one routing callback will be called with
original parameters, but if it has several routes callback will be
called with parameters from the latest processed one). I believe crypto
callback should not know about crypto sessions, routings, device and so
on, proper restriction is always a good idea.

Crypto routing.
This feature allows the same session to be processed by several
devices/algorithms. For example if you need to encrypt data and then
sign it in TPM device you can create one route to encryption device and
then route it to TPM device, or this can be used for tweakable cipher
encryption without 2-atomic-maps restriction.

Crypto device.
It can be either software emulator or hardware accelerator chip(like
HIFN 79*/83* or Via PadLock ACE/RNG, or even TPM device like each IBM
ThinkPad or some HP laptops have.
It can be registered with asynchronous crypto layer and must provide
some data for it:
->data_ready() method - it is called each time new session is added to
device's queue.
Array of struct crypto_capability and it's amount - 
struct crypto_capability describes each operation given device can
handle, and has a maximum session queue length parameter.
Note: this structure can [be extended to] include "rate" parameter to
show absolute speed of given operation in some units, which therefore
can be used by scheduler(load balancer) for proper device selection.
Actually queue length can somehow reflects device's "speed".
Note2: it can be calculated using ptime parameter of the session initializer - 
it is time given session was processed in crypto device.

Acrypto has full userspace support through ioctl and direct process' vmas and pages access.
It is done using ioctl() with 2 copyings from+to userspace data.
Session processing contains of 3 major parts:
1. Session creation. CRYPTO_SESSION_ALLOC ioctl.
User must provide special structure which has src, dst, key and iv data sizes 
and crypto initializer(crypto operation, mode, type and priority).
2. Data filling. User must call several CRYPTO_FILL_DATA ioctls.
Each one requires data size and data type(structure crypto_user_data) and data itself.
3. Finish. User must call CRYPTO_SESSION_ADD ioctl with pointer to the are whre crypting result must be stored.
The latter ioctl will sleep while session is being processed.

Second userspace communication mechanism is based on direct access to the process' 
vmas and pages from acrypto, pointers are transferred using special kernel connector structure.
Obviously it can not be used with the most hardware, but I like the idea itself.

Currently supported HIFN 7955(small load testing), via padlock driver(not tested), 
driver for CE-InfoSys FastCrypt PCI card equipped with a SuperCrypt CE99C003B chip(not tested).

