Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVANAYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVANAYa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVANAWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 19:22:32 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:33709 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261733AbVANASR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 19:18:17 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: blaisorblade_spam@yahoo.it
Subject: Re: [patch 02/11] uml: fix compilation for missing headers
Date: Fri, 14 Jan 2005 01:20:43 +0100
User-Agent: KMail/1.7.1
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net
References: <20050113210051.99326AB30@zion>
In-Reply-To: <20050113210051.99326AB30@zion>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501140120.44329.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I reposted the same patch inside the bunch of ones, hope it's not a 
problem. However, I've seen some more problems which I didn't fix in the 
patch:
> +#if 0
>  #define LAST_GENERIC_SYSCALL __NR_vperfctr_read
> +#else
> +#define LAST_GENERIC_SYSCALL __NR_keyctl
> +#endif
>
>  #if LAST_GENERIC_SYSCALL > LAST_ARCH_SYSCALL
>  #define LAST_SYSCALL LAST_GENERIC_SYSCALL
> @@ -54,11 +58,14 @@ extern syscall_handler_t sys_get_mempoli
>  extern syscall_handler_t sys_set_mempolicy;
>  extern syscall_handler_t sys_sys_kexec_load;
>  extern syscall_handler_t sys_sys_setaltroot;
> +
> +#if 0
>  extern syscall_handler_t sys_vperfctr_open;
>  extern syscall_handler_t sys_vperfctr_control;
>  extern syscall_handler_t sys_vperfctr_unlink;
>  extern syscall_handler_t sys_vperfctr_iresume;
>  extern syscall_handler_t sys_vperfctr_read;
> +#endif
>
>  syscall_handler_t *sys_call_table[] = {
>   [ __NR_restart_syscall ] = (syscall_handler_t *) sys_restart_syscall,
> @@ -273,7 +280,10 @@ syscall_handler_t *sys_call_table[] = {
>   [ __NR_mq_timedreceive ] = (syscall_handler_t *) sys_mq_timedreceive,
>   [ __NR_mq_notify ] = (syscall_handler_t *) sys_mq_notify,
>   [ __NR_mq_getsetattr ] = (syscall_handler_t *) sys_mq_getsetattr,
> +#if 0
>   [ __NR_sys_kexec_load ] = (syscall_handler_t *) sys_kexec_load,
> +#endif
> + [ __NR_sys_kexec_load ] = (syscall_handler_t *) sys_ni_syscall,
>   [ __NR_waitid ] = (syscall_handler_t *) sys_waitid,
>  #if 0
>   [ __NR_sys_setaltroot ] = (syscall_handler_t *) sys_sys_setaltroot,
This is left alone, but this way, the "285" syscall is not set at all, while 
it should be sys_ni_syscall like for what I commented out (apart the ones at 
the end).
> @@ -281,11 +291,14 @@ syscall_handler_t *sys_call_table[] = {
>   [ __NR_add_key ] = (syscall_handler_t *) sys_add_key,
>   [ __NR_request_key ] = (syscall_handler_t *) sys_request_key,
>   [ __NR_keyctl ] = (syscall_handler_t *) sys_keyctl,
> + /* These syscalls are still in -mm only*/
> +#if 0
>   [ __NR_vperfctr_open ] = (syscall_handler_t *) sys_vperfctr_open,
>   [ __NR_vperfctr_control ] = (syscall_handler_t *) sys_vperfctr_control,
>   [ __NR_vperfctr_unlink ] = (syscall_handler_t *) sys_vperfctr_unlink,
>   [ __NR_vperfctr_iresume ] = (syscall_handler_t *) sys_vperfctr_iresume,
>   [ __NR_vperfctr_read ] = (syscall_handler_t *) sys_vperfctr_read,
> +#endif
>
>   ARCH_SYSCALLS
>   [ LAST_SYSCALL + 1 ... NR_syscalls ] =
> _
While looking at the unistd.h code, I discovered another bug (for i386) - I'm 
posting it here to avoid forgetting it:

/*
 * user-visible error numbers are in the range -1 - -128: see
 * <asm-i386/errno.h>
 */

But in include/asm-generic/errno.h, there is a problem:

#define EKEYREVOKED     128     /* Key has been revoked */
#define EKEYREJECTED    129     /* Key was rejected by service */

I.e. the range has changed...
I think that the max errno value should become a macro defined in errno.h.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade
