Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264887AbSIWC6O>; Sun, 22 Sep 2002 22:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264888AbSIWC6N>; Sun, 22 Sep 2002 22:58:13 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:262 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S264887AbSIWC6M>; Sun, 22 Sep 2002 22:58:12 -0400
Date: Mon, 23 Sep 2002 00:03:12 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Adeos <adeos-main@mail.freesoftware.fsf.org>,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] Adeos nanokernel for 2.5.38 1/2: no-arch code
Message-ID: <20020923030312.GM20520@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Karim Yaghmour <karim@opersys.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Adeos <adeos-main@mail.freesoftware.fsf.org>,
	Philippe Gerum <rpm@xenomai.org>
References: <3D8E8371.D2070D87@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8E8371.D2070D87@opersys.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 22, 2002 at 10:58:57PM -0400, Karim Yaghmour escreveu:
> diff -urpN linux-2.5.38/kernel/printk.c linux-2.5.38-adeos/kernel/printk.c
> --- linux-2.5.38/kernel/printk.c	Sun Sep 22 00:25:31 2002
> +++ linux-2.5.38-adeos/kernel/printk.c	Sun Sep 22 21:57:19 2002
> @@ -194,17 +194,33 @@ int do_syslog(int type, char * buf, int 
>  		if (error)
>  			goto out;
>  		i = 0;
> +#ifdef CONFIG_ADEOS
> +		ipipe_hw_spin_lock_disable(&logbuf_lock);
> +#else  /* !CONFIG_ADEOS */
>  		spin_lock_irq(&logbuf_lock);
> +#endif /* CONFIG_ADEOS */
>  		while ((log_start != log_end) && i < len) {
>  			c = LOG_BUF(log_start);
>  			log_start++;
> +#ifdef CONFIG_ADEOS
> +			ipipe_hw_spin_unlock_enable(&logbuf_lock);
> +#else  /* !CONFIG_ADEOS */
>  			spin_unlock_irq(&logbuf_lock);
> +#endif /* CONFIG_ADEOS */
>  			__put_user(c,buf);
>  			buf++;
>  			i++;
> +#ifdef CONFIG_ADEOS
> +			ipipe_hw_spin_lock_disable(&logbuf_lock);
> +#else  /* !CONFIG_ADEOS */
>  			spin_lock_irq(&logbuf_lock);
> +#endif /* CONFIG_ADEOS */
>  		}
> +#ifdef CONFIG_ADEOS
> +		ipipe_hw_spin_unlock_enable(&logbuf_lock);
> +#else  /* !CONFIG_ADEOS */
>  		spin_unlock_irq(&logbuf_lock);
> +#endif /* CONFIG_ADEOS */
>  		error = i;

Why this ifdef hell and not something like:

	lockbuf_lock();
	bla
	logbuf_unlock();

and have this defined in a header, say printk.h or whatever, with the
ifdefs?

- Arnaldo
