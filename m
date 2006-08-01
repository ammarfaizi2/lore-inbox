Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422783AbWHALyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422783AbWHALyF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422784AbWHALyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:54:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21203 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422783AbWHALyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:54:03 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Paulo Marques <pmarques@grupopie.com>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 8/33] kallsyms.c: Generate relocatable symbols.
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<11544302331578-git-send-email-ebiederm@xmission.com>
	<44CF3CCE.9010209@grupopie.com>
Date: Tue, 01 Aug 2006 05:52:25 -0600
In-Reply-To: <44CF3CCE.9010209@grupopie.com> (Paulo Marques's message of "Tue,
	01 Aug 2006 12:36:46 +0100")
Message-ID: <m1psfkzn9i.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques <pmarques@grupopie.com> writes:

> Eric W. Biederman wrote:
>> Print the addresses of non-absolute symbols relative to _text
>> so that ld will generate relocations.  Allowing a relocatable
>> kernel to relocate them.  We can't actually use the symbol names
>> because kallsyms includes static symbols that are not exported
>> from their object files.
>> [...]
>>  	output_label("kallsyms_addresses");
>>  	for (i = 0; i < table_cnt; i++) {
>> -		printf("\tPTR\t%#llx\n", table[i].addr);
>> +		if (toupper(table[i].sym[0]) != 'A') {
>> +			printf("\tPTR\t_text + %#llx\n",
>> +				table[i].addr - _text);
>> +		} else {
>> +			printf("\tPTR\t%#llx\n", table[i].addr);
>> +		}
>
> Doesn't this break kallsyms for almost everyone?
>
> kallsyms addresses aren't used just for displaying, but also to find symbols
> from their addresses (from the stack trace, etc.).
>
> Am I missing something?

Yes, you are missing something.  This fixes the addresses in the table.

All this does is to put the same values in kallsyms that we have now
but it creates relocations for them.   So on a kernel where we process
relocations before loading (because we are running the kernel at a
different virtual address).  The processing of the relocations will
fix kallsyms to match the running kernel.

If we don't do this we will have the problems you are worried about.

Of course I would be overjoyed if you could point out a bug like
you are worried about so I could fix it :)

Eric
