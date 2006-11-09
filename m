Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161781AbWKIBQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161781AbWKIBQo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 20:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161780AbWKIBQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 20:16:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:27870 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423589AbWKIBQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 20:16:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=VbiZQGnH/c3ODQ6abBhrHoieaz6E+3jILcVSiB8c8goonvznrG1L7eXdayYgxFMwJOKcjcLNEz2R59lgCiFgfKPLZ1Z7/7rvJ5nJQC5QfASBYH/zvWw1RAVri6QW3J9otNYyQWt+7ZQm35HkFFVz4e2557YE6qjGoouJKN1Dggg=
Subject: [RESEND PATCHSET] direct-io: unify asyn/sync completion paths and fix completion bugs
In-Reply-To: 
X-Mailer: git-send-email
Date: Thu, 9 Nov 2006 10:16:11 +0900
Message-Id: <11630349713427-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: zach.brown@oracle.com, pbadari@us.ibm.com, suparna@in.ibm.com,
       jmoyer@redhat.com, akpm@osdl.org, cwyang@aratech.co.kr,
       linux-kernel@vger.kernel.org, htejun@gmail.com
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[forgot to include lkml, resending.  sorry ppl.]

Hello, Zach Brown, all.

Chul-Woong Yang of Aratech reported kernel oops after failed aio
(partially mapped request) on 2.6.19-rc4 and I spent three days
chasing the bug and hacking direct-io only to find out that there are
pending patches in -mm.

Oh, well.. As my patches are almost ready now, I'm posting it, for
cross-check if nothing else.  The biggest difference between your fix
and mine is that instead of merging waiting code, I just unified whole
completion paths.  ie. Sync requests are handled exactly the same as
async requests.  They are pre-dirtied, completed from bio completion
callback and redirtied from bio_dirty_work if necessary.  That
simplified the code a lot and made it humanly readable. :-)

The only concern is possible performance impact for sync DIOs due to
the change in how dirtying is done.  As it's done per-bio, the chance
of being written back between pre-issue dirtying and post-completion
checking should be pretty slim, so I don't think it would have any
noticeable effect.  Async DIOs have been handled that way after all.

I reshuffled things a bit just before finding out your patch and
didn't test it thoroughly after that, but it should be enough to get
the idea.

Arghh... The lesson here is... check -mm before starting hacking
unfamiliar code.  I'm back to libata now.

Thanks.

--
tejun


