Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268037AbUHFA5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268037AbUHFA5e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 20:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268039AbUHFA5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 20:57:34 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:24922 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268037AbUHFAzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 20:55:35 -0400
Message-ID: <4112D6FD.4030707@yahoo.com.au>
Date: Fri, 06 Aug 2004 10:55:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: Phillip Lougher <phillip@lougher.demon.co.uk>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] VFS readahead bug in 2.6.8-rc[1-3]
References: <41127371.1000603@lougher.demon.co.uk>
In-Reply-To: <41127371.1000603@lougher.demon.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Lougher wrote:

> Hi,
>
> There is a readahead bug in do_generic_mapping_read (filemap.c).  This
> bug appears to have been introduced in 2.6.8-rc1.  Specifically the bug
> is caused by an incorrect code change which causes VFS to call
> readpage() for indexes beyond the end of files where the file length is
> zero or a 4k multiple.
>
> In Squashfs this causes a variety of almost immediate OOPes because
> Squashfs trusts the VFS not to pass invalid index values.  For other
> filesystems it may also be causing subtle bugs.  I have received
> prune_dcache oopes similar to Gene Heskett's (which was also
> pointer corruption), and so it may fix this and other reported
> readahead bugs.
>
> The patch is against 2.6.8-rc3.
>

Good work - bug is mine, sorry.

You actually re-introduce a bug where read can return incorrect
data due to i_size changing from under it (I introduced this bug
while fixing that one).

My fix was to re-check i_size and update 'nr' after doing the
->readpage. You could probably fix up both problems with your
patch and also copying the hunk down to after i_size gets rechecked.
Does that sound ok?


The root of the problem is that i_size gets checked from multiple
places that it can get out of synch. A nice fix would be to snapshot
i_size once, and pass that around everywhere. Unfortunately this is
very intrusive.

