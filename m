Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270497AbTGNCa6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 22:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270498AbTGNCa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 22:30:58 -0400
Received: from h004005b9b492.ne.client2.attbi.com ([24.60.209.71]:65465 "EHLO
	joehill.bostoncoop.net") by vger.kernel.org with ESMTP
	id S270497AbTGNCav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 22:30:51 -0400
Date: Sun, 13 Jul 2003 22:45:36 -0400
From: Adam Kessel <adam@bostoncoop.net>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DVD/CD Read Problem: cdrom_decode_status: status=0x51 {DriveReady SeekComplete Error}
Message-ID: <20030714024535.GA1730@joehill.bostoncoop.net>
References: <200307131950.44923.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307131950.44923.arvidjaar@mail.ru>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 07:51:07PM +0400, Andrey Borzenkov wrote:
> this is ide-cd problem. drivers/ide/ide-cd:cdrom_decode_status():
> [ ... ]
>                } else if ((err & ~ABRT_ERR) != 0) {
> [ ... ]
>                } else if (sense_key == MEDIUM_ERROR) {
> [ ... ]
> they are not user-space issues. Try to swap two conditions above and see what 
> happens. I cannot test it anymore for reason below ...

Swapping these conditions improved the situation quite a lot.
Subjectively, I would say it's 90% better. By extending the read-ahead
cache to 32M, I can play the DVD almost perfectly with those conditions
(ABRT_ERR and MEDIUM_ERROR) swapped.  

Also, for the first time, I get messages of this sort in syslog:

Jul 13 22:22:47 joehill kernel: end_request: I/O error, dev hdc, sector 7865320
Jul 13 22:22:47 joehill kernel: Buffer I/O error on device hdc, logical block 983165

Before, the only sorts of errors I ever got were:

Jul 13 00:14:35 joehill kernel: hdc: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Jul 13 00:14:35 joehill kernel: hdc: cdrom_decode_status: error=0x30LastFailedSense 0x03 
Jul 13 00:14:35 joehill kernel: hdc: ide_intr: huh? expected NULL handler on exit

Is there a reason these conditions should *not* be swapped? Is there
something I can test? Otherwise, my problem is basically fixed by this
change.

--Adam Kessel
