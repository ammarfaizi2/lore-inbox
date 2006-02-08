Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965186AbWBHCvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbWBHCvb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 21:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbWBHCvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 21:51:31 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46228 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965186AbWBHCva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 21:51:30 -0500
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       saw@sawoct.com, devel@openvz.org, Dmitry Mishin <dim@sw.ru>,
       Andi Kleen <ak@suse.de>, Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: The issues for agreeing on a virtualization/namespaces
 implementation.
References: <43E7C65F.3050609@openvz.org>
	<m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>
	<43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>
	<20060207201908.GJ6931@sergelap.austin.ibm.com>
	<43E90716.4020208@watson.ibm.com>
	<m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com>
	<43E92EDC.8040603@watson.ibm.com>
	<20060208004325.GA15061@ms2.inr.ac.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 07 Feb 2006 19:49:08 -0700
In-Reply-To: <20060208004325.GA15061@ms2.inr.ac.ru> (Alexey Kuznetsov's
 message of "Wed, 8 Feb 2006 03:43:25 +0300")
Message-ID: <m1k6c6bm57.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru> writes:

> Hello!
>
>> >2) What is the syscall interface to create these namespaces?
>> >   - Do we add clone flags?  
>> >     (Plan 9 style)
>> 
>> Like that approach .. flexible .. particular when one has well specified 
>> namespaces.
>> 
>> >   - Do we add a syscall (similar to setsid) per namespace?
>> >     (Traditional unix style)?
>> 
>> Where does that approach end .. what's wrong with doing it at clone() time ?
>
> That most of those namespaces need a special setup rather than a plain copy?
>
> F.e. what are you going to do with NETWORK namespace? The only valid thing
> to do is to prepare a new context and to configure its content (addresses,
> routing tables, iptables...) later. So that, in this case it is natural
> to inherit the context through clone() and to create new context
> with a separate syscall.

With a NETWORK namespace what I implemented was that you get a empty
namespace with a loopback interface.

But setting up the namespace from the inside is clearly the sane thing
todo.

> Seems, only PID space needs to be setup at clone time. All the rest of
> suggested namespaces are more convenient to change with separate syscalls.

Actually I think I can setup a PID space in a syscall as well.
It is a little odd that your session, and process group change but since
I was keeping 2 pids on the PID space leader I could easily do it.
The fact that getpid() would start returning 1 might be confusing to a some
processes though so clone seems to be the natural time to do it.

> I would suggest to combine both approaches. Those namespaces, which can be
> naturally copied while clone() (f.e. the best example is already existing
> CLONE_NEWNS) deserve a clone() flag. The rest are preserved through clone()
> and forked and configured later.

Sounds reasonable.  We make the decision on a case by case base whatever
make sense for the patch and the namespace.

The only real advantage to clone is you can create a bunch of namespaces
all in one shot.  Of course that makes sys_clone a little slower.

Eric



