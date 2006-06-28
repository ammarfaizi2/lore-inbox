Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932816AbWF1Omm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932816AbWF1Omm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932813AbWF1Oml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:42:41 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44484 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932811AbWF1Omk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:42:40 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: hadi@cyberus.ca
Cc: Herbert Poetzl <herbert@13thfloor.at>, Alexey Kuznetsov <alexey@sw.ru>,
       viro@ftp.linux.org.uk, sam@vilain.net, devel@openvz.org, dev@sw.ru,
       Andrew Morton <akpm@osdl.org>, clg@fr.ibm.com, serue@us.ibm.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrey Savochkin <saw@swsoft.com>, Daniel Lezcano <dlezcano@fr.ibm.com>,
       Ben Greear <greearb@candelatech.com>, Dave Hansen <haveblue@us.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060627133849.E13959@castle.nmd.msu.ru>
	<44A1149E.6060802@fr.ibm.com>
	<m1sllqn7cb.fsf@ebiederm.dsl.xmission.com>
	<20060627160241.GB28984@MAIL.13thfloor.at>
	<m1psgulf4u.fsf@ebiederm.dsl.xmission.com>
	<44A1689B.7060809@candelatech.com>
	<20060627225213.GB2612@MAIL.13thfloor.at>
	<1151449973.24103.51.camel@localhost.localdomain>
	<20060627234210.GA1598@ms2.inr.ac.ru>
	<m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com>
	<20060628133640.GB5088@MAIL.13thfloor.at>
	<1151502803.5203.101.camel@jzny2>
Date: Wed, 28 Jun 2006 08:39:38 -0600
In-Reply-To: <1151502803.5203.101.camel@jzny2> (hadi@cyberus.ca's message of
	"Wed, 28 Jun 2006 09:53:23 -0400")
Message-ID: <m1veqlgx91.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal <hadi@cyberus.ca> writes:

> On Wed, 2006-28-06 at 15:36 +0200, Herbert Poetzl wrote:
>
>> note: personally I'm absolutely not against virtualizing
>> the device names so that each guest can have a separate
>> name space for devices, but there should be a way to
>> 'see' _and_ 'identify' the interfaces from outside
>> (i.e. host or spectator context)
>> 
>
> Makes sense for the host side to have naming convention tied
> to the guest. Example as a prefix: guest0-eth0. Would it not
> be interesting to have the host also manage these interfaces
> via standard tools like ip or ifconfig etc? i.e if i admin up
> guest0-eth0, then the user in guest0 will see its eth0 going
> up.
>
> Anyways, interesting discussion.

Please no.

We really want the fundamental rule that a network device
is tied to a single namespace, and that a socket is tied
to a single namespace.  If those two conditions are met
we don't have to tag packets with a namespace identifier.

We only have to modify hash table lookups in the networking
code to look at a namespace tag in addition to the rest because
that is less expensive than allocating new hash tables.

Currently with a network device only being usable in one
network namespace we have the situation where we can
fairly safely give a guest CAP_NET_ADMIN without problems.

In addition currently nothing in the implementation knows about
the hierarchical structure of how the network namespace will be
used.  To allow ifconfig guest0-eth0 to work would require
understanding the hierarchical structure and places serious questions
on how safe we can make CAP_NET_ADMIN.

Now I am open to radically different designs if they allow the
implementation cost to be lower and they have clean semantics,
and don't wind up being an ugly unmaintainable wart on the linux
networking stack.  The only route I could imagine such a thing coming
from is something like tagging flows, in some netfiler like way.
Which might allow ifconfig guest-eth0 from the host without problems.
But I have not seen such a design.

Eric
