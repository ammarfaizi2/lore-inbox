Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWF3DP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWF3DP4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 23:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbWF3DP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 23:15:56 -0400
Received: from terminus.zytor.com ([192.83.249.54]:9697 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751449AbWF3DPy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 23:15:54 -0400
Message-ID: <44A49759.9070305@zytor.com>
Date: Thu, 29 Jun 2006 20:15:37 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: cmm@us.ibm.com
CC: linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][Update][Patch 12/16]Fix undefined ">> 32" in revoke code
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <1151626725.6601.82.camel@dyn9047017069.beaverton.ibm.com>
In-Reply-To: <1151626725.6601.82.camel@dyn9047017069.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao wrote:
> "val >> 32" is undefined if val is a 32-bit value, so this code is
> broken if CONFIG_LBD is not set.  Make it safe for that case.
> 
> Signed-off-by: Stephen Tweedie <sct@redhat.com>
> Signed-off-by: Mingming Cao <cmm@us.ibm.com>
> 
> 
> ---
> 
>  linux-2.6.17-ming/fs/jbd/revoke.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN fs/jbd/revoke.c~jbd-revoke-32bit-shift-fix fs/jbd/revoke.c
> --- linux-2.6.17/fs/jbd/revoke.c~jbd-revoke-32bit-shift-fix	2006-06-28 16:47:09.695458913 -0700
> +++ linux-2.6.17-ming/fs/jbd/revoke.c	2006-06-28 16:47:09.699458454 -0700
> @@ -110,7 +110,7 @@ static inline int hash(journal_t *journa
>  {
>  	struct jbd_revoke_table_s *table = journal->j_revoke;
>  	int hash_shift = table->hash_shift;
> -	int hash = (int)block ^ (int)(block >> 32);
> +	int hash = (int)block ^ (int)((block >> 31) >> 1);
>  

It might be better to code it as:

	(int)((u64)block >> 32)

... which gcc can trivially recognize as 0 if block is 32 bits.  Not 
sure if it can do that with the code above.

	-hpa
