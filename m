Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270325AbTHGQzH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 12:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270326AbTHGQzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 12:55:07 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:57349 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S270325AbTHGQzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 12:55:01 -0400
Date: Thu, 7 Aug 2003 12:53:27 -0400 (EDT)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: Bernd Schubert <bernd.schubert@pci.uni-heidelberg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.21]: nbd ksymoops-report
In-Reply-To: <200308071604.06015.bernd.schubert@pci.uni-heidelberg.de>
Message-ID: <Pine.LNX.4.10.10308071245130.13289-100000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Aug 2003, Bernd Schubert wrote:

> every time when nbd-client disconnects a nbd-device the decoded oops 
> from below will happen. 
> This only happens after we upgraded from 2.4.20 to 2.4.21, 
> so I guess the backported update from 2.5.50 causes this. 

Yes, it's definitely related to this...


> Aug  6 17:24:31 goedel kernel: Process nbd-client (pid: 650, stackpage=d61a5000)

Are you using the v2.0 nbd-client from nbd.sf.net?


> Code;  d89e2be7 <[nbd]nbd_ioctl+353/480>
> 00000000 <_EIP>:
> Code;  d89e2be7 <[nbd]nbd_ioctl+353/480>   <=====
>    0:   8b 50 08                  mov    0x8(%eax),%edx   <=====
> Code;  d89e2bea <[nbd]nbd_ioctl+356/480>
>    3:   6a 03                     push   $0x3
> Code;  d89e2bec <[nbd]nbd_ioctl+358/480>
>    5:   50                        push   %eax
> Code;  d89e2bed <[nbd]nbd_ioctl+359/480>
>    6:   8b 42 28                  mov    0x28(%edx),%eax
> Code;  d89e2bf0 <[nbd]nbd_ioctl+35c/480>
>    9:   ff d0                     call   *%eax


This corresponds to the following source:

lo->sock->ops->shutdown(lo->sock, SEND_SHUTDOWN|RCV_SHUTDOWN);

Somehow, lo->sock is NULL here. The only way I see that this could
happen is if NBD_CLEAR_SOCK got called out of order (or you're 
using some non-standard nbd-client).

I guess it would be best to protect the NULLing of lo->sock 
in NBD_CLEAR_SOCK just in case, anyway.

Would you be willing to test a patch against 2.4.21?

--
Paul

