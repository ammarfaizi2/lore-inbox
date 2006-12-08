Return-Path: <linux-kernel-owner+w=401wt.eu-S1760844AbWLHSqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760844AbWLHSqb (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 13:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760842AbWLHSqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:46:31 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:42051 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760831AbWLHSqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:46:30 -0500
Date: Fri, 8 Dec 2006 17:33:43 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, schwidefsky@de.ibm.com,
       linux390@de.ibm.com, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Fix S390 driver workstruct usage
Message-ID: <20061208173342.GT4587@ftp.linux.org.uk>
References: <20061208145940.21411.77769.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208145940.21411.77769.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 02:59:40PM +0000, David Howells wrote:

> diff --git a/drivers/s390/char/ctrlchar.c b/drivers/s390/char/ctrlchar.c
> index 49e9628..9fcfe3a 100644
> --- a/drivers/s390/char/ctrlchar.c
> +++ b/drivers/s390/char/ctrlchar.c
> @@ -15,15 +15,16 @@ #include <linux/ctype.h>
>  #include "ctrlchar.h"
>  
>  #ifdef CONFIG_MAGIC_SYSRQ
> +static struct tty_struct *ctrlchar_sysrq_tty;
>  static int ctrlchar_sysrq_key;
>  
>  static void
> -ctrlchar_handle_sysrq(void *tty)
> +ctrlchar_handle_sysrq(struct work_struct *unused)
>  {
> -	handle_sysrq(ctrlchar_sysrq_key, (struct tty_struct *) tty);
> +	handle_sysrq(ctrlchar_sysrq_key, ctrlchar_sysrq_tty);
>  }
>  
> -static DECLARE_WORK(ctrlchar_work, ctrlchar_handle_sysrq, NULL);
> +static DECLARE_WORK(ctrlchar_work, ctrlchar_handle_sysrq);
>  #endif
>  
>  
> @@ -52,8 +53,8 @@ ctrlchar_handle(const unsigned char *buf
>  #ifdef CONFIG_MAGIC_SYSRQ
>  	/* racy */
>  	if (len == 3 && buf[1] == '-') {
> +		ctrlchar_sysrq_tty = tty;
>  		ctrlchar_sysrq_key = buf[2];
> -		ctrlchar_work.data = tty;
>  		schedule_work(&ctrlchar_work);
>  		return CTRLCHAR_SYSRQ;
>  	}

I don't think it's a real fix.

a) what protects tty from disappearing?
b) why the hell do we need that schedule_work() at all?  handle_sysrq() is
supposed to be safe to use from irq handler; when needed it does arrange for
delayed execution itself.

So how about we simply call handle_sysrq() there and be done with that?
Martin?
