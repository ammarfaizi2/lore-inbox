Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317314AbSFGS1L>; Fri, 7 Jun 2002 14:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317316AbSFGS1K>; Fri, 7 Jun 2002 14:27:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46854 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317314AbSFGS1J>;
	Fri, 7 Jun 2002 14:27:09 -0400
Message-ID: <3D00FBDA.7020106@zip.com.au>
Date: Fri, 07 Jun 2002 11:30:50 -0700
From: Andrew Morton <akpm@zip.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Jendrissek <berndj@prism.co.za>
CC: linux-kernel@vger.kernel.org, netfilter@lists.samba.org
Subject: Re: [patch 2/16] list_head debugging
In-Reply-To: <20020607161705.V2270@prism.co.za>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Jendrissek wrote:
> [sorry for the nonexistent In-Reply-To/whatever headers - cutting&pasting]
> 
> Andrew Morton wrote:
> 
>>  A common and very subtle bug is to use list_heads which aren't on any
>>  lists. It causes kernel memory corruption which is observed long after
>>  the offending code has executed.
>>
>>  The patch nulls out the dangling pointers so we get a nice oops at the
>>  site of the buggy code.
> 
> 
> I'm not current with the kernel tree, but will one such oops occur in
> netfilter?  See
> 
> http://lists.samba.org/pipermail/netfilter-announce/2002/000010.html
> 
> Hmm, no.  A DoS maybe?
> 

An oops, actually.  This code:


         /* Remove from both hash lists: must not NULL out next ptrs,
            otherwise we'll look unconfirmed.  Fortunately, LIST_DELETE
            doesn't do this. --RR */
         LIST_DELETE(&ip_conntrack_hash
                     [hash_conntrack(&ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple)],
                     &ct->tuplehash[IP_CT_DIR_ORIGINAL]);
         LIST_DELETE(&ip_conntrack_hash
                     [hash_conntrack(&ct->tuplehash[IP_CT_DIR_REPLY].tuple)],
                     &ct->tuplehash[IP_CT_DIR_REPLY]);


I think what is needed is:

--- 2.5.20/net/ipv4/netfilter/ip_conntrack_core.c~ipconntrack-lists	Fri Jun  7 11:26:38 2002
+++ 2.5.20-akpm/net/ipv4/netfilter/ip_conntrack_core.c	Fri Jun  7 11:26:42 2002
@@ -210,17 +210,22 @@ static void destroy_expectations(struct
  static void
  clean_from_lists(struct ip_conntrack *ct)
  {
+ 
struct list_head *l1;
+ 
struct list_head *l2;
+
  	DEBUGP("clean_from_lists(%p)\n", ct);
  	MUST_BE_WRITE_LOCKED(&ip_conntrack_lock);
- 
/* Remove from both hash lists: must not NULL out next ptrs,
-           otherwise we'll look unconfirmed.  Fortunately, LIST_DELETE
-           doesn't do this. --RR */
+
+ 
l1 = &ct->tuplehash[IP_CT_DIR_ORIGINAL];
+ 
l2 = &ct->tuplehash[IP_CT_DIR_REPLY];
+
  	LIST_DELETE(&ip_conntrack_hash
  		    [hash_conntrack(&ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple)],
- 
	    &ct->tuplehash[IP_CT_DIR_ORIGINAL]);
- 
LIST_DELETE(&ip_conntrack_hash
- 
	    [hash_conntrack(&ct->tuplehash[IP_CT_DIR_REPLY].tuple)],
- 
	    &ct->tuplehash[IP_CT_DIR_REPLY]);
+ 
	    l1);
+ 
if (l1 != l2)
+ 
	LIST_DELETE(&ip_conntrack_hash
+ 
		    [hash_conntrack(&ct->tuplehash[IP_CT_DIR_REPLY].tuple)],
+ 
		    l2);

  	/* Destroy all un-established, pending expectations */
  	destroy_expectations(ct);


-

