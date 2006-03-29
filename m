Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWC2Oob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWC2Oob (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 09:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWC2Oob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 09:44:31 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:51378 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750758AbWC2Ooa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 09:44:30 -0500
Date: Wed, 29 Mar 2006 07:47:09 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, devel@openvz.org,
       Sam Vilain <sam@vilain.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Herbert Poetzl <herbert@13thfloor.at>,
       Mishin Dmitry <dim@sw.ru>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [Devel] Re: [RFC] [PATCH 0/7] Some basic vserver infrastructure
Message-ID: <20060329134709.GC15745@sergelap.austin.ibm.com>
References: <20060321061333.27638.63963.stgit@localhost.localdomain> <1142967011.10906.185.camel@localhost.localdomain> <44206B58.5000404@vilain.net> <1142976756.10906.200.camel@localhost.localdomain> <4420885F.5070602@vilain.net> <m1bqvzq7de.fsf@ebiederm.dsl.xmission.com> <44241214.7090405@sw.ru> <20060327124517.GA16114@sergelap.austin.ibm.com> <442A7879.20802@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442A7879.20802@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kirill Korotaev (dev@sw.ru):
> Serge,
> 
> Serge E. Hallyn wrote:
> >Quoting Kirill Korotaev (dev@sw.ru):
> >>Just to make it more clear: my understanding of word "nested" means that
> >>if you have, for example, a nested IPC namespace, than parent can see
> >>all the resources (sems, shms, ...) of it's children and have some
> >>private, while children see only its own set of private resources. But
> >>it doesn't look like you are going to implement anything like this.
> >>So what is nesting then? Ability to create namespace? To delegate it
> >>some part of own resource limits?
> >
> >Nesting simply means that any child ns can create child namespaces of
> >it's own.
> your picture below doesn't show that containers have nested containers. 
> You draw a plain container set inside vserv.

And I am assuming that vserv is implemented as a container, hence this
is an example of nested containers very likely to be used.  But given
what I now think is your definition of nested, I think we are agreed.

> What I mean is that if some container user can create another container, 
> it DOES not mean it is nested. It is just about permitions to create 
> other containers. Nested containers in my POV is something different, 
> when you can see the resources of your container and your children. You see?

Alas, the spacing on the picture didn't quite work out :)  I think that
by nested containers, you mean overlapping nested containers.  In your
example, how are you suggesting that cont1 refers to items in
container1.1.2's shmem?  I assume, given your previous posts on openvz,
that you want every shmem id in all namespaces "nested" under cont1 to
be unique, and for cont1 to refer to any item in container1.1.2's
namespace just as it would any of cont1's own shmem?

In that case I am not sure of the actual usefulness.  Someone with
different use for containers (you? :)  will need to justify it.  For me,
pure isolation works just fine.  Clearly it will be most useful if we
want fine-grained administration, from parent namespaces, of the items
in a child namespace.

-serge

> I will try to show what I mean on a picture:
> 
> --------------------------------------------------
> |           ---------------------------------     | 
>                            |           |              --------------- 
> |     |                                                |           | 
>           | cont 1.1.1  |  |     | 
>            |           |              |  shm1.1.1.1 |  |     | 
>                                        |           |              | 
> shm1.1.1.2 |  |     |                                                | 
> cont 1.  | cont 1.1     ---------------  |     |
> |   shm1.1  |  shm1.1.1    ---------------  |     | 
>                            |   shm1.2  |              | cont 1.1.2  | 
> |     |                                                |           | 
>           |  shm1.1.2.1 |  |     | 
>            |           |              ---------------  |     | 
>                                        | 
> ---------------------------------     | 
>                |--------------------------------------------------
> 
> You see what I mean? In this example with IPC sharememory container 1 
> can see all the shm segments. while container1.1.2 can see only his 
> private one smm1.1.2.1.
> 
> And if resources are not nested like this, than it is a PLAIN container 
> structure.
> 
> Kirill
> 
> >In particular, the following scenario should be perfectly valid:
> >
> >	Machine 1                    Machine 2
> >	  Xen VM1.1                    Xen VM2.1
> >	    vserv 1.1.1                  vserv2.1.1
> >	      cont1.1.1.1                  cont2.1.1.1
> >	      cont1.1.1.2                  cont2.1.1.2
> >	      cont1.1.1.n                  cont2.1.1.n
> >	    vserv 1.1.2                  vserv2.1.2
> >	      cont1.1.2.1                  cont2.1.2.1
> >	      cont1.1.2.2                  cont2.1.2.2
> >	      cont1.1.2.n                  cont2.1.2.n
> >	  Xen VM1.2                    Xen VM2.2
> >	    vserv 1.2.1                  vserv2.2.1
> >	      cont1.2.1.1                  cont2.2.1.1
> >	      cont1.2.1.2                  cont2.2.1.2
> >	      cont1.2.1.n                  cont2.2.1.n
> >	    vserv 1.2.2                  vserv2.2.2
> >	      cont1.2.2.1                  cont2.2.2.1
> >	      cont1.2.2.2                  cont2.2.2.2
> >	      cont1.2.2.n                  cont2.2.2.n
> >
> >where containers are used for each virtual server and each container,
> >so that we can migrate entire VMs, entire virtual servers, or any
> >container.
> >
> >>>>>>Perhaps we can get a ruling from core team on this one, as it's
> >>>>>>aesthetics :-).
> >>I propose to use "namespace" naming.
> >>1. This is already used in fs.
> >>2. This is what IMHO suites at least OpenVZ/Eric
> >>3. it has good acronym "ns".
> >
> >I agree.
> >
> >-serge
> >
