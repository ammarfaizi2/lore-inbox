Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751759AbWANM5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbWANM5E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 07:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbWANM5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 07:57:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27276 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932091AbWANM47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 07:56:59 -0500
Date: Sat, 14 Jan 2006 04:56:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jan Beulich" <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] CONFIG_UNWIND_INFO
Message-Id: <20060114045635.1462fb9e.akpm@osdl.org>
In-Reply-To: <4370AF4A.76F0.0078.0@novell.com>
References: <4370AF4A.76F0.0078.0@novell.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <JBeulich@novell.com> wrote:
>
> As a foundation for reliable stack unwinding, this adds a config option
> (available to all architectures except IA64) to enable the generation
> of frame unwind information.
> 

This breaks ppc64.

> Index: linux/Makefile
> ===================================================================
> --- linux.orig/Makefile
> +++ linux/Makefile
> @@ -502,6 +502,10 @@ CFLAGS		+= $(call add-align,CONFIG_CC_AL
>  CFLAGS		+= $(call add-align,CONFIG_CC_ALIGN_LOOPS,-loops)
>  CFLAGS		+= $(call add-align,CONFIG_CC_ALIGN_JUMPS,-jumps)
>  
> +ifdef CONFIG_UNWIND_INFO
> +CFLAGS		+= -fasynchronous-unwind-tables
> +endif
> +
>  ifdef CONFIG_FRAME_POINTER
>  CFLAGS		+= -fno-omit-frame-pointer $(call cc-option,-fno-optimize-sibling-calls,)
>  else
> Index: linux/lib/Kconfig.debug
> ===================================================================
> --- linux.orig/lib/Kconfig.debug
> +++ linux/lib/Kconfig.debug
> @@ -195,6 +195,16 @@ config FRAME_POINTER
>  	  some architectures or if you use external debuggers.
>  	  If you don't debug the kernel, you can say N.
>  
> +config UNWIND_INFO
> +	bool "Compile the kernel with frame unwind information"
> +	depends on !IA64
> +	default DEBUG_KERNEL
> +	help
> +	  If you say Y here the resulting kernel image will be slightly larger
> +	  but not slower, and it will give very useful debugging information.
> +	  If you don't debug the kernel, you can say N, but we may not be able
> +	  to solve problems without frame unwind information or frame pointers.
> +
>  config RCU_TORTURE_TEST
>  	tristate "torture tests for RCU"
>  	depends on DEBUG_KERNEL
> 

If you do a `make oldconfig' with CONFIG_DEBUG_KERNEL you get
-fasynchronous-unwind-tables and (on my yellowdog-4 toolchain at least) the
ppc64 kernel doesn't like that one bit. 


EXT3-fs: mounted filesystem with ordered data mode.
ADDRCONF(NETDEV_UP): eth0: link is not ready
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
autofs: Unknown ADD relocation: 44
sunrpc: Unknown ADD relocation: 44
lockd: Unknown symbol svc_recv
lockd: Unknown symbol svc_create
lockd: Unknown symbol rpciod_up
lockd: Unknown symbol rpc_destroy_client
lockd: Unknown symbol xdr_encode_netobj
lockd: Unknown symbol svc_destroy
lockd: Unknown symbol xprt_create_proto
lockd: Unknown symbol rpc_delay
lockd: Unknown symbol rpc_call_async
lockd: Unknown symbol rpc_create_client
lockd: Unknown symbol svc_makesock
lockd: Unknown symbol nlm_debug
lockd: Unknown symbol xdr_decode_netobj
lockd: Unknown symbol svc_wake_up
lockd: Unknown symbol rpc_force_rebind
lockd: Unknown symbol rpciod_down
lockd: Unknown symbol svc_exit_thread
lockd: Unknown symbol xdr_encode_string
lockd: Unknown symbol rpc_call_sync
lockd: Unknown symbol xdr_decode_string_inplace
lockd: Unknown symbol svc_set_client
lockd: Unknown symbol svc_process
lockd: Unknown symbol xprt_set_timeout
lockd: Unknown symbol rpc_restart_call
lockd: Unknown symbol svc_create_thread
exportfs: Unknown ADD relocation: 44
sunrpc: Unknown ADD relocation: 44
lockd: Unknown symbol svc_recv
lockd: Unknown symbol svc_create
lockd: Unknown symbol rpciod_up
lockd: Unknown symbol rpc_destroy_client

I fixed it up for now by sticking an `&& !PPC64' in there, but why did it
break, and what other architectures/toolchains broke?
