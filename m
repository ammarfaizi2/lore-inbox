Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWBTOKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWBTOKf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbWBTOKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:10:34 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:55444 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964807AbWBTOKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:10:34 -0500
Message-ID: <43F9CE1C.2020603@sw.ru>
Date: Mon, 20 Feb 2006 17:11:40 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg <gkurz@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the process
 id namespace
References: <m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com> <m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com> <m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru> <m1psluw1jj.fsf@ebiederm.dsl.xmission.com> <43F04FD6.5090603@sw.ru> <m1wtfytri1.fsf@ebiederm.dsl.xmission.com> <43F31972.3030902@sw.ru> <20060215133131.GD28677@MAIL.13thfloor.at> <43F9A80A.6050808@sw.ru> <20060220123427.GA17478@MAIL.13thfloor.at>
In-Reply-To: <20060220123427.GA17478@MAIL.13thfloor.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>I would disagree with you. These discussions IMHO led us to the wrong
>>direction.
>>
>>Can I ask a bunch of questions which are related to other
>>virtualization issues, but which are not addressed by Eric anyhow?
>>
>>- How are you planning to make hierarchical namespaces for such 
>>  resources as IPC? Sockets? Unix sockets?
> 
> in the same way as for resources or filesystems -
> management is within the parent, usage within the
> child
So taking example with IPC, you propose the following:
- parent is able to setup limits on segments, sizes, messages etc.
- parent doesn't see child objects itself, i.e. it is unable to share 
segments with a child, send messages to child etc.
Am I correct?

Provided I got it correctly, how does this differ from the situation, 
when one container is granted rights to manage another container?
So where is hierarchy?

Moreover, granting/revoking rights is more fine grained I suppose. And 
it is more secure, since uses the model - allow only things which are 
safe, while heirarchy uses model "allow everything" to do with a child 
and leads to possible DoS.

>>Process tree is hierarchical by it's nature. But what is heirarchical 
>>IPC and other resources?
> for resources it's simple, you have to 'give away'
> a certain share to your children, which in turn will
> enable them to utilize them up to the given amount,
> or (depending on the implementation) up to the total
> amount of the parent.
Again, how does this differ from the situation when one container is 
granted to manage another one? In this case it grant some portion of 
it's resources to anyone he wishes.

Take a look at this from another angle:
You have a child container, which was granted 1/2 of your resources.
But since parent consumed 3/4 of it, child will never be able to get his 
1/2 portion. And child will be unable to find out the reason for 
resources allocation denies.

> (check out ckrm as a proof of concept, and example
> how it should not be done :)
let's be more friendly to each other :)

>>And no one ever told me why we need heierarchy at all. No any _real_
>>use cases. But it's ok.
> 
> there are many use cases here, first, the VPS within
> a VPS (of course, not the most useful one, but the
> most obvious one), then there are all kind of test,
> build and security scenarios which can benefit from
> hierarchical structures and 'delegated' administrative
> power (just think web space management)
If you are talking about management, then see my prev paragraph. Rights 
can be granted. Can you provide some other example, what do you want 
from hierarchy?

>>- Eric wants to introduce name spaces, but totally forgots how much
>>  they are tied with each other. IPC refers to netlinks, network refers
>>  to proc and sysctl, etc. It is some rare cases when you will be able
>>  to use namespaces without full OpenVZ/vserver containers. 

> well, we already visited the following:
> 
>  - filesystem namespaces (works quite fine completely
>    independant of all other)
it is tightly interconnected with unix sockets, proc, sysfs, ipc, and 
I'm sure something else :)
Herber, Eric, I'm not against namespaces. Actualy OpenVZ doesn't care 
whether we have single container or namespaces, I'm just trying to show 
you, that all of them are not that separate namespaces as you are trying 
to think of them.

>  - pid spaces (again they are quite fine without any
>    other namespace)
only if we remove all these pid uses from fown, netlinks etc.

>  - resource spaces (another one which makes perfect
>    sense to have without the others)
which one? give me an example please.

> the fact that some things like proc or netlink is tied
> to networking and ipc IMHO is just a sign that those
> interfaces need revisiting and proper isolation or
> virtualization ...
it needs virtualization, really. But being virtualized they are still 
tied to the subsystems they were.

>>- How long these namespaces live? And which management interface each
>>  of them will have?
> well, the lifetime of such a space is very likely to
> be at least the time of the users, including all
> created sockets, file-handles, ipc resources, etc ...
So if you have a socket in TCP_FIN_WAIT1 state, which can live long 
time, what do you do with it?
Full example: the process dies, but network space is still alive due to 
such a socket. You won't be able to reuse the address:port until it died.
I'm curios about how do you propose to handle similar issues in separate 
namespaces?

Also as a continuation of this example, if all the processes exited, how 
can you manage namespaces which leaked? where should you go to see these 
sockets if /proc is tightly related to pspace on the task, but there are 
no tasks?

>>So I really hate that we concentrated on discussion of VPIDs,
>>while there are more general and global questions on the whole
>>virtualization itself.
> 
> 
> well, I was not the one rolling out the 'perfect'
> vpid solution ...
ha ha :) won't start flaming with you.

>>First of all, I don't think syscalls like
>>"do_something and exec" should be introduced.
> Linux-VServer does not have any of those syscalls
> and it works quite well, so why should we need such
> syscalls?
My question is the same! Why?

> I have no problem at all to discuss a general plan
> (hey I though we were already doing so :) or move
> to some other area (like networking :)
Yup. Would be nice to switch to networking, IPC or something like this.

Kirill

