Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752427AbWJ0T1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbWJ0T1i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 15:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752430AbWJ0T1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 15:27:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39583 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752427AbWJ0T1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 15:27:37 -0400
To: Zach Brown <zach.brown@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dio: lock refcount operations
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
References: <20061027181735.18631.43565.sendpatchset@tetsuo.zabbo.net>
From: Jeff Moyer <jmoyer@redhat.com>
Date: Fri, 27 Oct 2006 15:27:25 -0400
In-Reply-To: <20061027181735.18631.43565.sendpatchset@tetsuo.zabbo.net> (Zach Brown's message of "Fri, 27 Oct 2006 11:17:35 -0700 (PDT)")
Message-ID: <x49fyd9v9sy.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding [PATCH] dio: lock refcount operations; Zach Brown <zach.brown@oracle.com> adds:

zach.brown> dio: lock refcount operations The wait_for_more_bios() function
zach.brown> name was poorly chosen.  While looking to clean it up it I
zach.brown> noticed that the dio struct refcounting between the bio
zach.brown> completion and dio submission paths was racey.

zach.brown> The bio submission path was simply freeing the dio struct if
zach.brown> atomic_dec_and_test() indicated that it dropped the final
zach.brown> reference.

zach.brown> The aio bio completion path was dereferencing its dio struct
zach.brown> pointer *after dropping its reference* based on the remaining
zach.brown> number of references.

zach.brown> These two paths could race and result in the aio bio completion
zach.brown> path dereferencing a freed dio, though this was not observed in
zach.brown> the wild.

I don't believe that this can happen.  dio_bio_end_aio will only reference
the dio if (remaining == 1 && waiter_holds_ref).  If the waiter is holding
the reference, then the bio submission path would not have dropped its
reference yet!

-Jeff
