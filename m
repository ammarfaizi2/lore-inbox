Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbULVAA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbULVAA0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 19:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbULUX7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 18:59:06 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:21648 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261907AbULUX60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 18:58:26 -0500
Message-ID: <41C8B89E.7000806@yahoo.com.au>
Date: Wed, 22 Dec 2004 10:58:22 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>
CC: Chris Friesen <cfriesen@nortelnetworks.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chris Ross <chris@tebibyte.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.6.9-ac16
References: <200412211850_MC3-1-916E-59A6@compuserve.com>
In-Reply-To: <200412211850_MC3-1-916E-59A6@compuserve.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any chance this can get into 2.6 before Linus fires off 2.6.10?

Chuck Ebbert wrote:
> Chuck Ebbert wrote:
> 
> 
>> I backported this patch to 2.6.9 but haven't tested it yet.  It requires the
>>'spurious oomkill' patch I posted earlier in this thread.  Early reports
>>are that it stops the freezes during heavy paging.
> 
> 
>  OK here's one that actually compiles.  (3AM was not a good time to be
> making patches.)
> 
> # mm_swap_token_disable.patch
> #       include/linux/swap.h -0 +1
> #       mm/rmap.c -0 +3
> #       mm/thrash.c -1 +4
> #
> #       NOTE: On 2.6.9 there is no sysctl to change
> #             swap_token_default_timeout.
> #
> #       Based on a patch by Con Kolivas for 2.6.10
> #       Backported to 2.6.9 by Chuck Ebbert <76306.1226@compuserve.com>
> #
> --- 2.6.9.1/include/linux/swap.h
> +++ 2.6.9.2/include/linux/swap.h
> @@ -230,6 +230,7 @@
>  
>  /* linux/mm/thrash.c */
>  extern struct mm_struct * swap_token_mm;
> +extern unsigned long swap_token_default_timeout;
>  extern void grab_swap_token(void);
>  extern void __put_swap_token(struct mm_struct *);
>  
> --- 2.6.9.1/mm/rmap.c
> +++ 2.6.9.2/mm/rmap.c
> @@ -394,6 +394,9 @@ int page_referenced(struct page *page, i
>  {
>         int referenced = 0;
>  
> +       if (!swap_token_default_timeout)
> +               ignore_token = 1;
> +
>         if (page_test_and_clear_young(page))
>                 referenced++;
>  
> --- 2.6.9.1/mm/thrash.c
> +++ 2.6.9.2/mm/thrash.c
> @@ -19,7 +19,11 @@ unsigned long swap_token_check;
>  struct mm_struct * swap_token_mm = &init_mm;
>  
>  #define SWAP_TOKEN_CHECK_INTERVAL (HZ * 2)
> -#define SWAP_TOKEN_TIMEOUT (HZ * 300)
> +#define SWAP_TOKEN_TIMEOUT     0
> +/*
> + * Currently disabled; Needs further code to work at HZ * 300.
> + */
> +unsigned long swap_token_default_timeout = SWAP_TOKEN_TIMEOUT;
>  
>  /*
>   * Take the token away if the process had no page faults
> _
