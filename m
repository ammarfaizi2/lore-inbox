Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWDCMkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWDCMkL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 08:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWDCMkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 08:40:11 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:58301 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S932237AbWDCMkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 08:40:09 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [PATCH] splice support #2
To: Pavel Machek <pavel@suse.cz>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Christoph Hellwig <hch@infradead.org>
Reply-To: 7eggert@gmx.de
Date: Mon, 03 Apr 2006 14:39:16 +0200
References: <5W2gv-Tp-19@gated-at.bofh.it> <5W48C-3KW-17@gated-at.bofh.it> <5W48D-3KW-21@gated-at.bofh.it> <5W8OT-2ms-17@gated-at.bofh.it> <5WcfS-7x9-23@gated-at.bofh.it> <5WcIT-8nr-13@gated-at.bofh.it> <5Wm5I-53z-7@gated-at.bofh.it> <5XjoS-8t9-11@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1FQOLJ-0002ig-U5@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:

>> We should extend the userspace API so that it is prepared to receive
>> 'excess data' via a separate 'flush excess data to' file descriptor:
>> 
>> sys_splice(fd_in, fd_out, fd_flush, size,
>>                    max_flush_size, *bytes_flushed)
> 
> I still see problems with error handling here. You get -EIO to
> userspace. How do you know if it is error reading fd_in, or error
> writing fd_out?

ACK.

Possibly you'll get an error reading from fd_in while also getting an error
flushing the data to fd_out, and an additional error while trying to rescue
the data on fd_flush.

Additionally you'll want to know the amount of transfered bytes even in case
of an error.

struct splice_fds {
        int in_fd,  int in_errno,
        int out_fd, int out_errno,

        /* used on transfer error to rescue the to-be-flushed data: */
        int err_fd, int err_errno,
        /* err_fd == -1 -> don't use */
        int err_size
        /* in: max. size, out: used size, unchanged if no error */
}
int sys_splice(struct splice_fds *fds, size, flags)
/* returns transfered_bytes even in case of an error */

Possible flags:
- Streaming, copied data won't be used too soon.
- Unconditionally use err_fd as a buffer, e.g. because we know that seeking
  from in_fd to out_fd is slow while err_fd is mapped memory.
- fail if err_fd == -1 and an error could cause data loss (out_fd must have
  a buffer like a pipe)

Dangers:
splice(in_fd = /dev/zero, out_fd = /dev/null, ...)
...

</brainstorming>
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
