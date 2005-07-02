Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVGBRen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVGBRen (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 13:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVGBRen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 13:34:43 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2486 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261232AbVGBRed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 13:34:33 -0400
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, akpm@osdl.org, aia21@cam.ac.uk,
       arjan@infradead.org, linux-kernel@vger.kernel.org, frankvm@frankvm.com,
       v9fs-developer@lists.sourceforge.net
Subject: Re: FUSE merging?
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	<m1acl5frw6.fsf@ebiederm.dsl.xmission.com>
	<1120322629.381A13EE@dl11.dngr.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 02 Jul 2005 11:33:10 -0600
In-Reply-To: <1120322629.381A13EE@dl11.dngr.org> (Eric Van Hensbergen's
 message of "Sat, 2 Jul 2005 12:43:46 -0400")
Message-ID: <m1oe9ldsfd.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Van Hensbergen <ericvh@gmail.com> writes:

> On Sat, 2 Jul 2005 6:15 am, Eric W. Biederman wrote:
>>
>> Taking a quick glance at v9fs and fuse I fail to see how either
>> plays nicely with the page cache.
>>
>
> True, in fact it actively avoids using it.  The previous version used both the
> page cache and the dcache with undesirable effects on synthetic file systems so
> we removed cache support.  Our intention is to design a cache layer (similar to
> cfs on Plan 9) which handles cache semantics which can be parameterized with the
> appropriate cache policy depending on the underlying file server.

Not having auto discovery for that kind of thing disturbs me.  But
if you can discover what you must do and then the policy is about
what you can do it I guess I'm fine with that.

>> v9fs according to my reading of the protocol specification does
>> not have any concept of a lease.  So you can't tell if you are
>> talking about a virtual filesystem where all calls should be passed
>> straight to the server or a real filesystem where you can perform
>> caching.
>
> While 9P contains no explicit support for leases and cacheing there is an
> informal mechanism which is used (at least for plan 9 file servers).  If the
> qid.vers is 0 the file can be assumed to be a synthetic file and so it is not
> cached.

That sounds sane.  With that you can at least do NFS style caching 
with a lot of stat calls to verify your cache is coherent and by
implementing it as a write-through cache you can even do a halfway
decent job of being cache coherent.  Which is probably about the
best you can do with the current unix API.

With a write-through cache you can likely achieve the same
semantic effect of totally not caching a file with an appropriate
number of stat calls.  Not caching some files will like yield 

I suggest you document the quid.vers == 0 magic for an uncachable
file, so future interoperability is assured.

Eric
