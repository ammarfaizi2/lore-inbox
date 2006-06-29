Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751835AbWF2A1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbWF2A1M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 20:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbWF2A1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 20:27:12 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61616 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751835AbWF2A1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 20:27:09 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Daniel Lezcano <dlezcano@fr.ibm.com>
Cc: Andrey Savochkin <saw@swsoft.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
       clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       viro@ftp.linux.org.uk, Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: Network namespaces a path to mergable code.
References: <20060626134945.A28942@castle.nmd.msu.ru>
	<m14py6ldlj.fsf@ebiederm.dsl.xmission.com>
	<20060627215859.A20679@castle.nmd.msu.ru>
	<m1ejx9kj1r.fsf@ebiederm.dsl.xmission.com>
	<20060628150605.A29274@castle.nmd.msu.ru>
	<44A2FA66.5070303@fr.ibm.com>
Date: Wed, 28 Jun 2006 18:25:40 -0600
In-Reply-To: <44A2FA66.5070303@fr.ibm.com> (Daniel Lezcano's message of "Wed,
	28 Jun 2006 23:53:42 +0200")
Message-ID: <m11wt8erjv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Lezcano <dlezcano@fr.ibm.com> writes:

> Andrey Savochkin wrote:
>
>> Ok, fine.
>> Now I'm working on socket code.
>> We still have a question about implicit vs explicit function parameters.
>> This question becomes more important for sockets: if we want to allow to use
>> sockets belonging to namespaces other than the current one, we need to do
>> something about it.
>> One possible option to resolve this question is to show 2 relatively short
>> patches just introducing namespaces for sockets in 2 ways: with explicit
>> function parameters and using implicit current context.
>> Then people can compare them and vote.
>> Do you think it's worth the effort?
>>
>
> The attached patch can have some part interesting for you for the socket
> tagging. It is in the IPV4 isolation (part 5/6). With this and the private
> routing table you will probably have a good IPV4 isolation.
> This patch partially isolates ipv4 by adding the network namespace
> structure in the structure sock, bind bucket and skbuf.

Ugh.  skbuf sounds very wrong.  Per packet overhead?

> When a socket
> is created, the pointer to the network namespace is stored in the
> struct sock and the socket belongs to the namespace by this way. That
> allows to identify sockets related to a namespace for lookup and
> procfs. 
>
> The lookup is extended with a network namespace pointer, in
> order to identify listen points binded to the same port. That allows
> to have several applications binded to INADDR_ANY:port in different
> network namespace without conflicting. The bind is checked against
> port and network namespace.

Yes.  If we don't duplicate the hash table we need to extend the lookup.

> When an outgoing packet has the loopback destination addres, the
> skbuff is filled with the network namespace. So the loopback packets
> never go outside the namespace. This approach facilitate the migration
> of loopback because identification is done by network namespace and
> not by address. The loopback has been benchmarked by tbench and the
> overhead is roughly 1.5 %

Ugh.  1.5% is noticeable.

I think it is cheaper to have one loopback device per namespace.
Which removes the need for a skbuff tag.

Eric
