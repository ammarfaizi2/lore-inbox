Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267451AbUIAWaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267451AbUIAWaP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 18:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267681AbUIAW3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 18:29:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:48822 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268089AbUIAW06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 18:26:58 -0400
Date: Wed, 1 Sep 2004 15:30:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: janitor@sternwelten.at
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 21/25]  hvc_console: replace schedule_timeout() with
 msleep()
Message-Id: <20040901153034.35104957.akpm@osdl.org>
In-Reply-To: <E1C2cAg-0007UH-3I@sputnik>
References: <E1C2cAg-0007UH-3I@sputnik>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

janitor@sternwelten.at wrote:
>
> -#define TIMEOUT		((HZ + 99) / 100)
> +#define TIMEOUT		10
>  
>  static struct tty_driver *hvc_driver;
>  static int hvc_offset;
> @@ -276,8 +277,7 @@ int khvcd(void *unused)
>  			for (i = 0; i < MAX_NR_HVC_CONSOLES; ++i)
>  				hvc_poll(i);
>  		}
> -		set_current_state(TASK_INTERRUPTIBLE);
> -		schedule_timeout(TIMEOUT);
> +		msleep(TIMEOUT);

This one is wrong: we need to sleep in interruptible state here, otherwise
this kernel thread will contribute to the system load average.

Several other of your msleep conversion patches actually fix bugs.  You've
found drivers which want to sleep for a fixed period, but they do that with
TASK_INTERRUPTIBLE.  If someone sends the calling process a signal, these
drivers will end up not sleeping at all and may fail.

I'll going through these patches and shall apply the ones which look right.
Please consider them all to have been handled, thanks.

