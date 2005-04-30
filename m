Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVD3QaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVD3QaH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 12:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVD3QaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 12:30:07 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:54476 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261279AbVD3QaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 12:30:02 -0400
Subject: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread
From: Steve French <smfrench@austin.rr.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, 7eggert@gmx.de, linux-kernel@vger.kernel.org
In-Reply-To: <E1DRueC-0002gU-00@dorka.pomaz.szeredi.hu>
References: <3YLdQ-4vS-15@gated-at.bofh.it>
	 <E1DRekV-0001RN-VQ@be1.7eggert.dyndns.org>
	 <20050430073238.GA22673@infradead.org>
	 <E1DRn70-0002AD-00@dorka.pomaz.szeredi.hu>
	 <20050430082952.GA23253@infradead.org>
	 <E1DRoBU-0002Fk-00@dorka.pomaz.szeredi.hu>
	 <E1DRpfS-0002Nc-00@dorka.pomaz.szeredi.hu> <427387FB.4030901@austin.rr.com>
	 <E1DRueC-0002gU-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Message-Id: <1114874844.5119.9.camel@smfhome.smfdom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 30 Apr 2005 10:27:24 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-30 at 11:16, Miklos Szeredi wrote:

> The big problem is the page cache, because that is not limited.  The
> user can mmap huge amounts of memory, dirty them, and then when the
> machine runs out of memory, and writeback kicks in, it may already be
> too late.

Yes - we have seen the inode caching get too aggressive in testcases
with paired machines each mounting two clients and also running two
servers - in particular running an NFS and CIFS mounts from the same
client to a server running nfsd and Samba, and then doing the reverse
and launching large file copy testcases going both directions at the
same time.  To make it nastier they add exports for Samba and NFS of
more than one local filesystem type.  Fortunately most of the issues
there have been fixed, but it is an incredibly hard thing to guarantee
that there is enough memory in those cases because so much is taken up
by the page manager doing inode data caching and multimachine deadlock
could occur if the server is blocked on a client doing writepage which
is blocked on the other server which is blocked on the other client ...

