Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWF3SLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWF3SLJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932998AbWF3SLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:11:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62129 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932995AbWF3SLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:11:05 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Daniel Lezcano <dlezcano@fr.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       Sam Vilain <sam@vilain.net>, hadi@cyberus.ca,
       Herbert Poetzl <herbert@13thfloor.at>, Alexey Kuznetsov <alexey@sw.ru>,
       viro@ftp.linux.org.uk, devel@openvz.org, dev@sw.ru,
       Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrey Savochkin <saw@swsoft.com>,
       Ben Greear <greearb@candelatech.com>, Dave Hansen <haveblue@us.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: strict isolation of net interfaces
References: <m1psgulf4u.fsf@ebiederm.dsl.xmission.com>
	<44A1689B.7060809@candelatech.com>
	<20060627225213.GB2612@MAIL.13thfloor.at>
	<1151449973.24103.51.camel@localhost.localdomain>
	<20060627234210.GA1598@ms2.inr.ac.ru>
	<m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com>
	<20060628133640.GB5088@MAIL.13thfloor.at>
	<1151502803.5203.101.camel@jzny2> <44A44124.5010602@vilain.net>
	<44A450D1.2030405@fr.ibm.com>
	<20060630023947.GA24726@sergelap.austin.ibm.com>
	<44A517B4.4010500@fr.ibm.com>
Date: Fri, 30 Jun 2006 12:09:44 -0600
In-Reply-To: <44A517B4.4010500@fr.ibm.com> (Daniel Lezcano's message of "Fri,
	30 Jun 2006 14:23:16 +0200")
Message-ID: <m1bqsabjmf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Lezcano <dlezcano@fr.ibm.com> writes:

> Serge E. Hallyn wrote:
>> Quoting Cedric Le Goater (clg@fr.ibm.com):
>>
>>>we could work on virtualizing the net interfaces in the host, map them to
>>>eth0 or something in the guest and let the guest handle upper network layers ?
>>>
>>>lo0 would just be exposed relying on skbuff tagging to discriminate traffic
>>>between guests.
>> This seems to me the preferable way.  We create a full virtual net
>> device for each new container, and fully virtualize the device
>> namespace.
>

Answers with respect to how I see layer 2 isolation,
with network devices and sockets as well as the associated routing
information given per namespace.

> I have a few questions about all the network isolation stuff:
>
>   * What level of isolation is wanted for the network ? network devices ?
> IPv4/IPv6 ? TCP/UDP ?
>
>   * How is handled the incoming packets from the network ? I mean what will be
> mecanism to dispatch the packet to the right virtual device ?

Wrong question.  A better question is to ask how do you know which namespace
a packet is in.  
Answer:  By looking at which device or socket it just came from.

How do you get a packet into a non-default namespace?
Either you move a real network interface into that namespace.
Or you use a tunnel device that shows up as two network interfaces in
two different namespaces.

Then you route, or bridge packets between the two.  Trivial.

>   * How to handle the SO_BINDTODEVICE socket option ?

Just like we do now.

>   * Has the virtual device a different MAC address ? 

All network devices are abstractions of the hardware so they are all
sort of virtual.  My implementation of a tunnel device has a mac
address so I can use it with ethernet bridging but that isn't a hard
requirement.  And yes the mac address is different because you can't
do layer 2 switching if everyone has the same mac address.

But there is no special ``virtual'' device.

> How to manage it with the real MAC address on the system ? 
Manage?

> How to manage ARP, ICMP, multicasting and IP ?

Like you always do.  It would be a terrible implementation if
we had to change that logic.  There is a little bit of that
where we need to detect which network namespace we are going to because
the answers can differ but that is pretty straight forward.

> It seems for me, IMHO that will require a lot of translation and browsing
> table. It will probably add a very significant overhead.

Then look at:
git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/linux-2.6-ns.git#proof-of-concept
or the OpenVZ implementation.  

It isn't serious overhead.

>    * How to handle NFS access mounted outside of the container ?

The socket should remember it's network namespace.
It works fine.

>    * How to handle ICMP_REDIRECT ?

Just like we always do?

Eric


