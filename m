Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWAHUQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWAHUQO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 15:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbWAHUQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 15:16:14 -0500
Received: from styx.suse.cz ([82.119.242.94]:43145 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932488AbWAHUQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 15:16:14 -0500
Date: Sun, 8 Jan 2006 21:16:18 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: akpm@osdl.org, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org,
       carlos@parisc-linux.org, willy@parisc-linux.org,
       dtor_core@ameritech.net
Subject: Re: [PATCH 5/5] Decrapify evdev.c of per-arch compat hacks
Message-ID: <20060108201618.GA11568@corona.ucw.cz>
References: <20060108193811.GL3782@tachyon.int.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060108193811.GL3782@tachyon.int.mcmartin.ca>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 02:38:11PM -0500, Kyle McMartin wrote:
> From: Kyle McMartin <kyle@parisc-linux.org>
> 
> A nice cleanup of evdev.c by using the is_compat_task() macro.
> 
> Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>

Nice, indeed.

> ---
> 
>  drivers/input/evdev.c |   18 +++---------------
>  1 files changed, 3 insertions(+), 15 deletions(-)
> 
> 3e7a8822763c01f93afdb2f0011dec6b641df1fb
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index f7490a0..3cabb4b 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -154,27 +154,15 @@ struct input_event_compat {
>  	__s32 value;
>  };
>  
> -#ifdef CONFIG_X86_64
> -#  define COMPAT_TEST test_thread_flag(TIF_IA32)
> -#elif defined(CONFIG_IA64)
> -#  define COMPAT_TEST IS_IA32_PROCESS(ia64_task_regs(current))
> -#elif defined(CONFIG_S390)
> -#  define COMPAT_TEST test_thread_flag(TIF_31BIT)
> -#elif defined(CONFIG_MIPS)
> -#  define COMPAT_TEST (current->thread.mflags & MF_32BIT_ADDR)
> -#else
> -#  define COMPAT_TEST test_thread_flag(TIF_32BIT)
> -#endif
> -
>  static inline size_t evdev_event_size(void)
>  {
> -	return COMPAT_TEST ?
> +	return is_compat_task(current) ?
>  		sizeof(struct input_event_compat) : sizeof(struct input_event);
>  }
>  
>  static int evdev_event_from_user(const char __user *buffer, struct input_event *event)
>  {
> -	if (COMPAT_TEST) {
> +	if (is_compat_task(current)) {
>  		struct input_event_compat compat_event;
>  
>  		if (copy_from_user(&compat_event, buffer, sizeof(struct input_event_compat)))
> @@ -196,7 +184,7 @@ static int evdev_event_from_user(const c
>  
>  static int evdev_event_to_user(char __user *buffer, const struct input_event *event)
>  {
> -	if (COMPAT_TEST) {
> +	if (is_compat_task(current)) {
>  		struct input_event_compat compat_event;
>  
>  		compat_event.time.tv_sec = event->time.tv_sec;
> -- 
> 1.0.7
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
