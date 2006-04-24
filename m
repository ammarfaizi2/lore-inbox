Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWDXSpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWDXSpj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 14:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWDXSpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 14:45:39 -0400
Received: from nproxy.gmail.com ([64.233.182.190]:56220 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751115AbWDXSpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 14:45:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=JmG2qOTatXWu5lp78AcF0O3oKj0blmDGNmutN6409IEJ3hLPFPvMBIcHxnYeDUc3Lt0Jr3zRUEQD06rHafI530dw4zYA2H02or9m+7B33w53vChTCPb2R23rPambg12ukWaJZ0SGwFQdgJHJaslyVbKdsiWfnmI3w189LsnqVks=
Date: Mon, 24 Apr 2006 22:42:56 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, perex@suse.cz,
       alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] Re: ALSA regression: oops on shutdown
Message-ID: <20060424184256.GA6222@mipter.zuzino.mipt.ru>
References: <20060423235730.GA7934@mipter.zuzino.mipt.ru> <20060423185721.39ff4207.akpm@osdl.org> <b6fcc0a0604231937h6f2754f9k68ec76dc19c7ddb9@mail.gmail.com> <1145846360.31507.50.camel@mindpipe> <20060424031142.GA7735@mipter.zuzino.mipt.ru> <20060424035144.GA7750@mipter.zuzino.mipt.ru> <s5hodyr2j2x.wl%tiwai@suse.de> <s5hhd4j2got.wl%tiwai@suse.de> <20060424153032.GA7747@mipter.zuzino.mipt.ru> <s5hu08j0w62.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hu08j0w62.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 06:34:45PM +0200, Takashi Iwai wrote:
> Thanks.  I think I got the culprit.  It's a patch introducing
> CONFIG_SND_VERBOSE_PROCFS option.
>
> Try the patch below.

Seems to work fine, thanks.

