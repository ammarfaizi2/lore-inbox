Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbWHDDJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWHDDJq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 23:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWHDDJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 23:09:46 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:29646 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030305AbWHDDJp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 23:09:45 -0400
Subject: Re: [PATCH] memory hotadd fixes [6/5] enhance collistion check
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: andrew <akpm@osdl.org>, y-goto@jp.fujitsu.com,
       lkml <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>
In-Reply-To: <20060804113245.30487789.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060803123604.0f909208.kamezawa.hiroyu@jp.fujitsu.com>
	 <1154650396.5925.49.camel@keithlap>
	 <20060804094443.c6f09de6.kamezawa.hiroyu@jp.fujitsu.com>
	 <1154656472.5925.71.camel@keithlap>
	 <20060804111550.ab30fc15.kamezawa.hiroyu@jp.fujitsu.com>
	 <20060804113245.30487789.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 03 Aug 2006 20:09:42 -0700
Message-Id: <1154660982.5925.87.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 11:32 +0900, KAMEZAWA Hiroyuki wrote:
> Okay... here is 6/5 patch..
> 
> On Fri, 4 Aug 2006 11:15:50 +0900
> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote: 
> > > > Maybe moving ioresouce collision check in early stage of add_memory() is good ?
> > >   Yea.  I am working a a full patch set for but my sparsemem and reserve
> > > add-based paths.  It creates a valid_memory_add_range call at the start
> > > of add_memory. I should be posting the set in the next few hours.
> > > 
> > Ah..ok. but I wrote my own patch...and testing it now..
> > 
> 
> This patch passed test with ia64. based on 5 patches already sent.
> plz check. 

<snip>
>  	pg_data_t *pgdat = NULL;
>  	int new_pgdat = 0;
> +	struct resource *res;
>  	int ret;
>  
> +	res = register_memory_resource(start, size);
> +	if (!res)
> +		return -EEXIST;
> +
>  	if (!node_online(nid)) {
>  		pgdat = hotadd_new_pgdat(nid, start);
>  		if (!pgdat)
> @@ -277,14 +293,13 @@
>  		BUG_ON(ret);
>  	}
>  
> -	/* register this memory as resource */
> -	ret = register_memory_resource(start, size);
> -
>  	return ret;
>  error:
>  	/* rollback pgdat allocation and others */
>  	if (new_pgdat)
>  		rollback_node_hotadd(nid, pgdat);
> +	if (res)
> +		release_memory_resource(res);
>  


I am trying to keep add_memory non-sparsemem specific.  With reserve
memory the memory is already present and so using
register_memory_resource as a key to find out if it is already present
won't work.

I can build ontop of this if you want me to.  I would like to test this
to make sure it works for me. (I will do this sometime today)


Thanks,
  Keith 

