Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265956AbUF2TDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265956AbUF2TDx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 15:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265957AbUF2TDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 15:03:43 -0400
Received: from mail.aknet.ru ([217.67.122.194]:52489 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S265922AbUF2TDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 15:03:32 -0400
Message-ID: <40E1BD0A.2020400@aknet.ru>
Date: Tue, 29 Jun 2004 23:03:38 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Rohland <cr@sap.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch][rfc] expandable anonymous shared mappings
References: <Pine.LNX.4.44.0406291828030.16640-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0406291828030.16640-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Hugh Dickins wrote:
>> It is full of surprises, it will map a zero-page to you,
>> it will give you a SIGBUS, it will do everything
> From this attack on poor little mremap(), I think perhaps there's
> something else you didn't realize, that I'd assumed you did realize.
OK, the last time I was messing around the
mremap, it was mapping the anonymous pages
to me when I was trying to expand the /dev/mem
mapping (missing nopage handler apparently,
having the failure could be much better in that
case I think).

> So mremap() is entirely consistent to allow you to extend a mapping
> beyond the end of the object, such that you'll get SIGBUS if you
> try to access the end of your mapping.
Yes, as for SIGBUS - now I see why it works that
way (not necessary accept its correctness, but
what you said, sounds perfectly valid to me, so
the complete retirement on my side:)

> The deficiency with shared anonymous is that there's no way to expand
> or shrink the underlying object to match the mapping, whereas you can
> ftruncate a real file.
... and/or expand the anonymous private mapping without
the truncation (nothing to truncate). So yes, after all,
it was specific to the anon-shm, which is a special case.
And introducing the per-vma mremap handlers to fix only
this special case (by doing the truncation immediately)
is an overkill and is not required by anyone except myself.
And this:
---
In most 
cases (at least for the malloc case) this will be a anonymous mapping, 
but it's by no means an error to extend any mapping you have created.
---
may just mean that it is never an error, but you have
to deal with the consequences yourself if you expanded
only the mapping and not the object (except for the
case of anon-shm, where you can't deal with the
consequences anyhow since you can't expand the object).
Have I got everything properly this time, or failed the
homework agan? :)

