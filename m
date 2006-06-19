Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWFSKpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWFSKpS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 06:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWFSKpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 06:45:18 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:44941 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932211AbWFSKpP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 06:45:15 -0400
Message-ID: <44967EA9.9070307@in.ibm.com>
Date: Mon, 19 Jun 2006 16:08:33 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Blunck <jblunck@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@zeniv.linux.org.uk, dgc@sgi.com, neilb@suse.de
Subject: Re: [PATCH 2/5] vfs: d_genocide() doesnt add dentries to unused list
References: <20060616104321.778718000@hasse.suse.de> <20060616104322.204073000@hasse.suse.de> <4495AABE.6090007@in.ibm.com> <20060619092249.GB6824@hasse.suse.de>
In-Reply-To: <20060619092249.GB6824@hasse.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Blunck wrote:
> On Mon, Jun 19, Balbir Singh wrote:
> 
> 
>>>			this_parent = dentry;
>>>			goto repeat;
>>>		}
>>>-		atomic_dec(&dentry->d_count);
>>>+		if (!list_empty(&dentry->d_lru)) {
>>>+			dentry_stat.nr_unused--;
>>>+			list_del_init(&dentry->d_lru);
>>>+		}
>>>+		if (atomic_dec_and_test(&dentry->d_count)) {
>>>+			list_add(&dentry->d_lru, dentry_unused.prev);
>>>+			dentry_stat.nr_unused++;
>>>+		}
>>
>>We could have dentries on the LRU list with non-zero d_count. If
>>we have a dentry on the LRU list with a count of 1, then the code
>>will remove it from LRU list and then add it back subsequently.
>>
> 
> 
> So you think this is better?
> 
>    if (atomic_dec_and_test(&dentry->d_count)) {
>       if (!list_empty(&dentry_d_lru))
>          list_move_tail(&dentry->d_lru, dentry_unused);
>    } else
>       if (!list_empty(&dentry->d_lru)) {
>          dentry_stat.nr_unused--;
>          list_del_init(&dentry->d_lru);
>       }
> 
> 

Yes, I think it is.

> 
>>I think the condition below should be an else if
>>
> 
> 
> No. We always lower the reference count in d_genocide.
> 

Yep, good catch

> 
>>d_genocide() now almost looks like select_parent(). I think we can share a 
>>lot
>>of code between the two.
>>
> 
> 
> Hmm, interesting idea. This would save the dentry-tree walking code in
> have_submounts too. Maybe something like this:
> 
> +static int select_parent_walker(struct dentry * dentry, int * found)
> +{
> +       if (!list_empty(&dentry->d_lru)) {
> +               dentry_stat.nr_unused--;
> +               list_del_init(&dentry->d_lru);
> +       }
> +
> +       /*
> +        * move only zero ref count dentries to the end
> +        * of the unused list for prune_dcache
> +        */
> +       if (!atomic_read(&dentry->d_count)) {
> +               list_add(&dentry->d_lru, dentry_unused.prev);
> +               dentry_stat.nr_unused++;
> +               *found++;
> +       }
> +
> +       /*
> +        * We can return to the caller if we have found some (this
> +        * ensures forward progress). We'll be coming back to find
> +        * the rest.
> +        */
> +       if (*found && need_resched())
> +               return -1;

Is this true for all paths? d_genocide() might actually not return

> +
> +       return 0;
> +}
> +
> +typedef int (*walker_t)(struct dentry * dentry, int * return);
> +

Will there be a different type of walker as well? Is it going to be too different?

> +static int dentry_tree_walk(struct dentry * parent, walker_t walker)
> +{
> +       struct dentry *this_parent = parent;
> +       struct list_head *next;
> +       int ret = 0;
> +
> +       spin_lock(&dcache_lock);
> +repeat:
> +       next = this_parent->d_subdirs.next;
> +resume:
> +       while (next != &this_parent->d_subdirs) {
> +               struct list_head *tmp = next;
> +               struct dentry *dentry = list_entry(tmp, struct dentry,
> +                                                  d_u.d_child);
> +               next = tmp->next;
> +
> +               if (walker(dentry, &ret))
> +                       goto out;
> +
> +               /*
> +                * Descend a level if the d_subdirs list is non-empty.
> +                */
> +               if (!list_empty(&dentry->d_subdirs)) {
> +                       this_parent = dentry;
> +                       goto repeat;
> +               }
> +       }
> +       /*
> +        * All done at this level ... ascend and resume the search.
> +        */
> +       if (this_parent != parent) {
> +               next = this_parent->d_u.d_child.next;
> +               this_parent = this_parent->d_parent;
> +               goto resume;
> +       }
> +out:
> +       spin_unlock(&dcache_lock);
> +       return ret;
> +}

The overall code looks good.

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
