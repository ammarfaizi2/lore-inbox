Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932718AbWF3OX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932718AbWF3OX3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 10:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932717AbWF3OX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 10:23:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43178 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932702AbWF3OX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 10:23:27 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Daniel Lezcano <dlezcano@fr.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       Sam Vilain <sam@vilain.net>, hadi@cyberus.ca,
       Herbert Poetzl <herbert@13thfloor.at>, Alexey Kuznetsov <alexey@sw.ru>,
       viro@ftp.linux.org.uk, devel@openvz.org, dev@sw.ru,
       Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrey Savochkin <saw@swsoft.com>,
       Ben Greear <greearb@candelatech.com>, Dave Hansen <haveblue@us.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
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
Date: Fri, 30 Jun 2006 08:20:24 -0600
In-Reply-To: <44A517B4.4010500@fr.ibm.com> (Daniel Lezcano's message of "Fri,
	30 Jun 2006 14:23:16 +0200")
Message-ID: <m1veqibu8n.fsf@ebiederm.dsl.xmission.com>
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
> I have a few questions about all the network isolation stuff:

So far I have seen two viable possibilities on the table,
neither of them involve multiple names for a network device.

layer 3 (filtering the allowed ip addresses at bind time roughly the current vserver).
  - implementable as a security hook.
  - Benefit no measurable performance impact.
  - Downside not many things we can do.

layer 2 (What appears to applications a separate instance of the network stack).
  - Implementable as a namespace.
  - Each network namespace would have dedicated network devices.
  - Benefit extremely flexible.
  - Downside since at least the slow path must examine the packet
    it has the possibility of slowing down the networking stack.


For me the important characteristics.
- Allows for application migration, when we take our ip address with us.
  In particular it allows for importation of addresses assignments
  mad on other machines.

- No measurable impact on the existing networking when the code
  is compiled in.

- Clean predictable semantics.


This whole debate on network devices show up in multiple network namespaces
is just silly.  The only reason for wanting that appears to be better management.
We have deeper issues like can we do a reasonable implementation without a
network device showing up in multiple namespaces.

I think the reason the debate exists at all is that it is a very approachable
topic, as opposed to the fundamentals here.

If we can get layer 2 level isolation working without measurable overhead
with one namespace per device it may be worth revisiting things.  Until
then it is a side issue at best.

Eric
