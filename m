Return-Path: <linux-kernel-owner+w=401wt.eu-S1751452AbXAGSQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbXAGSQO (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 13:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbXAGSQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 13:16:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:53039 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbXAGSQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 13:16:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rZHK7HPruY5s/7l3DugwLAs57ywFVlBp/p910c/Os6dq/qud5z8aMMQmIvVqWjE77CbBvyFTS4t6sHDiHWqQCvVh055XJFO2EdGlqoPmG1mUO4z4AuujNW3z3yakwbc1nYJPIcTdlP450uEetSxHhD+f8r9FRpQFmF9JjdDnQks=
Message-ID: <c70ff3ad0701071016q274a0dfdt4d2cfd05b410c3db@mail.gmail.com>
Date: Sun, 7 Jan 2007 20:16:11 +0200
From: "saeed bishara" <saeed.bishara@gmail.com>
To: linux-kernel@vger.kernel.org, "Jens Axboe" <jens.axboe@oracle.com>
Subject: Re: using splice/vmsplice to improve file receive performance
In-Reply-To: <c70ff3ad0612211121g3c5aaa28s9b738e9c79f9c2be@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c70ff3ad0612211121g3c5aaa28s9b738e9c79f9c2be@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/06, saeed bishara <saeed.bishara@gmail.com> wrote:
> Hi,
> I'm trying to use the splice/vmsplice system calls to improve the
> samba server write throughput, but before touching the smbd, I started
> to improve the ttcp tool since it simple and has the same flow. I'm
> expecting to avoid the "copy_from_user" path when using those
> syscalls.
> so far, I couldn't make any improvement, actually the throughput get
> worst. the new receive flow looks like this (code also attached):
> 1. read tcp packet (64 pages) to page aligned buffer.
> 2. vmsplice the buffer to pipe with SPLICE_F_MOVE.
> 3. splice the pipe to the file, also with SPLICE_F_MOVE.
>
> the strace shows that the splice takes a lot of time. also when
> profiling the kernel, I found that the memcpy() called to often !!

I found that when doing free to the buffer after the vmsplice and
befaore the splice syscall, the page is really moved without any
memcpy, this means the flow of my application should be:
- malloc aligned buffer
- fill the buffer with the desired data
- vmsplice
- free the buffer
- call splice.

but I still don't get I improvements, and when profing the kernel I
see _clear_user_page() too often, I guess this function called to
clean the new buffers allocated by the user, for securty and privacy
reasons, but the overhead of this operation is expensive.

is there any way to prevent the kernel from cleaning new allocated buffers?
saeed
