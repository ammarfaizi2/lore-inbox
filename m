Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWBXBVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWBXBVS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWBXBVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:21:18 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:56736 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S932363AbWBXBVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:21:17 -0500
Message-ID: <43FE5F84.4000001@oracle.com>
Date: Thu, 23 Feb 2006 17:21:08 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: suparna@in.ibm.com
Cc: akpm@osdl.org, sct@redhat.com, mason@suse.com,
       linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
       kenneth.w.chen@intel.com, pbadari@us.ibm.com,
       linux-kernel@vger.kernel.org, sonny@burdell.org
Subject: Re: [RFC][WIP] DIO simplification and AIO-DIO stability
References: <20060223072955.GA14244@in.ibm.com>
In-Reply-To: <20060223072955.GA14244@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya wrote:

> A recent AIO-DIO bug reported by Kenneth Chen, came very close
> to being the proverbial last straw for me.

Me too, though I found out about it from a different path.  Our QA guys
were pulling drives under load and it got stuck.  Trying to fix that bug
(io error setting dio->result to -EIO stops finished_one_bio() from
calling aio_complete()) without introducing other regressions involved
an incredible amount of squinting and head scratching.  In wandering
around I found what seem to be other additional bugs:

- errors that hit after dio->result is sampled in the buffered fallback
case are lost.  dio->result should be checked again after waiting.

- a few paths try to do arithmetic with dio->result assuming it's the
number of bytes transferred when it could be -EIO.

- the AIO path seems to forget to check dio->page_errors, but I didn't
look very hard to see what that means.

- the AIO bio completion paths don't populate dio->bio_list so reaping
doesn't happen in the AIO issuing case.. maybe that's intentional?

> It would be quite pointless (and painful!), if the rewrite ends up becoming
> just as tricky and error prone as before. Such a patch will need a very
> close critical review by many sharp eyes, to avoid disrupting the current
> state of stability.

So, I'm all for wringing the current bugs and confusion out of the
current code.  But the words "a patch" and "rewrite" terrify me.  It
seems much more prudent to make progress with incremental patches that
can be tested and reviewed.  Especially if that is tied to writing tests
as changes are made.

Let me think harder about the specific proposals..

- z
