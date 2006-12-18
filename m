Return-Path: <linux-kernel-owner+w=401wt.eu-S1754688AbWLRWV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688AbWLRWV7 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 17:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754685AbWLRWV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 17:21:59 -0500
Received: from ns1.coraid.com ([65.14.39.133]:13487 "EHLO coraid.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754675AbWLRWV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 17:21:58 -0500
Date: Mon, 18 Dec 2006 17:21:09 -0500
From: "Ed L. Cashin" <ecashin@coraid.com>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>, boddingt@optusnet.com.au,
       Andrew Morton <akpm@osdl.org>, bugme-daemon@bugzilla.kernel.org,
       Christoph Hellwig <hch@infradead.org>
Subject: bio pages with zero page reference count
Message-ID: <20061218222109.GA23156@coraid.com>
Reply-To: support@coraid.com
References: <20061209234305.c65b4e14.akpm@osdl.org> <20061218175300.GM23156@coraid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061218175300.GM23156@coraid.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(This email is a followup to "Re: [PATCH 2.6.19.1] fix aoe without
scatter-gather [Bug 7662]".)

On Mon, Dec 18, 2006 at 12:53:00PM -0500, Ed L. Cashin wrote:
...
> This patch eliminates the offset data on cards that don't support
> scatter-gather or have had scatter-gather turned off.  There remains
> an unrelated issue that I'll address in a separate email.

After fixing the problem with the skb headers, we noticed that there
were still problems when scatter gather wasn't in use.  XFS was giving
us bios that had pages with a reference count of zero.

The aoe driver sets up the skb with the frags pointing to the pages,
and when scatter gather isn't supported and __pskb_pull_tail gets
involved, put_page is called after the data is copied from the pages.
That causes problems because of the zero page reference count.

It seems like it would always be incorrect for one part of the kernel
to give pages with a zero reference count to another part of the
kernel, so this seems like a bug in XFS.

Christoph Hellwig, though, points out,

  > It's a kmalloced page.  The same can happen with ext3 aswell, but
  > only when doing log recovery.  The last time this came up (vs
  > iscsi) the conclusion was that the driver needs to handle this
  > case.

In attempting to find the conversation he was referencing, I only
found this:

  Subject: tcp_sendpage and page allocation lifetime vs. iscsi
  Date: 2005-04-25 17:02:59 GMT
  http://article.gmane.org/gmane.linux.kernel/298377

If anyone has a better reference, I'd like to see it.

-- 
  Ed L Cashin <ecashin@coraid.com>
