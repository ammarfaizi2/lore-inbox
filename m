Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUA0Svf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 13:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUA0Sve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 13:51:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8965 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262130AbUA0Svc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 13:51:32 -0500
Message-ID: <4016B316.4060304@zytor.com>
Date: Tue, 27 Jan 2004 10:51:02 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: Frodo Looijaard <frodol@dds.nl>, linux-kernel@vger.kernel.org
Subject: Re: PATCH to access old-style FAT fs
References: <20040126173949.GA788@frodo.local>	<bv3qb3$4lh$1@terminus.zytor.com> <87n0898sah.fsf@devron.myhome.or.jp>
In-Reply-To: <87n0898sah.fsf@devron.myhome.or.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:
> 
> The new cluster for directory entries must be initialized by 0x00.
> And, when the directory entry is deleted, the name[0] is updated by
> 0xe5 not 0x00.
> 
> So, if the name[0] is 0x00, it after, all bytes in cluster is 0x00.
> 
> The fat driver can stop at name[0] == 0x00, but this is just optimization.
> The behavior shouldn't change by this.

I looked at the spec, and yes, that is how the spec reads:

If DIR_Name[0] == 0x00, then the directory entry is free (same as for
0xE5), and there are no allocated directory entries after this one (all
of the DIR_Name[0] bytes in all of the entries after this one are also
set to 0). The special 0 value, rather than the 0xE5 value, indicates to
FAT file system driver code that the rest of the entries in this
directory do not need to be examined because they are all free.

I guess the original poster has found filesystems which have a 0
followed by garbage.  In cases like that, the cardinal rule for FAT is
WWDD (What Would DOS Do)... since I'm pretty sure DOS stops examining at
that point, we should do the same.

It's the same thing as with using 0xF8 for ending clusters; it's correct
according to spec, but WWDD says 0xFF is the right thing.

	-hpa

