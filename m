Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbWGESlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWGESlt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 14:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWGESlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 14:41:49 -0400
Received: from smtp-out.google.com ([216.239.33.17]:36685 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964931AbWGESlt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 14:41:49 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=aXzWbW+HYJOJd4DD4rpXVaFx9kBumRrurHK1YZDy109FGYwTAoMr+jc7m2wtab3RE
	KLydlTutaj/sNY+hrhcvA==
Message-ID: <44AC07C4.6030108@google.com>
Date: Wed, 05 Jul 2006 11:41:08 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Johann Lombardi <johann.lombardi@bull.net>, sho@tnes.nec.co.jp,
       cmm@us.ibm.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] ext3: enlarge blocksize and fix rec_len overflow
References: <20060628205238sho@rifu.tnes.nec.co.jp> <20060628155048.GG2893@chiva> <20060628202421.GL5318@schatzie.adilger.int> <44A417A3.80001@google.com> <20060629202700.GD5318@schatzie.adilger.int> <44A450BB.60105@google.com> <20060630093113.GA2702@chiva> <44A56B45.6050506@google.com> <20060701083950.GB5355@schatzie.adilger.int>
In-Reply-To: <20060701083950.GB5355@schatzie.adilger.int>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> On Jun 30, 2006  11:19 -0700, Daniel Phillips wrote:
>>OK, just to handle the 64K case, what is wrong with treating 0 as 64K?
> 
> Hmm, good question - it's impossible to have a valid rec_len of 0 bytes.
> There would need to be some special casing in the directory handling code.
> Also, it breaks some of the directory sanity checking, and since "0" is
> a common corruption pattern it isn't great to use.  We could instead use
> 0xfffc to mean 0x10000 since they are virtually the same value and the
> error checking is safe.  It isn't possible to have this as a valid value.

That might be unnecessarily paranoid, a zero would be legal only with 64K
block size and then only in the first record of the block.

How about this wrapper, with associated struct field name change?

unsigned ext3_entry_len(struct ext3_dir_entry_2 *de)
{
	return (le16_to_cpu(de->entry_len) ? : (1 << 16);
}

Storing will just work.  In search_dirblock we don't even get extra code
because there is already a special check for zero that goes away.

Regards,

Daniel
