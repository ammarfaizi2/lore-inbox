Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWJQPtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWJQPtI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 11:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWJQPtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 11:49:08 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:59588 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1751155AbWJQPtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 11:49:05 -0400
Date: Wed, 18 Oct 2006 00:51:22 +0900 (JST)
Message-Id: <20061018.005122.07644172.anemo@mba.ocn.ne.jp>
To: compudj@krystal.dyndns.org
Cc: mbligh@google.com, fche@redhat.com, masami.hiramatsu.pt@hitachi.com,
       prasanna@in.ibm.com, akpm@osdl.org, mingo@elte.hu,
       mathieu.desnoyers@polymtl.ca, lethal@linux-sh.org,
       linux-kernel@vger.kernel.org, jes@sgi.com, zanussi@us.ibm.com,
       richardj_moore@uk.ibm.com, michel.dagenais@polymtl.ca,
       hch@infradead.org, gregkh@suse.de, tglx@linutronix.de,
       wcohen@redhat.com, ltt-dev@shafik.org, systemtap@sources.redhat.com,
       alan@lxorguk.ukuu.org.uk, jeremy@goop.org, karim@opersys.com,
       pavel@suse.cz, joe@perches.com, rdunlap@xenotime.net, jrs@us.ibm.com
Subject: Re: [PATCH] Linux Kernel Markers 0.20 for 2.6.17
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060930180443.GB25761@Krystal>
References: <20060930180443.GB25761@Krystal>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2006 14:04:43 -0400, Mathieu Desnoyers <compudj@krystal.dyndns.org> wrote:
> +#define MARK(name, format, args...) \
> +	do { \
> +		static marker_probe_func *__mark_call_##name = \
> +					__mark_empty_function; \
> +		volatile static char __marker_enable_##name = 0; \
> +		static const struct __mark_marker_c __mark_c_##name \
> +			__attribute__((section(".markers.c"))) = \
> +			{ #name, &__mark_call_##name, format } ; \
> +		static const struct __mark_marker __mark_##name \
> +			__attribute__((section(".markers"), unused)) = \
> +			{ &__mark_c_##name, &__marker_enable_##name } ; \
> +		if (unlikely(__marker_enable_##name)) { \
> +			preempt_disable(); \
> +			(*__mark_call_##name)(format, ## args); \
> +			preempt_enable_no_resched(); \
> +		} \
> +	} while(0)

When I compiled this with gcc 4.1.1 (mips), ".markers" section was
empty.

I suppose "unused" attribute is not suitable for modern gcc.  Maybe
__attribute_used__ should be used?

The __attrribute_used__ is defined in compiler-gcc3.h as:

#if __GNUC_MINOR__ >= 3
# define __attribute_used__	__attribute__((__used__))
#else
# define __attribute_used__	__attribute__((__unused__))
#endif

---
Atsushi Nemoto
