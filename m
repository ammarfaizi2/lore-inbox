Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbVERUgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbVERUgB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 16:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbVERUgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 16:36:00 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:22745 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262351AbVERUfi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 16:35:38 -0400
Subject: Re: [PATCH] fix race in mark_mounts_for_expiry()
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dhowells@redhat.com, jamie@shareable.org,
       viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1DYU4Z-0001U5-00@dorka.pomaz.szeredi.hu>
References: <E1DYMVf-0000hD-00@dorka.pomaz.szeredi.hu>
	 <E1DYMB6-0000dw-00@dorka.pomaz.szeredi.hu>
	 <E1DYLvb-0000as-00@dorka.pomaz.szeredi.hu>
	 <E1DYLCv-0000W7-00@dorka.pomaz.szeredi.hu>
	 <1116005355.6248.372.camel@localhost>
	 <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu>
	 <1116012287.6248.410.camel@localhost>
	 <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu>
	 <1116013840.6248.429.camel@localhost>
	 <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu>
	 <1116256279.4154.41.camel@localhost>
	 <20050516111408.GA21145@mail.shareable.org>
	 <1116301843.4154.88.camel@localhost>
	 <E1DXm08-0006XD-00@dorka.pomaz.szeredi.hu>
	 <20050517012854.GC32226@mail.shareable.org>
	 <E1DXuiu-0007Mj-00@dorka.pomaz.szeredi.hu>
	 <1116360352.24560.85.camel@localhost>
	 <E1DYI0m-0000K5-00@dorka.pomaz.szeredi.hu>
	 <1116399887.24560.116.camel@localhost>
	 <1116400118.24560.119.camel@localhost> <6865.1116412354@redhat.com>
	 <7230.1116413175@redhat.com> <8247.1116413990@redhat.com>
	 <9498.1116417099@redhat.com> <E1DYNLt-0000nu-00@dorka.pomaz.szeredi! .hu>
	 <E1DYNjR-0000po-00@dorka.pomaz.szeredi.hu>
	 <E1DYRnw-0001J6-00@dorka.pomaz.szeredi.hu>
	 <1116442073.24560.142.camel@localhost>
	 <E1DYU4Z-0001U5-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1116448514.24560.209.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 18 May 2005 13:35:15 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-18 at 12:19, Miklos Szeredi wrote:
> > First of all the reason this race exists implies Al Viro may have had
> > assertion in his mind that "All tasks that have access to a namespace
> > has a refcount on that namespace".  If that was what he was thinking,
> > than the I would stick with that assertion being true. The overall idea
> > I am thinking off is:
> > 
> > 1) have the automounter hold a refcount on any new namespace created
> >     the mounts in which the automounter has interest in.
> > 2) have a refcount on the namespace when a new task gains access to
> >    a namespace through the file descriptor or any other 
> >    similar mechanisms and remove the reference
> >    once the fd gets closed. (bit tricky to implement)
> > 
> > Do you agree with the overall idea? 
> 
> I don't really understand it.
> 
> A reference count usually means, the number of references (pointers)
> to an object.  You can sometimes get away with schemes that deviate
> from this in various ways, but it's usually asking for trouble.

Ok. One more attempt to be clear.

All the places where get_namespace() is called currently except
in mark_mounts_for_expiry() are safe because they are called in
places where it is guaranteed that they will not race with 
__put_namespace(). 

For example in clone_namespace(), get_namespace() will not race
because the task that called the clone has a refcount on the
namespace and since that task is currently  in the kernel, there is
no chance for  the task  to go away  decrementing the refcount 
on that namespace. 

But the case where the call to get_namespace() is buggy in 
mark_mounts_for_expiry() is because:
it is called in a timer context, and the last process referring
the namespace may just disapper right than.  
 So what I am proposing is:
in automouter, while the automount takes place in 
afs_mntpt_follow_link() increment the refcount of the namespace,
by calling get_namespace(). This call will not race with __put_namespace
because the process that is trying to access the
mountpoint already has a refcount on the namespace and it won't be 
able to decrement the refcount currently. agree?

Now later when the automounter tries to unmount the mount 
call put_namespace() after unmounting. I mean do it in
mark_mounts_for_expiry(). Also delete the call to get_namespace()) 

So the race will not happen at all.

Makes sense? 

That was the easiest part, but the difficult part is how to call
get_namespace() on a forign namespace in do_loopback()?

thinking about it,
RP



> 
> The usage in mark_mounts_for_expiry() deviated from it so much, that
> the result was a subtle race.
> 
> Doing some tricky thing like what you propose will just likely
> introduce more subtle problems.
> 
> Miklos
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

