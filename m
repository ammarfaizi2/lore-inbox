Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbUJ0ABI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbUJ0ABI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 20:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbUJ0ABI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 20:01:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:51867 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261556AbUJ0AAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 20:00:38 -0400
Date: Tue, 26 Oct 2004 17:04:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: linux-kernel@vger.kernel.org, Urban Widmark <Urban.Widmark@enlight.net>
Subject: Re: smbfs and Slab corruption bug in 2.6
Message-Id: <20041026170433.7aa85a38.akpm@osdl.org>
In-Reply-To: <417DD81B.2090802@aknet.ru>
References: <417DD81B.2090802@aknet.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev <stsp@aknet.ru> wrote:
>
> Hello.
> 
> When I am trying to access some files
> on an SMB server, I get this in the log:

smb_add_request() does:

		if (!(req->rq_flags & SMB_REQ_RECEIVED)) {
			list_del_init(&req->rq_queue);
			smb_rput(req);
		}

but then proceeds to play with *req.

Urban, do you have time to review the code in there?

Thanks.

> ---
> Oct 25 09:30:09 stas mount.smbfs[2086]:   tdb(/var/lib/samba/gencache.tdb): tdb_lock failed on list 60 ltype=1 (Bad file descriptor)
> Oct 25 09:30:39 stas kernel: smb_add_request: request [d242b03c, mid=1802201963] timed out!
> Oct 25 09:30:39 stas kernel: Slab corruption: start=d242b03c, len=252
> Oct 25 09:30:39 stas kernel: Redzone: 0x5a2cf071/0x5a2cf071.
> Oct 25 09:30:39 stas kernel: Last user: [<e08ef84a>](smb_add_request+0x2aa/0x310 [smbfs])
> Oct 25 09:30:39 stas kernel: 000: 6b 6b 6b 6b 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b
> Oct 25 09:30:39 stas kernel: 0f0: 6b 6b 6b 6b 02 00 58 00 fb ff ff ff
> Oct 25 09:30:39 stas kernel: Next obj: start=d242b144, len=252
> Oct 25 09:30:39 stas kernel: Redzone: 0x170fc2a5/0x170fc2a5.
> Oct 25 09:30:39 stas kernel: Last user: [<e08ef1d4>](smb_do_alloc_request+0x24/0xa0 [smbfs])
> Oct 25 09:30:39 stas kernel: 000: 4c b2 42 d2 74 27 a6 de 02 00 00 00 01 00 00 00
> Oct 25 09:30:39 stas kernel: 010: ad 4e ad de 3c 8d 09 d4 3c 8d 09 d4 00 40 00 00
> Oct 25 09:30:39 stas kernel: smb_add_request: request [d242beac, mid=1802201963] timed out!
> Oct 25 09:30:39 stas kernel: Slab corruption: start=d242beac, len=252
> Oct 25 09:30:39 stas kernel: Redzone: 0x5a2cf071/0x5a2cf071.
> Oct 25 09:30:39 stas kernel: Last user: [<e08ef84a>](smb_add_request+0x2aa/0x310 [smbfs])
> Oct 25 09:30:39 stas kernel: 000: 6b 6b 6b 6b 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b
> Oct 25 09:30:39 stas kernel: 0f0: 6b 6b 6b 6b 02 00 58 00 fb ff ff ff
> Oct 25 09:30:39 stas kernel: Prev obj: start=d242bda4, len=252
> Oct 25 09:30:39 stas kernel: Redzone: 0x5a2cf071/0x5a2cf071.
> Oct 25 09:30:39 stas kernel: Last user: [<00000000>](0x0)
> Oct 25 09:30:39 stas kernel: 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Oct 25 09:30:39 stas kernel: 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Oct 25 09:30:39 stas kernel: smb_add_request: request [d242b144, mid=62] timed out!
> Oct 25 09:30:40 stas kernel: smb_lookup: find images/money.jpg failed, error=-5
> Oct 25 09:30:40 stas kernel: smb_add_request: request [d242b24c, mid=63] timed out!
> ---
> and then the system is unstable, so that
> I have to reboot.
> 
> This happens with all 2.6 kernels I tried
> (from something like 2.6.2 to 2.6.9).
> The only reference to the similar problem
> I can find, is this:
> http://lkml.org/lkml/2003/5/22/49
> 
> This bug is really nasty and I guess I was
> waiting for too long for it to get fixed.
> Any hints how can I get more info out of
> it, or how can I start debugging it?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
