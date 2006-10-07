Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932820AbWJGURt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932820AbWJGURt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 16:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932821AbWJGURt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 16:17:49 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:10766 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S932820AbWJGURs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 16:17:48 -0400
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       linville@tuxdriver.com, netdev@vger.kernel.org, pavel@suse.cz,
       linux-pm@osdl.org
Subject: Re: 2.6.19-rc1 regression: airo suspend fails
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	<871wpmoyjv.fsf@sycorax.lbl.gov> <20061006184706.GR16812@stusta.de>
	<1160250771.24902.6.camel@kleikamp.austin.ibm.com>
Date: Sat, 07 Oct 2006 13:17:13 -0700
In-Reply-To: <1160250771.24902.6.camel@kleikamp.austin.ibm.com> (message from
	Dave Kleikamp on Sat, 07 Oct 2006 14:52:51 -0500)
Message-ID: <873b9zhody.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp <shaggy@austin.ibm.com> writes:

> I believe it was broken by:
> http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=3b4c7d640376dbccfe80fc4f7b8772ecc7de28c5
>
> I have seen this in the -mm tree, but didn't follow up at the time.  I
> was able to fix it with the following patch.  I don't know if it's the
> best fix, but it seems to follow the same logic as the original code.
>
>
> The airo driver used to break out of while loop if there were any signals
> pending.  Since it no longer checks for signals, it at least needs to check
> if it needs to be frozen.
>
> Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>
>
> diff -Nurp linux-2.6.19-rc1/drivers/net/wireless/airo.c linux/drivers/net/wireless/airo.c
> --- linux-2.6.19-rc1/drivers/net/wireless/airo.c	2006-10-05 07:22:39.000000000 -0500
> +++ linux/drivers/net/wireless/airo.c	2006-10-07 13:42:13.000000000 -0500
> @@ -3090,7 +3090,8 @@ static int airo_thread(void *data) {
>  						set_bit(JOB_AUTOWEP, &ai->jobs);
>  						break;
>  					}
> -					if (!kthread_should_stop()) {
> +					if (!kthread_should_stop() &&
> +					    !freezing(current)) {
>  						unsigned long wake_at;
>  						if (!ai->expires || !ai->scan_timeout) {
>  							wake_at = max(ai->expires,
> @@ -3102,7 +3103,8 @@ static int airo_thread(void *data) {
>  						schedule_timeout(wake_at - jiffies);
>  						continue;
>  					}
> -				} else if (!kthread_should_stop()) {
> +				} else if (!kthread_should_stop() &&
> +					   !freezing(current)) {
>  					schedule();
>  					continue;
>  				}
>

thanks. with this patch applied i can suspend to ram with the airo
module loaded.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
