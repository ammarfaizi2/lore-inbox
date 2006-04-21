Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWDUVkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWDUVkS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 17:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWDUVkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 17:40:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43457 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964798AbWDUVkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 17:40:15 -0400
Date: Fri, 21 Apr 2006 14:42:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hua Zhong <hzhong@gmail.com>
Cc: jmorris@namei.org, dwalker@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: kfree(NULL)
Message-Id: <20060421144233.1201cf07.akpm@osdl.org>
In-Reply-To: <4449486F.8020108@gmail.com>
References: <4449486F.8020108@gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hua Zhong <hzhong@gmail.com> wrote:
>
> +#define __check_likely(x, v, uv)                                \

those single-char identifiers are not nice.

> +  ({ static int _ckl_print_nr = 0;                              \
> +     static unsigned int _ckl_s[2];                             \
> +     int _ckl_r = !!(x);                                        \
> +     _ckl_s[_ckl_r]++;                                          \
> +     if ((_ckl_s[v] == _ckl_s[uv]) && (_ckl_s[v] > debug_likely_count_min_thresh) \
> +          && (_ckl_print_nr < debug_likely_print_max_thresh)) { \
> +         _ckl_print_nr++;                                       \
> +         printk_debug_likely("possible (un)likely misuse at %s:%d/%s()\n",        \
> +                             __FILE__, __LINE__, __FUNCTION__); \
> +     }                                                          \
> +     _ckl_r; })

Kinda.  It would be better to put all the counters into a linked list

struct likeliness {
	char *file;
	int line;
	atomic_t true_count;
	atomic_t false_count;
	struct likeliness *next;
};

then

#define __check_likely(expr, value)
	({
		static struct likeliness likeliness;
		do_check_likely(__FILE__, __LINE__, &likeliness, value);
	})

...

static struct likeliness *likeliness_list;

void do_check_likely(char *file, int line, struct likeliness *likeliness,
			int value)
{
	static DEFINE_SPINLOCK(lock);
	unsigned long flags;

	if (!likeliness->next) {
		if (!spin_trylock_irqsave(&lock, flags))
			return;		/* Can be called from NMI */
		if (!likeliness->next) {
			likeliness->next = likeliness_list;
			likeliness_list = likeliness;
			likeliness->file = file;
			likeliness->line = line;
		}
		spin_unlock_irqsave(&lock, flags);
	}

	if (value)
		atomic_inc(&likeliness->true_count);
	else
		atomic_inc(&likeliness->false_count);
}
EXPORT_SYMBOL(do_check_likely);

then write a thingy to dump the linked list (sysrq&printk if it's a hack,
/proc handler if not).

It'll crash if a module gets registered then unloaded. 
CONFIG_MODULE_UNLOAD=n would be required.

