Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264680AbTDYA2f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 20:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264682AbTDYA2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 20:28:34 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:26566 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id S264680AbTDYA23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 20:28:29 -0400
Message-Id: <5.1.0.14.2.20030424170208.102ee6c8@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 24 Apr 2003 17:40:28 -0700
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [BK ChangeSet@1.1118.1.1] new module infrastructure for
  net_proto_family
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20030424230202.GB2931@conectiva.com.br>
References: <5.1.0.14.2.20030424094431.080b5320@unixmail.qualcomm.com>
 <5.1.0.14.2.20030423134636.100e5c60@unixmail.qualcomm.com>
 <5.1.0.14.2.20030423114915.10840678@unixmail.qualcomm.com>
 <5.1.0.14.2.20030423114915.10840678@unixmail.qualcomm.com>
 <5.1.0.14.2.20030423134636.100e5c60@unixmail.qualcomm.com>
 <5.1.0.14.2.20030424094431.080b5320@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:02 PM 4/24/2003, Arnaldo Carvalho de Melo wrote:
>Em Thu, Apr 24, 2003 at 12:33:35PM -0700, Max Krasnyansky escreveu:
>> Hi Arnaldo,
>> 
>> >I did, there are several valid points, I forgot the sys_accept case, I'm
>> >studying the code to see how to properly fix it,
>
>> It's pretty easy if we have sock->owner. Take a look how my patch does it 
>> (try_module_get should be replaced with __module_get()).
>> It also covers the case when net_family_owner transferred ownership to the
>> other module.
>
>Yes, this gives us more flexibility, but as well some more overhead in the
>common struct sock, I have worked in 2.5 to reduce its size, and want to
>reduce it further, if possible. 
Easy.
struct sock {
        ...
        struct sock             *next;
        struct sock             **pprev;
        struct sock             *bind_next;
        struct sock             **bind_pprev;
        struct sock             *prev;

At least one of the prev can go.

>> >Think about protecting the module with the top level network protocol family
>> >->create code on sock_create level and the modules with specific protocols at
>> ><net_proto_family>_sock_create level.
>
>> With the current infrastructure you'd need some kind of callback from
>> sk_free() for that to work.  I think it's simpler with sk->owner.
>
>not a callback, it'd be in sk_free itself (talking from the top of my head,
>just arrived home and will be further studying this now), I pretty much want to
>have protocol family maintainers not worrying about module refcounting at all
>in the default case of no further modularisation per specific prococol, that
>would save, for instance, Steven Whitehouse some work on DecNET :)

sk_free() doesn't know which module owns the socket in 
"net_proto_family owner != socket owner" case. 

BTW Let's call that case "NOnSO" I'm referring to it way too often :)

>> Sure. Transfer of the ownership has to be done on that level. What I'm saying
>> is that everything else can be done in generic code. 
>
>So we're in agreement on having most of this infrastructure in generic code :)
I guess so :). But haven't seen a generic solution for the NOnSO from you yet ;-). 

>> struct socket uses net_proto_family ops and stuff and therefor is related.
>> But struct sock is just a callbacks.
>
>But I want to avoid having another thing to worry about for net protocol
>family writers, i.e. not having to add a sk_set_owner if one decides it has
>to change one of the default callbacks.
Well, that means that refcounting overhead will affect even the protocols that 
don't have to keep track of 'struct sock'. It also means that those protocols 
will not unloadable until all sk's are killed. Even though sk's have no references 
whatsoever to the module that created them. 

>> Let's just get rid of the net_family_get/put thing. Each socket will have
>> owner field so we know who owns it and there is no need to access global
>> net_family table.
>
>I'm trying to avoid adding a pointer to struct sock, if it is not possible
>at all to avoid, ok, we do it, but I think we can have this at just one
>place, the net_family table.
Killing one of the list pointers from 'struct sock' shouldn't be a problem (see above). 

One net_family table won't handle NOnSO. Even if it will, protocol writers will have to 
worry about proper initialization of the tables anyway. Especially if someone comes up 
with something like:
        Family X (module X.ko)
                Proto X1 (module X1.ko)
                        Subproto X1-A (module X1-A.ko)
not that it makes a lot of sense right now but why restrict it if we don't have to. 

>> void sk_set_owner(struct module *owner)
>> {
>>         /* Module must already hold reference when it call this function. */
>>         __module_get(owner);
>>         sk->owner = owner;
>> }
>
>This is the additional rule I'm trying to avoid.

It's not a big deal rule. All protocols do hold reference when they allocate sk.

>> sk_free()
>>         ...
>>         module_put(sk->owner);
>>         ...
>
>this is already in BK tree.
No. I mean NOnSO ;-). 
What's in BK is net_family_put(family) which is by no means the same.

>> >>>        IPv4/6 - Private cache, non-default callbacks.
>> >>>                Must call sk_set_owner() (cannot be a module, so we don't really care)
>
>Well, I care, I wish to have this as a module at some point, if allowed by
>DaveM, of course 8)
If I remember correctly DaveM was one of those are strongly against that.

Max

