Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263423AbRFNRZh>; Thu, 14 Jun 2001 13:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263428AbRFNRZ1>; Thu, 14 Jun 2001 13:25:27 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:56208 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263423AbRFNRZO>;
	Thu, 14 Jun 2001 13:25:14 -0400
Message-ID: <3B28F376.1F528D5A@mandrakesoft.com>
Date: Thu, 14 Jun 2001 13:25:10 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org, Richard Henderson <rth@redhat.com>
Subject: Re: unregistered changes to the user<->kernel API
In-Reply-To: <20010614191219.A30567@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> Here the third, it registers the tux syscall at for the alpha so other
> people won't use such same syscall for something else (I didn't remove
> the #ifdefs since they don't hurt as they're undefined in mainline).
> 
> diff -urN ref/arch/alpha/kernel/entry.S tuxsys/arch/alpha/kernel/entry.S
> --- ref/arch/alpha/kernel/entry.S       Sat Apr 28 18:37:45 2001
> +++ tuxsys/arch/alpha/kernel/entry.S    Sun Apr 29 17:52:44 2001
> @@ -1004,7 +1004,15 @@
>         .quad alpha_ni_syscall
>         .quad alpha_ni_syscall                  /* 220 */
>         .quad alpha_ni_syscall
> +#ifdef CONFIG_TUX
> +       .quad __sys_tux
> +#else
> +# ifdef CONFIG_TUX_MODULE
> +       .quad sys_tux
> +# else
>         .quad alpha_ni_syscall
> +# endif
> +#endif

They don't hurt but it's also a bad precedent - you don't want to add a
ton of CONFIG_xxx to the Linus tree for stuff outside the Linus tree. 
disagree with this patch.

> Here the fifth, this defines the tux sysctl numbers (OTOH the sysctl by
> number gets broken all the time and nobody should use sysctl by number
> with new sysctls anyways).
> 
> diff -urN 2.4.5pre5/include/linux/sysctl.h tux-sysctl/include/linux/sysctl.h
> --- 2.4.5pre5/include/linux/sysctl.h    Tue May 22 22:04:27 2001
> +++ tux-sysctl/include/linux/sysctl.h   Wed May 23 19:20:48 2001
> @@ -157,7 +157,8 @@
>         NET_TR=14,
>         NET_DECNET=15,
>         NET_ECONET=16,
> -       NET_KHTTPD=17
> +       NET_KHTTPD=17,
> +       NET_TUX=18
>  };

ok

> +/* /proc/sys/net/tux/ */
> +enum {
> +       NET_TUX_DOCROOT                 =  1,
> +       NET_TUX_LOGFILE                 =  2,

this conflicts with noone, so can wait for tux patch


> diff -urN 2.4.5pre5/include/linux/kernel_stat.h tux-kstat/include/linux/kernel_stat.h
> --- 2.4.5pre5/include/linux/kernel_stat.h       Tue May 15 21:40:17 2001
> +++ tux-kstat/include/linux/kernel_stat.h       Wed May 23 19:06:38 2001
> @@ -33,6 +33,53 @@
>         unsigned int ierrors, oerrors;
>         unsigned int collisions;
>         unsigned int context_swtch;
> +       unsigned int context_swtch_cross;
> +       unsigned int nr_free_pending;
> +       unsigned int nr_allocated;
> +       unsigned int nr_idle_input_pending;
> +       unsigned int nr_output_space_pending;
> +       unsigned int nr_work_pending;
> +       unsigned int nr_input_pending;
> +       unsigned int nr_cachemiss_pending;
> +       unsigned int nr_secondary_pending;
> +       unsigned int nr_output_pending;
> +       unsigned int nr_redirect_pending;
> +       unsigned int nr_postpone_pending;
> +       unsigned int nr_finish_pending;
> +       unsigned int nr_userspace_pending;
> +       unsigned int static_lookup_cachemisses;
> +       unsigned int static_sendfile_cachemisses;
> +       unsigned int user_lookup_cachemisses;
> +       unsigned int user_fetch_cachemisses;
> +       unsigned int user_sendobject_cachemisses;
> +       unsigned int user_sendobject_write_misses;
> +       unsigned int user_sendbuf_cachemisses;
> +       unsigned int user_sendbuf_write_misses;
> +#define URL_HIST_SIZE 1000
> +       unsigned int url_hist_hits[URL_HIST_SIZE];
> +       unsigned int url_hist_misses[URL_HIST_SIZE];
> +       unsigned int input_fastpath;
> +       unsigned int input_slowpath;
> +       unsigned int inputqueue_got_packet;
> +       unsigned int inputqueue_no_packet;
> +       unsigned int nr_keepalive_optimized;
> +
> +       unsigned int parse_static_incomplete;
> +       unsigned int parse_static_redirect;
> +       unsigned int parse_static_cachemiss;
> +       unsigned int parse_static_nooutput;
> +       unsigned int parse_static_normal;
> +       unsigned int parse_dynamic_incomplete;
> +       unsigned int parse_dynamic_redirect;
> +       unsigned int parse_dynamic_cachemiss;
> +       unsigned int parse_dynamic_nooutput;
> +       unsigned int parse_dynamic_normal;
> +       unsigned int complete_parsing;
> +
> +       unsigned int nr_keepalive_reqs;
> +       unsigned int nr_nonkeepalive_reqs;
> +#define KEEPALIVE_HIST_SIZE 100
> +       unsigned int keepalive_hist[KEEPALIVE_HIST_SIZE];
>  };

ouch!   I would understand if this was inside CONFIG_TUX, but even so I
would disagree until Tux is merged.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
