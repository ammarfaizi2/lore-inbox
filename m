Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264232AbTDPFkG (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 01:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264233AbTDPFkG 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 01:40:06 -0400
Received: from granite.he.net ([216.218.226.66]:30992 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264232AbTDPFkD 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 01:40:03 -0400
Date: Tue, 15 Apr 2003 22:54:02 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@digeo.com>, Patrick Mochel <mochel@osdl.org>
Cc: Philippe =?iso-8859-1?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm3: Bad: scheduling while atomic with IEEE1394 then hard freeze ( lockup on CPU0)
Message-ID: <20030416055402.GC15860@kroah.com>
References: <20030416000501.342c216f.philippe.gramoulle@mmania.com> <20030415160530.2520c61c.akpm@digeo.com> <20030416011728.196d66ca.philippe.gramoulle@mmania.com> <20030415163456.020f83c1.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030415163456.020f83c1.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 04:34:56PM -0700, Andrew Morton wrote:
> Philippe Gramoullé <philippe.gramoulle@mmania.com> wrote:
> >
> > I'll wait for the fix and will happily try it once it's available.
> 
> Something like this...
> 
> diff -puN lib/kobject.c~kobj_lock-fix lib/kobject.c
> --- 25/lib/kobject.c~kobj_lock-fix	Tue Apr 15 16:31:28 2003
> +++ 25-akpm/lib/kobject.c	Tue Apr 15 16:34:33 2003
> @@ -336,12 +336,14 @@ void kobject_unregister(struct kobject *
>  struct kobject * kobject_get(struct kobject * kobj)
>  {
>  	struct kobject * ret = kobj;
> -	spin_lock(&kobj_lock);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&kobj_lock, flags);
>  	if (kobj && atomic_read(&kobj->refcount) > 0)
>  		atomic_inc(&kobj->refcount);
>  	else
>  		ret = NULL;
> -	spin_unlock(&kobj_lock);
> +	spin_unlock_irqrestore(&kobj_lock, flags);
>  	return ret;
>  }
>  
> @@ -371,10 +373,15 @@ void kobject_cleanup(struct kobject * ko
>  
>  void kobject_put(struct kobject * kobj)
>  {
> -	if (!atomic_dec_and_lock(&kobj->refcount, &kobj_lock))
> -		return;
> -	spin_unlock(&kobj_lock);
> -	kobject_cleanup(kobj);
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	if (atomic_dec_and_lock(&kobj->refcount, &kobj_lock)) {
> +		spin_unlock_irqrestore(&kobj_lock, flags);
> +		kobject_cleanup(kobj);
> +	} else {
> +		local_irq_restore(flags);
> +	}
>  }

CCed Pat, as this is his territory.

Hm yeah, this will fix the problem.  But is there anyway we can do this
without a lock at all?  I think we wouldn't need the lock, if we didn't
test the refcount for > 0, right?  Pat, that just keeps us from getting
a reference count on a kobject that hasn't been initialized, right?
That is a good idea to do, but is it really necessary?

If only atomic_inc_return() was defined for all platforms we might be
able to do the following, dropping the lock entirely:

struct kobject * kobject_get(struct kobject * kobj)
{
	struct kobject * ret = kobj;
	if (kobj)
		if (atomic_inc_return(kobj->refcount) <= 1) {
			atomic_dec(kobj->refcount);
			ret = NULL;
		}
	else
		ret = NULL;
	return ret;
}

void kobject_put(struct kobject * kobj)
{
	if (!atomic_dec(&kobj->refcount))
		return;
	kobject_cleanup(kobj);
}


Or am I missing something?

Anyone know how to whip up a atomic_inc_return() for the platforms
missing it?

thanks,

greg k-h
