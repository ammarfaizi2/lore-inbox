Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755198AbWKVW5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198AbWKVW5N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 17:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757018AbWKVW5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 17:57:13 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:36116 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1755198AbWKVW5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 17:57:11 -0500
Message-ID: <4564D5B7.7030307@fr.ibm.com>
Date: Wed, 22 Nov 2006 23:56:55 +0100
From: Daniel Lezcano <dlezcano@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Cedric Le Goater <clg@fr.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Dmitry Mishin <dim@sw.ru>,
       netdev@vger.kernel.org
Subject: Re: [patch -mm] net namespace: empty framework
References: <4563007B.9010202@fr.ibm.com> <4563046B.6040909@sw.ru>	<45633EDF.3050309@fr.ibm.com> <20061121181655.GA14656@MAIL.13thfloor.at>	<456454C4.5010803@fr.ibm.com> <m1ejrvtlje.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ejrvtlje.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> The justification is performance and a little on the simplicity side.
> 
> My personal feel is still that layer 3 is something easier done
> as a new kind of table in an iptables type infrastructure.  And in
> fact I believe if done that way would capture do what 90%+ of what
> all of the iptables rules do.  So it might be a nice firewalling speed up.
> I don't think the layer 3 idea where you just do bind filter fits
> the namespace concept very well.

The question is why do we need to do isolation/virtualization at the 
layer 3 ?

1 - for security
2 - for ressource management
3 - for mobility

The last one is not implementable with a netfilter only solution. The 
solution is to have a container id by sockets in order to identify them 
and to descriminate the sockets owned by the container for 
checkpoint/restart and for quescient point. If you look closely to the 
layer 3 approach with network isolation you will see if we replace the 
container id by the network namespace pointer, the code is the *same*.
So we have a common code for the layer 4 for namespaces and layer 3 
isolation. Pushing a little more the layer 3 isolation into namespaces 
we have reach a common solution for layer 2 and layer 3 with Dmitry and 
made the two to co-exists.

The next step will be to reach a quescient point in order to 
checkpoint/restart. The quescient point will be reach using the 
namespace identifier, the traffic will be dropped for incoming and 
outgoing traffic and network timers will be frozen. Should we have again 
two approaches ? One for the layer 2 and another one for the layer 3, 
instead of using the same mechanism for namespaces ?
After that the checkpoint will use the network namespace in order to 
find the sockets to be checkpointed. Should we have 2 checkpoint/restart 
mechanisms ?

I agree, some part of the layer 3 approach does not fit the namespaces 
concept very well, but this is a conceptual vision of the namespaces. I 
can argue, the layer 2 does not fit the namespace concept too, the 
socket hashtable are not by namespaces, the routes cache are not by 
namespaces, does it mean it does not fit the namespace concept at all ? 
No, it does, but it is written to be optimized, it is a question of 
performance...

I don't want to enter to the debate, again, about layer 2/3 
isolation/virtualization, I did my best to promote layer 2 and to 
justify layer 3 on top of that. Now, I let the network guys to decide...

   -- Daniel
