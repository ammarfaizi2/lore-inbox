Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278962AbRKAOLM>; Thu, 1 Nov 2001 09:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278967AbRKAOLD>; Thu, 1 Nov 2001 09:11:03 -0500
Received: from [195.66.192.167] ([195.66.192.167]:22535 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S278962AbRKAOKu>; Thu, 1 Nov 2001 09:10:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [Patch] Re: Nasty suprise with uptime
Date: Thu, 1 Nov 2001 16:09:08 +0000
X-Mailer: KMail [version 1.2]
Cc: Andreas Dilger <adilger@turbolabs.com>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0110312138040.30038-100000@gans.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.30.0110312138040.30038-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Message-Id: <01110116090800.01137@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 October 2001 20:47, Tim Schmielau wrote:
> btw.: can someone please explain to me why do_timer uses
> 	(*(unsigned long *)&jiffies)++;
> instead of just doing jiffies++ ?

This casts away volatile -> gcc generates potentially faster code


> -unsigned long volatile jiffies;
> +unsigned long volatile jiffies = INITIAL_JIFFIES;
> +unsigned long volatile jiffies_hi, jiffies_hi_shadow;

Grepped your patch for uses of jiffies_hi_shadow, found none
except for stores. Seems to be unused?


>  void do_timer(struct pt_regs *regs)
>  {
> -	(*(unsigned long *)&jiffies)++;
> +	/* we assume that two calls to do_timer can never overlap
> +	 * since they are one jiffie apart in time */
> +	if (jiffies != (unsigned long)(-1)) {
> +		jiffies++;
> +	} else {
> +		/* We still need to care about the race with readers of
> +		 * jiffies_hi. Readers have to discard the values if
> +		 * jiffies_hi != jiffies_hi_shadow when read with
> +		 * proper barriers in between. */
> +		jiffies_hi++;
> +		barrier();
> +		jiffies++;
> +		barrier();
> +		jiffies_hi_shadow = jiffies_hi;
> +		barrier();
> +	}

Looks like gross overkill for 64bit i++. I see no flaw in much simpler:
+	if(++jiffies == 0) {
+		/* barrier(); --vda: needed? I have some doubts... */
+		jiffies_hi++;
+	}

To avoid races 64bit readers must read in reverse order: hi,lo,check hi;
your patch already does this just right:

> +static inline u64 get_jiffies64() {
> +	unsigned long hi,lo;
> +	/* We need to make sure jiffies_hi does not change while
> +	 * reading jiffies and jiffies_hi */
> +	do {
> +	        hi = jiffies_hi;
> +	        barrier();
> +	        lo = jiffies;
> +	        barrier();
> +	} while (hi != jiffies_hi);
> +	return lo + (((u64)hi) << BITS_PER_LONG);
> +}
> +


> +#define INITIAL_JIFFIES 0xFFFFD000ul
> +extern unsigned long volatile jiffies, jiffies_hi, jiffies_hi_shadow;

This belongs to some .h file, not .c (most likely include/linux/sched.h)

Also consider 

+#if defined(CONFIG_DEBUG_KERNEL)
+/* Rollover in 1000 secs */
+#define INITIAL_JIFFIES ((unsigned long) -1000*HZ)
+#else
+#define INITIAL_JIFFIES 0
+#endif


Hope your patch will go into mainline soon!
--
vda
