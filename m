Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbUDCC6E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 21:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUDCC6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 21:58:04 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:28624 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S261317AbUDCC56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 21:57:58 -0500
Date: Sat, 03 Apr 2004 11:58:33 +0900 (JST)
Message-Id: <20040403.115833.74749140.taka@valinux.co.jp>
To: Zoltan.Menyhart@bull.net, Zoltan.Menyhart_AT_bull.net@nospam.org
Cc: haveblue@us.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, iwamoto@valinux.co.jp
Subject: Re: Migrate pages from a ccNUMA node to another - patch
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <40698501.BD3E12BF@nospam.org>
References: <40695802.1F13AB0D@nospam.org>
	<20040330.210804.71938972.taka@valinux.co.jp>
	<40698501.BD3E12BF@nospam.org>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

>> It's not hard to add "no-retry-mode" to "remap_onepage()" function
>> if you want. It may skip to migrate some pages if they are accessed
>> heavily. In paticular if you only want to care about anonymous pages,
>> they will be handled very well.
>
>Well, why not to give it a try ?
>Yet your code is not really easy to read. :-)
>I do not dare to adapt it on my own, I am afraid of breaking something.
>Could you please provide me a modified version of your "remap_onepage()" ?
>Can we move to 2.6.4 ?

Iwamot and I are working on this. We'll post it soon.

>In addition to "no-retry-mode", I need to specify where the new page
>should be allocated from.
>
>Here is my interface I need to implement with "remap_onepage()":

I guess aruguments src_node, mm and pte would be redundant since
they can be looked up from old_p with the reverse mapping scheme.

>/*
> * Common part of checking & migrating the pages one by one.
> *
> * Arguments:	src_node:	Source NUMA node
> *		old_p:		-> old page structure
> *		node:		Destination NUMA node
> *		mm:		-> victim "mm_struct"
> *		pte:		-> PTE of the page to be moved
> *
> * Returns:	1:		Migration O. K.
> *		0:		Minor error, no actual migration has been done
> *		-Exxx:		Catastrophic error
> *
> * Notes:	- "mm->page_table_lock" and "mm->mmap_sem" have to be held.
> *		- The old page is "get_page()"-ed on entry to make sure it does not go
> *		  away in the mean time - on return it gets "put_page()"-ed.
> */
>int
>common_check_migrate_1_page(const int src_node, struct page * const old_p,
>			const int node, struct mm_struct * const mm, pte_t * const pte)
>
>Notes: "pte" can be NULL if I do not know it apriori
>       I cannot release "mm->page_table_lock" otherwise I have to re-scan the "mm->pgd".

Re-schan plicy would be much better since migrating pages is heavy work.
I don't think that holding mm->page_table_lock for long time would be
good idea.

How do you think about following algorism:
  1. get mm->page_table_lock
  2. chose some pages.
  3. release mm->page_table_lock
  4. call remap_onepage() against each page.
  5. goto step1 if there remain pages to be migrated.

