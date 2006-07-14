Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422651AbWGNRTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbWGNRTw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422655AbWGNRTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:19:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1672 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422651AbWGNRTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:19:51 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <m1psgaag7y.fsf@ebiederm.dsl.xmission.com>
	<44B684A5.2040008@fr.ibm.com>
	<20060713174721.GA21399@sergelap.austin.ibm.com>
	<m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>
	<1152815391.7650.58.camel@localhost.localdomain>
	<m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>
	<20060713214101.GB2169@sergelap.austin.ibm.com>
	<m1y7uwyh9z.fsf@ebiederm.dsl.xmission.com>
	<20060714140237.GD28436@sergelap.austin.ibm.com>
	<m1k66gw88t.fsf@ebiederm.dsl.xmission.com>
	<20060714163905.GB25303@sergelap.austin.ibm.com>
Date: Fri, 14 Jul 2006 11:18:46 -0600
In-Reply-To: <20060714163905.GB25303@sergelap.austin.ibm.com> (Serge
	E. Hallyn's message of "Fri, 14 Jul 2006 11:39:05 -0500")
Message-ID: <m1mzbct895.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> "Serge E. Hallyn" <serue@us.ibm.com> writes:
>> 
>> > Quoting Eric W. Biederman (ebiederm@xmission.com):
>> >> If you permission checks are not (user namespace, uid) what can't you do?
>> >
>> > File descripters can only be passed over a unix socket, right?
>> 
>> No.  You can use /proc to do the same thing.  You can inherit
>
> How?

/proc/<pid>/fd/...
/proc/<pid>/exe
/proc/<pid>/cwd

It isn't quite the same as you are actually opening a second
copy of the file descriptor but the essence is the same.

>> file descriptors, etc.  This isn't a door you can just close and ignore.
>> It is too easy to do this to assume you have closed every possible
>> way to get a descriptor from outside of ``container''.
>> 
>> Suppose you have user fred uid 1000 outside of any containers,
>> and you have user joe uid 1000 inside user uid namespace.  If you don't
>> make your permission checks (user namespace, uid) fred can do terrible
>
> Only if user fred can reach user joe's files.

If they are logged in a the same time this is possible.

>> If I we don't do the expanded permission checks the only alternative
>> is to check to see if every object is in our ``container'' at every
>> access.  That isn't something I want to do.
>
> Ditto.
>
>> I don't intend to partition objects just partition object look ups by name.
                                                            ^just
>> Which means that if you very carefully setup your initial process you
>> will never be able to find an object outside of your namespace.  But
>> the kernel never should assume user space has done that.
>
> Are you contradicting yourself here?

I don't think so.

Basically what I am saying all new looks happen in the new namespace.
That makes it hard to find objects that are not in your namespace.
If you already have those objects open, or if can find a way besides
lookup by name to access those objects you can see objects in another
namespace.

>> > So this seems to fall into the same "userspace should set things up
>> > sanely" argument you've brought up before.
>> 
>> For using it yes.  But not for correct kernel operation.
>
> Well if we say the kernel controls files (barring LSMs) based on simple
> uids, then that is correct kernel operation :)

If we so define it yes, I believe that definition is wrong.

> In other words we're not letting the kernel do anything it isn't
> supposed to do.

In the context of user namespaces if the compare is not 
(user_ns, uid) == (other_user_ns, other_uid) then we are.

>> > Don't get me wrong though - the idea of using in-kernel keys as
>> > cross-namespace uid's is definately interesting.
>> 
>> That is their role in the kernel.
>
> They have more roles than that...
>
> I phrased it the way I did to point out we shouldn't need to be using
> ecryptfs - which uses the keyring to store actual encryptions keys - to
> do this.

Ok. I will buy that.

>> A flavor of key to handle uid
>> mapping needs to be added, but that is all.
>
> How can that be all?  How do we represent this on the filesystem then?

You handle it at the VFS layer unless the filesystem overrides the
permission checks.

> We can't store (namespace, uid) because we presumably dont' have actual
> external unique ids for a namespace.  So we really will need to provide
> global uids, and store those in the keys (and with the files).  So now
> 3475276bc0dcd9cc501ba9bb7f12683f1b867066 is my uid no matter where I am,
> for instance.

That is one way to do it.  Anyway as long as we can see it is possible using
keys now we can sort out the rest of the details later.

Eric

