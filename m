Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbTESRGc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 13:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbTESRGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 13:06:31 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:20127 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262567AbTESRGa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 13:06:30 -0400
Importance: Normal
Sensitivity: 
Subject: Re: CIFS oops in 2.5.69-mm5
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF9814E442.D895C05F-ON87256D2B.00571760@us.ibm.com>
From: Steven French <sfrench@us.ibm.com>
Date: Mon, 19 May 2003 11:10:09 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 6.0.1 [IBM]|April 28, 2003) at
 05/19/2003 11:19:17
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Looks like this oops occurred right next to a list_for_each in which I
demultiplex the received network response from the server and try to match
it against one of the pending requests in the list.  No obvious reason was
this should oops and access to the list is spinlock protected.   The
location reminds me of the problems with prefetch that Jon Grimm and Andi
were mentioning.

>I just tried mouting a cifs share in 2.5.69-mm5 and got this during the
>attempt.
>
>Unable to handle kernel paging request at virtual address 4fb899ce
>printing eip:
>.eeac8eed
>*pde = 00000000
>Oops: 0002 [#1]
>CPU:    0
>EIP:    0060:[<eeac8eed>]    Not tainted VLI
>EFLAGS: 00010246
>EIP is at cifs_demultiplex_thread+0x329/0x4c8 [cifs]
>eax: eaf21664   ebx: dbe42450   ecx: eaf21600   edx: 00000000
>esi: 0000005b   edi: 0000005b   ebp: c1efffec   esp: c1efffa8
>ds: 007b   es: 007b   ss: 0068
>Process cifsd (pid: 21104, threadinfo=c1efe000 task=eafeae00)

Although one of the three newer cifs changesets at
bk://cifs.bkbits.net/linux-2.5cifs (changeset 1.1115) adds missing spinlock
protection for modifications to the one list that was missing spinlocks
(the cifs open file list) and changes a list_for_each to list_for_each_safe
in one case where releasing the spinlock temporarily was necessary, which
does fix a different oops, none of the three pending cifs vfs changesets
are likely to affect this problem.   This one looks unrelated and plausibly
similar to the other two reports of general prefetch problems mentioned in
earlier posts.

Steve French
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench at-sign us dot ibm dot com

