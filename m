Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbTFBPCm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 11:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbTFBPCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 11:02:42 -0400
Received: from dns01.mail.yahoo.co.jp ([211.14.15.204]:39227 "HELO
	dns01.mail.yahoo.co.jp") by vger.kernel.org with SMTP
	id S262409AbTFBPCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 11:02:40 -0400
Message-ID: <002901c32919$ddc37000$570486da@w0a3t0>
From: "matsunaga" <matsunaga_kazuhisa@yahoo.co.jp>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       "David Woodhouse" <dwmw2@infradead.org>
Cc: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20030530144959.GA4736@wohnheim.fh-wedel.de>
Subject: Re: [PATCH RFC] 1/2 central workspace for zlib
Date: Tue, 3 Jun 2003 00:15:56 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following creates a central workspace per cpu for the zlib.  The
> original idea was to save memory for embedded, but this should also
> improve performance for smp.

Hi

Thank you for the patch.
It definitely reduces resources and improve multiple CPU scalability. 

But I still would like to stick to performance.
(Though I haven't evaluated the performance yet...)
So far I think MTD is used mostly on Embedded device, 
in which single CPU which is not so powerful is used.

How is the following code (it is ugly though)?

static void default_workspace[WSIZE];

<snip>

    size = MAX(sizeof(struct inflate_workspace),
        sizeof(struct deflate_workspace));

    if(WSIZE < size)
        BUG();

    zlib_workspace[0] = default_workspace;

    for (i=1; i<smp_num_cpus; i++) {
        zlib_workspace[i] = vmalloc(size);
        if (!zlib_workspace[i]) {
            zlib_exit();
            return -ENOMEM;
        }
   }

P.S.
There is another vmalloc in mtdblock_open()...;-)

