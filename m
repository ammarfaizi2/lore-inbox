Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932999AbWF3SVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932999AbWF3SVz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933000AbWF3SVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:21:54 -0400
Received: from smtp-out.google.com ([216.239.45.12]:31395 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932999AbWF3SVx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:21:53 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=rTj858/0vL9b4RfTPiNrm7J2ESksZNernAMaXWPr3xiFBdS3+VIhiI4MzliPpwAF0
	fJLGH2rrp5C7hXP3hdcZw==
Message-ID: <44A56B45.6050506@google.com>
Date: Fri, 30 Jun 2006 11:19:49 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Johann Lombardi <johann.lombardi@bull.net>
CC: Andreas Dilger <adilger@clusterfs.com>, sho@tnes.nec.co.jp, cmm@us.ibm.com,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] ext3: enlarge blocksize and fix rec_len overflow
References: <20060628205238sho@rifu.tnes.nec.co.jp> <20060628155048.GG2893@chiva> <20060628202421.GL5318@schatzie.adilger.int> <44A417A3.80001@google.com> <20060629202700.GD5318@schatzie.adilger.int> <44A450BB.60105@google.com> <20060630093113.GA2702@chiva>
In-Reply-To: <20060630093113.GA2702@chiva>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johann Lombardi wrote:
>>>I have no objection to this at all, but I think it will lead to a slightly
>>>more complex implementation.  We even discussed in the distant past to
>>>make large directories a series of 4kB "chunks", for fs blocksize >= 4kB.
>>>This has negative implications for large filenames because the internal
>>>free space fragmentation is high, but has the advantage that it might
>>>eventually still be usable if we can get blocksize > PAGE_SIZE.
>>>
>>>The difficulty is that when freeing dir entires you would have to be
>>>concerned with a merging a dir_entry that is spanning the middle
>>>of a 2^16 block.
>>
>>That is easy, just don't let an entry span subblocks by not letting
>>delete merge past the end of a subblock, just a minor tweak.  New block
>>initialization needs an outer loop on subblocks and that's it, I think.
> 
> 
> I've been working on a patch implementing this feature. It currently works w/o 
> htree.
> With dir_index, the difficulty is that an entry can span subblocks after a leaf
> block split.

Argh, hoist by my own petard!  That is not the only problem - we also need
to represent 64K empty records for the index blocks.  These issues need to
be dealt with in order to go past 64K blocks, and then we have so many
entries per block we probably want to rethink the leaf format anyway.  OK,
just to handle the 64K case, what is wrong with treating 0 as 64K?

Regards,

Daniel

