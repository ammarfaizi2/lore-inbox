Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932844AbWF1Ph7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932844AbWF1Ph7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932843AbWF1Ph7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:37:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24731 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932840AbWF1Ph6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:37:58 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Sam Vilain <sam@vilain.net>, Herbert Poetzl <herbert@13thfloor.at>
Cc: Kirill Korotaev <dev@sw.ru>, Daniel Lezcano <dlezcano@fr.ibm.com>,
       Andrey Savochkin <saw@swsoft.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
       clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, devel@openvz.org,
       viro@ftp.linux.org.uk, Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060626192751.A989@castle.nmd.msu.ru>
	<44A00215.2040608@fr.ibm.com>
	<20060627131136.B13959@castle.nmd.msu.ru>
	<44A0FBAC.7020107@fr.ibm.com> <44A1006B.3040700@sw.ru>
	<20060627160908.GC28984@MAIL.13thfloor.at>
	<m1y7vilfyk.fsf@ebiederm.dsl.xmission.com>
	<20060627230723.GC2612@MAIL.13thfloor.at>
	<m1irmlkjni.fsf@ebiederm.dsl.xmission.com>
	<44A22229.2090404@vilain.net>
	<20060628141548.GB5572@MAIL.13thfloor.at>
Date: Wed, 28 Jun 2006 09:36:40 -0600
In-Reply-To: <20060628141548.GB5572@MAIL.13thfloor.at> (Herbert Poetzl's
	message of "Wed, 28 Jun 2006 16:15:48 +0200")
Message-ID: <m11wt9gulz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> On Wed, Jun 28, 2006 at 06:31:05PM +1200, Sam Vilain wrote:
>> Eric W. Biederman wrote:
>> > Have a few more network interfaces for a layer 2 solution
>> > is fundamental.  Believing without proof and after arguments
>> > to the contrary that you have not contradicted that a layer 2
>> > solution is inherently slower is non-productive.  Arguing
>> > that a layer 2 only solution most prove itself on guest to guest
>> > communication is also non-productive.
>> >   
>> 
>> Yes, it does break what some people consider to be a sanity condition
>> when you don't have loopback anymore within a guest. I once experimented
>> with using 127.* addresses for per-guest loopback devices with vserver
>> to fix this, but that couldn't work without fixing glibc to not make
>> assumptions deep in the bowels of the resolver. I logged a fault with
>> gnu.org and you can guess where it went :-).
>
> this is what the lo* patches address, by providing
> the required loopback isolation and providing lo
> inside a guest (i.e. it looks and feels like a
> normal system, except that you cannot modify the
> interfaces from inside)

Ok.  This is new.  How do you talk between guests now?
Before those patches it was through IP addresses on the loopback interface
as I recall.

>> > With a guest with 4 IPs 
>> > 10.0.0.1 192.168.0.1 172.16.0.1 127.0.0.1
>> > How do you make INADDR_ANY work with just filtering at bind time?
>> >   
>> 
>> It used to just bind to the first one. Don't know if it still does.
>
> no, it _alway_ binds to INADDR_ANY and checks
> against other sockets (in the same context)
> comparing the lists of assigned IPs (the subset)
>
> so all checks happen at bind/connect time and
> always against the set of IPs, only exception is
> a performance optimization we do for single IP
> guests (where INADDR_ANY gets rewritten to the
> single IP)

What is the mechanism there?

My rough extrapolation says this mechanism causes problems when
migrating between machines.  In particular it sounds like
only one process can bind to *:80, even if it is only allowed
to accept connections from a subset of those IPs.

So if on another machine I bound something to *:80 and only allowed to
use a different set of IPs and then attempted to migrate it, the
migration would fail because I could not restart the application,
with all of it's layer 3 resources.

To be clear I assume when I migrate I always take my IP address or
addresses with me.

Eric
