Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933044AbWF2WOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933044AbWF2WOo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 18:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933045AbWF2WOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 18:14:43 -0400
Received: from smtp-out.google.com ([216.239.45.12]:64583 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S933044AbWF2WOm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 18:14:42 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=kwn/ljuO5hzG/3JVejxPmlajI8qP6iLynwx2JqPFKF1PKcQeMDpm9V/d2U+wES2n0
	32cx0dfzC67/LgDxHb38A==
Message-ID: <44A450BB.60105@google.com>
Date: Thu, 29 Jun 2006 15:14:19 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Johann Lombardi <johann.lombardi@bull.net>, sho@tnes.nec.co.jp,
       cmm@us.ibm.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] ext3: enlarge blocksize and fix rec_len overflow
References: <20060628205238sho@rifu.tnes.nec.co.jp> <20060628155048.GG2893@chiva> <20060628202421.GL5318@schatzie.adilger.int> <44A417A3.80001@google.com> <20060629202700.GD5318@schatzie.adilger.int>
In-Reply-To: <20060629202700.GD5318@schatzie.adilger.int>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> On Jun 29, 2006  11:10 -0700, Daniel Phillips wrote:
>>Andreas Dilger wrote:
>>>On Jun 28, 2006  17:50 +0200, Johann Lombardi wrote:
>>>
>>>>ext2/ext3_dir_entry_2 has a 16-bit entry(rec_len) and it would overflow
>>>>with 64KB blocksize.  This patch prevent from overflow by limiting
>>>>rec_len to 65532.
>>>
>>>Having a max rec_len of 65532 is rather unfortunate, since the dir
>>>blocks always need to filled with dir entries.  65536 - 65532 = 4, and
>>>the minimum ext3_dir_entry size is 8 bytes.  I would instead make this
>>>maybe 64 bytes less so that there is room for a filename in the "tail"
>>>dir_entry.
>>
>>Then why not introduce a little symmetry by making max rec_len 2**15 and
>>treat big directory blocks as an array of smaller ones?  I dimly recall
>>the page-cache oriented Ext2 dir code already does this.
> 
> I have no objection to this at all, but I think it will lead to a slightly
> more complex implementation.  We even discussed in the distant past to
> make large directories a series of 4kB "chunks", for fs blocksize >= 4kB.
> This has negative implications for large filenames because the internal
> free space fragmentation is high, but has the advantage that it might
> eventually still be usable if we can get blocksize > PAGE_SIZE.
> 
> The difficulty is that when freeing dir entires you would have to be
> concerned with a merging a dir_entry that is spanning the middle
> of a 2^16 block.

That is easy, just don't let an entry span subblocks by not letting
delete merge past the end of a subblock, just a minor tweak.  New block
initialization needs an outer loop on subblocks and that's it, I think.

Regards,

Daniel
