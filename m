Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWCTLcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWCTLcu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 06:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWCTLcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 06:32:50 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:48785 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751129AbWCTLct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 06:32:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=hClxBydpha5QdXr6lI8o5V35dQxuxGc4Vl4GusSdPH2W6zNJ2kOboiJUaiSFv5/S95urifkd7jVZYqg0IpxBTJAcJpLH3OUNu1dRwD9b66w1M1/o04FPWByy9PsiVTznGvH94dOxp/Nipoql5l1ebZLN1z5H5gzXSm0VzcXd5Jw=  ;
Message-ID: <441E92D8.4070309@yahoo.com.au>
Date: Mon, 20 Mar 2006 22:32:40 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: prasanna@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, ak@suse.de, davem@davemloft.net,
       suparna@in.ibm.com, richardj_moore@uk.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [3/3 PATCH] Kprobes: User space probes support- single stepping
 out-of-line
References: <20060320060745.GC31091@in.ibm.com>	<20060320060931.GD31091@in.ibm.com>	<20060320061014.GE31091@in.ibm.com>	<20060320061123.GF31091@in.ibm.com> <20060320030922.4ea9445b.akpm@osdl.org>
In-Reply-To: <20060320030922.4ea9445b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Prasanna S Panchamukhi <prasanna@in.ibm.com> wrote:

>>+
>>+/**
>>+ * This routines get the pte of the page containing the specified address.
>>+ */
>>+static pte_t  __kprobes *get_uprobe_pte(unsigned long address)
>>+{
>>+	pgd_t *pgd;
>>+	pud_t *pud;
>>+	pmd_t *pmd;
>>+	pte_t *pte = NULL;
>>+
>>+	pgd = pgd_offset(current->mm, address);
>>+	if (!pgd)
>>+		goto out;
>>+
>>+	pud = pud_offset(pgd, address);
>>+	if (!pud)
>>+		goto out;
>>+
>>+	pmd = pmd_offset(pud, address);
>>+	if (!pmd)
>>+		goto out;
>>+
>>+	pte = pte_alloc_map(current->mm, pmd, address);
>>+
>>+out:
>>+	return pte;
>>+}
> 
> 
> That's familiar looking code..
> 
> I guess this should be given a more generic name then placed in
> mm/memory.c, which is where we do pagetable walking.
> 

Apart from this, there looks like quite a bit of other mm code
that has been crammed into everywhere but mm/ (yes this has
happened before, but it shouldn't be encouraged in new code).

For this specific example, I'm not sure that a function returning
a pointer to a pte is a good idea to be exporting. I'd like to see
some good reasons why things like get_user_pages, find_*_page, and
other standard APIs can't be used. Then you can list those reasons
in an individual patch to add your required API to mm/. This can
be more easily reviewed by people who aren't as good at wading
through code as Andrew.

Also, adding your own mm code outside core files really makes
things hard to maintain and audit when somebody would like to
change anything.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
