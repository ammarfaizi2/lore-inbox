Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVHXQjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVHXQjp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVHXQjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:39:45 -0400
Received: from mail-ash.bigfish.com ([206.16.192.253]:30703 "EHLO
	mail58-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751140AbVHXQjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:39:45 -0400
X-BigFish: V
Message-ID: <430CA2CE.4070403@am.sony.com>
Date: Wed, 24 Aug 2005 09:39:42 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Guillaume Chazarain <guichaz@yahoo.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Wrong printk return value
References: <42F08FE6.8000601@yahoo.fr>
In-Reply-To: <42F08FE6.8000601@yahoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Chazarain wrote:
> What's the true meaning of the printk return value?

Hi,

I was one of the ones to touch this code last.  I
assumed it was meant to represent the number of characters
emitted by printk into the log.  This includes any priority
prefix, time prefix and format character expansion.



> Should it include the prioty prefix length of 3? and what about the timing
> information? In both cases it was broken:
>
> The returned length was "length of input string + 3", I made it "length
> of printed string including any prefix".
>

IMHO, it should behave as much like printf as possible,
which means the return value should represent output length
rather than input length.  It was already accounting for format
expansion, so it wasn't really returning just "length of input
string + 3" (only in the most simple case). I don't think it matters
that there are other systems down the line that mask part
of the value (such as the priority prefix).  Theoretically,
this code could change in the future.  printk should stay
as self-contained as possible in terms of its own operation,
and not predict post-processing.

I would argue it shouldn't be "length of printed string", if
by this you mean the thing that dmesg outputs.
Rather, it should be length of string emitted to log buffer.

> 
> strace -e write echo 1 > /dev/kmsg
> => write(1, "1\n", 2)                      = 5
This is not broken, from the standpoint of printk.
But it's weird from the standpoint of kmsg_write.

> 
> strace -e write echo "<1>1" > /dev/kmsg
> => write(1, "<1>1\n", 5)                   = 8
OK, this is wrong.  The math got messed up somewhere.
This should have been 5.

> Successful printk calls can have a return value different than the input
> length (priority prefix, timing), so /bin/echo will still think there is
> an error.
> So, to avoid breaking programs that assume write(buff, len) != len is an
> error, /dev/kmsg should return the buffer length when the call succeeds.
> 
> The only drawback is that now it's no more possible to use /dev/kmsg to
> check the printk return value :-(
> 
> 
> ------------------------------------------------------------------------
> 
> --- linux-2.6.13-rc5/kernel/printk.c
> +++ linux-2.6.13-rc5/kernel/printk.c
> @@ -553,7 +553,7 @@
>  				   p[1] <= '7' && p[2] == '>') {
>  					loglev_char = p[1];
>  					p += 3;
> -					printed_len += 3;
> +					printed_len -= 3;
>  				} else {
>  					loglev_char = default_message_loglevel
>  						+ '0';
> @@ -568,7 +568,7 @@
>  
>  				for (tp = tbuf; tp < tbuf + tlen; tp++)
>  					emit_log_char(*tp);
> -				printed_len += tlen - 3;
> +				printed_len += tlen;
>  			} else {
>  				if (p[0] != '<' || p[1] < '0' ||
>  				   p[1] > '7' || p[2] != '>') {
> @@ -576,8 +576,8 @@
>  					emit_log_char(default_message_loglevel
>  						+ '0');
>  					emit_log_char('>');
> +					printed_len += 3;
>  				}
> -				printed_len += 3;
>  			}
>  			log_level_unknown = 0;
>  			if (!*p)

I like the above code since it moves the counting closer
to the emitting, and I think it's easier to understand (and apparently
more correct. ;-)  I haven't runtime tested this, but
consider this part to have an:

Acked-By: Tim Bird <tim.bird@am.sony.com>

> --- linux-2.6.13-rc5/drivers/char/mem.c
> +++ linux-2.6.13-rc5/drivers/char/mem.c
> @@ -819,7 +819,7 @@ static ssize_t kmsg_write(struct file * 
>  			  size_t count, loff_t *ppos)
>  {
>  	char *tmp;
> -	int ret;
> +	ssize_t ret;
>  
>  	tmp = kmalloc(count + 1, GFP_KERNEL);
>  	if (tmp == NULL)
> @@ -828,6 +828,9 @@ static ssize_t kmsg_write(struct file * 
>  	if (!copy_from_user(tmp, buf, count)) {
>  		tmp[count] = 0;
>  		ret = printk("%s", tmp);
> +		if (ret > count)
> +			/* printk can add a prefix */
> +			ret = count;
>  	}
>  	kfree(tmp);
>  	return ret;

I'm not sure the side effect of this is.  Someone else will
have to comment.

Overall, if this patch didn't get noticed, please consider sending it again.

Thanks,
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