> --- a/include/sound/pcm.h
> +++ b/include/sound/pcm.h
> @@ -374,12 +374,14 @@ struct snd_pcm_substream {
>  	/* -- OSS things -- */
>  	struct snd_pcm_oss_substream oss;
>  #endif
> +#ifdef CONFIG_SND_VERBOSE_PROCFS
>  	struct snd_info_entry *proc_root;
>  	struct snd_info_entry *proc_info_entry;
>  	struct snd_info_entry *proc_hw_params_entry;
>  	struct snd_info_entry *proc_sw_params_entry;
>  	struct snd_info_entry *proc_status_entry;
>  	struct snd_info_entry *proc_prealloc_entry;
> +#endif
>  	/* misc flags */
>  	unsigned int no_mmap_ctrl: 1;
>  	unsigned int hw_opened: 1;
> @@ -400,12 +402,14 @@ struct snd_pcm_str {
>  	struct snd_pcm_oss_stream oss;
>  #endif
>  	struct snd_pcm_file *files;
> +#ifdef CONFIG_SND_VERBOSE_PROCFS
>  	struct snd_info_entry *proc_root;
>  	struct snd_info_entry *proc_info_entry;
>  #ifdef CONFIG_SND_DEBUG
>  	unsigned int xrun_debug;	/* 0 = disabled, 1 = verbose, 2 = stacktrace */
>  	struct snd_info_entry *proc_xrun_debug_entry;
>  #endif
> +#endif
>  };
>  
>  struct snd_pcm {
> diff --git a/include/sound/pcm_oss.h b/include/sound/pcm_oss.h
> index 39df2ba..c854647 100644
> --- a/include/sound/pcm_oss.h
> +++ b/include/sound/pcm_oss.h
> @@ -75,7 +75,9 @@ struct snd_pcm_oss_substream {
>  struct snd_pcm_oss_stream {
>  	struct snd_pcm_oss_setup *setup_list;	/* setup list */
>  	struct mutex setup_mutex;
> +#ifdef CONFIG_SND_VERBOSE_PROCFS
>  	struct snd_info_entry *proc_entry;
> +#endif
>  };
>  
>  struct snd_pcm_oss {
> diff --git a/sound/core/Kconfig b/sound/core/Kconfig
> index 8efc1b1..44015a8 100644
> --- a/sound/core/Kconfig
> +++ b/sound/core/Kconfig
> @@ -142,7 +142,7 @@ config SND_SUPPORT_OLD_API
>  
>  config SND_VERBOSE_PROCFS
>  	bool "Verbose procfs contents"
> -	depends on SND
> +	depends on SND && PROC_FS
>  	default y
>  	help
>  	  Say Y here to include code for verbose procfs contents (provides
> diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
> index c5978d6..817b727 100644
> --- a/sound/core/oss/pcm_oss.c
> +++ b/sound/core/oss/pcm_oss.c
> @@ -2212,7 +2212,7 @@ static int snd_pcm_oss_mmap(struct file 
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PROC_FS
> +#ifdef CONFIG_SND_VERBOSE_PROCFS
>  /*
>   *  /proc interface
>   */
> @@ -2366,10 +2366,10 @@ static void snd_pcm_oss_proc_done(struct
>  		}
>  	}
>  }
> -#else /* !CONFIG_PROC_FS */
> +#else /* !CONFIG_SND_VERBOSE_PROCFS */
>  #define snd_pcm_oss_proc_init(pcm)
>  #define snd_pcm_oss_proc_done(pcm)
> -#endif /* CONFIG_PROC_FS */
> +#endif /* CONFIG_SND_VERBOSE_PROCFS */
>  
>  /*
>   *  ENTRY functions
> diff --git a/sound/core/pcm.c b/sound/core/pcm.c
> index 122e10a..d8c6d7f 100644
> --- a/sound/core/pcm.c
> +++ b/sound/core/pcm.c
> @@ -142,7 +142,7 @@ static int snd_pcm_control_ioctl(struct 
>  	return -ENOIOCTLCMD;
>  }
>  
> -#if defined(CONFIG_PROC_FS) && defined(CONFIG_SND_VERBOSE_PROCFS)
> +#ifdef CONFIG_SND_VERBOSE_PROCFS
>  
>  #define STATE(v) [SNDRV_PCM_STATE_##v] = #v
>  #define STREAM(v) [SNDRV_PCM_STREAM_##v] = #v
> @@ -599,12 +599,12 @@ static int snd_pcm_substream_proc_done(s
>  	}
>  	return 0;
>  }
> -#else /* !CONFIG_PROC_FS */
> +#else /* !CONFIG_SND_VERBOSE_PROCFS */
>  static inline int snd_pcm_stream_proc_init(struct snd_pcm_str *pstr) { return 0; }
>  static inline int snd_pcm_stream_proc_done(struct snd_pcm_str *pstr) { return 0; }
>  static inline int snd_pcm_substream_proc_init(struct snd_pcm_substream *substream) { return 0; }
>  static inline int snd_pcm_substream_proc_done(struct snd_pcm_substream *substream) { return 0; }
> -#endif /* CONFIG_PROC_FS */
> +#endif /* CONFIG_SND_VERBOSE_PROCFS */
>  
>  /**
>   * snd_pcm_new_stream - create a new PCM stream
> diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
> index 230a940..91fe5d0 100644
> --- a/sound/core/pcm_lib.c
> +++ b/sound/core/pcm_lib.c
> @@ -130,7 +130,7 @@ void snd_pcm_playback_silence(struct snd
>  static void xrun(struct snd_pcm_substream *substream)
>  {
>  	snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
> -#ifdef CONFIG_SND_DEBUG
> +#if defined(CONFIG_SND_DEBUG) && defined(CONFIG_SND_VERBOSE_PROCFS)
>  	if (substream->pstr->xrun_debug) {
>  		snd_printd(KERN_DEBUG "XRUN: pcmC%dD%d%c\n",
>  			   substream->pcm->card->number,
> @@ -204,7 +204,7 @@ static inline int snd_pcm_update_hw_ptr_
>  	delta = hw_ptr_interrupt - new_hw_ptr;
>  	if (delta > 0) {
>  		if ((snd_pcm_uframes_t)delta < runtime->buffer_size / 2) {
> -#ifdef CONFIG_SND_DEBUG
> +#if defined(CONFIG_SND_DEBUG) && defined(CONFIG_SND_VERBOSE_PROCFS)
>  			if (runtime->periods > 1 && substream->pstr->xrun_debug) {
>  				snd_printd(KERN_ERR "Unexpected hw_pointer value [1] (stream = %i, delta: -%ld, max jitter = %ld): wrong interrupt acknowledge?\n", substream->stream, (long) delta, runtime->buffer_size / 2);
>  				if (substream->pstr->xrun_debug > 1)
> @@ -249,7 +249,7 @@ int snd_pcm_update_hw_ptr(struct snd_pcm
>  	delta = old_hw_ptr - new_hw_ptr;
>  	if (delta > 0) {
>  		if ((snd_pcm_uframes_t)delta < runtime->buffer_size / 2) {
> -#ifdef CONFIG_SND_DEBUG
> +#if defined(CONFIG_SND_DEBUG) && defined(CONFIG_SND_VERBOSE_PROCFS)
>  			if (runtime->periods > 2 && substream->pstr->xrun_debug) {
>  				snd_printd(KERN_ERR "Unexpected hw_pointer value [2] (stream = %i, delta: -%ld, max jitter = %ld): wrong interrupt acknowledge?\n", substream->stream, (long) delta, runtime->buffer_size / 2);
>  				if (substream->pstr->xrun_debug > 1)
> diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
> index a0119ae..428f8c1 100644
> --- a/sound/core/pcm_memory.c
> +++ b/sound/core/pcm_memory.c
> @@ -100,8 +100,10 @@ static void snd_pcm_lib_preallocate_dma_
>  int snd_pcm_lib_preallocate_free(struct snd_pcm_substream *substream)
>  {
>  	snd_pcm_lib_preallocate_dma_free(substream);
> +#ifdef CONFIG_SND_VERBOSE_PROCFS
>  	snd_info_unregister(substream->proc_prealloc_entry);
>  	substream->proc_prealloc_entry = NULL;
> +#endif
>  	return 0;
>  }
>  
> @@ -124,7 +126,7 @@ int snd_pcm_lib_preallocate_free_for_all
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PROC_FS
> +#ifdef CONFIG_SND_VERBOSE_PROCFS
>  /*
>   * read callback for prealloc proc file
>   *
> @@ -203,9 +205,9 @@ static inline void preallocate_info_init
>  	substream->proc_prealloc_entry = entry;
>  }
>  
> -#else /* !CONFIG_PROC_FS */
> +#else /* !CONFIG_SND_VERBOSE_PROCFS */
>  #define preallocate_info_init(s)
> -#endif
> +#endif /* CONFIG_SND_VERBOSE_PROCFS */
>  
>  /*
>   * pre-allocate the buffer and create a proc file for the substream

