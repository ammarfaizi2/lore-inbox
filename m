Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261802AbTC1Awt>; Thu, 27 Mar 2003 19:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261817AbTC1Awt>; Thu, 27 Mar 2003 19:52:49 -0500
Received: from cs.columbia.edu ([128.59.16.20]:3326 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S261802AbTC1Awq>;
	Thu, 27 Mar 2003 19:52:46 -0500
Subject: Re: process creation/deletions hooks
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1048809375.30988.140.camel@zaphod>
References: <1048799290.31010.62.camel@zaphod>
	 <20030327213131.GA936@sgi.com>  <1048809375.30988.140.camel@zaphod>
Content-Type: text/plain
Organization: 
Message-Id: <1048813389.31797.30.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 27 Mar 2003 20:03:09 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In fleshing out the ideas a little more, I would think the hook would go
right b4 wake_up_process(p) in do_fork() (at least on my 2.4.18 kernel),
so that the process is totally setup, but not yet runnable.  It would
also seem correct to go right b/4 after the BSD process accounting code
in do_exit().

so the pseudo code would be something like (pseudo in the fact that it's
been over a year since I touched the kernel's linked list, so I believe
I got them right)

list_for_each(tmp, &accounting_head)
{
        as = list_entry(tmp, struct account_struct, as_list);
        if (as->remove) //or create
                as->remove(code); //or create(p)
}

It would seem that the BSD proceed accounting could probably be changed
to use this same infrastructure, so an IFDEF would be removed, though
that's not a reason 

The only negative I see is that there would have to be some sort of
locking to prevent removal's from the list causing problems.

I'm also making the assumption that the only way a process is removed
from the system is through do_exit().

anyways, comments would be appreciated.

thanks,

shaya

On Thu, 2003-03-27 at 18:56, Shaya Potter wrote:
> Well, the ideas are somewhat similar, but I'm viewing it more from a
> module perspective that lets any module author implement something, so
> it's not specialized, and hopefully has a better chance of getting in
> the kernel (i.e. I think your system could work for this as well).
> 
> basically what I envision is something simple, in process creation and
> deletion we do something like
> 
> item = some list_head;
> while (item)
> {
> 	item->function(task_struct);
> 	item = item->next;
> }
> 
> so it has very little overhead into the actual kernel if it's not being
> used (1 memory load and 1 compare/branch).
> 
> the way pagg would work (I think, just did a cursory reading) is that
> instead of storing the data in the task_struct, you'd have a seperate
> struct that deal with it.  Not as pretty in that regards, but also the
> standard way modules that want to extend the linux kernel have to work,
> and therefore hopefully linus would be willing to include it in his
> kernel.
> 
> shaya
> 
> On Thu, 2003-03-27 at 16:31, Nathan Straz wrote:
> > On Thu, Mar 27, 2003 at 04:08:10PM -0500, Shaya Potter wrote:
> > > We are trying to write a module that does it's own accounting of
> > > processes as they are created and deleted.  We have an extremely ugly
> > > hack of taking care of process creation (wrap fork() and clone() in a
> > > syscall wrapper, as that's the only way processes can be created).  
> > 
> > You might want to look at the PAGG patch.  SGI did something like this
> > to implement CSA, an accounting package.  Here are some links that might
> > interest you:
> > 
> > Linux PAGG home page:
> > http://oss.sgi.com/projects/pagg/
> > 
> > Design Doc:
> > http://oss.sgi.com/projects/pagg/pagg-lkd.txt
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

