Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbVAERyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbVAERyk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 12:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbVAERyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 12:54:40 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:33239 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262472AbVAERyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 12:54:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=EKictTPSRX+DqjVdEs5pMhMVEvz2Q/56fvN66Lq7EtItNYT+QXL0xCQl7ryHamO7y0r5cKKeXKG4el5JFdrj7zih1Gdrba4O9jxljFJzHJXUEvtd70fQ3BG9IgB3kz1ssiVFJV02ZMwzlqlnBuuVap5xHPtEfHWsbJY4YQB+MG8=
Message-ID: <29495f1d0501050931379525d1@mail.gmail.com>
Date: Wed, 5 Jan 2005 09:31:55 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Willem Riede <osst@riede.org>
Subject: Re: [PATCH 2/3] osst upgrade to 0.99.3
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <1104627573l.3427l.3l@serve.riede.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1104627573l.3427l.3l@serve.riede.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Jan 2005 00:59:33 +0000, Willem Riede <osst@riede.org> wrote:
> Here is patch 2 (see previous mail for context), providing osst error
> handling improvements.

<snip>

> +               while (retval && time_before (jiffies, startwait + 5*60*HZ)) {
> +
> +                       if (STp->buffer->syscall_result && (SRpnt->sr_sense_buffer[2] & 0x0f) != 2) {
> +
> +                               /* some failure - not just not-ready */
> +                               retval = osst_write_error_recovery(STp, aSRpnt, 0);
> +                               break;
> +                       }
> +                       set_current_state(TASK_INTERRUPTIBLE);
> +                       schedule_timeout (HZ / OSST_POLL_PER_SEC);

Are you sure you want to use TASK_INTERRUPTIBLE here? If you are sure,
then you probably should add code which checks if schedule_timeout()
returns early because of signals (signals_pending(current) will be
true). Additionally, you may as well use msleep_interruptible(1000 /
OSST_POLL_PER_SEC), since you are requesting a 10th of a second sleep
(with OSST_POLL_PER_SEC #define'd to 10) (which is long & measurable
in milliseconds), you are not checking the return value (so you don't
seem to care how much time was left in the sleep) and
msleep_interruptible() will return on the same conditions as the
current code does. Seems like it should do what you want (still need
some means of checking for signals, though, I think).

If, in fact, you did not intend to use TASK_INTERRUPTIBLE, but
TASK_UNINTERRUPTIBLE, then you may want to consider using msleep(1000
/ OSST_POLL_PER_SEC) [ignoring signals in addition to waitqueue
events].

If, though, you want to keep the code as is, then please ignore the
noise and I apologize :)

Thanks,
Nish
