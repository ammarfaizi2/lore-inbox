Return-Path: <linux-kernel-owner+w=401wt.eu-S1754329AbWLRRh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329AbWLRRh4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 12:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754331AbWLRRhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 12:37:55 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:57269 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329AbWLRRhz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 12:37:55 -0500
Date: Mon, 18 Dec 2006 09:38:55 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Miguel Ojeda" <maxextreme@gmail.com>
Cc: davem@davemloft.net, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH davem] drivers: add LCD support
Message-Id: <20061218093855.01445a7c.randy.dunlap@oracle.com>
In-Reply-To: <653402b90611110203y6ea7356re77c6de6fb868807@mail.gmail.com>
References: <20061108204908.8def2283.maxextreme@gmail.com>
	<653402b90611110203y6ea7356re77c6de6fb868807@mail.gmail.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2006 11:03:51 +0100 Miguel Ojeda wrote:

> David, as akpm suggested, may this patch will solve the dcache aliasing problem?
> 
> I will give you a introduction:
> 
> The user mmaped page (got by __get_free_page()) is cfag12864b_buffer.
> 
> The kernel only access it for reading at the same function 1 or 2 times:
> 
>   1º memcmp() it against the cache, so we can tell if we must update the screen
>   2º if true, memcpy() the buffer to the cache buffer
> 
> So, if we want the kernel to know the last state of the data, we should call
> flush_dcache_page() just once before we access it, right?
> 
> The relevant code:
> 
>         flush_dcache_page(virt_to_page(cfag12864b_buffer));
>         if (memcmp(cfag12864b_cache, cfag12864b_buffer, CFAG12864B_SIZE)) {
>                 memcpy(cfag12864b_cache, cfag12864b_buffer, CFAG12864B_SIZE);
> 
>                 /***... update using cfag12864b_cache ...***/
>         }
> 
> You know, I can't test this stuff ;) so please review and check if it is right.
> 
> Thanks you.
> ---
> 
>  - remove the "depends on x86" as it is portable again
> 
>  - memcpy() buffer to cache, then update from cache, not buffer,
>    This way we only read the mmapped buffer 2 times.
> 
>  - add a flush_dcache_page() to flush the user mmaped page so
>    the kernel has the last written data before accessing it.
> 
>  drivers/auxdisplay/Kconfig      |    1 -
>  drivers/auxdisplay/cfag12864b.c |    9 +++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> drivers-add-lcd-support-dcache.patch
> Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>
> ---
> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
> index 8d41f72..ee30c48 100644
> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -64,7 +64,6 @@ config KS0108_DELAY
> 
>  config CFAG12864B
>         tristate "CFAG12864B LCD"
> -       depends on X86
>         depends on KS0108
>         default n
>         ---help---

Hi,

Shouldn't the framebuffer part of this code (cfag12864bfb) also
depend on CONFIG_FB?  Without that, this build error occurs:

cfag12864bfb.c:(.init.text+0xc19d): undefined reference to `framebuffer_alloc'
cfag12864bfb.c:(.init.text+0xc211): undefined reference to `register_framebuffer'
cfag12864bfb.c:(.text+0xf2782): undefined reference to `unregister_framebuffer'
cfag12864bfb.c:(.text+0xf2789): undefined reference to `framebuffer_release'

(from 2.6.20-rc1-mm1)

so you may need to modify the Kconfig and Makefile to have a
separate config entry for cfag12864bfb (or is it always required?).


And while you are there (in the Kconfig file), please change
(hertzs) to (hertz).

---
~Randy
