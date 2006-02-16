Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWBPDQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWBPDQi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 22:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWBPDQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 22:16:38 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:16763 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751371AbWBPDQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 22:16:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=4zz4TF8mUHdcusctuCO1Cn6bJxA0RDJnNDXo3qDZeNI39IUrhOabBTFNDpuZjQeuU0S0XiVzFkEhZZuPzp3wQ5oqoOeINnGA3rqN5jncp7aAZ5a+BlxGcNKkIMpAQoq/zFfZSitg9maMTWyRX/J7cC7kZD9+aOSQNB6aMfVZSVo=  ;
Message-ID: <43F3EE8F.8060000@yahoo.com.au>
Date: Thu, 16 Feb 2006 14:16:31 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Possibly bug in radix_tree_delete, and fix.
References: <17395.58244.839605.685011@cse.unsw.edu.au>
In-Reply-To: <17395.58244.839605.685011@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> Hi Nick,
>  I believe there is a bug in radix_tree_delete introduced by:
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=d5274261ea46f0aae93820fe36628249120d2f75
> 
> The nature of the bug is that if a tag is set on a node that is being
> deleted, then that tag is unconditionally cleared in the parent of the
> node, even if the deleted node has siblings with the tag still set.
> 
> I don't know what the large-scale consequences of this bug might be,
> but I'm kinda hoping fixing it will fix a nasty NFS client related
> oops we are seeing in radix_tree_tag_set ....
> 

I think you're right. I was kind of suspecting I might have introduced
a silly bug somewhere after a couple of radix tree oopses popped up.

Not sure why it didn't trigger Andrew's test suite, but I guess that's
something to add.

> My suggested patch is below.
> 
> Please review, confirm, and Ack:
> 

It should be basically an identical block to the one below in the main
loop, yeah? You're missing the nr_cleared_tags bit.

Something like:

    tags[tag] = 1;
    if (tag_get(pathp->node, tag, pathp->offset)) {
       tag_clear(pathp->node, tag, pathp->offset);
       if (!any_tag_set(pathp->node, tag)) {
          tags[tag] = 0;
          nr_cleared_tags++;
       }
    }

And you can add an
Acked-by: Nick Piggin <npiggin@suse.de>

Thanks,
Nick

> Thanks,
> NeilBrown
> 
> 
> Fix over-zealous clearing of tags in radix_tree_delete.
> 
> Signed-off-by: Neil Brown <neilb@suse.de>
> 
> ### Diffstat output
>  ./lib/radix-tree.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff ./lib/radix-tree.c~current~ ./lib/radix-tree.c
> --- ./lib/radix-tree.c~current~	2006-02-16 13:22:28.000000000 +1100
> +++ ./lib/radix-tree.c	2006-02-16 13:23:19.000000000 +1100
> @@ -755,7 +755,7 @@ void *radix_tree_delete(struct radix_tre
>  	for (tag = 0; tag < RADIX_TREE_TAGS; tag++) {
>  		if (tag_get(pathp->node, tag, pathp->offset)) {
>  			tag_clear(pathp->node, tag, pathp->offset);
> -			tags[tag] = 0;
> +			tags[tag] = any_tag_set(pathp->node, tag);
>  			nr_cleared_tags++;
>  		} else
>  			tags[tag] = 1;
> 


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
